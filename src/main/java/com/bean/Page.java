package com.bean;

import java.util.List;



public class Page {
    // 总页数
    private int maxPageCount = 0;
    // 页面大小，即每页显示记录数
    private final int PAGE_SIZE = 7;
    // 记录总数
    private int userCount;
    // 当前页码
    private int currPageNo = 1;
    // 用户信息每页网站集合
    private List<User> users;
    // 电影购票每页网站集合
    private List<Collection> movies;

    public int getMaxPageCount() {
        return maxPageCount;
    }

    public void setMaxPageCount(int maxPageCount) {
        this.maxPageCount = maxPageCount;
    }

    public int getPAGE_SIZE() {
        return PAGE_SIZE;
    }

    public int getUserCount() {
        return userCount;
    }

    public void setUserCount(int userCount) {
        if (userCount > 0) {
            this.userCount = userCount;
            maxPageCount = this.userCount % PAGE_SIZE == 0 ? (this.userCount / PAGE_SIZE) : (this.userCount / PAGE_SIZE + 1);
        }
    }

    public int getCurrPageNo() {
        if(currPageNo == 0) return 0;
        return currPageNo;
    }

    public void setCurrPageNo(int currPageNo) {
        if(currPageNo > 0) this.currPageNo = currPageNo;
    }

    public List<User> getUsers() {
        return users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }

    public List<Collection> getMovies() {
        return movies;
    }

    public void setMovies(List<Collection> movies) {
        this.movies = movies;
    }
}
