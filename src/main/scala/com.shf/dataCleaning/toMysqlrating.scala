package com.shf.dataCleaning

import org.apache.spark.SparkConf
import org.apache.spark.sql.{DataFrame, SaveMode, SparkSession}

import java.util.Properties

object toMysqlrating {
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
    val allmovies: DataFrame = spark.read.jdbc("jdbc:mysql://localhost/moviesdata", "allmovies", prop)
    allmovies.createOrReplaceTempView("allmovies")
    val users: DataFrame = spark.read.jdbc("jdbc:mysql://localhost/moviesdata", "users", prop)
    users.createOrReplaceTempView("users")
    val dataFrame: DataFrame = spark.read.csv("data/movieRating.csv/part-00000-e157d0c2-61c0-4a01-8a11-c48a94498f46.csv")
    dataFrame.createOrReplaceTempView("dataFrame")

    val frame: DataFrame = spark.sql(
      """
        |select users.id as userId,allmovies.id as movieId,dataFrame._c4 as score,dataFrame._c5 as timestamp
        |from dataFrame
        |join users on users.username=dataFrame._c0
        |join allmovies on dataFrame._c3=allmovies.name
        |""".stripMargin)
    frame.show()

    frame.coalesce(1).write.mode(SaveMode.Overwrite).jdbc("jdbc:mysql://localhost:3306/moviesdata", "movierating", prop)

    spark.stop()
  }

}
