package com.Dao.Imp;

import com.Dao.CommentsDao;
import com.bean.Comments;
import com.utils.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * @Author:Su HangFei
 * @Date:2022-12-04 12 44
 * @Project:JavaWebEndofPeriod
 */
public class CommentsDaoImp implements CommentsDao {

    private String sql = "";
    private PreparedStatement pstmt;
    private Comments comments;
    private ArrayList<Comments> commentsArrayList = new ArrayList<Comments>();
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

    public ArrayList<Comments> getByRs(ResultSet rs) {
        try {
            if (rs == null || !rs.next()) {
                return null;
            }
            commentsArrayList.clear();
            do {
                comments = new Comments();
                comments.setId(rs.getInt("id"));
                comments.setUsername(rs.getString("username"));
                comments.setMovieid(rs.getInt("movieid"));
                comments.setMoviename(rs.getString("moviename"));
                comments.setContent(rs.getString("content"));
                comments.setVotes(rs.getString("votes"));
                comments.setCommenttime(rs.getString("commenttime"));
                commentsArrayList.add(comments);
            } while (rs.next());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return commentsArrayList;
    }

    public ArrayList<Comments> getById(String movieid){
        getConn();
        sql = "select * from comments where movieid = ? order by commenttime desc limit 4";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,movieid);
            rs=pstmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return getByRs(rs);
    }

    @Override
    public boolean addComment(Comments comments) {
        sql = "insert into comments (username,movieid,moviename,content,commenttime) values (?,?,?,?,?)";
        int result = 0;
        try {
            pstmt = getConn().prepareStatement(sql);
            pstmt.setString(1, comments.getUsername());
            pstmt.setInt(2, comments.getMovieid());
            pstmt.setString(3, comments.getMoviename());
            pstmt.setString(4, comments.getContent());
            pstmt.setString(5, comments.getCommenttime());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (result > 0) {
            return true;
        } else {
            return false;
        }
    }
}
