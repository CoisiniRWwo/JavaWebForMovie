package com.shf.dataCleaning

import org.apache.spark.SparkConf
import org.apache.spark.sql.{DataFrame, SaveMode, SparkSession}

import java.util.Properties

object raging {
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

    val movierating: DataFrame = spark.read.jdbc("jdbc:mysql://localhost/javaweb_ods", "movierating", prop)
    movierating.createOrReplaceTempView("movierating")
//    movierating.show()
    val allmovies: DataFrame = spark.read.jdbc("jdbc:mysql://localhost/javaweb_ods", "allmovies", prop)
    allmovies.createOrReplaceTempView("allmovies")
//    allmovies.show()

    val dataFrame: DataFrame = spark.sql(
      """
        |select userId,name,movierating.score,timestamp
        |from movierating
        |left join allmovies on movierating.movieId=allmovies.id
        |""".stripMargin)
    dataFrame.show()
    dataFrame.createOrReplaceTempView("dataFrame")

    val newallmovies: DataFrame = spark.read.jdbc("jdbc:mysql://localhost/moviesdata", "allmovies", prop)
    newallmovies.createOrReplaceTempView("newallmovies")
    val result: DataFrame = spark.sql(
      """
        |select userId,id,dataFrame.score,timestamp
        |from dataFrame
        |left join newallmovies on newallmovies.name=dataFrame.name
        |""".stripMargin)
    result.show()

    result.coalesce(1).write.mode(SaveMode.Overwrite).jdbc("jdbc:mysql://localhost:3306/moviesdata", "movierating", prop)

    spark.stop()
  }

}
