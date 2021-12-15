<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="plan.planDAO"%>
<%@ page import="plan.planDTO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	input[type=submit]{
        background-color: #55d01f;
        border:none;
        color:white;
        border-radius: 5px;
        width:100%;
        height:5%;
        font-size: 10pt;
        
    }
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
	<form name="frm" method="post" action="planWriteSave.jsp">
		<table>
		<caption>일정등록</caption>
			<tr>
				<th width="20%">날짜</th>
				<td width="80"><input type="date" name="pdate" style="width:98%"></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" style="width:98%"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content" style="width:98%; height:150px;"></textarea></td>
			</tr>
		</table>
		<div class="div1">
			<input type="submit" value="저장">
			<br><br>
			<input type="button" onclick="self.close();" value="닫기">
		</div>
	</form>
</body>
</html>