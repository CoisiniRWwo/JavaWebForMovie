package com.Dao;

import com.bean.Movie;

import java.sql.ResultSet;
import java.util.ArrayList;

public interface MovieDao {

    public ArrayList<Movie> getByRs(ResultSet rs);

    public ArrayList<Movie> getByName(String moviename);

    public boolean addMovie(Movie movie);

    public boolean deleteMovie(int movieid);

    public boolean updateMovie(Movie movie);

    public ArrayList<Movie> getRecommendationMoive(String recommendationData);

    public ArrayList<Movie> getHotTopN();

    public ArrayList<Movie> getLikeMovies(String like);

    public ArrayList<Movie> getLikeMoviesLimit(String like,int index,int limit);

    public ArrayList<Movie> getSearch(String search);

    public ArrayList<Movie> getSearchtwo(String search,int index,int limit);

    public Movie getById(String moiveid);

    public boolean delAll(String movieId);

}
