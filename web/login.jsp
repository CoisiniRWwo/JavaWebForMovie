<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2022/11/15
  Time: 20:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%request.setCharacterEncoding("utf-8");%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="ThemeBucket">
    <link rel="shortcut icon" href="#" type="image/png">

    <title>Login</title>

    <link href="css/style.css" rel="stylesheet">
    <link href="css/style-responsive.css" rel="stylesheet">

    <link href="yzm/css/drag.css" rel="stylesheet" type="text/css">
    <script src="yzm/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="yzm/js/drag.js" type="text/javascript"></script>
</head>
<body class="login-body">

<div class="container">

    <form class="form-signin" action="adminToUserController?action=login" method="post">
        <div class="form-signin-heading text-center" style="height: 80px">
            <h1 class="sign-title">登 录</h1>
            <img src="images/login-logo.png" alt="" style="width: 60px"/>
        </div>
        <div class="login-wrap">
            <input type="text" name="username" class="form-control" placeholder="用户名或邮箱" autofocus id="aaa123">
            <input type="password" name="password" class="form-control" placeholder="密码">
            <%-- 验证码模块 --%>
            <div id="drag" style="width: 290px;"></div>

            <button class="btn btn-lg btn-login btn-block" type="submit" id="bt1" disabled>
                <i class="fa fa-check"></i>
            </button>

            <script type="text/javascript">
                $('#drag').drag();
            </script>

            <div class="registration">
                还不是会员？
                <a class="" href="registration.jsp">
                    注册
                </a>
            </div>
<%--            <label class="checkbox">--%>
<%--                <input type="checkbox" value="remember-me"> Remember me--%>
<%--                <span class="pull-right">--%>
<%--                    <a data-toggle="modal" href="#myModal"> Forgot Password?</a>--%>

<%--                </span>--%>
<%--            </label>--%>

        </div>

    </form>

</div>

<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/modernizr.min.js"></script>

</body>
</html>
