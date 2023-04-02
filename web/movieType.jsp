<%@ page import="com.bean.Movie" %>
<%@ page import="com.DaoFactory.DaoFactory" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: Time_
  Date: 2022/11/29
  Time: 16:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<body class="bg-dark">

<!-- jQuery -->
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/popper.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件 -->
<script src="js/bootstrap.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>

<div id="main">

    <jsp:include page="headerMain.jsp"/>
    <jsp:useBean id="movie" class="com.bean.Movie"/>
        <%
            String type = request.getParameter("type").toString();
    %>
    <div class="div-location" style="position:fixed;left:3%;bottom:55%; letter-spacing:5px; opacity:0.5;">
        <p><a href="#top">顶部></a></p>
    </div>
    <div class="middle-show">
        <div class="middle-cont">
            <div class="middle-content">
                <div class="title">
                    <h2>
                        <a class="text-white" href="#"><%=type%>
                        </a>
                    </h2>
                </div>
                <%--                第一行--%>
                <div class="movie">
                    <ul class="movie-img">
                        <%--                        <c:forEach var="m" items="${data['XXX']}">--%>
                        <%
                            ArrayList<Movie> comedy = DaoFactory.getMovieDaoInstance().getLikeMovies(type);
                            if (comedy != null) {
                                for (int i = 0; i < comedy.size(); i++) {
                                    movie = comedy.get(i);
                        %>
                        <li>
                            <div class="box">
                                <a href="movieDetail.jsp?moiveid=<%=movie.getId()%>">
                                    <img src="<%=movie.getImage()%>"
                                         alt="" style="height: 354px; border: 0px;">
                                </a>
                            </div>
                            <h4 class="dytit">
                                <a target="_blank" href="#xxx"><%=movie.getName()%>
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
                <%--                第二行--%>
                <div class="movie">
                    <ul class="movie-img">
                        <%--                        <c:forEach var="m" items="${data['XXX']}">--%>
                            <%
                                comedy = DaoFactory.getMovieDaoInstance().getLikeMoviesLimit(type,5,5);
                                if (comedy != null) {
                                    for (int i = 0; i < comedy.size(); i++) {
                                        movie = comedy.get(i);
                            %>
                            <li>
                                <div class="box">
                                    <a href="movieDetail.jsp?moiveid=<%=movie.getId()%>">
                                        <img src="<%=movie.getImage()%>"
                                             alt="" style="height: 354px; border: 0px;">
                                    </a>
                                </div>
                                <h4 class="dytit">
                                    <a target="_blank" href="#xxx"><%=movie.getName()%>
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
                <%--                第三行--%>
                <div class="movie">
                    <ul class="movie-img">
                        <%--                        <c:forEach var="m" items="${data['XXX']}">--%>
                            <%
                                comedy = DaoFactory.getMovieDaoInstance().getLikeMoviesLimit(type,10,5);
                                if (comedy != null) {
                                    for (int i = 0; i < comedy.size(); i++) {
                                        movie = comedy.get(i);
                            %>
                            <li>
                                <div class="box">
                                    <a href="movieDetail.jsp?moiveid=<%=movie.getId()%>">
                                        <img src="<%=movie.getImage()%>"
                                             alt="" style="height: 354px; border: 0px;">
                                    </a>
                                </div>
                                <h4 class="dytit">
                                    <a target="_blank" href="#xxx"><%=movie.getName()%>
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
                <%--                第四行--%>
                <div class="movie">
                    <ul class="movie-img">
                        <%--                        <c:forEach var="m" items="${data['XXX']}">--%>
                            <%
                                comedy = DaoFactory.getMovieDaoInstance().getLikeMoviesLimit(type,15,5);
                                if (comedy != null) {
                                    for (int i = 0; i < comedy.size(); i++) {
                                        movie = comedy.get(i);
                            %>
                            <li>
                                <div class="box">
                                    <a href="movieDetail.jsp?moiveid=<%=movie.getId()%>">
                                        <img src="<%=movie.getImage()%>"
                                             alt="" style="height: 354px; border: 0px;">
                                    </a>
                                </div>
                                <h4 class="dytit">
                                    <a target="_blank" href="#xxx"><%=movie.getName()%>
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
                <%--                第五行--%>
                <div class="movie">
                    <ul class="movie-img">
                        <%--                        <c:forEach var="m" items="${data['XXX']}">--%>
                            <%
                                comedy = DaoFactory.getMovieDaoInstance().getLikeMoviesLimit(type,20,5);
                                if (comedy != null) {
                                    for (int i = 0; i < comedy.size(); i++) {
                                        movie = comedy.get(i);
                            %>
                            <li>
                                <div class="box">
                                    <a href="movieDetail.jsp?moiveid=<%=movie.getId()%>">
                                        <img src="<%=movie.getImage()%>"
                                             alt="" style="height: 354px; border: 0px;">
                                    </a>
                                </div>
                                <h4 class="dytit">
                                    <a target="_blank" href="#xxx"><%=movie.getName()%>
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
