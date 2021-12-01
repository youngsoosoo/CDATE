<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Connection conn;
PreparedStatement pstmt;

String dbURL = "jdbc:mysql://localhost:3306/student";
String dbID = "root";
String dbPassword = "1018pskc!!";
Class.forName("com.mysql.jdbc.Driver");
conn = DriverManager.getConnection(dbURL, dbID, dbPassword); 	

	String USERID = (String) session.getAttribute("userId");
	
	String yy = request.getParameter("year");
	String mm = request.getParameter("month");

	Calendar cal = Calendar.getInstance();

	int y = cal.get(Calendar.YEAR);
	int m = cal.get(Calendar.MONTH);
	
	if(yy!=null && mm !=null && !yy.equals("") && !mm.equals("")){
		y = Integer.parseInt(yy);
		m = Integer.parseInt(mm)-1;
	}
	
	cal.set(y, m, 1);
	int dayOfweek = cal.get(Calendar.DAY_OF_WEEK);
	int lastday = cal.getActualMaximum(Calendar.DATE);
	
	int b_y = y;
	int b_m = m;
	if(b_m==0){
		b_y = b_y - 1;
		b_m = 12;
	}
	
	int n_y = y;
	int n_m = m+2;
	if(n_m == 13){
		n_y = n_y + 1;
		n_m = 1;
	}
	
	String 	SQL = "select day, ddayname from dday";
	SQL += " where userid='" + USERID + "'";
	pstmt = conn.prepareStatement(SQL);
	ResultSet rs = pstmt.executeQuery(SQL);
	String today1 = new SimpleDateFormat("yyyy-MM-dd").format( cal.getTime());
	
String day = "";
String ddayname = "";

if(rs.next()) {
	day = rs.getString("day");
	ddayname = rs.getString("ddayname");
}


cal.setTime( new Date(System.currentTimeMillis()));
String today = new SimpleDateFormat("yyyy-MM-dd").format( cal.getTime()); // 오늘날짜

SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
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
	window.open(url, "planWrite", "width=500, height=500, left="+w+", top="+h);
}
function fn_View(){
	var w = (window.screen.width/2)- 200;
	var h = (window.screen.height/2)- 200;
	var url = "planViewget.jsp";
	window.open(url, "planViewget", "width=500, height=500, left="+w+", top="+h);
}
function fn_defail(v){
	var w = (window.screen.width/2)- 200;
	var h = (window.screen.height/2)- 200;
	var url = "planView.jsp?pdate="+v;
	window.open(url,"planView", "width=500, height=500, left="+w+", top="+h);
}
function fn_Day() {
	var w = (window.screen.width/2)- 400;
	var h = (window.screen.height/2)- 400;
	var url = "planDayInput.jsp";
	window.open(url, "planDayInput", "width=500, height=300, left="+w+", top="+h);
}
function fn_deDay(v){
	var w = (window.screen.width/2)- 200;
	var h = (window.screen.height/2)- 200;
	var url = "planDayView.jsp?ddayname="+v;
	window.open(url, "planDayDelete", "width=500, height=300, left="+w+", top="+h);
}
</script>
</head>
<style>
	body{
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
		font-size:15px;
	}
	caption{
		margin-bottom:10px;
		font-size:15px;
	}
	a {
	 	text-decoration:none 
	}
	a:link {
  		color : #34900b;
	}
	a:visited {
 		color : #34900b;
	}
	a:hover {
  		color : #34900b;
	}
	a:active {
  	color : #34900b;
	}
</style>
<body>
	<jsp:include page="/Header1.jsp" flush="false"/>
	<br><br><br><br><br><br><br><br>	
	<table width="500px" align="center" border="0">
		<tr>
    		<td style=""><button type="button" onclick="location='planList.jsp?year=<%=b_y %>&month=<%=b_m %>'"> 이전 </button></td>
    		<td><%=y %>년 <%=m + 1%>월</td>
    		<td><button type="button" onclick="location='planList.jsp?year=<%=n_y %>&month=<%=n_m %>'"> 다음 </button></td>
    		<td><input type="button" value="일정등록" onclick="fn_Write()">&ensp;<input type="button" value="디데이" onclick="fn_Day()"></td>
    	</tr>
    			<%
    				if(ddayname == ""){
    			%>
    			<%	
    				}else{
    					Date date = new Date(dateFormat.parse(day).getTime()); 
    					Date todate = new Date(dateFormat.parse(today).getTime());
        
    					long calculate = (long) (date.getTime() - todate.getTime());

    					int Ddays = (int) (calculate / ( 24*60*60*1000));
    			%>
    				
    				<tr>
    					<td colspan="4"><a href="javascript:fn_deDay('<%=ddayname %>')"><%=ddayname %></a> - <%=Ddays%></td>
    				</tr>    			
    			<%
    				}
    			%>
	</table>
    <table width="500px" align="center">
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
    		
    		for(int s=1; s<dayOfweek; s++){ //빈칸 출력
    			out.print("<td></td>");
    			count++;
    		}
    		for(int d=1; d<=lastday;d++){ // 토요일, 일요일 색
    			count++;
    			String f_date = y + "-" + (m+1) + "-" + d;
    			String color ="#555555";
    			if(count == 7){
    				color="blue";
    			}else if(count == 1){
    				color = "red";
    			}
    			String 	f_sql = " select count(*) cnt from plan";
    					f_sql += " where userid='"+USERID+"' ";
    					f_sql += " and pdate='"+f_date+"' ";
    			pstmt = conn.prepareStatement(f_sql);
    			ResultSet f_rs = pstmt.executeQuery(f_sql);
    			f_rs.next();

    			int f_cnt = f_rs.getInt("cnt");
    			
    			if(f_cnt == 1){
    				color="pink";
    				%>
    				<td style="color:<%=color %>;" align="center"><a href="javascript:fn_defail('<%=f_date %>')"><%=d %></a></td>
    				<%
    			} else {
    		%>
    		 	<td style="color:<%=color %>;" align="center"><%=d %></td>
    		<%	
    			}
    			if(count==7){	// 7칸씩 밑으로 내리기
    				out.print("<tr></tr>");
    				count = 0;
    			}
    		}
    		while(count < 7){ //남은 날짜 빈칸 출력
    			out.print("<td></td>");
    			count++;
    		}
    		%>
    	</tr>
    </table>
</body>
</html>