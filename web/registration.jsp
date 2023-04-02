<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2022/11/16
  Time: 19:03
  To change this template use File | Settings | File Templates.
--%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="ThemeBucket">
    <link rel="shortcut icon" href="#" type="image/png">

    <title>Registration</title>

    <link href="css/style.css" rel="stylesheet">
    <link href="css/style-responsive.css" rel="stylesheet">

    <link href="yzm/css/drag.css" rel="stylesheet" type="text/css">
    <script src="yzm/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="yzm/js/drag.js" type="text/javascript"></script>
</head>
<body class="login-body">

<div class="container">

    <form class="form-signin" action="registrationController?action=registration" method="post">
        <div class="form-signin-heading text-center" style="height: 50px">
            <h1 class="sign-title">注 册</h1>
            <img src="images/login-logo.png" alt="" style="width: 60px"/>
        </div>

        <input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>"><br/>
        <input type="hidden" name="headurl" value="images/photos/user1.png"><br/>

        <div class="login-wrap">
            <p>在下面输入您的个人详细信息</p>
            <input type="text" autofocus="" placeholder="输入邮箱" class="form-control" name="email">
            <input type="text" autofocus="" placeholder="输入手机号" class="form-control" name="telephone">
            <div class="radios">
                <label for="radio-01" class="label_radio col-lg-6 col-sm-6">
                    <input type="radio" checked="" value="男" id="radio-01" name="gender"> 帅哥
                </label>
                <label for="radio-02" class="label_radio col-lg-6 col-sm-6">
                    <input type="radio" value="女" id="radio-02" name="gender"> 美女
                </label>
            </div>

            <p> 在下面输入您的帐户详细信息</p>
            <input type="text" autofocus="" placeholder="登录用户名" class="form-control" name="username">
            <input type="password" placeholder="输入密码" class="form-control" name="password">
            <input type="password" placeholder="再次确认密码" class="form-control">
<%--            <label class="checkbox">--%>
<%--                <input type="checkbox" value="agree this condition"> I agree to the Terms of Service and Privacy Policy--%>
<%--            </label>--%>

            <div id="drag" style="width: 290px;"></div>

            <button type="submit" class="btn btn-lg btn-login btn-block" id="bt1" disabled>
                <i class="fa fa-check"></i>
            </button>

            <script type="text/javascript">
                $('#drag').drag();
            </script>

            <div class="registration">
                已经是会员？
                <a href="login.jsp" class="">
                    登录
                </a>
            </div>

        </div>

    </form>

</div>

<script src="js/jquery-1.10.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/modernizr.min.js"></script>

</body>
</html>
