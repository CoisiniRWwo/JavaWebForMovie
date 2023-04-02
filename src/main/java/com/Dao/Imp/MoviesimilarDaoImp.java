package com.Dao.Imp;

import com.Dao.MoviesimilarDao;
import com.bean.Moviesimilar;
import com.utils.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * @Author:Su HangFei
 * @Date:2022-12-04 13 30
 * @Project:JavaWebEndofPeriod
 */
public class MoviesimilarDaoImp implements MoviesimilarDao {

    private String sql = "";
    private PreparedStatement pstmt;
    private Moviesimilar moviesimilar;
    private ResultSet rs;
    private Connection conn = null;

    private Connection getConn() {
        try {
            if ((conn == null) || conn.isClosed()) {
                DB db = new DB();
                conn = db.getConn();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

    @Override
    public String getImilarByMid(String uid) {
        getConn();
        sql = "select similar from moviesimilar where mid = ?";
        String result = "";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,uid);
            rs = pstmt.executeQuery();
            if(rs.next()){
                result = rs.getString(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return result;
    }
}
