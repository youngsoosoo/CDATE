<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="connectDB.jsp" %><!-- 데이터베이스 커넥션 생성 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width">
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
%>
	<div class="container">
		<div class="row">
			<form method="post" action="boardWriteSave.jsp" enctype="multipart/form-data">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<caption>
						<jsp:include page="/Header.jsp" flush="false"/>
					</caption>
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">DAILY LOOK</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="file" class="form-control" name="boardimg"><input type="file" class="form-control" name="boardimgplus"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" name="boardcontent" maxlength="2048" style="height: 350px;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<!-- 글쓰기 버튼 생성 -->
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
			</form>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>