<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.bean.User" %>
<%@ page import="com.Dao.Imp.UserDaoImp" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.awt.print.Book" %>
<%@ page import="com.DaoFactory.DaoFactory" %><%--
  Created by IntelliJ IDEA.
  User: zhuhaipeng
  Date: 2022/11/20
  Time: 22:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="UserDao" class="com.Dao.Imp.UserDaoImp"></jsp:useBean>

<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户管理界面 - 后台管理</title>

    <!-- 地址栏左侧图标 -->
    <link rel="shortcut icon" href="images/img/logo.png">

    <!-- 弹窗盒子的css -->
    <link href="libs/custombox/custombox.min.css" rel="stylesheet">

    <!-- 小图标的css -->
    <link href="libs/@mdi/font/css/materialdesignicons.min.css" rel="stylesheet" type="text/css"/>
    <link href="libs/dripicons/webfont/webfont.css" rel="stylesheet" type="text/css"/>

    <!-- 主题样式 -->
    <link href="css/app.css" rel="stylesheet" type="text/css"/>
</head>

<body>

<%
    if (session.getAttribute("username") == null || session.getAttribute("username").equals("")) {
        out.println("<script type='text/javascript'> alert('请先登录！'); location.href='login.jsp'</script>");
    }
    String username = (String) session.getAttribute("username");
    User user = null;
    if (session.getAttribute("username") != null) {
        user = DaoFactory.getUserDaoInstance().getUserByName(username);
        request.setAttribute("user", user);
    }
%>
<script type="text/javascript">
    function exitUser() {
        if (confirm("你确定要退出登陆吗？") == true) window.location = "adminToUserController?action=exitUser";
    }

    function updateUser(id, headurl, username, password, gender, telephone, email, registTime, ip) {
        document.getElementById("id").value = id;
        document.getElementById("headurl").value = headurl;
        document.getElementById("username").value = username;
        document.getElementById("password").value = password;
        document.getElementById("gender").value = gender;
        document.getElementById("telephone").value = telephone;
        document.getElementById("email").value = email;
        document.getElementById("registTime").value = registTime;
        document.getElementById("ip").value = ip;
    }

    function download(photo) {
        if (confirm("你确定要下载图片吗?") === true) {
            window.location.href = "userUpdateController?action=download&filename=" + photo + "&url=images/photos";
        }
    }
</script>
<header id="topnav">
    <nav class="navbar-custom">
        <div class="container-fluid">
            <ul class="list-unstyled topbar-right-menu float-right mb-0">
                <li class="dropdown notification-list">
                    <a class="navbar-toggle nav-link">
                        <div class="lines">
                            <span></span>
                            <span></span>
                            <span></span>
                        </div>
                    </a>
                </li>

                <li class="dropdown notification-list">
                    <a class="nav-link dropdown-toggle nav-user" data-toggle="dropdown" href="#" role="button"
                       aria-haspopup="false" aria-expanded="false">
                        <% if (user != null) {%>
                        <span class="ml-1"><img src="<%=user.getHeadurl()%>" alt="user-pic"
                                                class="rounded-circle thumb-sm bx-shadow-lg">
                            <%=session.getAttribute("username")%><i class="mdi mdi-chevron-down"></i> </span>
                        <%}%>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-animated profile-dropdown ">

                        <a class="dropdown-item notify-item" onclick="exitUser()">
                            <i class="dripicons-power"></i> <span>退出登录</span>
                        </a>
                    </div>
                </li>
            </ul>

            <ul class="list-inline menu-left mb-0">
                <li class="float-left">
                    <a href="index.jsp" class="logo" style="text-decoration: none; color: #fff; text-align: center">
                        <img src="images/img/logo.png" alt="" style="height: auto; width: 40px;">
                    </a>
                </li>
                <li class="float-left">
                    <a href="index.jsp" class="logo" style="text-decoration: none; color: #fff; text-align: center">
                        <span style="font-size: 30px">电影网</span>
                    </a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="topbar-menu">
        <div class="container-fluid">
            <div id="navigation">
                <ul class="navigation-menu">
                    <li class="has-submenu">
                        <a href="user_userHomepage.jsp"><i class="mdi mdi-view-dashboard"></i>主页</a>
                    </li>

                    <li class="">
                        <a href="user_userManagement.jsp"><i class="mdi mdi-account-box-multiple"></i>用户信息管理</a>
                    </li>

                    <li class="">
                        <a href="main.jsp"><i class="mdi mdi-file-multiple"></i>购票界面</a>
                    </li>

                </ul>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
</header>

<div class="wrapper">
    <div class="container-fluid">
        <div class="page-title-alt-bg"></div>
        <div class="page-title-box">
            <ol class="breadcrumb float-right">
                <li class="breadcrumb-item">后台管理</li>
                <li class="breadcrumb-item active">用户信息管理</li>
            </ol>
            <h4 class="page-title">用户信息管理</h4>
        </div>
        <div class="row" style="width: 50%; height: auto; position: absolute; left: 25%;">
            <div class="col-12">
                <div class="card-box">
                    <div class="row w-100">
                        <div class="col-md-12">
                            <h3 class="header-title float-left">用户信息</h3>
                            <a href="#modify-Movie" class="btn float-right btn-sm  btn-icon btn-warning"
                               data-animation="blur" data-plugin="custommodal"
                               onclick="updateUser('${user.id}','${user.headurl}','${user.username}','${user.password}','${user.gender}',
                                       '${user.telephone}','${user.email}','${user.registTime}','${user.ip}')"
                               data-overlaySpeed="100" data-overlayColor="#36404a"><i
                                    class="mdi mdi-wrench"></i>>修改信息</a>
                        </div>
                    </div>
                    <br>

                    <%-- 个人信息 --%>
                    <%if (user != null) {%>
                    <div class="border-top-0"><h3>头像 </h3></div>
                    <img onclick="download('${user.headurl}')" src="<%=user.getHeadurl()%>" alt="user-pic" width="110px"
                         height="115px"
                         class="img-thumbnail">
                    <hr/>
                    <h5>
                        <div class="border-top-0"><h3>名称 </h3></div>
                        <% out.print(user.getUsername());%>
                        <hr/>
                        <div class="border-top-0"><h3>密码 </h3></div>
                        ********
                        <hr/>
                        <div class="border-top-0"><h3>性别 </h3></div>
                        <% out.print(user.getGender());%>
                        <hr/>
                        <div class="border-top-0"><h3>邮箱 </h3></div>
                        <% out.print(user.getEmail());%>
                        <hr/>
                        <div class="border-top-0"><h3>手机号 </h3></div>
                        <% out.print(user.getTelephone());%>
                        <hr/>
                    </h5>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 修改个人信息 -->
<div id="modify-Movie" class="modal-demo" style="margin-top: 5%; height: 600px">
    <button type="button" class="close" onclick="Custombox.modal.close();">
        <span>&times;</span><span class="sr-only">Close</span>
    </button>
    <h4 class="custom-modal-title">修改个人信息</h4>
    <form class="form-horizontal m-2" method="post"
          action="userUpdateController?action=user_update" enctype="multipart/form-data">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">用户ID</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="id" id="id" readonly>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">用户头像</label>
            <div class="col-sm-10">
                <input type="hidden" name="headurl" id="headurl">
                <input type="file" class="form-control" name="file"
                       accept="image/gif,image/jpeg,image/jpg,image/png,image/svg">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">用户名</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="username" id="username">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">密码</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="password" id="password">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">性别</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="gender" id="gender">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">邮箱</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="email" id="email">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">手机号</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="telephone" id="telephone">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">注册日期</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="registTime" id="registTime" readonly>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">注册IP</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="ip" id="ip" readonly>
            </div>
        </div>
        <div class="form-group row">
            <div class="col-md-12 text-center align-content-center">
                <button type="submit" class="btn btn-primary btn-rounded w-md">提交修改</button>
            </div>
        </div>
    </form>
</div>

</body>
<!-- jQuery  -->
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>

<!-- 添加电影模块 -->
<script src="libs/custombox/custombox.min.js"></script>
<script src="js/jquery.core.js"></script>

</html>