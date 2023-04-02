package com.shf.Recommendation

import org.apache.spark.SparkConf
import org.apache.spark.sql.{DataFrame, SparkSession}

import java.util.Properties

object DataLoader {
  val MONGODB_MOVIE_COLLECTION = "Movie"
  val MONGODB_RATING_COLLECTION = "Rating"
  val MONGODB_TAG_COLLECTION = "Tag"
  val ES_MOVIE_INDEX = "Movie"

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
    val allmovies: DataFrame = session.read.jdbc("jdbc:mysql://localhost/moviesdata", "allmovies", prop)
    val comments: DataFrame = session.read.jdbc("jdbc:mysql://localhost/moviesdata", "comments", prop)
//    val allmovies: DataFrame = session.read.jdbc("jdbc:mysql://localhost/moviesdata", "allmovies", prop)

    allmovies.orderBy($"years".desc).limit(10).show()
    println("================================")
    comments.limit(10).show()


    session.stop()
  }

}
