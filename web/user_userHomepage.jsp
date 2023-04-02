<%@ page import="com.bean.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bean.Movie" %>
<%@ page import="com.bean.Collection" %>
<%@ page import="com.DaoFactory.DaoFactory" %>
<%@ page import="com.bean.Page" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2022/11/15
  Time: 20:44
  To change this template use File | Settings | File Templates.
--%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="CollectionDao" class="com.Dao.Imp.CollectionDaoImp"></jsp:useBean>
<jsp:useBean id="UserDao" class="com.Dao.Imp.UserDaoImp"></jsp:useBean>
<jsp:useBean id="Collection" class="com.bean.Collection"></jsp:useBean>

<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="utf-8"/>
    <title>用户管理界面 - 后台管理</title>
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
    String username = (String) session.getAttribute("username");
    int currPageNo = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1");
    Page p = new Page();
    p.setCurrPageNo(currPageNo);
    p.setUserCount(DaoFactory.getCollectionDaoInstance().getMovieCount(username));
    ArrayList<Collection> collections = DaoFactory.getCollectionDaoInstance().getMovieByName(username, p.getCurrPageNo(), p.getPAGE_SIZE());
//    out.println(collections);
    p.setMovies(collections);
    int pageNum = p.getCurrPageNo(), maxPage = p.getMaxPageCount();
    User user = null;
    if (session.getAttribute("username") != null) {
        user = DaoFactory.getUserDaoInstance().getUserByName(username);
        request.setAttribute("user", user);
    }
    request.setAttribute("collections", collections);
%>

<script type="text/javascript">

    function updatePage(num, max) {
        if (num !== -10) window.location.href = "user_userHomepage.jsp?page=" + num;
        else {
            if (event.keyCode === 13) {
                if (document.getElementById("pageNum").value >= 1 && document.getElementById("pageNum").value <= max)
                    window.location.href = "user_userHomepage.jsp?page=" + document.getElementById("pageNum").value;
                else {
                    if (document.getElementById("pageNum").value !== "") confirm("请输入正确的页码！");
                }
            }
        }
    }

    function exitUser() {
        if (confirm("你确定要退出登陆吗？") == true) window.location = "adminToUserController?action=exitUser";
    }

    //选中全选按钮，下面的checkbox全部选中
    var selAll = document.getElementById("selAll");

    function selectAll() {
        var obj = document.getElementsByName("checkAll");
        if (document.getElementById("selAll").checked === false) {
            for (var i = 0; i < obj.length; i++) {
                obj[i].checked = false;
            }
        } else {
            for (var i = 0; i < obj.length; i++) {
                obj[i].checked = true;
            }
            document.getElementById("inverse1").checked = false;
        }

    }

    //当选中所有的时候，全选按钮会勾上
    function setSelectAll() {
        var obj = document.getElementsByName("checkAll");
        var count = obj.length;
        var selectCount = 0;

        for (var i = 0; i < count; i++) {
            if (obj[i].checked === true) {
                selectCount++;
            }
        }
        if (count === selectCount) {
            document.all.selAll.checked = true;

        } else {
            document.all.selAll.checked = false;
        }
    }

    //反选按钮
    function notSelectAll() {
        var checkboxs = document.getElementsByName("checkAll");
        for (var i = 0; i < checkboxs.length; i++) {
            var e = checkboxs[i];
            e.checked = !e.checked;
            setSelectAll();
        }
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
                        <% if (user != null) {%>
                        <span class="ml-1"><img src="<%=user.getHeadurl()%>" alt="user-pic"
                                                class="rounded-circle thumb-sm bx-shadow-lg">
                            <%=session.getAttribute("username")%><i class="mdi mdi-chevron-down"></i> </span>
                        <%}%>
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
                        <span style="font-size: 30px">电影网</span>
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
                        <a href="user_userHomepage.jsp"><i class="mdi mdi-view-dashboard"></i>主页</a>
                    </li>

                    <li class="">
                        <a href="user_userManagement.jsp"><i class="mdi mdi-account-box-multiple"></i>用户管理</a>
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
                <li class="breadcrumb-item">用户界面</li>
                <li class="breadcrumb-item active">主页</li>
            </ol>
            <h4 class="page-title">主页</h4>
        </div>

        <div class="row">
            <div class="col-xl-4">
                <div class="card-box">
                    <%--                    <h4 class="header-title">购票总数</h4>--%>
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
                        <h2 class="text-white mb-0 mt-2">购票总数</h2>
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
                    <form action="userUpdateController?action=deleteAll" method="post">
                        <div>
                            <h4 class="header-title float-left">购票信息</h4>
                            <div style="text-align: right">
                                <input type="checkbox" id="selAll" onclick="selectAll();"/>&nbsp;&nbsp;全选&nbsp;&nbsp;
                                <input type="checkbox" id="inverse1" onclick="notSelectAll();"/>&nbsp;&nbsp;反选&nbsp;&nbsp;
                                <input type="submit" name="deleteAll" value="批量删除" onclick="return confirm('是否确认删除？')"
                                       class="btn btn-sm btn-icon btn-danger">
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-centered table-hover mb-0" id="datatable">
                                <thead style="text-align: center">
                                <tr>
                                    <th class="border-top-0">选择</th>
                                    <th class="border-top-0">海报&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;电影名称</th>
                                    <th></th>
                                    <th></th>
                                    <th class="border-top-0">票价</th>
                                    <th class="border-top-0">座位</th>
                                    <th class="border-top-0">购买时间</th>
                                    <th class="border-top-0">删除</th>
                                </tr>
                                </thead>
                                <tbody style="text-align: center">
                                <c:forEach items="${collections}" var="collection">
                                    <tr>
                                        <th><input type="checkbox" name="checkAll" id="checkAll"
                                                   value="${collection.id}"
                                                   onclick="setSelectAll();"/><br/>${collection.id}</th>
                                        <th><img src="${collection.moviePhoto}" alt="user-pic" width="50px"
                                                 height="65px"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                ${collection.name}</th>
                                        <th></th>
                                        <th></th>
                                        <th>${collection.fare}</th>
                                        <th>${collection.seat}</th>
                                        <th>${collection.purchaseDate}</th>
                                        <td>
                                                <%-- 删除用户弹窗 --%>
                                            <a onclick="return confirm('是否确认删除？')"
                                               class="btn btn-sm btn-icon btn-danger"
                                               href="userUpdateController?action=delete&id=${collection.id}">
                                                <i class="mdi mdi-close"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                                <tfoot>
                                </tfoot>
                            </table>
                        </div>
                    </form>
                    <table style="width: 100%">
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
                    </table>

                </div>
            </div>
            <%--            </form>--%>
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
