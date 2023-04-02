<%request.setCharacterEncoding("utf-8");%>
<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<div class="container-fluid" style="opacity: 0.7;" id="top">
    <header class="ml-5">
        <nav class="navbar navbar-expand-md navbar-dark">
<%--            <a class="navbar-brand" href="${pageContext.request.contextPath}/main.do">--%>
                <img src="images/logo_icon.png" alt="" style="height: auto; width: 40px">
<%--            </a>--%>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse"
                    aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="main.jsp">首页
                            <span class="sr-only">(current)</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="movieType.jsp?type=喜剧">喜剧</a></li>
                    <li class="nav-item">
                        <a class="nav-link" href="movieType.jsp?type=科幻">科幻</a></li>
                    <li class="nav-item">
                        <a class="nav-link" href="movieType.jsp?type=动画">动画</a></li>
                    <li class="nav-item">
                        <a class="nav-link" href="movieType.jsp?type=奇幻">奇幻</a></li>
                    <li class="nav-item">
                        <a class="nav-link" href="movieType.jsp?type=恐怖">恐怖</a></li>
                    <li class="nav-item">
                        <a class="nav-link" href="movieType.jsp?type=悬疑">悬疑</a></li>
                    <li class="nav-item">
                        <a class="nav-link" href="movieType.jsp?type=犯罪">犯罪</a></li>
                    <li class="nav-item">
                        <a class="nav-link" href="movieType.jsp?type=冒险">冒险</a></li>
                    <li class="nav-item">
                        <a class="nav-link" href="movieType.jsp?type=动作">动作</a></li>
                </ul>


                <form class="form-inline mt-2 mt-md-0 mr-3" action="SearchPage.jsp"
                      method="post">
                    <input class="form-control mr-sm-2" type="text" name="search" placeholder="电影名" value=""
                           aria-label="Search">
                    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">
                        <span class="iconfont iconsousuo"></span></button>
                </form>


                <ul class="navbar-nav mr-4">
                    <li class="nav-item dropdown">
                        <%
//                            session.setAttribute("username", "username");
                            Object username = session.getAttribute("username");
//                            out.println(username);
                            if (username != null) {
                        %>
<%--                        <c:if test="${username == \"admin\"}">--%>
<%--                            <a href="management/index.jsp" onclick="jump()">--%>
<%--                                    ${username }--%>
<%--                            </a>--%>
<%--                        </c:if>--%>
<%--                        <c:if test="${username != \"admin\"}">--%>
                            <a class="nav-link dropdown-toggle" href=""
                               id="navbardrop" data-toggle="dropdown">
                                <%=username%>
                            </a>
<%--                        </c:if>--%>
                        <%
                        }
                            else {
                        %>
                        <a href="login.jsp">登录</a>
                        <%
                            }
                        %>

                        <div class="dropdown-menu">
                            <c:if test="${username == \"admin\"}">
                            <a class="dropdown-item" href="index_administrators.jsp">后台管理</a>
                            </c:if>
                            <c:if test="${username != \"admin\"}">
                                <a class="dropdown-item" href="user_userHomepage.jsp">修改账户</a>
                            </c:if>
                            <div class="dropdown-divider"></div>
                            <%
                                if (username != null) {
                            %>
                            <a class="dropdown-item" href="adminToUserController?action=exitUser">退出</a>
                            <%
                            }
                            %>
                        </div>
                    </li>
                </ul>

            </div>
        </nav>
    </header>

    <!-- 结束 -->
</div>
