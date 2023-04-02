package com.bean;

/**
 * @Author:Su HangFei
 * @Date:2022-12-04 13 21
 * @Project:JavaWebEndofPeriod
 */
public class Moviesimilar {
    private Integer mid;
    private String similar;

    public Moviesimilar() {
    }

    public Moviesimilar(Integer mid, String similar) {
        this.mid = mid;
        this.similar = similar;
    }

    public Integer getMid() {
        return mid;
    }

    public void setMid(Integer mid) {
        this.mid = mid;
    }

    public String getSimilar() {
        return similar;
    }

    public void setSimilar(String similar) {
        this.similar = similar;
    }

    @Override
    public String toString() {
        return "Moviesimilar{" +
                "mid=" + mid +
                ", similar='" + similar + '\'' +
                '}';
    }
}
