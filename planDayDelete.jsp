<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>