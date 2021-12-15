<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
input[type=button]{
        background-color: #55d01f;
        border:none;
        color:white;
        border-radius: 5px;
        width:15%;
        height:100px;
        font-size: 30px;
        margin-top:100px;
        padding: 18px; 
  		text-transform:uppercase;
  		color: white;
  		text-decoration: none;
    }

 
input[type=button]:hover {
  box-shadow: 0 0 5px rgba(0, 0, 0, 0.3), inset 0 0 1px rgba(255, 255, 255, 0.3);
  color:white;
}
</style>
</head>
<body>
	<jsp:include page="/Header.jsp" flush="false"/>
	<br><br><br><br>
	<div style="text-align: center;">
	<table style="width:100%;" align="center">
		<tr>
			<td>
				<input type="button" onclick="location.href='Map.jsp'" value="SEARCH">
				&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
				<input type="button" onclick="location.href='Markers.jsp'" value="COS">
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" onclick="location.href='planList.jsp'" value="CALENDAR">
				&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
				<input type="button" onclick="location.href='board.jsp'" value="STORY">
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" onclick="location.href='MapLine.jsp'" value="recommend">
				&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
				<input type="button" onclick="location.href='logout.jsp'" value="LOGOUT">
			</td>
		</tr>
		
	</table>
	</div>
</body>
</html>