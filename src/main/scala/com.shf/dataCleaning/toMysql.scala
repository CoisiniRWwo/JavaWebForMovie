package com.shf.dataCleaning

import org.apache.spark.SparkConf
import org.apache.spark.rdd.RDD
import org.apache.spark.sql.{DataFrame, Dataset, Row, SparkSession}

import java.sql.{Connection, DriverManager}
import java.util.Properties

object toMysql {
  def main(args: Array[String]): Unit = {
    val conf: SparkConf = new SparkConf().setAppName("toMysql").setMaster("local[*]")
    val spark: SparkSession = SparkSession.builder()
      .config(conf)
      .getOrCreate()

    import spark.implicits._
    import org.apache.spark.sql.functions._

    val dataFrame: DataFrame = spark.read.csv("data/movieRating.csv/part-00000-e157d0c2-61c0-4a01-8a11-c48a94498f46.csv")

    val prop = new Properties()
    prop.put("user", "root")
    prop.put("password", "010111")
    prop.put("driver", "com.mysql.cj.jdbc.Driver")

    var connectionMqcrm: Connection = null
    Class.forName("com.mysql.cj.jdbc.Driver")
    connectionMqcrm = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviesdata", "root", "010111")

    val value: Dataset[Row] = dataFrame.select("_c0").dropDuplicates("_c0")
    println(value.count())
    val rdd: Array[Row] = value.rdd.collect()
    rdd.foreach(x => println(x.toString().replace("[","").replace("]","")))

    val sql = "INSERT INTO users (`username`) VALUES (?)"
    rdd.foreach(data => {
      val str: String = data.toString().replace("[", "").replace("]", "")
      val statement = connectionMqcrm.prepareStatement(sql)
      statement.setString(1, str)
      var result = statement.executeUpdate()
    })




  }

}
