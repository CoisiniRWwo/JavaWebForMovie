package com.utils;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

/**
 * @Author:Su HangFei
 * @Date:2022-11-01 15 12
 * @Project:JavaWebCode
 */
public class DB {
    private Properties p;
    private String driver;
    private String url;
    private String username;
    private String password;
    private Connection conn;

    public Connection getConn() {
        return conn;
    }

    public DB() {
        try {
            p = new Properties();
            InputStream resourceAsStream = this.getClass().getResourceAsStream("/config.ini");
            p.load(resourceAsStream);
            driver = p.getProperty("driver");
            url = p.getProperty("url");
            username = p.getProperty("username");
            password = p.getProperty("password");
            Class.forName(driver);
            conn = DriverManager.getConnection(url, username, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
