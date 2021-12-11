<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.io.PrintWriter"%>
<%@ include file="connectDB.jsp" %><!-- 데이터베이스 커넥션 생성 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="board" class="board.board" scope="page" />
<jsp:setProperty name="board" property="boardtitle" />
<jsp:setProperty name="board" property="boardcontent" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
		//파일저장 위치 설정
		String fileSave = "/fileSave";
	
		//실제 파일 저장 위치
		String real = application.getRealPath(fileSave);
	
		int max = 1024 * 1024 * 10;//kb, mb, gb 순서
	
		//파라미터
		MultipartRequest mr = new MultipartRequest(request, real, max, "utf-8",	new DefaultFileRenamePolicy());
		
		String USERID = (String)session.getAttribute("id");
		String boardcontent = mr.getParameter("boardcontent");
		String filename = mr.getOriginalFileName("boardimg");
		String filename1 = mr.getOriginalFileName("boardimgplus");
		File file = new File(real+"/"+filename);
		
		String datenow = null;
		String sql1 = "select now()";
		pstmt = conn.prepareStatement(sql1);
		rs = pstmt.executeQuery(sql1);
		if(rs.next()){
			datenow = rs.getString(1);
		}
		
		//현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
		int next = 1;//첫 번째 게시물인 경우
		String sql2 = "select boardid from board order by boardid desc";
		pstmt = conn.prepareStatement(sql2);
		rs = pstmt.executeQuery(sql2);
		if(rs.next()) {
			next = rs.getInt(1) + 1;
		}
		if(session.getAttribute("userId") != null){
			USERID = (String)session.getAttribute("userId");
		}
		if(USERID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href='Main.jsp'");
			script.println("</script>");
		}else{
			if(boardcontent == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				String sql3 = "insert into board values('"+next+"', '"+USERID+"', '"+filename+"', '"+filename1+"', '"+datenow+"', '"+boardcontent+"')";
				pstmt = conn.prepareStatement(sql3);
				int result = pstmt.executeUpdate(sql3);
				if(result == 1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기 성공')");
					script.println("location.href='board.jsp'");
					script.println("</script>");
				}else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");
				}
			}
		}
	
	%>
</body>
</html>