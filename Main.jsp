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
	#test_btn1{
		border-top-left-radius: 5px;
		border-bottom-left-radius:5px;
		margin-right:4px;
	}
	#btn_group button{
		border:1px solid skyblue;
		bakground-color:rgba(0, 0, 0, 0);
		color: skyblue;
		padding: 5px;
	}
	#btn_group button:hover{
		color:white;
		background-color:skyblie
	}
</style>
</head>
<body>
	<jsp:include page="/Header.jsp" flush="false"/>
	<br><br><br><br><br><br><br><br>
	
		<form action="login.jsp" method="post" enctype="multipart/form-data">
		<p align="center">
			<input type="submit" value="로그인"  style='background-color: #F4F4F4; border: 1px #34900b solid; width: 109px; height: 25px;' >
		</p>
		</form>
		<form action="registration.jsp" method="post" enctype="multipart/form-data">
		<p align="center">
			<input type="submit" value="회원가입"  style='background-color: #F4F4F4; border: 1px #34900b solid; width: 109px; height: 25px;'>
		</p>
		</form>
	
</body>
</html>