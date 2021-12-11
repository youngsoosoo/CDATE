<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="plan.planDAO"%>
<%@ page import="plan.planDTO"%>
<%@ include file="connectDB.jsp" %><!-- 데이터베이스 커넥션 생성 -->
<%
	request.setCharacterEncoding("UTF-8");

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
	alert("일정 수정완료!");
	self.close();
	opener.location = "planList.jsp";
</script>
</head>
<body>
</body>
</html>