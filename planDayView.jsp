<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
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
String ddayname = (String) request.getParameter("ddayname");
if(ddayname==null){
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

String 	sql = "select ddayname, day from dday";
		sql += " where userid='" + USERID + "' and ddayname='" + ddayname + "'";
		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery(sql);

	String dayname = "";
	String dday = "";

if(rs.next()) {
	dayname = rs.getString("ddayname");
	dday = rs.getString("day");
} else{
	%>
	<script>
		alert("일정이 없습니다.");
		self.close();
	</script>
<%
	return;
}

Calendar cal = Calendar.getInstance();
cal.setTime( new Date(System.currentTimeMillis()));
String today = new SimpleDateFormat("yyyy-MM-dd").format( cal.getTime()); // 오늘날짜

SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

Date date = new Date(dateFormat.parse(dday).getTime()); 
Date todate = new Date(dateFormat.parse(today).getTime());
    
long calculate = date.getTime() - todate.getTime();

int Ddays = (int) (calculate / ( 24*60*60*1000));

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	function fn_ddaymodify() {
		location = "planDayModify.jsp?ddayname=<%=ddayname %>";
	}
	function fn_ddaydelete() {
		if(confirm("정말 삭제하시겠습니까?")){
			location = "DayDelete.jsp?ddayname=<%=ddayname %>";
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
<table>
	<caption>디데이</caption>
		<tr>
			<th>디데이 명</th>
			<td><%=dayname %></td>
		</tr>
		<tr>
			<th>남은 일수</th>
			<td valign="top"><%=Ddays %></td>
		</tr>
</table>
<div class="div1">
	<button type="button" onclick="fn_ddaymodify();">수정</button>
	<button type="button" onclick="fn_ddaydelete();">삭제</button>
	<button type="button" onclick="self.close();">닫기</button>
</div>
</body>
</html>