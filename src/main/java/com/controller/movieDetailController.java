package com.controller;

import com.DaoFactory.DaoFactory;
import com.bean.Collection;
import com.bean.Comments;
import org.apache.commons.io.IOUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @Author:Su HangFei
 * @Date:2022-12-04 15 11
 * @Project:JavaWebEndofPeriod
 */
@WebServlet("/movieDetailController")
public class movieDetailController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String action = request.getParameter("action");
//        System.out.println(action);
        if (action.equals("addComment")) {
            addComment(request, response);
        } else if (action.equals("buy")) {
            try {
                buyMovie(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (action.equals("downLoad")) {
            downLoadImg(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    public void addComment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("username") == null) {
            request.setAttribute("msg", "请先登录！");
            request.setAttribute("url", "login.jsp");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } else {
            String username = request.getSession().getAttribute("username").toString();
            String comment = request.getParameter("comment");
            String id = request.getParameter("id");
            int idnumber = 0;
            if (id != null && !id.trim().equals("")) {
                idnumber = Integer.parseInt(id.trim());
            }
            String moviename = request.getParameter("moviename").toString();
            Date date = new Date();
            String commenttime = date.toLocaleString();
//        System.out.println(moviename+"======");
            Comments comments = new Comments(username, idnumber, moviename, comment, commenttime);
            boolean result = DaoFactory.getCommentsDaoInstance().addComment(comments);
            if (result) {
                request.setAttribute("msg", "评论成功！");
                request.setAttribute("url", "index.jsp");
                request.getRequestDispatcher("result.jsp").forward(request, response);
            } else {
                request.setAttribute("msg", "评论失败！");
                request.setAttribute("url", "index.jsp");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        }
    }

    public void buyMovie(HttpServletRequest request, HttpServletResponse response) throws Exception {
        if (request.getSession().getAttribute("username") == null) {
            request.setAttribute("msg", "请先登录！");
            request.setAttribute("url", "login.jsp");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } else {
            String username = request.getSession().getAttribute("username").toString();
            String moviename = request.getParameter("name");
            String director = request.getParameter("director");
            String actor = request.getParameter("actor");
            String image = request.getParameter("image");
            String date = request.getParameter("date");
            String price = request.getParameter("price");
            double idnumber = 0.0;
            if (price != null && !price.trim().equals("")) {
                idnumber = Double.parseDouble(price.trim());
            }
            String row = request.getParameter("row");
            String col = request.getParameter("col");
            String seat = row + "排" + col + "座";
            System.out.println(idnumber);
//            System.out.println(row+","+col);
            Collection collection = new Collection(username, moviename, director, actor, idnumber, seat, date, image);
            boolean result = DaoFactory.getCollectionDaoInstance().buyMovie(collection);
            if (result) {
                request.setAttribute("msg", "购票成功！");
                request.setAttribute("url", "user_userHomepage.jsp");
                request.getRequestDispatcher("result.jsp").forward(request, response);
            } else {
                request.setAttribute("msg", "购票失败！");
                request.setAttribute("url", "index.jsp");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        }
    }

    public void downLoadImg(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取要下载的文件名与地址
        String downLoadFileUrl = request.getParameter("imgUrl");
//        System.out.println(downLoadFileUrl);
        String[] split = downLoadFileUrl.split("//");
//        System.out.println("===="+split[1]);
        //读取要下载的文件内容
        ServletContext servletContext = getServletContext();
        //获取要下载的文件类型
        String mimeType = servletContext.getMimeType(downLoadFileUrl);
//        System.out.println(mimeType);
        //告诉客户端收到的数据用于下载使用
        SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd 'at' HH:mm:ss z");
        Date date = new Date(System.currentTimeMillis());
        String time = formatter.format(date);
//        System.out.println(formatter.format(date));
        response.setHeader("Content-Disposition","attachment;filename="+time+".jpg");
        //映射到文件地址
        InputStream resourceAsStream = servletContext.getResourceAsStream(downLoadFileUrl);
        //获取响应的输出流
        ServletOutputStream outputStream = response.getOutputStream();
        //读取输入流的全部数据，给输出流
        IOUtils.copy(resourceAsStream, outputStream);
    }
}
