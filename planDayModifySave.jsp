<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="plan.planDAO"%>
<%@ page import="plan.planDTO"%>
<%@ include file="connectDB.jsp" %><!-- 데이터베이스 커넥션 생성 -->
<%
	String userID = (String) session.getAttribute("userId");
	String ddayname = request.getParameter("ddayname");
	String setDate = request.getParameter("date");  // 기준 날짜 데이터 (("yyyy-MM-dd")의 형태)	
	
	String 	sql = "UPDATE dday SET ddayname='"+ddayname+"', day='"+setDate+"' ";
			sql += " WHERE userid='"+userID+"' and ddayname='"+ddayname+"' ";
			pstmt = conn.prepareStatement(sql);
	int result = pstmt.executeUpdate(sql);
if(result == 1){
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
<%} else{%>
	<script>
	alert("디데이 수정실패!");
	self.close();
	opener.location = "planList.jsp";
</script>
<%} %>
</head>
<body>
</body>
</html>