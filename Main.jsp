<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	h1{text-align:center;}
	h2{text-align:center;}
	input[type=submit]{
        background-color: #55d01f;
        border:none;
        color:white;
        border-radius: 5px;
        width:15%;
        height:100px;
        font-size: 14pt;
        margin-top:100px;
    }
</style>
</head>
<body>
	<jsp:include page="/Header.jsp" flush="false"/>
	<br><br><br><br><br><br><br><br>
		<form action="login.jsp" method="post" enctype="multipart/form-data">
		<div style="text-align: center;">
			<input type="submit" value="로그인">
		</div>
		</form>
		<form action="registration.jsp" method="post" enctype="multipart/form-data">
		<div style="text-align: center;">
			<input type="submit" value="회원가입">
		</div>
		</form>
</body>
</html>