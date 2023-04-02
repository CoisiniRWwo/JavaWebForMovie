package com.bean;

/**
 * @Author:Su HangFei
 * @Date:2022-11-16 19 24
 * @Project:JavaWebEndofPeriod
 */
public class User {
    private int id;
    private String username;
    private String password;
    private String gender;
    private String email;
    private String telephone;
    private String registTime;
    private String headurl;
    private String ip;

    public User() {
    }

    public User(String username, String password, String gender, String email, String telephone) {
        this.username = username;
        this.password = password;
        this.gender = gender;
        this.email = email;
        this.telephone = telephone;
    }

    public User(int id, String username, String password, String gender, String email, String telephone, String headurl) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.gender = gender;
        this.email = email;
        this.telephone = telephone;
        this.headurl = headurl;
    }

    public User(String username, String password, String gender, String email, String telephone, String ip, String headurl) {
        this.username = username;
        this.password = password;
        this.gender = gender;
        this.email = email;
        this.telephone = telephone;
        this.ip = ip;
        this.headurl = headurl;
    }

    public User(Integer id, String username, String password, String gender, String email, String telephone, String registTime, String headurl) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.gender = gender;
        this.email = email;
        this.telephone = telephone;
        this.registTime = registTime;
        this.headurl = headurl;
    }

    public User(int id, String username, String password, String gender, String email, String telephone, String registTime, String headurl, String ip) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.gender = gender;
        this.email = email;
        this.telephone = telephone;
        this.registTime = registTime;
        this.headurl = headurl;
        this.ip = ip;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getHeadurl() {
        return headurl;
    }

    public void setHeadurl(String headurl) {
        this.headurl = headurl;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getRegistTime() {
        return registTime;
    }

    public void setRegistTime(String registTime) {
        this.registTime = registTime;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", gender='" + gender + '\'' +
                ", email='" + email + '\'' +
                ", telephone='" + telephone + '\'' +
                ", registTime='" + registTime + '\'' +
                ", headurl='" + headurl + '\'' +
                ", ip='" + ip + '\'' +
                '}';
    }
}
