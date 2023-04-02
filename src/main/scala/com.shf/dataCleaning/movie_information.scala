package com.shf.dataCleaning

import org.apache.spark.SparkConf
import org.apache.spark.sql.{DataFrame, Row, SparkSession}

import java.sql.{Connection, DriverManager}
import java.util.Properties

object movie_information {
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
    //movierating

    val movierating: DataFrame = spark.read.jdbc("jdbc:mysql://localhost/moviesdata", "movierating", prop)
    movierating.createOrReplaceTempView("movierating")
    val users: DataFrame = spark.read.jdbc("jdbc:mysql://localhost/moviesdata", "users", prop)
    users.createOrReplaceTempView("users")
    val allmovies: DataFrame = spark.read.jdbc("jdbc:mysql://localhost/moviesdata", "allmovies", prop)
    allmovies.createOrReplaceTempView("allmovies")

    val dataFrame: DataFrame = spark.sql(
      """
        |select users.username,movierating.movieID
        |from movierating
        |left join users on movierating.userId=users.id
        |""".stripMargin)
    dataFrame.show()
    println(dataFrame.count())
    dataFrame.createOrReplaceTempView("dataFrame")
    val frame: DataFrame = spark.sql(
      """
        |select username,name,director,actor as starring,years as purchasedate,image as
        |from dataFrame
        |left join allmovies on dataFrame.movieID=allmovies.id
        |""".stripMargin)
    frame.show()
    println(frame.count())

    var connectionMqcrm: Connection = null
    Class.forName("com.mysql.cj.jdbc.Driver")
    connectionMqcrm = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviesdata", "root", "010111")

    val rdd: Array[Row] = frame.rdd.collect()
    rdd.foreach(x => println(x.toString().replace("[", "").replace("]", "")))

    val sql = "INSERT INTO movie_information (`username`,`name`,`director`,`starring`,`purchasedate`,`moviephoto`) VALUES (?,?,?,?,?,?)"
    rdd.foreach(data => {
      val strings: Array[String] = data.toString().replace("[", "").replace("]", "")
        .split(",")
      val statement = connectionMqcrm.prepareStatement(sql)
      statement.setString(1, strings(0))
      statement.setString(2, strings(1))
      statement.setString(3, strings(2))
      statement.setString(4, strings(3))
      statement.setString(5, strings(4))
      statement.setString(6, strings(5))
      statement.executeUpdate()
    })

    spark.stop()
  }
}
