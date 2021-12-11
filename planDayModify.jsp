<%@page import="java.util.ArrayList"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="plan.planDAO"%>
<%@ page import="plan.planDTO"%>
<%@ include file="connectDB.jsp" %><!-- 데이터베이스 커넥션 생성 -->
<%
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
rs = pstmt.executeQuery(sql);

String day = "";
String dayname = "";

if(rs.next()) {
	day = rs.getString("day");
	dayname = rs.getString("ddayname");
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
	function fn_ddaysubmit() {
		var f = document.frm;
		f.submit();
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
<form name="frm" method="post" action="planDayModifySave.jsp">
<input type="hidden" name="ddayname" value="<%=dayname%>">
<table>
	<caption>디데이 수정</caption>
		<tr>
			<th width="20%">디데이 명</th>
			<td width="80"><input type="text" name="ddayname" id="ddayname" value="<%=dayname %>" style="width:98%"></td>
		</tr>
		<tr>
			<th>남은 일수</th>
			<td><input type="date" name="date" style="width:98%"></td>
		</tr>
</table>
<div class="div1">
	<button type="submit" onclick="fn_ddaysubmit(); return false;">저장</button>
	<button type="button" onclick="self.close();">닫기</button>
</div>
</form>
</body>
</html>