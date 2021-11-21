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
String pdate = request.getParameter("pdate");

if(pdate==null){
%>
	<script>
		alert("잘못된 경로로의 접근1");
		self.close();
	</script>
<%
	return;
}

String sql = "DELETE FROM plan WHERE userid='" + USERID +"' AND pdate='" + pdate + "' ";
pstmt = conn.prepareStatement(sql);
int result = pstmt.executeUpdate(sql);
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