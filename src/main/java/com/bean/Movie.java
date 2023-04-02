package com.bean;

/**
 * @Author:Su HangFei
 * @Date:2022-11-19 10 54
 * @Project:JavaWebEndofPeriod
 */
public class Movie {

    private Integer id;

    private String name;

    private int score;

    private String director;

    private String scriptwriter;

    private String actor;

    private String years;

    private String country;

    private String languages;

    private String length;

    private String image;

    private String des;

    private String url;

    private String type;

    public Movie() {
    }

    public Movie(Integer id, String name, Integer score, String director, String years, String country, String type) {
        this.id = id;
        this.name = name;
        this.score = score;
        this.director = director;
        this.years = years;
        this.country = country;
        this.type = type;
    }

    public Movie(Integer id, String name, Integer score, String director, String scriptwriter, String actor, String years, String country, String languages, String length, String image, String des, String url, String type) {
        this.id = id;
        this.name = name;
        this.score = score;
        this.director = director;
        this.scriptwriter = scriptwriter;
        this.actor = actor;
        this.years = years;
        this.country = country;
        this.languages = languages;
        this.length = length;
        this.image = image;
        this.des = des;
        this.url = url;
        this.type = type;
    }

    public String getScriptwriter() {
        return scriptwriter;
    }

    public void setScriptwriter(String scriptwriter) {
        this.scriptwriter = scriptwriter;
    }

    public String getActor() {
        return actor;
    }

    public void setActor(String actor) {
        this.actor = actor;
    }

    public String getLanguages() {
        return languages;
    }

    public void setLanguages(String languages) {
        this.languages = languages;
    }

    public String getLength() {
        return length;
    }

    public void setLength(String length) {
        this.length = length;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getYears() {
        return years;
    }

    public void setYears(String years) {
        this.years = years;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "Movie{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", score=" + score +
                ", director='" + director + '\'' +
                ", scriptwriter='" + scriptwriter + '\'' +
                ", actor='" + actor + '\'' +
                ", years='" + years + '\'' +
                ", country='" + country + '\'' +
                ", languages='" + languages + '\'' +
                ", length='" + length + '\'' +
                ", image='" + image + '\'' +
                ", des='" + des + '\'' +
                ", url='" + url + '\'' +
                ", type='" + type + '\'' +
                '}';
    }
}
