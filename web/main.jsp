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
<%
    System.out.println("用户名：" + session.getAttribute("username"));
    String username = "";
    ArrayList<Movie> recommendationMoive = new ArrayList<>();
    if (session.getAttribute("username") != null) {
        username = (String) session.getAttribute("username");
        int id = DaoFactory.getUserDaoInstance().getId(username);
//        System.out.println("用户id：" + id);
        String userRecommendation = DaoFactory.getUserRecommendationDaoInstance().getUserRecommendation(id);
//        System.out.println(userRecommendation);
        recommendationMoive = DaoFactory.getMovieDaoInstance().getRecommendationMoive(userRecommendation);
        System.out.println(recommendationMoive);
    }
%>

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
                        <a class="text-white" href="#">推荐电影</a>
                    </h2>
                </div>
                <div class="movie">
                    <ul class="movie-img">
                        <%
                            if (session.getAttribute("username") == null) {
                        %>
                        <p class="inzhuy" align="center">亲亲请先
                            <a href="login.jsp">登录</a>
                            才能推荐哦！</p>
                        <%
                        } else {
                            if (recommendationMoive != null) {
                                for (int i = 0; i < recommendationMoive.size(); i++) {
                                    movie = recommendationMoive.get(i);
                        %>
                        <%--                        <c:forEach var="m" items="${data['推荐']}">--%>
                        <li>
                            <div class="box">
                                <a href="movieDetail.jsp?moiveid=<%=movie.getId()%>">
                                    <img class="" src="<%=movie.getImage()%>"
                                         alt="" style="height: 354px; border: 0px;">
                                </a>
                            </div>
                            <h4 class="dytit">
                                <a  href="movieDetail.jsp?moiveid=<%=movie.getId()%>">
                                    <%=movie.getName()%>
                                </a>
                            </h4>
                            <p class="inzhuy">主演：<%=movie.getActor()%>
                            </p>
                        </li>
                        <%
                                    }
                                }
                            }
                        %>
                        <%--                        </c:forEach>--%>
                    </ul>
                </div>

            </div>

            <div class="middle-show">
                <div class="middle-cont">
                    <div class="middle-content">
                        <div class="title" id="ry">
                            <h2>
                                <a class="text-white" href="#">当前热映</a>
                            </h2>
                        </div>
                        <div class="movie">
                            <ul class="movie-img">
                                <%
                                    ArrayList<Movie> hotTopN = DaoFactory.getMovieDaoInstance().getHotTopN();
                                    if (hotTopN != null) {
                                        for (int i = 0; i < hotTopN.size(); i++) {
                                            movie = hotTopN.get(i);
                                %>
                                <%--                        <c:forEach var="m" items="${data['热映中']}">--%>
                                <li>
                                    <div class="box">
                                        <a href="movieDetail.jsp?moiveid=<%=movie.getId()%>">
                                            <img class="" src="<%=movie.getImage()%>"
                                                 alt="" style="height: 354px; border: 0px;">
                                        </a>
                                    </div>

                                    <h4 class="dytit">
                                        <a
                                           href="movieDetail.jsp?moiveid=<%=movie.getId()%>"><%=movie.getName()%>
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

                    <div class="middle-content">
                        <div class="title" id="xj">
                            <h2>
                                <a class="text-white" href="movieType.jsp?type=喜剧">喜剧 更多>></a>
                            </h2>
                        </div>
                        <div class="movie">
                            <ul class="movie-img">
                                <%--                        <c:forEach var="m" items="${data['喜剧']}">--%>
                                <%
                                    ArrayList<Movie> comedy = DaoFactory.getMovieDaoInstance().getLikeMovies("喜剧");
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
                                        <a
                                           href="movieDetail.jsp?moiveid=<%=movie.getId()%>"><%=movie.getName()%>
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

                    <div class="middle-content">
                        <div class="title" id="kh">
                            <h2>
                                <a class="text-white" href="movieType.jsp?type=科幻">科幻 更多>></a>
                            </h2>
                        </div>
                        <div class="movie">
                            <ul class="movie-img">
                                <%--                        <c:forEach var="m" items="${data['科幻']}">--%>
                                <%
                                    ArrayList<Movie> scienceFiction = DaoFactory.getMovieDaoInstance().getLikeMovies("科幻");
                                    if (scienceFiction != null) {
                                        for (int i = 0; i < scienceFiction.size(); i++) {
                                            movie = scienceFiction.get(i);
                                %>
                                <li>
                                    <div class="box">
                                        <a href="movieDetail.jsp?moiveid=<%=movie.getId()%>">
                                            <img src="<%=movie.getImage()%>"
                                                 alt="" style="height: 354px; border: 0px;">
                                        </a>
                                    </div>
                                    <h4 class="dytit">
                                        <a
                                           href="movieDetail.jsp?moiveid=<%=movie.getId()%>"><%=movie.getName()%>
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

                    <div class="middle-content">
                        <div class="title" id="dh">
                            <h2>
                                <a class="text-white" href="movieType.jsp?type=动画">动画 更多>></a>
                            </h2>
                        </div>
                        <div class="movie">
                            <ul class="movie-img">
                                <%--                        <c:forEach var="m" items="${data['动画']}">--%>
                                <%
                                    ArrayList<Movie> animation = DaoFactory.getMovieDaoInstance().getLikeMovies("动画");
                                    if (animation != null) {
                                        for (int i = 0; i < animation.size(); i++) {
                                            movie = animation.get(i);
                                %>
                                <li>
                                    <div class="box">
                                        <a href="movieDetail.jsp?moiveid=<%=movie.getId()%>">
                                            <img src="<%=movie.getImage()%>"
                                                 alt="" style="height: 354px; border: 0px;">
                                        </a>
                                    </div>
                                    <h4 class="dytit">
                                        <a
                                           href="movieDetail.jsp?moiveid=<%=movie.getId()%>"><%=movie.getName()%>
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

                    <div class="middle-content">
                        <div class="title" id="qh">
                            <h2>
                                <a class="text-white" href="movieType.jsp?type=奇幻">奇幻 更多>></a>
                            </h2>
                        </div>
                        <div class="movie">
                            <ul class="movie-img">
                                <%--                        <c:forEach var="m" items="${data['奇幻']}">--%>
                                <%
                                    ArrayList<Movie> fantasy = DaoFactory.getMovieDaoInstance().getLikeMovies("奇幻");
                                    if (fantasy != null) {
                                        for (int i = 0; i < fantasy.size(); i++) {
                                            movie = fantasy.get(i);
                                %>
                                <li>
                                    <div class="box">
                                        <a href="movieDetail.jsp?moiveid=<%=movie.getId()%>">
                                            <img src="<%=movie.getImage()%>"
                                                 alt="" style="height: 354px; border: 0px;">
                                        </a>
                                    </div>
                                    <h4 class="dytit">
                                        <a
                                           href="movieDetail.jsp?moiveid=<%=movie.getId()%>"><%=movie.getName()%>
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

                    <div class="middle-content">
                        <div class="title" id="kb">
                            <h2>
                                <a class="text-white" href="movieType.jsp?type=恐怖">恐怖 更多>></a>
                            </h2>
                        </div>
                        <div class="movie">
                            <ul class="movie-img">
                                <%--                        <c:forEach var="m" items="${data['恐怖']}">--%>
                                <%
                                    ArrayList<Movie> terror = DaoFactory.getMovieDaoInstance().getLikeMovies("恐怖");
                                    if (terror != null) {
                                        for (int i = 0; i < terror.size(); i++) {
                                            movie = terror.get(i);
                                %>
                                <li>
                                    <div class="box">
                                        <a href="movieDetail.jsp?moiveid=<%=movie.getId()%>">
                                            <img src="<%=movie.getImage()%>"
                                                 alt="" style="height: 354px; border: 0px;">
                                        </a>
                                    </div>
                                    <h4 class="dytit">
                                        <a
                                           href="movieDetail.jsp?moiveid=<%=movie.getId()%>"><%=movie.getName()%>
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

                    <div class="middle-content">
                        <div class="title" id="xy">
                            <h2>
                                <a class="text-white" href="movieType.jsp?type=悬疑">悬疑 更多>></a>
                            </h2>
                        </div>
                        <div class="movie">
                            <ul class="movie-img">
                                <%--                        <c:forEach var="m" items="${data['悬疑']}">--%>
                                <%
                                    ArrayList<Movie> Suspense = DaoFactory.getMovieDaoInstance().getLikeMovies("悬疑");
                                    if (Suspense != null) {
                                        for (int i = 0; i < Suspense.size(); i++) {
                                            movie = Suspense.get(i);
                                %>
                                <li>
                                    <div class="box">
                                        <a href="movieDetail.jsp?moiveid=<%=movie.getId()%>">
                                            <img src="<%=movie.getImage()%>"
                                                 alt="" style="height: 354px; border: 0px;">
                                        </a>
                                    </div>
                                    <h4 class="dytit">
                                        <a
                                           href="movieDetail.jsp?moiveid=<%=movie.getId()%>"><%=movie.getName()%>
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

                    <div class="middle-content">
                        <div class="title" id="fz">
                            <h2>
                                <a class="text-white" href="movieType.jsp?type=犯罪">犯罪 更多>></a>
                            </h2>
                        </div>
                        <div class="movie">
                            <ul class="movie-img">
                                <%--                        <c:forEach var="m" items="${data['犯罪']}">--%>
                                <%
                                    ArrayList<Movie> Crime = DaoFactory.getMovieDaoInstance().getLikeMovies("犯罪");
                                    if (Crime != null) {
                                        for (int i = 0; i < Crime.size(); i++) {
                                            movie = Crime.get(i);
                                %>
                                <li>
                                    <div class="box">
                                        <a href="movieDetail.jsp?moiveid=<%=movie.getId()%>">
                                            <img src="<%=movie.getImage()%>"
                                                 alt="" style="height: 354px; border: 0px;">
                                        </a>
                                    </div>
                                    <h4 class="dytit">
                                        <a
                                           href="movieDetail.jsp?moiveid=<%=movie.getId()%>"><%=movie.getName()%>
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

                    <div class="middle-content">
                        <div class="title" id="mx">
                            <h2>
                                <a class="text-white" href="movieType.jsp?type=冒险">冒险 更多>></a>
                            </h2>
                        </div>
                        <div class="movie">
                            <ul class="movie-img">
                                <%--                        <c:forEach var="m" items="${data['冒险']}">--%>
                                <%
                                    ArrayList<Movie> adventure = DaoFactory.getMovieDaoInstance().getLikeMovies("冒险");
                                    if (adventure != null) {
                                        for (int i = 0; i < adventure.size(); i++) {
                                            movie = adventure.get(i);
                                %>
                                <li>
                                    <div class="box">
                                        <a href="movieDetail.jsp?moiveid=<%=movie.getId()%>">
                                            <img src="<%=movie.getImage()%>"
                                                 alt="" style="height: 354px; border: 0px;">
                                        </a>
                                    </div>
                                    <h4 class="dytit">
                                        <a
                                           href="movieDetail.jsp?moiveid=<%=movie.getId()%>"><%=movie.getName()%>
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

                    <div class="middle-content">
                        <div class="title" id="dz">
                            <h2>
                                <a class="text-white" href="movieType.jsp?type=动作">动作 更多>></a>
                            </h2>
                        </div>
                        <div class="movie">
                            <ul class="movie-img">
                                <%--                        <c:forEach var="m" items="${data['动作']}">--%>
                                <%
                                    ArrayList<Movie> actionMovies = DaoFactory.getMovieDaoInstance().getLikeMovies("动作");
                                    if (actionMovies != null) {
                                        for (int i = 0; i < actionMovies.size(); i++) {
                                            movie = actionMovies.get(i);
                                %>
                                <li>
                                    <div class="box">
                                        <a href="movieDetail.jsp?moiveid=<%=movie.getId()%>">
                                            <img src="<%=movie.getImage()%>"
                                                 alt="" style="height: 354px; border: 0px;">
                                        </a>
                                    </div>
                                    <h4 class="dytit">
                                        <a
                                           href="movieDetail.jsp?moiveid=<%=movie.getId()%>"><%=movie.getName()%>
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