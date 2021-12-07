<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Connection conn;
PreparedStatement pstmt;

String dbURL = "jdbc:mysql://localhost:3306/student";
String dbID = "root";
String dbPassword = "1018pskc!!";
Class.forName("com.mysql.jdbc.Driver");
conn = DriverManager.getConnection(dbURL, dbID, dbPassword); 

String review = request.getParameter("reviewcontent");
String replace = request.getParameter("replace");
%>

<%
String 	sql = "INSERT INTO review ";
		sql += " VALUES('"+review+"','"+replace+"')";
		pstmt = conn.prepareStatement(sql);
int result = pstmt.executeUpdate(sql);
%>
<script>
	alert("리뷰 작성 완료!");
	location.href = "review.jsp";
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>