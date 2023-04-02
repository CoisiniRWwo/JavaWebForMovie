<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.DaoFactory.DaoFactory" %>
<%@ page import="com.bean.Movie" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bean.Comments" %><%--
  Created by IntelliJ IDEA.
  User: Time_
  Date: 2022/12/2
  Time: 20:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="movie" class="com.bean.Movie"/>
<jsp:useBean id="comment" class="com.bean.Comments"/>

<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>XXX电影推荐网</title>
    <link rel="stylesheet" href="fonts/iconfont.css">
    <link rel="icon" type="image/x-icon" href="images/logo.png">
    <link rel="stylesheet" href="css/mainCss/comment.css"/>
    <link rel="stylesheet" href="css/mainCss/sinaFaceAndEffec.css"/>
    <link rel="stylesheet" href="css/mainCss/dreamlike.css"/>

    <!-- Bootstrap -->
    <link href="css/mainCss/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/mainCss/info.css">

</head>
<style>
    body {
        /*  字号 */
        font-size: 16px;
        /*  字体颜色  */
        color: #333;
        /* 行距 */
        line-height: 1.75;
    }

</style>
<body class="bg-dark">

<!-- jQuery -->
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/popper.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件-->
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="js/comment.js"></script>
<script type="text/javascript" src="js/sinaFaceAndEffec.js"></script>

<div id="main">
    <jsp:include page="headerMain.jsp"/>

        <%
            String moiveid = request.getParameter("moiveid");
            Movie movieData = DaoFactory.getMovieDaoInstance().getById(moiveid);
            System.out.println(movieData.toString());
    %>

    <div class="mid" style="margin-top: 10px;">
        <!--电影详情 开始 -->
        <div class="row" style="height: 400px;">
            <div class="col-md-6 detail" style="margin-top: -40px;">
                <img src="<%=movieData.getImage()%>" style="height: 354px; border: 0px;">
                <table class="info">
                    <tr class="info-tr">
                        <td>电影名：
                        </td>
                        <td style="height:60px;">
                            <%=movieData.getName()%>
                        </td>
                    </tr>
                    <tr class="info-tr">
                        <td>上映日期：</td>
                        <td><%=movieData.getYears()%>
                        </td>
                    </tr>
                    <tr class="info-tr">
                        <td>电影时长：</td>
                        <td><%=movieData.getLength()%>
                        </td>
                    </tr>
                    <tr class="info-tr">
                        <td>导演：</td>
                        <td><%=movieData.getDirector()%>
                        </td>
                    </tr>
                    <tr class="info-tr">
                        <td>地区：</td>
                        <td><%=movieData.getCountry()%>
                        </td>
                    </tr>
                    <tr class="info-tr">
                        <td>类型：</td>
                        <td><%=movieData.getType()%>
                        </td>
                    <tr class="info-tr">
                        <td>评分：</td>
                        <td><%=movieData.getScore()%>
                        </td>
                    </tr>
                    <tr class="info-tr">
                        <td colspan="2">
                            <a class="btn btn-success" href="#" data-toggle="modal" data-target=".bd-example-modal-gp">
                                <span>在线购票</span>
                            </a>
                        </td>
                    </tr>
                    <tr class="info-tr">
                        <td colspan="2">
                            <a href="movieDetailController?action=downLoad&imgUrl=<%=movieData.getImage()%>">下载海报</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-md-6" style="margin-top: -45px;">
                <div class="juqing">
                    <h4>主演</h4>
                </div>
                <span style="
                    width: auto;
                    text-overflow:ellipsis;
                    display: -webkit-box;
                    -webkit-box-orient: vertical;
                     -webkit-line-clamp:2;
                     overflow: hidden;">
                    <%=movieData.getActor()%>
                </span>
            </div>
            <div class="col-md-6" style="margin-top: -310px;margin-left: 676px">
                <div class="juqing">
                    <h4>简介</h4>
                </div>
                <span style="
                    width: auto;
                    text-overflow:ellipsis;
                    display: -webkit-box;
                    -webkit-box-orient: vertical;
                     -webkit-line-clamp:7;
                     overflow: hidden;">
                    <%=movieData.getDes()%>
                </span>
            </div>

        </div>
        <!-- 电影详情 结束 -->

        <!-- 电影购票 -->
        <div class="modal fade bd-example-modal-gp" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" style="margin-top: 22%">
                <div class="modal-content" style="width: 320px; height: 280px;">
                    <form class="form-horizontal m-2" method="post" action="movieDetailController?action=buy">
                        <div class="form-group row">
                            <label style="margin-left: 20px;margin-right: 10px;margin-top: 3px">电影名称</label>
                            <div>
                                <input type="text" class="form-control" value="<%=movieData.getName()%>" name="name"
                                       readonly="readonly">
                            </div>
                        </div>
                        <input type="hidden" name="director" value="<%=movieData.getDirector()%>">
                        <input type="hidden" name="actor" value="<%=movieData.getActor()%>">
                        <input type="hidden" name="image" value="<%=movieData.getImage()%>">
                        <div class="form-group row">
                            <label style="margin-left: 20px;margin-right: 10px;margin-top: 3px">观看日期</label>
                            <div>
                                <input type="date" class="form-control" value="" name="date" style="width: 207px">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label style="margin-left: 20px;margin-right: 10px;margin-top: 3px">座位选择</label>
                            <div style="width: 200px;display: inline-block;">
                                <input type="text" list="typeRow" name="row"
                                       style="width: 65px;
                                                background-color:#fff;
                                                border:1px solid #ced4da;
                                                padding:.375rem .75rem;
                                                border-radius:.25rem;
                                                height:calc(1.5em + .75rem + 2px);">
                                <datalist id="typeRow">
                                    <option>1</option>
                                    <option>2</option>
                                    <option>3</option>
                                    <option>4</option>
                                    <option>5</option>
                                    <option>6</option>
                                    <option>7</option>
                                    <option>8</option>
                                    <option>9</option>
                                </datalist>
                                <span style="margin-left: 5px;margin-right: 5px;margin-top: 3px">行</span>
                                <input type="text" list="typeList" name="col"
                                       style="width: 65px;
                                                background-color:#fff;
                                                border:1px solid #ced4da;
                                                padding:.375rem .75rem;
                                                border-radius:.25rem;
                                                height:calc(1.5em + .75rem + 2px);">
                                <datalist id="typeList">
                                    <option>1</option>
                                    <option>2</option>
                                    <option>3</option>
                                    <option>4</option>
                                    <option>5</option>
                                    <option>6</option>
                                    <option>7</option>
                                    <option>8</option>
                                    <option>9</option>
                                </datalist>
                                <span style="margin-left: 5px;margin-right: 5px;margin-top: 3px">列</span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label style="margin-left: 20px;margin-right: 10px;margin-top: 3px">购票价格</label>
                            <div>
                                <input type="text" class="form-control" value="99.99" readonly="readonly" name="price">
                            </div>
                        </div>
                        <div class="form-group row ">
                            <div class="col-md-12 text-center align-content-center">
                                <button type="submit" class="btn btn-success">提交订单</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- 评论框 -->
        <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content" style="width: 402px; height: 118px;">
                    <div style="width: 400px; height: auto;">
                        <div class="content">
                            <form method="post" action="movieDetailController?action=addComment">
                                <input type="hidden" name="id" value="<%=moiveid%>">
                                <input type="hidden" name="moviename" value="<%=movieData.getName()%>">
                                <div class="cont-box">
                                    <textarea class="text" name="comment" placeholder="请输入评论..."
                                              id="description"></textarea>
                                </div>
                                <div class="tools-box">
                                    <div class="submit-btn">
                                        <input type="submit" value="提交评论"/>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 评论部分 -->
        <div class="row" style="background: white;">
            <div class="row" style="width: 100%; margin-top: 20px;">
                <div class="col-md-12">
                    <h3 class="hot-title" style="display : inline">电影评论&nbsp;&nbsp;&nbsp;&nbsp;</h3>
                    <a href="#">
                        <span data-toggle="modal" data-target=".bd-example-modal-lg">去写评论</span>
                    </a>
                </div>
            </div>

            <div class="row">
                <div class=" comment">
                    <%
                        ArrayList<Comments> commentData = DaoFactory.getCommentsDaoInstance().getById(moiveid);
                        System.out.println(commentData);
                    %>
                    <%--                    <c:forEach var="comment" items="${comments}" varStatus="status">--%>
                    <%
                        if (commentData != null) {
                            for (int i = 0; i < commentData.size(); i++) {
                                comment = commentData.get(i);
                                String headurl = DaoFactory.getUserDaoInstance().getHeadByName(comment.getUsername());
                                if (headurl == null) {
                                    headurl = "images/photos/user1.png";
                                }
                    %>
                    <div class="c-info" style="height: auto">
                        <div class="row">
                            <!-- 头像图片 -->
                            <img src="<%=headurl%>" alt=""
                                 class="rounded-circle mt-2" width="50px" height="50px">
                            <div>
                                <h4><%=comment.getUsername()%>
                                </h4>
                                <span style="color: gray;">评论时间:<%=comment.getCommenttime()%></span>
                            </div>
                        </div>
                        <div class="row" style="height: auto;width: 1150px">
                            <%=comment.getContent()%>
                        </div>
                        <br>
                    </div>

                    <%
                        }
                    } else {
                    %>
                    <p align="center">暂无评论</p>
                    <%
                        }
                    %>
                    <%--                    </c:forEach>--%>
                </div>
            </div>
        </div>
        <!-- 热门电影 -->
        <%
            String imilarByMid = DaoFactory.getMoviesImilarDaoInstance().getImilarByMid(moiveid);
            System.out.println(imilarByMid.toString());
            ArrayList<Movie> data;
            String result = "";
            if (imilarByMid.equals("")) {
                result = "热门电影";
                data = DaoFactory.getMovieDaoInstance().getHotTopN();
            } else {
                result = "相似电影";
                data = DaoFactory.getMovieDaoInstance().getRecommendationMoive(imilarByMid);
            }
        %>
        <div class="remeng row">
            <h3 class="hot-title">
                <%=result%>
            </h3>
        </div>
        <div class="movie">
            <ul class="movie-img">
                <%--                        <c:forEach var="m" items="${data['热映中']}">--%>
                <%
                    for (int i = 0; i < data.size(); i++) {
                        movie = data.get(i);
                %>
                <li>
                    <div class="box">
                        <a href="movieDetail.jsp?moiveid=<%=movie.getId()%>">
                            <img class="" src="<%=movie.getImage()%>"
                                 alt="" style="height: 354px; border: 0px;">
                        </a>
                    </div>
                    <h4 class="dytit">
                        <a href="movieDetail.jsp?moiveid=<%=movie.getId()%>"><%=movie.getName()%>
                        </a>
                    </h4>
                    <p class="inzhuy">主演：<%
                        String[] split = movie.getActor().split("、");
                        for (int j = 0; j < 5; j++) {
                            out.println(split[j]);
                        }
                    %></p>
                </li>
                <%
                    }
                %>
                <%--                        </c:forEach>--%>
            </ul>
        </div>

    </div>
    <jsp:include page="footMain.jsp"/>
</body>
</html>
