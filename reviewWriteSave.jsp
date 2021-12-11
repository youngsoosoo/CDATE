<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="connectDB.jsp" %><!-- 데이터베이스 커넥션 생성 -->
<%
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