<%@page import="board.board"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="connectDB.jsp" %><!-- 데이터베이스 커넥션 생성 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="css/bootstrap.css">
<title>Insert title here</title>
<style>
    a {
  	text-decoration-line: none;
	color: black;
	}
	a:hover{
	text-decoration-line: none;
	color: black;
	}
	.copy {
	text-align: center;
    }
</style>
</head>
<body>

<%
	String USERID = (String) session.getAttribute("userId");

	if(USERID ==null){
%>
	<script>
		alert("로그인 이후에 이용가능합니다.");
		self.close();
	</script>
<%
	return;
}
	int pageNumber = 1;
	if(request.getParameter("pageNumber") != null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
%>

<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<caption>
				<jsp:include page="/Header1.jsp" flush="false"/>
			</caption>
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">STORY</th>

					</tr>
				</thead>
				<tbody>
					<%
					//현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
					int next = 1;//첫 번째 게시물인 경우
					String sql2 = "select boardid from board order by boardid desc";
					pstmt = conn.prepareStatement(sql2);
					rs = pstmt.executeQuery(sql2);
					if(rs.next()) {
						next = rs.getInt(1) + 1;
					}
						String sql = "select boardid, boardimg from board where boardid < ? order by boardid desc limit 9";
						ArrayList<board> list = new ArrayList<board>();
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, next - ((pageNumber - 1) * 9));
							rs = pstmt.executeQuery();
							while(rs.next()) {
								board board = new board();
								board.setBoardid(rs.getInt("boardid"));
								board.setBoardimg(rs.getString("boardimg"));
								list.add(board);
							}
						
					%>
					<tr>

						<td><%for(int i = 0; i < list.size(); i++){ %><a href="boardView.jsp?boardID=<%= list.get(i).getBoardid() %>">
						<img alt="<%= list.get(i).getBoardimg()%>" src="fileSave/<%= list.get(i).getBoardimg() %>" width="300" height="300"></a><%} %></td>
						
					</tr>
				</tbody>
			</table>
			<%
				if(pageNumber != 1){
			%>
				<a href="board.jsp?pageNumber=<%=pageNumber - 1 %>"
					class="btn btn-success btn-arraw-left">이전</a>
			<%
				}
				String sql3 = "select * from board where boardid < ?";
				pstmt = conn.prepareStatement(sql3);
				pstmt.setInt(1, next - (pageNumber) * 9);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					if(pageNumber > 0){
			%>
						<a href="board.jsp?pageNumber=<%=pageNumber + 1 %>"
						class="btn btn-success btn-arraw-left">다음</a>
			<%
					}
				}
			%>
			<a href="boardWrite.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
<script src="https:code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<br><br><br><br><br><br><br><br><br><br><br><br>
<footer>
    <p class="copy" >Copyright © 2021 박용수 </p>
</footer>
</body>
</html>