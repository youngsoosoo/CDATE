<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@ page import="user.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
String userID = request.getParameter("userId"); 
String userPassword = request.getParameter("userPassword"); 
String userName = request.getParameter("userName");
String userKey = request.getParameter("userKey");
if (userID == null || userID.equals("") || userPassword == null
	|| userPassword.equals("") || userName == null || userName.equals("")) {
	PrintWriter script = response.getWriter();
	script.println("<script type=\"text/javascript\">");
	script.println("alert('입력이 안 된 사항이 있습니다.')");
	script.println("history.go(-1);");
	script.println("</script>");
	script.close();
	return;
}
int result = new UserDAO().register(userID, userPassword, userName);
if (result == 1) {
	PrintWriter script = response.getWriter();
	script.println("<script type=\"text/javascript\">");
	script.println("alert('회원가입에 성공했습니다.')");
	script.println("location.href='login.jsp';");
	script.println("</script>");
	script.close();
	return;
} else {
	PrintWriter script = response.getWriter();
	script.println("<script type=\"text/javascript\">");
	script.println("alert('이미 존재하는 아이디입니다.')");
	script.println("history.go(-1);");
	script.println("</script>");
	script.close();
}
%>
</body>
</html>