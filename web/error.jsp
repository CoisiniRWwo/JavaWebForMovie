<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2022/11/24
  Time: 22:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script type='text/javascript'>
    alert('${requestScope.msg}');
    location.href='${requestScope.url}';
</script>
</body>
</html>
