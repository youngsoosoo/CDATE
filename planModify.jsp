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
	function fn_submit() {
		var f = document.frm;
		/*if(f.pdate.value == ""){
			alert("날짜를 입력해주세요.");
			f.date.focus();
			return false;
		}
		if(f.title.value == ""){
			alert("제목을 입력해주세요.");
			f.title.focus();
			return false;
		}*/
		f.submit();
		
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
<form name="frm" method="post" action="planModifySave.jsp">
<input type="hidden" name="pdate" value="<%=pdate%>">
<table>
	<caption>일정수정</caption>
		<tr>
			<th width="20%">날짜</th>
			<td width="80"><input type="text" name="pdate" id="pdate" value="<%=pdate %>" style="width:98%"></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input type="text" name="title" value="<%=title %>" style="width:98%"></td>
		</tr>
		<tr>
			<th>내용</th>
			<td height="120" valign="top"><textarea name="content" style="width:98%; height:150px;"><%=content %></textarea></td>
		</tr>
</table>
<div class="div1">
	<button type="submit" onclick="fn_submit(); return false;">저장</button>
	<button type="button" onclick="self.close();">닫기</button>
</div>
</form>
</body>
</html>