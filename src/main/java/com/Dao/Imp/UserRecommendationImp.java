package com.Dao.Imp;

import com.Dao.UserRecommendationDao;
import com.bean.UserRecommendation;
import com.utils.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * @Author:Su HangFei
 * @Date:2022-11-30 19 49
 * @Project:JavaWebEndofPeriod
 */
public class UserRecommendationImp implements UserRecommendationDao {

    private String sql = "";
    private PreparedStatement pstmt;
    private UserRecommendation userRecommendation;
    private ArrayList<UserRecommendation> userRecommendationArrayList = new ArrayList<UserRecommendation>();
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

    public ArrayList<UserRecommendation> getByRs(ResultSet rs){
        try {
            if (rs == null || !rs.next()) {
                return null;
            }
            userRecommendationArrayList.clear();
            do {
                userRecommendation = new UserRecommendation();
                userRecommendation.setUid(rs.getInt("uid"));
                userRecommendation.setMid(rs.getString("mid"));
                userRecommendationArrayList.add(userRecommendation);
            }while (rs.next());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userRecommendationArrayList;
    }

    @Override
    public String getUserRecommendation(int uid) {
        getConn();
        sql = "select mid from userrecommendation where uid = ?";
        String result = "";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,uid);
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
