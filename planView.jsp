<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="plan.planDAO"%>
<%@ page import="plan.planDTO"%>
<%
Connection conn;
PreparedStatement pstmt;

String dbURL = "jdbc:mysql://localhost:3306/student";
String dbID = "root";
String dbPassword = "1018pskc!!";
Class.forName("com.mysql.jdbc.Driver");
conn = DriverManager.getConnection(dbURL, dbID, dbPassword); 

String USERID = (String) session.getAttribute("userId");
String pdate = (String) request.getParameter("pdate");
if(pdate==null){
%>
	<script>
		alert("잘못된 경로로의 접근1");
		self.close();
	</script>
<%
	return;
}
if(USERID ==null){
	%>
	<script>
		alert("잘못된 경로로의 접근3");
		self.close();
	</script>
	<%
	
}

String 	sql = "select title, content from plan";
		sql += " where userid='" + USERID + "' and pdate='" + pdate + "'";
		pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery(sql);

String title = "";
String content = "";

if(rs.next()) {
	title = rs.getString("title");
	content = rs.getString("content");
} else{
	%>
	<script>
		alert("일정이 없습니다.");
		self.close();
	</script>
<%
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	function fn_modify() {
		location = "planModify.jsp?pdate=<%=pdate %>";
		
	}
	function fn_delete() {
		if(confirm("정말 삭제하시겠습니까?")){
			location = "planDelete.jsp?pdate=<%=pdate %>";
		}
		
	}
</script>
<style>
	body {
		font-size:9pt;
		font-family:맑은 고딕;
		color:#333333;
	}
	table {
		width:380px;
		border-collapse:collapse; /* 셀 간격을 지움 */
	}
	th, td {
		border:1px solid #cccccc;
		padding:5px;
	}
	caption {
		font-size:14pt;
		font-weight:bold;
		margin-bottom:5px;
	}
	.div1 {
		width:380px;
		text-align:center;
		margin-top:10px;
	}
</style>
<body>
<%
	boolean re = new planDAO().getList(USERID, pdate);
%>
<table>
	<caption>일정등록</caption>
		<tr>
			<th width="20%">날짜</th>
			<td width="80"><%=pdate %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><%=title %></td>
		</tr>
		<tr>
			<th>내용</th>
			<td height="120" valign="top"><%=content %></td>
		</tr>
</table>
<div class="div1">
	<button type="button" onclick="fn_modify();">수정</button>
	<button type="button" onclick="fn_delete();">삭제</button>
	<button type="button" onclick="self.close();">닫기</button>
</div>
</body>
</html>