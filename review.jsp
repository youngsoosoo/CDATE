<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="review.review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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
		text-align:center;
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
Connection conn;
PreparedStatement pstmt;

String dbURL = "jdbc:mysql://localhost:3306/student";
String dbID = "root";
String dbPassword = "1018pskc!!";
Class.forName("com.mysql.jdbc.Driver");
conn = DriverManager.getConnection(dbURL, dbID, dbPassword); 


%>
<table>
	<tr>
		<th colspan="2">★간단 리뷰★<input type="button" onclick="location.href='reviewWrite.jsp'" value="작성하기"></td>
	</tr>
	<tr>
		<td colspan="2">방문 장소 / 리뷰</td>
	</tr>
<%
	String sql = "select * from  review";
	ArrayList<review> list = new ArrayList<review>();
	pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery(sql);
		while(rs.next()) {
			review review = new review();
			review.setReviewcontent(rs.getString("reviewcontent"));
			review.setReplace(rs.getString("replace"));
			list.add(review);
		}
		for(int i = 0; i < list.size(); i++){
%>
	
	<tr>
		<td colspan="2"><%= list.get(i).getReplace() %>&nbsp; / &nbsp;<%= list.get(i).getReviewcontent() %></td>
	</tr>
	<%
		}
	%>
</table>
</body>
</html>