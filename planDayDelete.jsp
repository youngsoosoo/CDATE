<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="connectDB.jsp" %><!-- 데이터베이스 커넥션 생성 -->
<%

String USERID = (String) session.getAttribute("userId");
String ddayname = request.getParameter("ddayname");

if(ddayname==null){
%>
	<script>
		alert("디데이가 없습니다.");
		self.close();
	</script>
<%
	return;
}

String sql = "DELETE FROM dday WHERE userid='" + USERID +"' AND ddayname='"+ddayname+"' ";
pstmt = conn.prepareStatement(sql);
int result = pstmt.executeUpdate(sql);
if(result == 1){
%>
	<script>
		alert("삭제 성공");
		self.close();
		opener.document.location="planList.jsp";
	</script>
<%
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>