<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="plan.planDAO"%>
<%@ page import="plan.planDTO"%>
<%
	request.setCharacterEncoding("UTF-8");
	Connection conn;
	PreparedStatement pstmt;
	
	String dbURL = "jdbc:mysql://localhost:3306/student";
	String dbID = "root";
	String dbPassword = "1018pskc!!";
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(dbURL, dbID, dbPassword); 
	String userID = (String) session.getAttribute("userId");
	String pdate = request.getParameter("pdate");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	String 	sql = "UPDATE plan SET title='"+title+"', content='"+content+"' ";
			sql += " WHERE userid='"+userID+"' and pdate='"+pdate+"' ";
			pstmt = conn.prepareStatement(sql);
	int result = pstmt.executeUpdate(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	alert("일정 저장완료!");
	self.close();
	opener.location = "planList.jsp";
</script>
</head>
<body>
</body>
</html>