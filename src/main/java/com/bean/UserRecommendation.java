package com.bean;

/**
 * @Author:Su HangFei
 * @Date:2022-11-30 19 45
 * @Project:JavaWebEndofPeriod
 */
public class UserRecommendation {
    private Integer uid;

    private String mid;

    public UserRecommendation() {
    }

    public UserRecommendation(Integer uid, String mid) {
        this.uid = uid;
        this.mid = mid;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getMid() {
        return mid;
    }

    public void setMid(String mid) {
        this.mid = mid;
    }

    @Override
    public String toString() {
        return "UserRecommendation{" +
                "uid='" + uid + '\'' +
                ", mid='" + mid + '\'' +
                '}';
    }
}
