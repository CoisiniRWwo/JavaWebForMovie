package com.controller;

import com.DaoFactory.DaoFactory;
import com.bean.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * @Author:Su HangFei
 * @Date:2022-12-02 22 13
 * @Project:JavaWebEndofPeriod
 */

@WebServlet("/registrationController")
public class registrationController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String action = request.getParameter("action");
        if (action.equals("registration")){
            registrationUser(request,response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    public void registrationUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String telephone = request.getParameter("telephone");
        String gender = request.getParameter("gender");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String ip = request.getParameter("ip");
        String headurl = request.getParameter("headurl");
        User users = new User(username, password, gender, email, telephone,ip,headurl);
        boolean result = DaoFactory.getUserDaoInstance().registration(users);
        if (result) {
            request.setAttribute("msg", "注册成功！");
            request.setAttribute("url", "login.jsp");
            request.getRequestDispatcher("result.jsp").forward(request, response);
        } else {
            request.setAttribute("msg", "注册失败！");
            request.setAttribute("url", "registration.jsp");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
