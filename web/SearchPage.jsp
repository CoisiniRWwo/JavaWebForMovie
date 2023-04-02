<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.DaoFactory.DaoFactory" %>
<%@ page import="com.bean.UserRecommendation" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bean.Movie" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<jsp:useBean id="movie" class="com.bean.Movie"/>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <!-- 上述3个meta标签*必须*放在最前面 -->
    <title>XXX电影推荐网</title>
    <link rel="icon" type="images/x-icon" href="images/logo.png">
    <!-- Bootstrap -->
    <link rel="stylesheet" href="css/mainCss/bootstrap.min.css">
    <link rel="stylesheet" href="fonts/iconfont.css">
    <link rel="stylesheet" href="css/mainCss/index.css">
    <link rel="stylesheet" href="css/mainCss/owl.carousel.css">
    <link rel="stylesheet" href="css/mainCss/mainstyle.css">
</head>

<style>

    body {
        /*  字号 */
        font-size: 16px;
        /*  字体颜色  */
        color: #333;
        /* 行距 */
        font-weight: 400;
    }

    .box {
        background: #343a40;
        font-family: 'Merriweather Sans', sans-serif;
        position: relative;
        overflow: hidden;
    }

    .box img {
        width: 100%;
        height: 100%;
    }

</style>

<body class="bg-dark">

<!-- jQuery -->
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/popper.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件 -->
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>

<div id="main">

    <jsp:include page="headerMain.jsp"/>
    <div class="div-location" style="position:fixed;left:3%;bottom:55%; letter-spacing:5px; opacity:0.5;">
        <p><a href="#top">顶部></a></p>
        <p><a href="#tj">推荐></a></p>
        <p><a href="#ry">热映></a></p>
        <p><a href="#xj">喜剧></a></p>
        <p><a href="#kh">科幻></a></p>
        <p><a href="#dh">动画></a></p>
        <p><a href="#qh">奇幻></a></p>
        <p><a href="#kb">恐怖></a></p>
        <p><a href="#xy">悬疑></a></p>
        <p><a href="#fz">犯罪></a></p>
        <p><a href="#mx">冒险></a></p>
        <p><a href="#dz">动作></a></p>
    </div>
    <div class="middle-show">
        <div class="middle-cont">

            <div class="middle-content">
                <div class="title" id="tj">
                    <h2>
                        <a class="text-white" href="#">搜索结果</a>
                    </h2>
                </div>
                <div class="movie">
                    <ul class="movie-img">
                        <%
                            System.out.println(request.getParameter("search"));
                            String search = request.getParameter("search").toString();
                            if (request.getParameter("search") != null) {
                                ArrayList<Movie> movies = DaoFactory.getMovieDaoInstance().getSearch(search);
                                System.out.println(movies);
                                for (int i = 0; i < movies.size(); i++) {
                                    movie = movies.get(i);
                                    Movie movie1 = DaoFactory.getMovieDaoInstance().getByName(movie.getName()).get(0);
                        %>
                        <%--                        <c:forEach var="m" items="${data['推荐']}">--%>
                        <li>
                            <div class="box">
                                <a href="movieDetail.jsp?moiveid=<%=movie1.getId()%>">
                                    <img class="" src="<%=movie.getImage()%>"
                                         alt="" style="height: 354px; border: 0px;">
                                </a>
                            </div>
                            <h4 class="dytit">
                                <a href="movieDetail.jsp?moiveid=<%=movie1.getId()%>"><%=movie.getName()%>
                                </a>
                            </h4>
                            <p class="inzhuy">主演：<%=movie.getActor()%>
                            </p>
                        </li>
                        <%
                                }
                            }
                        %>
                        <%--                        </c:forEach>--%>
                    </ul>
                </div>
                <%
                    ArrayList<Movie> movies = DaoFactory.getMovieDaoInstance().getSearchtwo(search, 5, 5);
                %>
                <div class="movie">
                    <ul class="movie-img">
                        <%--                        <c:forEach var="m" items="${data['XXX']}">--%>
                        <%
                            if (movies != null) {
                                for (int i = 0; i < movies.size(); i++) {
                                    movie = movies.get(i);
                                    Movie movie1 = DaoFactory.getMovieDaoInstance().getByName(movie.getName()).get(0);
                        %>
                        <li>
                            <div class="box">
                                <a href="movieDetail.jsp?moiveid=<%=movie1.getId()%>">
                                    <img src="<%=movie.getImage()%>"
                                         alt="" style="height: 354px; border: 0px;">
                                </a>
                            </div>
                            <h4 class="dytit">
                                <a href="movieDetail.jsp?moiveid=<%=movie1.getId()%>"><%=movie.getName()%>
                                </a>
                            </h4>
                            <p class="inzhuy">主演：<%=movie.getActor()%>
                            </p>
                        </li>
                        <%
                                }
                            }
                        %>
                        <%--                        </c:forEach>--%>
                    </ul>
                </div>
            </div>


            <script src="js/jquery.slicknav.min.js"></script><!-- owl carousel JS -->
            <script src="js/owl.carousel.min.js"></script><!-- Popup JS -->
            <script src="js/jquery.magnific-popup.min.js"></script><!-- Isotope JS -->
            <script src="js/isotope.pkgd.min.js"></script><!-- main JS -->
            <script src="js/main.js"></script>
            <!-- 版权所有 -->
            <jsp:include page="footMain.jsp"/>
        </div>
    </div>

</body>

</html>