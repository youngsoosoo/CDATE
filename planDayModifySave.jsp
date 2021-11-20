<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
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
	String ddayname = request.getParameter("ddayname");
	String setDate = request.getParameter("date");  // 기준 날짜 데이터 (("yyyy-MM-dd")의 형태)	
	
	String 	sql = "UPDATE dday SET ddayname='"+ddayname+"', day='"+setDate+"' ";
			sql += " WHERE userid='"+userID+"' and ddayname='"+ddayname+"' ";
			pstmt = conn.prepareStatement(sql);
	int result = pstmt.executeUpdate(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	alert("디데이 수정완료!");
	self.close();
	opener.location = "planList.jsp";
</script>
</head>
<body>
</body>
</html>