<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</style>
</head>
<body>
	<form action="planDday.jsp">
		<table>
		<caption>디데이 등록</caption>
			<tr>
				<td align="center"> 기념일 이름 </td><td><input type="text" name="setName"></td>
			</tr>
			<tr>
				<td align="center"> 날짜 </td><td><input type="date" name="setDate"></td>
			</tr>
			<tr>
				<td align="center" colspan="2"><input type="submit" value="디데이 생성"></td>
			</tr>
		</table>
	</form>
</body>
</html>