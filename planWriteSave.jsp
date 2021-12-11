<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="plan.planDAO"%>
<%@ page import="plan.planDTO"%>
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

	
	String pdate = request.getParameter("pdate");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
%>

<%
String 	sql = "INSERT INTO plan(userid,pdate,title,content) ";
		sql += " VALUES('"+USERID+"','"+pdate+"','"+title+"','"+content+"')";
		pstmt = conn.prepareStatement(sql);
int result = pstmt.executeUpdate(sql);
%>
<script>
	alert("일정 저장완료!");
	self.close();
	opener.location = "planList.jsp";
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