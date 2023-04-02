package com.shf.Recommendation

import org.apache.spark.SparkConf
import org.apache.spark.mllib.recommendation.{ALS, MatrixFactorizationModel, Rating}
import org.apache.spark.rdd.RDD
import org.apache.spark.sql.types.StructType
import org.apache.spark.sql.{DataFrame, Encoders, SaveMode, SparkSession}
import org.jblas.DoubleMatrix

import java.util.Properties

// 基于评分数据的LFM，只需要rating数据
case class MovieRating(userId: Int, movieId: Int, score: Double, timestamp: Int)

// 定义一个基准推荐对象
case class Recommendation(mid: Int, score: Double)

// 定义基于预测评分的用户推荐列表
case class UserRecs(uid: Int, recs: Seq[Recommendation])

// 定义基于LFM电影特征向量的电影相似度列表
case class MovieRecs(mid: Int, recs: Seq[Recommendation])

object offline {

  val USER_MAX_RECOMMENDATION = 5

  def main(args: Array[String]): Unit = {
    val dataLoaderSparkConf: SparkConf = new SparkConf().setMaster("local[*]").setAppName("DataLoader")

    val session: SparkSession = SparkSession.builder()
      .config(dataLoaderSparkConf)
      .getOrCreate()

    import session.implicits._
    import org.apache.spark.sql.functions._

    val prop = new Properties()
    prop.put("user", "root")
    prop.put("password", "010111")
    prop.put("driver", "com.mysql.cj.jdbc.Driver")
    val schema: StructType = Encoders.product[MovieRating].schema

    //加载数据
    val movierating: DataFrame = session.read
      .jdbc("jdbc:mysql://localhost/moviesdata", "movierating", prop)
    movierating.show()
    movierating.printSchema()

    val ratingRDD: RDD[(Int, Int, Double)] = movierating.as[MovieRating]
      .rdd
      .map((data: MovieRating) => (data.userId, data.movieId, data.score))
      .cache()

    // 从rating数据中提取所有的uid和mid，并去重
    val userRDD: RDD[Int] = ratingRDD.map((_: (Int, Int, Double))._1).distinct()
    val movieRDD: RDD[Int] = ratingRDD.map((_: (Int, Int, Double))._2).distinct()

    // 训练隐语义模型
    val trainData: RDD[Rating] = ratingRDD.map((x: (Int, Int, Double)) => Rating(x._1, x._2, x._3))

    val (rank, iterations, lambda) = (200, 10, 0.1)
    val model: MatrixFactorizationModel = ALS.train(trainData, rank, iterations, lambda)

    // 基于用户和电影的隐特征，计算预测评分，得到用户的推荐列表
    // 计算user和movie的笛卡尔积，得到一个空评分矩阵
    val userMovies: RDD[(Int, Int)] = userRDD.cartesian(movieRDD)

    // 调用model的predict方法预测评分
    val preRatings: RDD[Rating] = model.predict(userMovies)

    val userRecs: DataFrame = preRatings
      .filter((_: Rating).rating > 0) // 过滤出评分大于0的项
      .map((rating: Rating) => (rating.user, (rating.product, rating.rating)))
      .groupByKey()
      .map {
        case (uid, recs) => UserRecs(uid, recs.toList.sortWith((_: (Int, Double))._2 > (_: (Int, Double))._2)
          .take(USER_MAX_RECOMMENDATION).map((x: (Int, Double)) => Recommendation(x._1, x._2)))
      }
      .toDF()

    userRecs.show()
    val userRecommendation: DataFrame = userRecs.select("uid", "recs.mid")
      .withColumn("mid", col("mid").cast("string"))
      .withColumn("mid", regexp_replace(col("mid"), "\\[", ""))
      .withColumn("mid", regexp_replace(col("mid"), "\\]", ""))
    userRecommendation.show()
    userRecommendation.coalesce(1).write.mode(SaveMode.Overwrite)
      .jdbc("jdbc:mysql://localhost:3306/moviesdata", "userrecommendation", prop)

    println("==================================")

    // 基于电影隐特征，计算相似度矩阵，得到电影的相似度列表
    val movieFeatures: RDD[(Int, DoubleMatrix)] = model.productFeatures.map {
      case (mid, features) => (mid, new DoubleMatrix(features))
    }

    // 对所有电影两两计算它们的相似度，先做笛卡尔积
    val movieRecs: DataFrame = movieFeatures.cartesian(movieFeatures)
      .filter {
        // 把自己跟自己的配对过滤掉
        case (a, b) => a._1 != b._1
      }
      .map {
        case (a, b) => {
          val simScore: Double = this.consinSim(a._2, b._2)
          (a._1, (b._1, simScore))
        }
      }
      .filter((_: (Int, (Int, Double)))._2._2 > 0.6) // 过滤出相似度大于0.6的
      .groupByKey()
      .map {
        case (mid, items) => MovieRecs(mid, items.toList.sortWith((_: (Int, Double))._2 > (_: (Int, Double))._2)
          .take(USER_MAX_RECOMMENDATION)
          .map((x: (Int, Double)) => Recommendation(x._1, x._2)))
      }
      .toDF()

    movieRecs.show()
    movieRecs.printSchema()

    //as ("similar")
    val movieSimilar: DataFrame = movieRecs.select($"mid", $"recs.mid".as("similar") )
      .withColumn("similar", col("similar").cast("string"))
      .withColumn("similar", regexp_replace(col("similar"), "\\[", ""))
      .withColumn("similar", regexp_replace(col("similar"), "\\]", ""))
    movieSimilar.show()

//    movieSimilar.coalesce(1).write.mode(SaveMode.Overwrite)
//      .jdbc("jdbc:mysql://localhost:3306/moviesdata", "moviesimilar", prop)


    session.stop()
  }

  // 求向量余弦相似度
  def consinSim(movie1: DoubleMatrix, movie2: DoubleMatrix): Double = {
    movie1.dot(movie2) / (movie1.norm2() * movie2.norm2())
  }

}
