<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String yy = request.getParameter("year");
	String mm = request.getParameter("month");

	Calendar cal = Calendar.getInstance();

	int y = cal.get(Calendar.YEAR);
	int m = cal.get(Calendar.MONTH);
	
	if(yy!=null && mm !=null && !yy.equals("") && !mm.equals("")){
		y = Integer.parseInt(yy);
		m = Integer.parseInt(mm);
	}
	
	cal.set(y, m, 1);
	int dayOfweek = cal.get(Calendar.DAY_OF_WEEK);
	int lastday = cal.getActualMaximum(Calendar.DATE);
	
	int b_y = y;
	int b_m = m - 1;
	if(b_m==0){
		b_y = b_y - 1;
		b_m = 12;
	}
	
	int n_y = y;
	int n_m = m+1;
	if(n_m == 13){
		n_y = n_y + 1;
		n_m = 1;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function fn_Write() {
	var w = (window.screen.width/2)- 200;
	var h = (window.screen.height/2)- 200;
	var url = "planWrite.jsp";
	window.open(url, "planWrite", "width=400, height=400, left="+w+", top="+h);
}
</script>
</head>
<style>
	body{
	font-size:9px;
	color:#555555;
	}
	table{
		border-collapse:collapse;
	}
	th, td{
		border:1px solid #cccccc;
		width:30px;
		height:25px;
		text-align:center;
	}
	caption{
		margin-bottom:10px;
		font-size:15px;
	}
</style>
<body>
	<br><br>
    <table>
    	<caption>
    	<button type="button" onclick="location='cal.jsp?year=<%=b_y %>&month=<%=b_m %>'"> 이전 </button>
    	<%=y %>년 <%=m %>월
    	<button type="button" onclick="location='cal.jsp?year=<%=n_y %>&month=<%=n_m %>'"> 다음</button>
    	</caption>
    	<tr>
    		<th>일</th>
    		<th>월</th>
    		<th>화</th>
    		<th>수</th>
    		<th>목</th>
    		<th>금</th>
    		<th>토</th>
    	</tr>
    	<tr>
    		<%
    		int count = 0;
    		
    		for(int s=1; s<dayOfweek; s++){
    			out.print("<td></td>");
    			count++;
    		}
    		for(int d=1; d<=lastday;d++){
    			count++;
    			String color = "#555555";
    			if(count == 7){
    				color = "blue";
    			} else if(count == 1) {
    				color = "red";
    			}
    		%>
    		 <td style="color:<%=color %>"><%=d %></td>
    		<%	
    			if(count==7){
    				out.print("<tr></tr>");
    				count = 0;
    			}
    		}
    		while(count < 7){
    			out.print("<td></td>");
    			count++;
    		}
    		
    		%>
    	</tr>
    </table>
</body>
</html>