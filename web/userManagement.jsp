<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.bean.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.awt.print.Book" %>
<%@ page import="com.DaoFactory.DaoFactory" %>
<%@ page import="com.bean.Page" %><%--
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
    <title>电影推荐购票网 - 后台管理</title>

    <!-- 地址栏左侧图标 -->
    <link rel="shortcut icon" href="img/logo.png">

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
    request.setCharacterEncoding("utf-8");
    session.setAttribute("keyword", request.getParameter("keyword"));
    String keyword = (String) session.getAttribute("keyword");
    if (keyword == null) keyword = "";
    int currPageNo = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1");
    Page p = new Page();
    p.setCurrPageNo(currPageNo);
    if (UserDao.getUserByNames(keyword) != null) p.setUserCount(UserDao.getUserByNames(keyword).size());
    ArrayList<User> user = DaoFactory.getUserDaoInstance().getUserByNames(keyword, p.getCurrPageNo(), p.getPAGE_SIZE());
    p.setUsers(user);
    int pageNum = p.getCurrPageNo(), maxPage = p.getMaxPageCount();
    request.setAttribute("users", user);
%>
<script type="text/javascript">
    function updatePage(num, max) {
        if (num !== -10) window.location.href = "userManagement.jsp?page=" + num + "&keyword=<%=keyword%>";
        else {
            if (event.keyCode === 13) {
                if (document.getElementById("pageNum").value >= 1 && document.getElementById("pageNum").value <= max)
                    window.location.href = "userManagement.jsp?page=" + document.getElementById("pageNum").value + "&keyword=<%=keyword%>";
                else {
                    if (document.getElementById("pageNum").value !== "") confirm("请输入正确的页码！");
                }
            }
        }
    }

    function exitUser() {
        if (confirm("你确定要退出登陆吗？") === true) window.location = "adminToUserController?action=exitUser";
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

                        <a class="dropdown-item notify-item" onclick="exitUser()">
                            <i class="dripicons-power"></i> <span>退出登录</span>
                        </a>
                    </div>
                </li>
            </ul>

            <ul class="list-inline menu-left mb-0">
                <li class="float-left">
                    <a href="index.jsp" class="logo" style="text-decoration: none; color: #fff; text-align: center">
                        <img src="img/logo.png" alt="" style="height: auto; width: 40px;">
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
                <li class="breadcrumb-item active">用户管理</li>
            </ol>
            <h4 class="page-title">用户管理</h4>
        </div>

        <div class="row">
            <div class="col-12">
                <div class="card-box">

                    <%-- 搜索栏 --%>
                    <div class="page-title-box">
                        <form action="userManagement.jsp?username=<%=request.getAttribute("username")%>"
                              method="post">
                            <input type="text" placeholder="输入用户名，使用回车进行搜索" class="form-control"
                                   name="keyword" value="${requestScope.keyword}">
                            <button type="submit" class="sr-only"></button>
                        </form>
                    </div>

                    <form action="adminToUserController?action=deleteAll" method="post">
                        <div class="row w-100">
                            <div class="col-md-12">
                                <h4 class="header-title float-left">所有用户</h4>
                                <div style="text-align: right">
                                    <input type="checkbox" id="selAll" onclick="selectAll();"/>&nbsp;&nbsp;全选&nbsp;&nbsp;
                                    <input type="checkbox" id="inverse1" onclick="notSelectAll();"/>&nbsp;&nbsp;反选&nbsp;&nbsp;
                                    <input type="submit" name="deleteAll" value="批量删除" onclick="return confirm('是否确认删除？')"
                                           class="btn btn-sm btn-icon btn-danger">
                                </div>
                            </div>
                        </div>
                        <br>

                        <%-- 电影信息 --%>

                        <table id="datatable" class="table table-bordered dt-responsive nowrap"
                               style="text-align: center">
                            <thead>
                            <tr>
                                <th width="80px" fixed="true">用户ID</th>
                                <th width="90px" fixed="true">用户头像</th>
                                <th width="200px" fixed="true">用户名</th>
                                <th>密码</th>
                                <th width="60px" fixed="true">性别</th>
                                <th>手机号</th>
                                <th width="260px" fixed="true">邮箱</th>
                                <th>注册日期</th>
                                <th>注册IP</th>
                                <th width="53px" fixed="true">删除</th>
                                <th width="53px" fixed="true">修改</th>
                            </tr>
                            </thead>
                            <tbody style="text-align: center">
                            <c:forEach items="${users}" var="user">
                                <tr>
                                    <th><input type="checkbox" name="checkAll" id="checkAll" value="${user.id}"
                                               onclick="setSelectAll();"/><br/>${user.id}</th>
                                    <th><img src="${user.headurl}" alt="user-pic" width="103px" height="103px"
                                             class="rounded-circle thumb-sm bx-shadow-lg"/></th>
                                    <th>${user.username}</th>
                                    <th>${user.password}</th>
                                    <th>${user.gender}</th>
                                    <th>${user.telephone}</th>
                                    <th>${user.email}</th>
                                    <th>${user.registTime}</th>
                                    <th>${user.ip}</th>
                                    <td>
                                            <%-- 删除用户弹窗 --%>
                                        <a onclick="return confirm('是否确认删除？')" class="btn btn-sm btn-icon btn-danger"
                                           href="adminToUserController?action=delete&id=${user.id}">
                                            <i class="mdi mdi-close"></i>
                                        </a>
                                    </td>
                                    <td>
                                        <a href="#modify-Movie" class="btn float-right btn-sm  btn-icon btn-warning"
                                           data-animation="blur" data-plugin="custommodal"
                                           onclick="updateUser('${user.id}','${user.headurl}','${user.username}','${user.password}','${user.gender}',
                                                   '${user.telephone}','${user.email}','${user.registTime}','${user.ip}')"
                                           data-overlaySpeed="100" data-overlayColor="#36404a"><i
                                                class="mdi mdi-wrench"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </form>
                    <table style="width: 100%">
                        <%--                        <form action="admin_userManagement.jsp" method="post">--%>
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
                        <%--                        </form>--%>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 修改用户资料 -->
<div id="modify-Movie" class="modal-demo" style="margin-top: 5%; height: 600px">
    <button type="button" class="close" onclick="Custombox.modal.close();">
        <span>&times;</span><span class="sr-only">Close</span>
    </button>
    <h4 class="custom-modal-title">修改用户资料</h4>
    <form class="form-horizontal m-2" method="post"
          action="adminToUserController?action=update" enctype="multipart/form-data">
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
            <label class="col-sm-2 col-form-label">手机号</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="telephone" id="telephone">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">邮箱</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="email" id="email">
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