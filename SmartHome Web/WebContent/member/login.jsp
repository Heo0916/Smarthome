<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
function loginCheck() {
	if (document.frm.userID.value.length == 0) {
		alert("아이디를 입력해주세요.");
		frm.userID.focus();
		return false;
	}
	if (document.frm.userPassword.value == "") {
		alert("비밀번호 입력해주세요.");
		frm.userPassword.focus();
		return false;
	}
	document.frm.submit();
}
</script>
<meta name = "viewport" content = "width=device-width", initial-scale ="1">
<link rel = "stylesheet" href = "../css/bootstrap.css">
<link rel = "stylesheet" href = "../css/custom.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인</title>
</head>
<body>
	<nav class = "navbar navbar-defalut">
		<div class = "navbar-header">
			<button type ="button" class ="navbar-toggle collapsed"
				data-toggle = "collapse" data-target ="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class ="icon-bar"></span>
				<span class ="icon-bar"></span>
				<span class ="icon-bar"></span>
				</button>
				<a class ="navbar-brand" href ="../main.jsp">Smart-Home 웹 사이트</a>
		</div>
		<div class = "collapse navbar-collapse" id="#bs-example-navbar-collapse-1">
			<ul class = "nav navbar-nav">
				<li><a href="../main.jsp">Main</a></li>
				<li><a href="../chart.jsp">Chart</a></li>
			</ul>
			<ul class = "nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href = "#" class ="dropdown-toggle"
						data-toggle="dropdown" role ="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class = "caret"></span></a>
						<ul class ="dropdown-menu">
							<li class = "active"><a href ="login.jsp">로그인</a></li>
							<li><a href ="join.jsp">회원가입</a></li>
						</ul>
		</li>
		</ul>
		</div>
		</nav>
	<div class = "container">
			<div class = "col-lg-4"></div>
			<div class = "col-lg-4">
				<div class ="jumbotron" style ="padding-top : 20px;">
					<form action = "loginAction.jsp" method = "post" name = "frm" onsubmit="return loginCheck();">
						<h3 style ="text-align: center;">로그인화면</h3>
						<div class = "form-group">
							<input type = "text" class ="form-control" placeholder="아이디" name ="userID" maxlength="20"
						value="<%if (session.getAttribute("id") != null)out.println(session.getAttribute("id"));%>">
					</div>
					<div class = "form-group">
						<input type = "password" class ="form-control" placeholder="비밀번호" name ="userPassword" maxlength="20">
					</div>
					<input type ="submit" class ="btn btn-primary form-control" value="로그인">
					<br><br>
					<input type ="button" class ="btn btn-primary form-control"
					 value="회원가입" onclick = "javascript:window.location='join.jsp'">
					</form>
			</div>
		</div>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>