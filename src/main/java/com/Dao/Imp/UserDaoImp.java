package com.Dao.Imp;

import com.Dao.UserDao;
import com.bean.User;
import com.utils.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

/**
 * @Author:Su HangFei
 * @Date:2022-11-16 19 59
 * @Project:JavaWebEndofPeriod
 */
public class UserDaoImp implements UserDao {

    private String sql = "";

    private PreparedStatement pstmt;

    private User user;

    private ArrayList<User> users = new ArrayList<>();

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

    public boolean login(String username, String password) throws SQLException {
        getConn();
        sql = "select * from users where username = ? and password = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (rs.next()) {
            return true;
        } else {
            return false;
        }
    }

    public boolean registration(User user) {
        sql = "insert into users (username,password,gender,email,telephone,registTime,headurl,ip) values (?,?,?,?,?,?,?,?)";
        int result = 0;
        try {
            Date date = new Date();
            String commenttime = date.toLocaleString();
            pstmt = getConn().prepareStatement(sql);
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getGender());
            pstmt.setString(4, user.getEmail());
            pstmt.setString(5, user.getTelephone());
            pstmt.setString(6, commenttime);
            pstmt.setString(7, user.getHeadurl());
            pstmt.setString(8, user.getIp());
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

    public ArrayList<User> getByRs(ResultSet rs) throws Exception{
        try {
            if(rs == null || !rs.next()) return null;
            users.clear();
            do {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setGender(rs.getString("gender"));
                user.setEmail(rs.getString("email"));
                user.setTelephone(rs.getString("telephone"));
                user.setRegistTime(rs.getString("registtime"));
                user.setHeadurl(rs.getString("headurl"));
                user.setIp(rs.getString("ip"));
                users.add(user);
            }while (rs.next());
        }catch (Exception e){
            e.printStackTrace();
        }
        return users;
    }

    public ArrayList<User> getAllUser(int num, int max) throws Exception {
        getConn();
        sql = "select * from users limit " + (num - 1) * max + "," + max;
        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return getByRs(rs);
    }

    public ArrayList<User> getUserByNames(String name) throws Exception{
        getConn();
        if(name == null) {
            name = "";
        }
        sql = "select * from users where username like concat('%',?,'%')";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,name);
            rs = pstmt.executeQuery();
        }catch (Exception e){
            e.printStackTrace();
        }
        return getByRs(rs);
    }

    public ArrayList<User> getUserByNames(String name, int num, int maxNum) throws Exception{
        getConn();
        if(name == null) {
            name = "";
        }
        sql = "select * from users where username like concat('%',?,'%') limit " + (num - 1) * maxNum + "," + maxNum;
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,name);
            rs = pstmt.executeQuery();
        }catch (Exception e){
            e.printStackTrace();
        }
        return getByRs(rs);
    }

    public User getUserByName(String name) throws Exception{
        getConn();
        if(name == null) {
            name = "";
        }
        sql = "select * from users where username = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,name);
            rs = pstmt.executeQuery();
        }catch (Exception e){
            e.printStackTrace();
        }
        return getByRs(rs).get(0);
    }

    public User getUserById(int id) throws Exception {
        getConn();
        sql = "select * from users where id = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,id);
            rs = pstmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return getByRs(rs).get(0);
    }

    public int getUserCount() throws Exception {
        getConn();
        int count = 0;
        sql = "select count(*) from users";
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

    public boolean updateUser(User user) throws Exception{
        getConn();
        sql = "update users set username = ?, password = ?, gender = ?, email = ?, telephone = ?, registTime = ?, headurl = ?, ip = ? where id = ?";
        int result = 0;
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,user.getUsername());
            pstmt.setString(2,user.getPassword());
            pstmt.setString(3,user.getGender());
            pstmt.setString(4,user.getEmail());
            pstmt.setString(5,user.getTelephone());
            pstmt.setString(6,user.getRegistTime());
            pstmt.setString(7,user.getHeadurl());
            pstmt.setString(8,user.getIp());
            pstmt.setInt(9,user.getId());
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(result > 0){
            return true;
        }else {
            return false;
        }
    }

    public boolean userUpdateUser(User user) throws Exception{
        getConn();
        sql = "update users set username = ?, password = ?, gender = ?, email = ?, telephone = ?, headurl = ? where id = ?";
        int result = 0;
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,user.getUsername());
            pstmt.setString(2,user.getPassword());
            pstmt.setString(3,user.getGender());
            pstmt.setString(4,user.getEmail());
            pstmt.setString(5,user.getTelephone());
            pstmt.setString(6,user.getHeadurl());
            pstmt.setInt(7,user.getId());
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        if(result > 0){
            return true;
        }else {
            return false;
        }
    }

    public boolean delete(int id) throws Exception{
        getConn();
        sql = "delete from users where id = ?";
        int result = 0;
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,id);
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

    public boolean deleteAll(String id) throws Exception{
        getConn();
        sql = "delete from users where id in ("+id+")";
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

    public int getInquireCount(String name) throws Exception {
        getConn();
        int count = 0;
        sql = "select count(*) from users where username like concat('%',?,'%')";
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

    public int getId(String name){
        getConn();
        int id = 0;
        sql = " select id from users where username = ? ";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,name);
            rs = pstmt.executeQuery();
            if(rs.next()){
                id = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return id;
    }

    public String getHeadByName(String username){
        getConn();
        String headurl = "";
        sql = " select headurl from users where username = ? ";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,username);
            rs = pstmt.executeQuery();
            if(rs.next()){
                headurl = rs.getString(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return headurl;
    }

}
