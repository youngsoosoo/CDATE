<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#tabmenu {margin:0;  height:30px; border-bottom:1px solid #55d01f; font:14px;}
#tabmenu li {margin:0; padding:0; display:block; float:left; list-style-type:none; width:150px; height:30px; text-align:center;}
#tabmenu a {float:left; line-height:14px; width:150px; height:26px; text-decoration:none;font:bold 14px; color:#34900b;}
#tabmenu a .move, #tabmenu a:hover {border-bottom:4px solid #34900b; color:#34900b;}
#tabmenu a:hover {color:#696;}
</style>
</head>

<body>
<ul id ="tabmenu">
	<li><a href="Main.jsp" class="move">HOME</a></li>
	<li><a href="login.jsp">로그인</a></li>
</ul>
</body>
</html>