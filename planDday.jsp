<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="connectDB.jsp" %><!-- 데이터베이스 커넥션 생성 -->
<%
String USERID = (String) session.getAttribute("userId");

if(USERID ==null){
	%>
	<script>
		alert("로그인 이후에 이용가능합니다.");
		self.close();
	</script>
	<%
	return;
}
String setName = request.getParameter("setName");
String setDate = request.getParameter("setDate");
%>

<%
String 	sql = "INSERT INTO dday(userid,day,ddayname) ";
		sql += " VALUES('"+USERID+"','"+setDate+"','"+setName+"')";
		pstmt = conn.prepareStatement(sql);
int result = pstmt.executeUpdate(sql);
if(result == 1){
%>
<script>
	alert("디데이 생성 완료!");
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
</body>
</html>