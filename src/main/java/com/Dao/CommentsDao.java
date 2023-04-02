package com.Dao;

import com.bean.Comments;

import java.util.ArrayList;

public interface CommentsDao {
    public ArrayList<Comments> getById(String movieid);

    public boolean addComment(Comments comments);
}
