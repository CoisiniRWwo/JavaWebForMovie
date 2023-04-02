package com.controller;


import com.DaoFactory.DaoFactory;
import com.bean.Movie;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * @Author:Su HangFei
 * @Date:2022-11-24 21 31
 * @Project:JavaWebEndofPeriod
 */
@WebServlet("/movieAdminController")
public class movieAdminController extends HttpServlet {

    private String path;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action.equals("add")) {
            addMovie(request, response);
        } else if (action.equals("delete")) {
            deleteMovie(request, response);
        } else if (action.equals("update")) {
            updateMovie(request, response);
        } else if (action.equals("delAll")) {
            delAll(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

//    public void addMovie(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String movieName = request.getParameter("name");
//        String score = request.getParameter("score");
////        int movieScore = Integer.parseInt();
//        int number = 0 ;
//        if(score != null && !score.trim().equals("")){
//            number = Integer.parseInt(score.trim());
//        }
//        String director = request.getParameter("director");
//        String scriptwriter = request.getParameter("scriptwriter");
//        String actor = request.getParameter("actor");
//        String years = request.getParameter("years");
//        String country = request.getParameter("country");
//        String languages = request.getParameter("languages");
//        String length = request.getParameter("length");
//        String image = request.getParameter("image");
//        String des = request.getParameter("des");
//        String url = request.getParameter("url");
//        String type = request.getParameter("type");
//        Movie movie = new Movie();
//        movie.setName(movieName);
//        movie.setScore(number);
//        movie.setDirector(director);
//        movie.setScriptwriter(scriptwriter);
//        movie.setActor(actor);
//        movie.setYears(years);
//        movie.setCountry(country);
//        movie.setLanguages(languages);
//        movie.setLength(length);
//        movie.setImage(image);
//        movie.setDes(des);
//        movie.setUrl(url);
//        movie.setType(type);
//        boolean result = DaoFactory.getMovieDaoInstance().addMovie(movie);
//        request.setAttribute("url","movieManagement.jsp");
//        if (result){
//            path = "result.jsp";
//            request.setAttribute("msg","添加成功，点击确定跳转回管理电影页面");
//            request.getRequestDispatcher(path).forward(request,response);
//        }else{
//            path = "error.jsp";
//            request.setAttribute("msg","添加失败，点击确定跳转回管理电影页面");
//            request.getRequestDispatcher(path).forward(request,response);
//        }
//    }
    public void addMovie(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //创建FileItemFactory工厂实现类
        FileItemFactory fileItemFactory = new DiskFileItemFactory();
        //创建用于解析上传数据的工具类ServletFileUpload类
        ServletFileUpload servletFileUpload = new ServletFileUpload(fileItemFactory);
        String[] data = new String[13];
        //解析上传的数据
        try {
            List<FileItem> fileItems = servletFileUpload.parseRequest(request);
            //循环判断，每一个表单项，是普通类型，还是上传的文件
            for (int i = 0; i < fileItems.size(); i++) {
                if (fileItems.get(i).isFormField()) {
                    //普通表单项
                    data[i] = fileItems.get(i).getString("utf-8");
                } else {
//                    System.out.println(list.getName());
                    File file = new File("D:\\Study\\SHFWorkSpace\\JavaWebForMovie\\target\\JavaWebForMovie-1.0-SNAPSHOT\\images\\" + fileItems.get(i).getName());
                    data[i] = "images//" + fileItems.get(i).getName();
                    fileItems.get(i).write(file);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        Movie movie = new Movie();
        movie.setName(data[0]);
        int number = 0;
        if ((data[1] != null && !(data[1].trim().equals("")))) {
            number = Integer.parseInt((data[1].trim()));
        }
        movie.setScore(number);
        movie.setDirector(data[2]);
        movie.setScriptwriter(data[3]);
        movie.setActor(data[4]);
        movie.setYears(data[5]);
        movie.setCountry(data[6]);
        movie.setLanguages(data[7]);
        movie.setLength(data[8]);
        movie.setImage(data[9]);
        movie.setDes(data[10]);
        movie.setUrl(data[11]);
        movie.setType(data[12]);
        boolean result = DaoFactory.getMovieDaoInstance().addMovie(movie);
        request.setAttribute("url", "movieManagement.jsp");
        if (result) {
            path = "result.jsp";
            request.setAttribute("msg", "添加成功，点击确定跳转回管理电影页面");
            request.getRequestDispatcher(path).forward(request, response);
        } else {
            path = "error.jsp";
            request.setAttribute("msg", "添加失败，点击确定跳转回管理电影页面");
            request.getRequestDispatcher(path).forward(request, response);
        }
    }

    public void deleteMovie(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int movieid = Integer.parseInt(request.getParameter("movieid"));
        boolean result = DaoFactory.getMovieDaoInstance().deleteMovie(movieid);
        request.setAttribute("url", "movieManagement.jsp");
        if (result) {
            path = "result.jsp";
            request.setAttribute("msg", "删除成功，点击确定跳转回管理电影页面");
            request.getRequestDispatcher(path).forward(request, response);
        } else {
            path = "error.jsp";
            request.setAttribute("msg", "删除失败，点击确定跳转回管理电影页面");
            request.getRequestDispatcher(path).forward(request, response);
        }
    }

//    public void updateMovie(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String id = request.getParameter("id");
//        int idnumber = 0;
//        if (id != null && !id.trim().equals("")) {
//            idnumber = Integer.parseInt(id.trim());
//        }
//        String movieName = request.getParameter("name");
//        String score = request.getParameter("score");
////        int movieScore = Integer.parseInt();
//        int number = 0;
//        if (score != null && !score.trim().equals("")) {
//            number = Integer.parseInt(score.trim());
//        }
//        String director = request.getParameter("director");
//        String scriptwriter = request.getParameter("scriptwriter");
//        String actor = request.getParameter("actor");
//        String years = request.getParameter("years");
//        String country = request.getParameter("country");
//        String languages = request.getParameter("languages");
//        String length = request.getParameter("length");
//        String image = request.getParameter("image");
//        String des = request.getParameter("des");
//        String url = request.getParameter("url");
//        String type = request.getParameter("type");
//        Movie movie = new Movie(idnumber, movieName, number, director, scriptwriter, actor, years, country, languages, length, image, des, url, type);
//        boolean result = DaoFactory.getMovieDaoInstance().updateMovie(movie);
//        request.setAttribute("url", "movieManagement.jsp");
//        if (result) {
//            path = "result.jsp";
//            request.setAttribute("msg", "修改成功，点击确定跳转回管理电影页面");
//            request.getRequestDispatcher(path).forward(request, response);
//        } else {
//            path = "error.jsp";
//            request.setAttribute("msg", "修改失败，点击确定跳转回管理电影页面");
//            request.getRequestDispatcher(path).forward(request, response);
//        }
//    }

    public void updateMovie(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //创建FileItemFactory工厂实现类
        FileItemFactory fileItemFactory = new DiskFileItemFactory();
        //创建用于解析上传数据的工具类ServletFileUpload类
        ServletFileUpload servletFileUpload = new ServletFileUpload(fileItemFactory);
        String[] data = new String[14];
        //解析上传的数据
        try {
            List<FileItem> fileItems = servletFileUpload.parseRequest(request);
            //循环判断，每一个表单项，是普通类型，还是上传的文件
            for (int i = 0; i < fileItems.size(); i++) {
                if (fileItems.get(i).isFormField()) {
                    //普通表单项
//                    System.out.print(list.getString("utf-8"));
//                    data = data +","+ list.getString("utf-8");
                    data[i] = fileItems.get(i).getString("utf-8");
                } else {
//                    System.out.println(list.getName());
                    File file = new File("D:\\Study\\SHFWorkSpace\\JavaWebForMovie\\target\\JavaWebForMovie-1.0-SNAPSHOT\\images\\" + fileItems.get(i).getName());
                    data[i] = "images\\" + fileItems.get(i).getName();
                    fileItems.get(i).write(file);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        int idnumber = 0;
        if (data[0] != null && !data[0].trim().equals("")) {
            idnumber = Integer.parseInt(data[0].trim());
        }
        int number = 0;
        if (data[2] != null && !data[2].trim().equals("")) {
            number = Integer.parseInt(data[2].trim());
        }
        Movie movie = new Movie(idnumber, data[1], number, data[3], data[4], data[5], data[6], data[7], data[8], data[9], data[10], data[11], data[12], data[13]);
//        System.out.println(movie);
        boolean result = DaoFactory.getMovieDaoInstance().updateMovie(movie);
        request.setAttribute("url", "movieManagement.jsp");
        if (result) {
            path = "result.jsp";
            request.setAttribute("msg", "修改成功，点击确定跳转回管理电影页面");
            request.getRequestDispatcher(path).forward(request, response);
        } else {
            path = "error.jsp";
            request.setAttribute("msg", "修改失败，点击确定跳转回管理电影页面");
            request.getRequestDispatcher(path).forward(request, response);
        }
    }

    public void delAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String checkId = request.getParameter("checkId");
//        System.out.println(checkId);
        String newData = checkId.replace("on,", "");
//        System.out.println(newData);
        boolean result = DaoFactory.getMovieDaoInstance().delAll(newData);
        request.setAttribute("url", "movieManagement.jsp");
        if (result) {
            path = "result.jsp";
            request.setAttribute("msg", "删除成功，点击确定跳转回管理电影页面");
            request.getRequestDispatcher(path).forward(request, response);
        } else {
            path = "error.jsp";
            request.setAttribute("msg", "删除失败，点击确定跳转回管理电影页面");
            request.getRequestDispatcher(path).forward(request, response);
        }
    }

}
