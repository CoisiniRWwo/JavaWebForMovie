package com.shf.dataCleaning

import org.apache.spark.SparkConf
import org.apache.spark.sql.expressions.{Window, WindowSpec}
import org.apache.spark.sql.{DataFrame, SaveMode, SparkSession}

import java.util.Properties

object comment {
  def main(args: Array[String]): Unit = {
    val conf: SparkConf = new SparkConf().setAppName("toMysqlrating").setMaster("local[*]")
    val spark: SparkSession = SparkSession.builder()
      .config(conf)
      .getOrCreate()

    import spark.implicits._
    import org.apache.spark.sql.functions._

    val prop = new Properties()
    prop.put("user", "root")
    prop.put("password", "010111")
    prop.put("driver", "com.mysql.cj.jdbc.Driver")

    val comments: DataFrame = spark.read.option("header", true).csv("D:\\Study\\SHFWorkSpace\\MoviesData\\comments.csv")
    comments.createOrReplaceTempView("comments")
//    comments.show()
    val movies: DataFrame = spark.read.option("header", true).csv("D:\\Study\\SHFWorkSpace\\MoviesData\\movies.csv")
    movies.createOrReplaceTempView("movies")
//    movies.show()
    val users: DataFrame = spark.read.option("header", true).csv("D:\\Study\\SHFWorkSpace\\MoviesData\\users.csv")
    users.createOrReplaceTempView("users")
//    users.show()

    val allmovies: DataFrame = spark.read.jdbc("jdbc:mysql://localhost/moviesdata", "allmovies", prop)
    allmovies.createOrReplaceTempView("allmovies")

    val data: DataFrame = spark.sql(
      """
        |select users.USER_NICKNAME,comments.MOVIE_ID,NAME,CONTENT,VOTES,COMMENT_TIME
        |from comments
        |left join movies on comments.MOVIE_ID=movies.MOVIE_ID
        |join users on comments.USER_MD5=users.USER_MD5
        |""".stripMargin)
    data.show()
    data.createOrReplaceTempView("data")

    val frame: DataFrame = spark.sql(
      """
        |select USER_NICKNAME,allmovies.id,data.NAME,CONTENT,VOTES,COMMENT_TIME
        |from allmovies
        |left join data on allmovies.name=data.NAME
        |where USER_NICKNAME is not null
        |""".stripMargin)
    frame.show()
    val spec: WindowSpec = Window.partitionBy().orderBy($"COMMENT_TIME")
    val df1: DataFrame = frame.withColumn("index", row_number().over(spec))
    df1.show()

    df1.coalesce(1).write.mode(SaveMode.Overwrite).jdbc("jdbc:mysql://localhost:3306/moviesdata", "comments", prop)

    spark.stop()
  }

}
