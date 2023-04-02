package com.Dao.Imp;

import com.Dao.MovieDao;
import com.bean.Movie;
import com.utils.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * @Author:Su HangFei
 * @Date:2022-11-19 10 56
 * @Project:JavaWebEndofPeriod
 */
public class MovieDaoImp implements MovieDao {

    private String sql = "";
    private PreparedStatement pstmt;
    private Movie movie;
    private ArrayList<Movie> movies = new ArrayList<Movie>();
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

    public ArrayList<Movie> getByRs(ResultSet rs) {
        try {
            if (rs == null || !rs.next()) {
                return null;
            }
            movies.clear();
            do {
                movie = new Movie();
                movie.setId(rs.getInt("id"));
                movie.setName(rs.getString("name"));
                movie.setScore(rs.getInt("score"));
                movie.setDirector(rs.getString("director"));
                movie.setScriptwriter(rs.getString("scriptwriter"));
                movie.setActor(rs.getString("actor"));
                movie.setYears(rs.getString("years"));
                movie.setCountry(rs.getString("country"));
                movie.setLanguages(rs.getString("languages"));
                movie.setLength(rs.getString("length"));
                movie.setImage(rs.getString("image"));
                movie.setDes(rs.getString("des"));
                movie.setUrl(rs.getString("url"));
                movie.setType(rs.getString("type"));
                movies.add(movie);
            } while (rs.next());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movies;
    }

    public ArrayList<Movie> getByRstwo(ResultSet rs) {
        try {
            if (rs == null || !rs.next()) {
                return null;
            }
            movies.clear();
            do {
                movie = new Movie();
                movie.setName(rs.getString("name"));
                movie.setActor(rs.getString("actor"));
                movie.setYears(rs.getString("years"));
                movie.setImage(rs.getString("image"));
                movies.add(movie);
            } while (rs.next());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movies;
    }

    public ArrayList<Movie> getByName(String moviename) {
        getConn();
        if (moviename == null) {
            moviename = "";
        }
        sql = "select * from allmovies where name like concat('%',?,'%')  limit 10";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, moviename);
            rs = pstmt.executeQuery();
        } catch (SQLException e) {
             e.printStackTrace();
        }
        return getByRs(rs);
    }

    public boolean addMovie(Movie movie){
        getConn();
        sql = "insert into allmovies values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        int result = 0;

        try {
            pstmt = getConn().prepareStatement(sql);
            pstmt.setString(1,null);
            pstmt.setString(2,movie.getName());
            pstmt.setInt(3,movie.getScore());
            pstmt.setString(4,movie.getDirector());
            pstmt.setString(5,movie.getScriptwriter());
            pstmt.setString(6,movie.getActor());
            pstmt.setString(7,movie.getYears());
            pstmt.setString(8,movie.getCountry());
            pstmt.setString(9,movie.getLanguages());
            pstmt.setString(10,movie.getLength());
            pstmt.setString(11,movie.getImage());
            pstmt.setString(12,movie.getDes());
            pstmt.setString(13,movie.getUrl());
            pstmt.setString(14,movie.getType());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (result>0){
            return true;
        }else {
            return false;
        }
    }

    public boolean deleteMovie(int movieid){
        int result = 0;
        sql = "delete from allmovies where id = ?";

        try {
            pstmt = getConn().prepareStatement(sql);
            pstmt.setInt(1,movieid);
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (result>0){
            return true;
        }else{
            return false;
        }
    }

    public boolean updateMovie(Movie movie) {
        sql = "update allmovies set name=?,score=?,director=?,scriptwriter=?,actor=?,years=?,country=?,languages=?,length=?,image=?,des=?,url=?,type=? where id = ?";
        int result = 0;
        try {
            pstmt = getConn().prepareStatement(sql);
            pstmt.setString(1,movie.getName());
            pstmt.setInt(2,movie.getScore());
            pstmt.setString(3,movie.getDirector());
            pstmt.setString(4,movie.getScriptwriter());
            pstmt.setString(5,movie.getActor());
            pstmt.setString(6,movie.getYears());
            pstmt.setString(7,movie.getCountry());
            pstmt.setString(8,movie.getLanguages());
            pstmt.setString(9,movie.getLength());
            pstmt.setString(10,movie.getImage());
            pstmt.setString(11,movie.getDes());
            pstmt.setString(12,movie.getUrl());
            pstmt.setString(13,movie.getType());
            pstmt.setInt(14,movie.getId());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (result>0){
            return true;
        }else{
            return false;
        }
    }

    public ArrayList<Movie> getRecommendationMoive(String recommendationData) {

        getConn();
        sql = "select * from allmovies where FIND_IN_SET(id,?) order by years desc ";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,recommendationData);
            rs=pstmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return getByRs(rs);
    }

    @Override
    public ArrayList<Movie> getHotTopN() {

        getConn();
        sql = "select * from allmovies order by years desc limit 5 ";

        try {
            pstmt = conn.prepareStatement(sql);
            rs=pstmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return getByRs(rs);
    }

    @Override
    public ArrayList<Movie> getLikeMovies(String like) {

        getConn();
        sql = "select * from allmovies where type = ? order by years desc limit 5";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,like);
            rs=pstmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return getByRs(rs);
    }

    public ArrayList<Movie> getLikeMoviesLimit(String like,int index,int limit){
        getConn();
        sql = "select * from allmovies where type = ? order by years desc limit ?,?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,like);
            pstmt.setInt(2,index);
            pstmt.setInt(3,limit);
            rs=pstmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return getByRs(rs);
    }

    public ArrayList<Movie> getSearch(String search){
        getConn();
        sql = "select name,actor,max(image) as image,years from allmovies group by name,actor,years having name like concat('%',?,'%') order by years desc limit 5";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,search);
            rs=pstmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return getByRstwo(rs);
    }

    public ArrayList<Movie> getSearchtwo(String search,int index,int limit){
        getConn();
        sql = "select name,actor,max(image) as image,years from allmovies group by name,actor,years having name like concat('%',?,'%') order by years desc limit ?,?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,search);
            pstmt.setInt(2,index);
            pstmt.setInt(3,limit);
            rs=pstmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return getByRstwo(rs);
    }

    @Override
    public Movie getById(String movieid) {
        getConn();
        sql = "select * from allmovies where id  = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,movieid);
            rs=pstmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return getByRs(rs).get(0);
    }

    public boolean delAll(String movieId){
        int result = 0;
        sql = "delete from allmovies where id in ("+movieId+")";

        try {
            pstmt = getConn().prepareStatement(sql);
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (result>0){
            return true;
        }else{
            return false;
        }
    }

}
