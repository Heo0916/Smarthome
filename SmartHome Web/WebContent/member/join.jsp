<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
function joinCheck() {
	 var email = document.frm.userEmail.value;
	 var regex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	if (document.frm.userID.value.length == 0) {
		alert("아이디를 입력하지 않았습니다.");
		frm.userID.focus();
		return false;
	}
	//아이디 유효성 검사 (영문소문자, 숫자만 허용)
	//alert(document.frm.userID.value.length);
    //for (var i = 0; i < document.frm.userID.value.length; i++) {
        // ch = document.frm.id.value.charAt(i)
         //if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')) {
            // alert("아이디는 영문 대소문자, 숫자만 입력가능합니다.");
             //document.frm.userID.focus();
             //document.frm.userID.select();
             //return false;
         //}
   //  }
	
	 if (document.frm.userID.value.length<4) {
		alert("아이디는 4글자이상이어야 합니다.");
		frm.userID.focus();
		return false;
	}
	 if (document.frm.userPassword.value == "") {
		alert("암호는 반드시 입력해야 합니다.");
		frm.userPassword.focus();
		return false;
	}
	 if (document.frm.userPassword.value != document.frm.userPassword_check.value) {
		alert("암호가 일치하지 않습니다.");
		frm.userPassword.focus();
		return false;
	}
	 if (document.frm.userName.value.length == 0) {
		alert("이름을 써주세요.");
		frm.userName.focus();
		return false;
	}
	
	/* if (document.frm.reid.value.length == 0) {
		alert("중복 체크를 하지 않았습니다.");
		frm.userid.focus();
		return false;
	} */
	if (document.frm.userEmail.value == "") {
        alert("이메일을 입력하지 않았습니다.")
        document.frm.userEmail.focus();
        return false;
    }
    if (regex.test(email) === false) {
        alert("잘못된 이메일 형식입니다.");
        document.frm.userEmail.focus();
        return false;
    }
    document.frm.submit();
}

</script>
<meta name = "viewport" content = "width=device-width", initial-scale ="1">
<link rel = "stylesheet" href = "../css/bootstrap.css">
<link rel = "stylesheet" href = "../css/custom.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
</head>
<body>
	<nav class = "navbar navbar-defalut">
		<div class = "navbar-header">
			<button type ="button" class ="navbar-toggle collapsed"
				data-toggle = "collapse" data-target ="#bs-example-navbar-collapse-1"
				aria-expanded="true">
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
							<li><a href ="login.jsp">로그인</a></li>
							<li class = "active"><a href ="join.jsp">회원가입</a></li>
						</ul>
		</li>
		</ul>
		</div>
		</nav>
	<div class = "container">
			<div class = "col-lg-4"></div>
			<div class = "col-lg-4">
				<div class ="jumbotron" style ="padding-top : 20px;">
					<form method = "post" action = "joinAction.jsp" name ="frm" onsubmit="return joinCheck();">
					<h3 style ="text-align: center;">회원가입화면</h3>
					<div class = "form-group">
					<input type = "text" class ="form-control" placeholder = "아이디" name ="userID" maxlength="20">
					</div>
					<div class = "form-group">
						<input type = "password" class ="form-control" placeholder = "비밀번호" name ="userPassword" maxlength="20">
					</div>
					<div class = "form-group">
						<input type = "password" class ="form-control" placeholder = "비밀번호 확인" name ="userPassword_check" maxlength="20">
					</div>
					<div class = "form-group">
						<input type = "text" class ="form-control" placeholder = "이름" name ="userName" maxlength="20">
					</div>
					<div class = "form-group">
						<input type = "text" class ="form-control" placeholder = "이메일" name ="userEmail" maxlength="50">
					</div>	
					<input type ="submit" class ="btn btn-primary form-control" value="회원가입">
					<br><br>
					<input	type="reset" class ="btn btn-primary form-control"	value="취소" onclick="javascript:window.location='login.jsp'">
					
					</form>
			</div>
		
		</div>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>