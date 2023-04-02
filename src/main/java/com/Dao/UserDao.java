package com.Dao;

import com.bean.User;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public interface UserDao {
    public boolean login(String username, String password) throws SQLException;

    public boolean registration(User user);

    public ArrayList<User> getByRs(ResultSet rs) throws Exception;

    public ArrayList<User>  getAllUser(int num, int max) throws Exception;

    public ArrayList<User> getUserByNames(String name) throws Exception;

    public User getUserByName(String name) throws Exception;

    public ArrayList<User> getUserByNames(String name, int num, int maxNum) throws Exception;

    public User getUserById(int id) throws Exception;

    public int getUserCount() throws Exception;

    public boolean updateUser(User user) throws Exception;

    public boolean userUpdateUser(User user) throws Exception;

    public boolean delete(int id) throws Exception;

    public int getInquireCount(String name) throws Exception;

    public int getId(String name);

    public String getHeadByName(String username);

    public boolean deleteAll(String id) throws Exception;

}
