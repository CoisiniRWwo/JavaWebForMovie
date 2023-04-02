package com.Dao.Imp;

import com.Dao.CollectionDao;
import com.bean.Collection;
import com.utils.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * @Author:Su HangFei
 * @Date:2022-11-28 19 12
 * @Project:JavaWebEndofPeriod
 */
public class CollectionDaoImp implements CollectionDao {

    private String sql = "";

    private PreparedStatement pstmt;

    private ArrayList<Collection> collections = new ArrayList<>();

    private Collection collection;

    private ResultSet rs;

    private Connection conn = null;

    private Connection getConn() throws Exception {
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

    public ArrayList<Collection> getByRs(ResultSet rs) throws Exception{
        try {
            if(rs == null || !rs.next()) return null;
            collections.clear();
            do {
                collection = new Collection();
                collection.setId(rs.getInt("id"));
                collection.setUsername(rs.getString("username"));
                collection.setName(rs.getString("name"));
                collection.setDirector(rs.getString("director"));
                collection.setStarring(rs.getString("starring"));
                collection.setPlace(rs.getString("place"));
                collection.setFare(rs.getDouble("fare"));
                collection.setSeat(rs.getString("seat"));
                collection.setDatetime(rs.getString("datetime"));
                collection.setPurchaseDate(rs.getString("purchasedate"));
                collection.setMoviePhoto(rs.getString("moviephoto"));
                collections.add(collection);
            }while (rs.next());
        }catch (Exception e){
            e.printStackTrace();
        }
        return collections;
    }

    public ArrayList<Collection> getMovieByName(String name) throws Exception {
        getConn();
        sql = "select * from movie_information where username = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,name);
            rs = pstmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return getByRs(rs);
    }

    public int getMovieCount() throws Exception {
        getConn();
        int count = 0;
        sql = "select count(*) from movie_information";
        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if(rs.next()){
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean delete(int id) throws Exception{
        getConn();
        sql = "delete from movie_information where id = ?";
        int result = 0;
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,id);
            result = pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        resetId();
        if(result > 0){
            return true;
        }else {
            return false;
        }
    }

    public void resetId() throws Exception {
        getConn();
        int result = 0;
        String[] str = {"alter table movie_information modify id int;",
                "alter table movie_information drop primary key;",
                "alter table movie_information drop id;",
                "alter table movie_information add id int primary key auto_increment;"};
        for (int i = 0; i < str.length; i++) {
            sql = str[i];
            try {
                pstmt = conn.prepareStatement(sql);
                result = pstmt.executeUpdate();
            }catch (Exception e){
                e.printStackTrace();
            }
        }
    }

    public ArrayList<Collection> getMovieByName(String name, int num, int maxNum) throws Exception {
        getConn();
        sql = "select * from movie_information where username = ? limit " + ((num - 1) * maxNum) + "," + maxNum;
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,name);
            System.out.println(sql);
            rs = pstmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return getByRs(rs);
    }

    public int getMovieCount(String name) throws Exception {
        getConn();
        int count = 0;
        sql = "select count(*) from movie_information where username = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,name);
            rs = pstmt.executeQuery();
            if(rs.next()){
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public boolean buyMovie(Collection collection) throws Exception {
        getConn();
        sql = "insert into movie_information (username,name,director,starring,fare,seat,purchasedate,moviephoto) values (?,?,?,?,?,?,?,?)";
        int result = 0;
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,collection.getUsername());
            pstmt.setString(2, collection.getName());
            pstmt.setString(3, collection.getDirector());
            pstmt.setString(4, collection.getStarring());
            pstmt.setDouble(5, collection.getFare());
            pstmt.setString(6, collection.getSeat());
            pstmt.setString(7, collection.getPurchaseDate());
            pstmt.setString(8, collection.getMoviePhoto());
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

    public boolean deleteAll(String id) throws Exception{
        getConn();
        sql = "delete from movie_information where id in ("+id+")";
        int result = 0;
        try {
            pstmt = conn.prepareStatement(sql);
//            pstmt.setString(1,id);
            result = pstmt.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }
        if(result > 0){
            return true;
        }else {
            return false;
        }
    }

}
