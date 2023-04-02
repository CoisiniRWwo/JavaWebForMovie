package com.shf.dataCleaning

import org.apache.spark.SparkConf
import org.apache.spark.sql.{DataFrame, SaveMode, SparkSession}

import java.util.Properties

object ratingData {
  def main(args: Array[String]): Unit = {
    val conf: SparkConf = new SparkConf().setAppName("ratingData").setMaster("local[*]")
    val spark: SparkSession = SparkSession.builder()
      .config(conf)
      .getOrCreate()

    import spark.implicits._
    import org.apache.spark.sql.functions._

    val usersData: DataFrame = spark.read.option("header", true).csv("D:\\Study\\SHFWorkSpace\\MoviesData\\users.csv")
    val ratingsData: DataFrame = spark.read.option("header", true).csv("D:\\Study\\SHFWorkSpace\\MoviesData\\ratings.csv")
    val moviesData: DataFrame = spark.read.option("header", true).csv("D:\\Study\\SHFWorkSpace\\MoviesData\\movies.csv")

    usersData.createOrReplaceTempView("users")
    ratingsData.createOrReplaceTempView("rating")
    moviesData.createOrReplaceTempView("movies")
    usersData.show()
    ratingsData.show()
    moviesData.show()
    println("==================="+moviesData.count())

    val prop = new Properties()
    prop.put("user", "root")
    prop.put("password", "010111")
    prop.put("driver", "com.mysql.cj.jdbc.Driver")
    val allmovies: DataFrame = spark.read.jdbc("jdbc:mysql://localhost/moviesdata", "allmovies", prop)
    allmovies.createOrReplaceTempView("allmovies")

//    usersData.printSchema()

    val dataFrame: DataFrame = spark.sql(
      """
        |select USER_NICKNAME,RATING_ID,rating.MOVIE_ID,NAME,RATING,RATING_TIME
        |from users
        |left join rating on users.USER_MD5=rating.USER_MD5
        |join movies on rating.MOVIE_ID=movies.MOVIE_ID
        |""".stripMargin)
    dataFrame.show()
    dataFrame.createOrReplaceTempView("olddata")

    println("=================================")

    val frame: DataFrame = spark.sql(
      """
        |select olddata.USER_NICKNAME,allmovies.NAME,olddata.RATING,olddata.RATING_TIME
        |from olddata
        |left join allmovies on allmovies.name=olddata.NAME
        |where allmovies.id is not null
        |""".stripMargin)
    frame.show()

    dataFrame.coalesce(1).write.mode(SaveMode.Overwrite).csv("data/movieRating.csv")


    spark.stop()
  }

}
