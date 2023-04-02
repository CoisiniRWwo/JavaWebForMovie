package com.shf.dataCleaning

import org.apache.spark.SparkConf
import org.apache.spark.sql.{DataFrame, SaveMode, SparkSession}

import java.util.Properties

object test3 {
  def main(args: Array[String]): Unit = {
    val conf: SparkConf = new SparkConf().setAppName("task2").setMaster("local[*]")
    val spark: SparkSession = SparkSession.builder()
      .config(conf)
      .getOrCreate()

    import spark.implicits._
    import org.apache.spark.sql.functions._

    val prop = new Properties()
    prop.put("user", "root")
    prop.put("password", "010111")
    prop.put("driver", "com.mysql.cj.jdbc.Driver")
    val dataFrame: DataFrame = spark.read.jdbc("jdbc:mysql://localhost/test", "allmovies", prop)

    dataFrame.select(length(col("director")))
      .show()

    val frame: DataFrame = dataFrame
      .withColumn("des", regexp_replace(col("des"), " ", ""))
      .withColumn("des", regexp_replace(col("des"), "\\s+", ""))
      .withColumn("director", col("director").substr(lit(0), length(col("director")) - 1))
      .withColumn("scriptwriter", col("scriptwriter").substr(lit(0), length(col("scriptwriter")) - 1))
      .withColumn("actor", col("actor").substr(lit(0), length(col("actor")) - 1))
    frame.show()

    frame.coalesce(1).write.mode(SaveMode.Overwrite).jdbc("jdbc:mysql://localhost:3306/moviesdata", "allmovies", prop)

  }

}
