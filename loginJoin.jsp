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
int result = new UserDAO().login(userID, userPassword);

if (result == 1) {
	session.setAttribute("userId", userID);
	PrintWriter script = response.getWriter();
	script.println("<script type=\"text/javascript\">");
	script.println("alert('로그인에 성공했습니다.')");
	script.println("location.href='Main1.jsp';");
	script.println("</script>");
	script.close();
	return;
} else if (result == 0) {
	PrintWriter script = response.getWriter();
	script.println("<script type=\"text/javascript\">");
	script.println("alert('비밀번호가 틀립니다.')");
	script.println("history.go(-1);");
	script.println("</script>");
	script.close();
} else if (result == -1) {
	PrintWriter script = response.getWriter();
	script.println("<script type=\"text/javascript\">");
	script.println("alert('아이디가 틀립니다.')");
	script.println("history.go(-1);");
	script.println("</script>");
	script.close();
} else if (result == -2) {
	PrintWriter script = response.getWriter();
	script.println("<script type=\"text/javascript\">");
	script.println("alert('데이터베이스 오류가 발생했습니다.')");
	script.println("history.go(-1);");
	script.println("</script>");
	script.close();
}
%>
</body>
</html>