<%--
  Created by IntelliJ IDEA.
  User: zhuhaipeng
  Date: 2022/11/20
  Time: 22:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.bean.Movie" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.DaoFactory.DaoFactory" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="movieDao" class="com.Dao.Imp.MovieDaoImp"/>
<jsp:useBean id="movie" class="com.bean.Movie"/>
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
%>
<script type="text/javascript">
    function exitUser() {
        if (confirm("你确定要退出登陆吗？") == true) window.location = "adminToUserController?action=exitUser";
    }

    function selectAll(obj) {
        $(".itemSelect").prop("checked", obj.checked);
    }

    function delall() {
        alert("确定要全部删除嘛？")
        var checkId = [];
        if ($("input[type='checkbox']:checked").length > 0) {
            $("input[type='checkbox']:checked").each(function (i) {
                checkId[i] = $(this).val();
            })
            window.location.href = "movieAdminController?action=delAll&checkId=" + checkId;
        } else {
            alert("请至少选择一个要删除的信息")
        }
    }

    function fx() {
        var ck = document.getElementsByName("check")
        for (var x = 0; x < ck.length; x++) {
            if (ck[x].checked) {
                ck[x].checked = false;
            } else {
                ck[x].checked = true;
            }
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
                <li class="breadcrumb-item active">电影管理</li>
            </ol>
            <h4 class="page-title">电影管理</h4>
        </div>
        <div class="row">
            <div class="col-12">
                <div class="card-box">
                    <div class="row w-100">
                        <div class="col-md-12">
                            <h4 class="header-title float-left">所有电影</h4>
                            <a href="#custom-modal" class="btn btn-primary waves-effect w-md mr-2 mb-2 float-right"
                               data-animation="blur" data-plugin="custommodal"
                               data-overlaySpeed="100" data-overlayColor="#36404a">添加电影</a>
                        </div>

                    </div>

                    <%-- 搜索栏 --%>
                    <div class="page-title-box">
                        <form>
                            <input type="text" placeholder="输入电影名，使用回车进行搜索" class="form-control"
                                   name="keyword"
                                   value="${requestScope.keyword}">
                            <button type="submit" class="sr-only"></button>
                        </form>
                    </div>


                    <%
                        String keyword = request.getParameter("keyword");
                        request.setAttribute("keyword", keyword);
                        ArrayList<Movie> moviesData = DaoFactory.getMovieDaoInstance().getByName(keyword);
                        request.setAttribute("moviesData", moviesData);
                    %>

                    <%-- 电影信息 --%>
                    <from method="post">
                        <table id="datatable" class="table table-bordered dt-responsive nowrap">
                            <thead>
                            <tr>
                                <th><input type="checkbox" onclick="selectAll(this)">全选</th>
                                <th>ID</th>
                                <th>名字</th>
                                <th>评分</th>
                                <th>导演</th>
                                <th>上映日期</th>
                                <th>上映国家</th>
                                <th>类型</th>
                                <th width="53px" fixed="true">删除</th>
                                <th width="53px" fixed="true">修改</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                if (moviesData != null) {
                                    for (int i = 0; i < moviesData.size(); i++) {
                                        movie = moviesData.get(i);
                            %>
                            <tr>
                                <td><input type="checkbox" name="check" class="itemSelect" value="<%=movie.getId()%>">
                                </td>
                                <td><%=movie.getId()%>
                                </td>
                                <td><%=movie.getName()%>
                                </td>
                                <td><%=movie.getScore()%>
                                </td>
                                <td><%=movie.getDirector()%>
                                </td>
                                <td><%=movie.getYears()%>
                                </td>
                                <td><%=movie.getCountry()%>
                                </td>
                                <td><%=movie.getType()%>
                                </td>
                                <td>
                                    <%-- 删除电影弹窗 --%>
                                    <a onclick="return confirm('是否确认删除？')" class="btn btn-sm btn-icon btn-danger"
                                       href="movieAdminController?action=delete&movieid=<%=movie.getId()%>">
                                        <i class="mdi mdi-close"></i>
                                    </a>
                                </td>
                                <td>
                                    <%--                                    ?action=selectid&movieid=${movie.id}--%>
                                    <a href="#modify-Movie" class="btn float-right btn-sm  btn-icon btn-warning"
                                       data-animation="blur" data-plugin="custommodal"
                                       onclick="func('<%=movie.getId()%>','<%=movie.getName()%>',<%=movie.getScore()%>,'<%=movie.getDirector()%>','<%=movie.getScriptwriter()%>',
                                               '<%=movie.getActor()%>','<%=movie.getYears()%>','<%=movie.getCountry()%>','<%=movie.getLanguages()%>','<%=movie.getLength()%>',
                                               '<%=movie.getDes()%>','<%=movie.getUrl()%>','<%=movie.getType()%>')"
                                       data-overlaySpeed="100" data-overlayColor="#36404a"><i
                                            class="mdi mdi-wrench"></i></a>
                                </td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                            </tbody>
                        </table>
                    </from>
                    <p>
                        <input type="button" value="反选" onclick="fx()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="button" value="批量删除" onclick="delall()">
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- 添加电影 -->
<div id="custom-modal" class="modal-demo" style="margin-top: 1%; height: 860px">
    <button type="button" class="close" onclick="Custombox.modal.close();">
        <span>&times;</span><span class="sr-only">Close</span>
    </button>
    <h4 class="custom-modal-title">添加电影</h4>
    <form class="form-horizontal m-2" method="post" action="movieAdminController?action=add"
          enctype="multipart/form-data">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">电影名</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="name">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">评分</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="score">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">导演</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="director">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">编剧</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="scriptwriter">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">演员</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="actor">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">上映日期</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="years">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">上映国家</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="country">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">语言</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="languages">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">片长</label>
            <div class="col-sm-10">
                <input class="form-control" type="number" name="length">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">电影海报图片</label>
            <div class="col-sm-10">
                <input type="file" class="form-control" name="image"
                       accept="image/gif,image/jpeg,image/jpg,image/png,image/svg">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">电影描述</label>
            <div class="col-sm-10">
                <textarea class="form-control" rows="5" name="des"></textarea>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">播放地址</label>
            <div class="col-sm-10">
                <input class="form-control" type="url" name="url">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">类型</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="type">
            </div>
        </div>
        <div class="form-group row ">
            <div class="col-md-12 text-center align-content-center">
                <button type="submit" class="btn btn-primary btn-rounded w-md">提交</button>
            </div>
        </div>
    </form>
</div>

<!-- 修改电影 -->
<div id="modify-Movie" class="modal-demo" style="margin-top: 1%; height: 860px">
    <script>
        function func(id, name, score, zdirector, scriptwriter, actor, years, country, languages, length, des, url, type) {
            document.getElementById("id").value = id;
            document.getElementById("name").value = name;
            document.getElementById("score").value = score;
            document.getElementById("zdirector").value = zdirector;
            document.getElementById("scriptwriter").value = scriptwriter;
            document.getElementById("actor").value = actor;
            document.getElementById("years").value = years;
            document.getElementById("country").value = country;
            document.getElementById("languages").value = languages;
            document.getElementById("length").value = length;
            // document.getElementById("image").value = image;
            document.getElementById('des').value = des;
            document.getElementById("url").value = url;
            document.getElementById("as").value = type;
        }
    </script>
    <button type="button" class="close" onclick="Custombox.modal.close();">
        <span>&times;</span><span class="sr-only">Close</span>
    </button>
    <h4 class="custom-modal-title">修改电影</h4>
    <form class="form-horizontal m-2" method="post" action="movieAdminController?action=update"
          enctype="multipart/form-data">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Id</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="id" id="id" readonly="readonly">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">电影名</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="name" id="name">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">评分</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="score" id="score">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">导演</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="director" id="zdirector">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">编剧</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="scriptwriter" id="scriptwriter">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">演员</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="actor" id="actor">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">上映日期</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="years" id="years">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">上映国家</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="country" id="country">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">语言</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="languages" id="languages">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">片长</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="length" id="length">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">电影海报图片</label>
            <div class="col-sm-10">
                <input type="file" class="form-control" name="image"
                       accept="image/gif,image/jpeg,image/jpg,image/png,image/svg" id="image">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">电影描述</label>
            <div class="col-sm-10">
                <textarea class="form-control" rows="5" name="des" id="des"></textarea>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">播放地址</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" name="url" id="url">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">类型</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" value="" name="type" id="as">
            </div>
        </div>
        <div class="form-group row ">
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