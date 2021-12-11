<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs;
	Class.forName("com.mysql.jdbc.Driver");
	
	String dbURL = "jdbc:mysql://localhost:3306/student?useSSL=false&serverTimezone=UTC";
	String dbID = "root";
	String dbPassword = "1018pskc!!";
	
	conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
%>
</body>
</html>