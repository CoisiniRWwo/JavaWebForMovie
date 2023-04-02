package com.bean;

/**
 * @Author:Su HangFei
 * @Date:2022-11-28 19 11
 * @Project:JavaWebEndofPeriod
 */
public class Collection {
    private int id;
    private String username;
    private String name;
    private String director;
    private String starring;
    private String place;
    private double fare;
    private String seat;
    private String datetime;
    private String purchaseDate;
    private String moviePhoto;

    public Collection() {
    }

    public Collection(String username, String name, String director, String starring, double fare, String seat, String purchaseDate, String moviePhoto) {
        this.username = username;
        this.name = name;
        this.director = director;
        this.starring = starring;
        this.fare = fare;
        this.seat = seat;
        this.purchaseDate = purchaseDate;
        this.moviePhoto = moviePhoto;
    }

    public Collection(int id, String username, String name, String director, String starring, String place, double fare, String seat, String datetime, String purchaseDate, String moviePhoto) {
        this.id = id;
        this.username = username;
        this.name = name;
        this.director = director;
        this.starring = starring;
        this.place = place;
        this.fare = fare;
        this.seat = seat;
        this.datetime = datetime;
        this.purchaseDate = purchaseDate;
        this.moviePhoto = moviePhoto;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getStarring() {
        return starring;
    }

    public void setStarring(String starring) {
        this.starring = starring;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public double getFare() {
        return fare;
    }

    public void setFare(double fare) {
        this.fare = fare;
    }

    public String getSeat() {
        return seat;
    }

    public void setSeat(String seat) {
        this.seat = seat;
    }

    public String getDatetime() {
        return datetime;
    }

    public void setDatetime(String datetime) {
        this.datetime = datetime;
    }

    public String getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(String purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public String getMoviePhoto() {
        return moviePhoto;
    }

    public void setMoviePhoto(String moviePhoto) {
        this.moviePhoto = moviePhoto;
    }

    @Override
    public String toString() {
        return "Collection{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", name='" + name + '\'' +
                ", director='" + director + '\'' +
                ", starring='" + starring + '\'' +
                ", place='" + place + '\'' +
                ", fare=" + fare +
                ", seat='" + seat + '\'' +
                ", datetime='" + datetime + '\'' +
                ", purchaseDate='" + purchaseDate + '\'' +
                ", moviePhoto='" + moviePhoto + '\'' +
                '}';
    }
}
