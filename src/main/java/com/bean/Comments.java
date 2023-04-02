package com.bean;

/**
 * @Author:Su HangFei
 * @Date:2022-12-04 12 40
 * @Project:JavaWebEndofPeriod
 */
public class Comments {
    private Integer id;
    private String username;
    private Integer movieid;
    private String moviename;
    private String content;
    private String votes;
    private String commenttime;

    public Comments() {
    }

    public Comments(String username, Integer movieid, String moviename, String content, String commenttime) {
        this.username = username;
        this.movieid = movieid;
        this.moviename = moviename;
        this.content = content;
        this.commenttime = commenttime;
    }

    public Comments(Integer id, String username, Integer movieid, String moviename, String content, String votes, String commenttime) {
        this.id = id;
        this.username = username;
        this.movieid = movieid;
        this.moviename = moviename;
        this.content = content;
        this.votes = votes;
        this.commenttime = commenttime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Integer getMovieid() {
        return movieid;
    }

    public void setMovieid(Integer movieid) {
        this.movieid = movieid;
    }

    public String getMoviename() {
        return moviename;
    }

    public void setMoviename(String moviename) {
        this.moviename = moviename;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getVotes() {
        return votes;
    }

    public void setVotes(String votes) {
        this.votes = votes;
    }

    public String getCommenttime() {
        return commenttime;
    }

    public void setCommenttime(String commenttime) {
        this.commenttime = commenttime;
    }

    @Override
    public String toString() {
        return "comments{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", movieid=" + movieid +
                ", moviename='" + moviename + '\'' +
                ", content='" + content + '\'' +
                ", votes='" + votes + '\'' +
                ", commenttime='" + commenttime + '\'' +
                '}';
    }
}
