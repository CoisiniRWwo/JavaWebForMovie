package com.Dao;

import com.bean.Collection;

import java.sql.ResultSet;
import java.util.ArrayList;

public interface CollectionDao {
    public ArrayList<Collection> getByRs(ResultSet rs) throws Exception;
    public ArrayList<Collection> getMovieByName(String name) throws Exception;
    public int getMovieCount() throws Exception;
    public boolean delete(int id) throws Exception;
    public void resetId() throws Exception;

    public ArrayList<Collection> getMovieByName(String name, int num, int maxNum) throws Exception;

    public int getMovieCount(String name ) throws Exception;

    public boolean buyMovie(Collection collection) throws Exception;

    public boolean deleteAll(String id) throws Exception;

}
