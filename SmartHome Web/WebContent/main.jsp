<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name = "viewport" content = "width=device-width", initial-scale ="1">
<link rel = "stylesheet" href = "css/bootstrap.css">
<link rel = "stylesheet" href = "css/custom.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Main</title>
</head>
<body>
	<% 
	String userID = null;
	if (session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	%>
	<nav class = "navbar navbar-defalut">
		<div class = "navbar-header">
			<button type ="button" class ="navbar-toggle collapsed"
				data-toggle = "collapse" data-target ="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class ="icon-bar"></span>
				<span class ="icon-bar"></span>
				<span class ="icon-bar"></span>
				</button>
				<a class ="navbar-brand" href ="main.jsp">Smart-Home 웹 사이트</a>
		</div>
		<div class = "collapse navbar-collapse" id="#bs-example-navbar-collapse-1">
			<ul class = "nav navbar-nav">
				<li class="active"><a href="main.jsp">Main</a></li>
				<li><a href="chart.jsp">Chart</a></li>
			</ul>
			<%
				if(userID == null){
			%>
			<ul class = "nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href = "#" class ="dropdown-toggle"
						data-toggle="dropdown" role ="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class = "caret"></span></a>
						<ul class ="dropdown-menu">
							<li><a href ="member/login.jsp">로그인</a></li>
							<li><a href ="member/join.jsp">회원가입</a></li>
						</ul>
		</li>
		</ul>
			<%
			}else {
			%>
			<ul class = "nav navbar-nav navbar-right">
				<li class = "dropdown">
					<a href = "#" class ="dropdown-toggle"
						data-toggle="dropdown" role ="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class = "caret"></span></a>
						<ul class ="dropdown-menu">
							<li><a href ="chart.jsp">차트 보기</a></li>
							<li><a href ="member/logoutAction.jsp">로그아웃</a></li>
						</ul>
		</li>
		</ul>
			<%
			}
			%>
		</div>
		</nav>
		<div  class = "container">
			<div class = "jumbotron">
				<div class = "container">
					<h1>Smart Home 소개</h1> 
					<p> 정보통신 CCIT 졸업 작품인 스마트 홈 웹 사이트입니다.<br>
					스마트 미러에  AI음성인식을 통하여 IoT서비스를 제공하고, 집안의 데이터 정보들을 차트로 보여줍니다.<br><br>
					<a class = "btn btn-primary btn-pull" href ="https://www.joongbu.ac.kr/smartit/" role = "button">스마트IT학과 홈페이지</a>
				</div>
			</div>
		</div>
		
		<div class="container">
			<div id = "myCarousel" class ="carousel slide" data-ride ="carousel">
				<ol class ="carousel-indicators">
					<li data-target="#myCarousel" data-slide-to="0" class="active"> </li>
					<li data-target="#myCarousel" data-slide-to="1" ></li>
				</ol>
				<div class = "carousel-inner">
					<div class = "item active">
						<img src = "image/image2.jpg">
					</div>
					<div class = "item">
						<img src = "image/image3.jpg">
					</div>	
				</div>
					<a class = "left carousel-control" href = "#myCarousel" data-slide = "prev">
						<span class = "glyphicon glyphicon-chevron-left"></span>
					</a>
					<a class = "right carousel-control" href = "#myCarousel" data-slide = "next">
						<span class = "glyphicon glyphicon-chevron-right"></span>
					</a>
					
				</div>
			</div>
		</div>
		<div>
		<br><br><br><br><br><br>
		</div>
	
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>