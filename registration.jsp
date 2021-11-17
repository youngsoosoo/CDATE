<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	h1{text-align:center;}
	h2{text-align:center;}
	#test_btn1{
		border-top-left-radius: 5px;
		border-bottom-left-radius:5px;
		margin-right:4px;
	}
	#btn_group button{1
		border:1px solid skyblue;
		bakground-color:rgba(0, 0, 0, 0);
		color: skyblue;
		padding: 5px;
	}
	#btn_group button:hover{
		color:white;
		background-color:skyblie
	}
</style>
</head>
<body>
	<jsp:include page="/Header.jsp" flush="false"/>
	<form action="registerJoin.jsp" method="post">
	<p align="center">
	<table width="400" height = "100%" border="0" cellpadding="0" cellspacing="0" align="center">
		<br><br><br><br><br><br><br><br>
		<tr>
        	<td colspan="2" align=center height=40><FONT SIZE="2" COLOR="#34900b"><B>회원가입</B></FONT></td>
        </tr>
        <tr>
                <td align=right WIDTH=80 height=30 ><b><FONT SIZE="2" color='#34900b'>아이디&nbsp;</FONT></b></td>
                <td><input name="userId" type="text">&nbsp;<input name="checkId" type="button" value="중복체크"></td>
        </tr>
    	<tr>
            <td align=right height=30><b><font size=2 color='#34900b'>비밀번호&nbsp;</font></b></td>
            <td><input name="userPassword" type="password" border= "1px #34900b solid"></td>
       	</tr>
       	<tr>
       		<td align=right height=30><b><font size=2 color='#34900b'>이름(별명)&nbsp;</font></b></td>
       		<td><input name="userName" type="text" border= "1px #34900b solid"></td>
       	</tr>
       	<tr>
       		<td align=right height=30><b><font size=2 color='#34900b'>번호&nbsp;</font></b></td>
       		<td><input name="userKey" type="text" border= "1px #34900b solid"></td>
       	</tr>
        <tr>
            <td align=center colspan=2><BR><center><input type="submit" value="회원가입" style='background-color: #F4F4F4; border: 1px #34900b solid; width: 109px; height: 25px'>
             <input type=reset style='background-color: #F4F4F4; border: 1px #34900b solid; width: 109px; height: 25px'></td>
        </tr>
	</table>
	</p>
	</form>
</body>
</html>