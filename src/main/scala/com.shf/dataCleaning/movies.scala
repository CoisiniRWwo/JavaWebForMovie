package com.shf.dataCleaning

import org.apache.spark.SparkConf
import org.apache.spark.sql.expressions.{Window, WindowSpec}
import org.apache.spark.sql.{DataFrame, Dataset, Row, SaveMode, SparkSession}

import java.util.Properties

object movies {
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

    val allmovies: DataFrame = spark.read.jdbc("jdbc:mysql://localhost/javaweb_ods", "allmovies", prop)
    allmovies.show()
    println("未去重条数："+allmovies.count())
    allmovies.createOrReplaceTempView("allmovies")

    val windowSpec: WindowSpec = Window.partitionBy("name").orderBy("years")

    val result: Dataset[Row] = allmovies.withColumn("index", row_number().over(windowSpec))
      .filter($"index" === 1)
    println("剩余条数："+result.count())

    result.show()

    result.coalesce(1).write.mode(SaveMode.Overwrite).jdbc("jdbc:mysql://localhost:3306/moviesdata", "allmovies", prop)

    spark.stop()
  }

}
