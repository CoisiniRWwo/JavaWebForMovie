<%@ page import="java.awt.print.Book" %>
<%@ page import="com.bean.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.DaoFactory.DaoFactory" %>
<%@ page import="com.bean.Page" %><%--
  Created by IntelliJ IDEA.
  User: Time_
  Date: 2022/11/16
  Time: 14:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="UserDao" class="com.Dao.Imp.UserDaoImp"></jsp:useBean>
<jsp:useBean id="User" class="com.bean.User"></jsp:useBean>

<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="utf-8"/>
    <title>电影推荐购票网 - 后台管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta content="Coderthemes" name="author"/>

    <!-- 地址栏左侧图标 -->
    <link rel="shortcut icon" href="images/img/logo.png">

    <!-- 数据表样式 -->
    <link href="libs/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css"/>

    <!-- 图标样式 -->
    <link href="libs/@mdi/font/css/materialdesignicons.min.css" rel="stylesheet" type="text/css"/>
    <link href="libs/dripicons/webfont/webfont.css" rel="stylesheet" type="text/css"/>
    <link href="libs/simple-line-icons/css/simple-line-icons.css" rel="stylesheet" type="text/css"/>

    <!-- 主题样式 -->
    <link href="css/app.css" rel="stylesheet" type="text/css"/>
</head>

<body>

<%
    if (session.getAttribute("username") == null || session.getAttribute("username").equals("")) {
        out.println("<script type='text/javascript'> alert('请先登录！'); location.href='login.jsp'</script>");
    }
    int currPageNo = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1");
    Page p = new Page();
    p.setCurrPageNo(currPageNo);
    p.setUserCount(UserDao.getUserCount());
    ArrayList<User> user = DaoFactory.getUserDaoInstance().getAllUser(p.getCurrPageNo(), p.getPAGE_SIZE());
    p.setUsers(user);
    int pageNum = p.getCurrPageNo(), maxPage = p.getMaxPageCount();
    request.setAttribute("users", user);
%>
<script type="text/javascript">
    function updatePage(num, max) {

        if (num !== -10) window.location.href = "index_administrators.jsp?page=" + num + "&key=";
        else {
            if (event.keyCode === 13) {
                if (document.getElementById("pageNum").value >= 1 && document.getElementById("pageNum").value <= max)
                    window.location.href = "index_administrators.jsp?page=" + document.getElementById("pageNum").value + "&key=";
                else {
                    if (document.getElementById("pageNum").value !== "") confirm("请输入正确的页码！");
                }
            }
        }
    }

    function exitUser() {
        if (confirm("你确定要退出登陆吗？") == true) window.location = "adminToUserController?action=exitUser";
    }
</script>
<!-- Navigation Bar-->
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
                        <span class="ml-1">欢迎，<%=session.getAttribute("username")%>管理员<i
                                class="mdi mdi-chevron-down"></i> </span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right dropdown-menu-animated profile-dropdown ">
                        <!-- item-->

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
                        <span style="font-size: 30px">后台管理页面</span>
                    </a>
                </li>
            </ul>
        </div>

    </nav>

    <%-- 导航栏 --%>
    <div class="topbar-menu">
        <div class="container-fluid">
            <div id="navigation">
                <ul class="navigation-menu">
                    <li class="has-submenu">
                        <a href="index_administrators.jsp"><i class="mdi mdi-view-dashboard"></i>主页</a>
                    </li>

                    <li class="">
                        <a href="movieManagement.jsp"><i class="mdi mdi-file-multiple"></i>电影管理</a>
                    </li>

                    <li class="">
                        <a href="userManagement.jsp"><i class="mdi mdi-account-box-multiple"></i>用户管理</a>
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
                <li class="breadcrumb-item active">主页</li>
            </ol>
            <h4 class="page-title">主页</h4>
        </div>

        <div class="row">
            <div class="col-xl-4">
                <div class="card-box">
                    <%--                    <h4 class="header-title">总用户人数</h4>--%>
                    <p class="text-muted" id="time"></p>
                    <div class="mb-3 mt-4">
                        <%--                        <h2 class="font-weight-light"><% out.print(p.getUserCount());%></h2>--%>
                    </div>
                    <div class="chartjs-chart dash-sales-chart">
                        <canvas id="sales-chart"></canvas>
                    </div>
                </div><!-- end card-box-->

                <div class="card-box gradient-success bx-shadow-lg">
                    <div class="float-left">
                        <h2 class="text-white mb-0 mt-2">总用户人数</h2>
                    </div>
                    <div class="text-right">
                        <h3 class="text-white" id="onlineNumber">
                            <% out.print(p.getUserCount());%>
                        </h3>
                    </div>
                </div>
            </div>

            <div class="col-xl-8">
                <div class="card-box">
                    <h4>访问者信息</h4>
                    <div class="table-responsive">
                        <table class="table table-centered table-hover mb-0" id="datatable">
                            <thead>
                            <tr>
                                <th class="border-top-0">头像&nbsp&nbsp&nbsp&nbsp用户名</th>
                                <th class="border-top-0">IP地址</th>
                                <th class="border-top-0">第一次登陆时间</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                if (user != null) {
                                    for (int i = 0; i < user.size(); i++) {
                            %>
                            <tr>
                                <th>
                                    <img src="<%=user.get(i).getHeadurl()%>" alt="user-pic"
                                         class="rounded-circle thumb-sm bx-shadow-lg"/>
                                    <%out.print(user.get(i).getUsername()); %>
                                </th>
                                <th>
                                    <%out.print(user.get(i).getIp()); %>
                                </th>
                                <th>
                                    <%out.print(user.get(i).getRegistTime()); %>
                                </th>
                            </tr>
                            <%
                                    }
                                }
                            %>
                            </tbody>
                            <tfoot>
                            <tr>
                                <th>当前第 <% out.print(pageNum);%> 页，
                                    共 <% out.print(maxPage);%>页，
                                    <% out.print(p.getUserCount());%> 条记录
                                </th>
                                <th></th>
                                <th style="text-align: right">
                                    <input type="button" onclick="updatePage(1)" value="首页">&nbsp;
                                    <input type="button"
                                           onclick="updatePage(<%=pageNum - 1 > 0 ? pageNum - 1 : pageNum%>)"
                                           value="上一页">&nbsp;
                                    <input type="text" onkeydown="updatePage(-10,<%=maxPage%>)" id="pageNum"
                                           style="width: 50px">
                                    <input type="button"
                                           onclick="updatePage(<%=pageNum + 1 <= maxPage ? pageNum + 1 : pageNum%>)"
                                           value="下一页">&nbsp;
                                    <input type="button" onclick="updatePage(<%=maxPage%>)" value="尾页">&nbsp;
                                </th>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- jQuery  -->
        <script src="libs/jquery/jquery.min.js"></script>
        <script src="libs/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- 数据表图初始化 -->
        <script src="libs/jqvmap/jquery.vmap.min.js"></script>
        <script src="libs/jqvmap/maps/jquery.vmap.usa.js"></script>
        <script src="libs/chart.js/Chart.bundle.min.js"></script>
        <script src="js/jquery.dashboard.js"></script>
        <%-- 结束 --%>

</body>

</html>