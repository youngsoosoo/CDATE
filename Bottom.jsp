<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일 a hh:mm:ss");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	h3{text-align:center;}
	p{text-align:center;}
</style>
</head>
<body>
<h3>Welcome to COSDATA!</h3>
<p>현재 접속 시각 : <%= sf.format(nowTime) %></p>
<hr>
</body>
</html>