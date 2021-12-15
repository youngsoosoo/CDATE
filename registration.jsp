<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	h2{text-align:center; color: #55d01f}
	header{
        display:flex;
        justify-content: center;
    }
    form{
        padding:10px;
    }
    .input-box{
    	display:flex;
        justify-content: center;
        position:relative;
        margin:0 auto;
        
    }
    .input-box > input{
        background:transparent;
        border:none;
        border-bottom: solid 1px #55d01f;
        padding:20px 0px 5px 0px;
        font-size:14pt;
        width:30%;
     }
     input[type=submit]{
        background-color: #55d01f;
        border:none;
        color:white;
        border-radius: 5px;
        width:30%;
        height:35px;
        font-size: 14pt;
        margin-top:100px;
    }
    #forgot{
        text-align: right;
        font-size:12pt;
        color:rgb(164, 164, 164);
        margin:10px 0px;
    }
</style>
</head>
<body>
	<jsp:include page="/Header.jsp" flush="false"/>
	<form action="registerJoin.jsp" method="post">
	<br><br><br><br><br><br><br><br>
		<header>
            <h2>회원가입</h2>
        </header>
			<div class="input-box">
                <input id="username" type="text" name="userId" placeholder="아이디">
            </div>
            <div class="input-box">
                <input id="password" type="password" name="userPassword" placeholder="비밀번호">
            </div>
            <div class="input-box">
                <input id="username" type="text" name="userName" placeholder="이름">
            </div>          
            <div style="text-align: center;">
            	<input type="submit" value="회원가입">
            </div>
	</form>
</body>
</html>