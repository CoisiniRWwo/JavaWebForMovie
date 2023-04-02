package com.shf.dataCleaning

import org.apache.spark.sql.{DataFrame, SaveMode, SparkSession}
import org.apache.spark.{SparkConf, SparkContext}

import java.util.Properties

object task1 {
  def main(args: Array[String]): Unit = {
    val conf: SparkConf = new SparkConf().setAppName("task1").setMaster("local[*]")
    val spark: SparkSession = SparkSession.builder()
      .config(conf)
      .getOrCreate()

    import spark.implicits._
    import org.apache.spark.sql.functions._

    val dataFrame: DataFrame = spark.read.option("header", true).csv("C:\\Users\\Admin\\Downloads\\movies.csv")
    val dataFrame1: DataFrame = dataFrame
      //      .drop("NAME")
      //      .select("NAME")
      .withColumn("NAME", regexp_replace(col("NAME"), " ", ""))
    dataFrame1
      .show()
    dataFrame.printSchema()

    val properties = new Properties()
    properties.setProperty("user", "root")
    properties.setProperty("password", "010111")
    dataFrame1.coalesce(1).write.mode(SaveMode.Overwrite)
      .jdbc("jdbc:mysql://localhost:3306/javaweb_ods", "movie", properties)

    spark.stop()
  }

}
