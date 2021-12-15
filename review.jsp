<%@page import="java.util.ArrayList"%>
<%@page import="review.review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="connectDB.jsp" %><!-- 데이터베이스 커넥션 생성 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	input[type=button]{
        background-color: #55d01f;
        border:none;
        color:white;
        border-radius: 5px;
        width:100%;
        height:5%;
        font-size: 10pt;
        
    }
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
		border:1px solid #55d01f;
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
	rs = pstmt.executeQuery(sql);
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