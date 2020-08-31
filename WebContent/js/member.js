function joinCheck() {
    var email = document.frm.userEmail.value;
    var regex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

	if (document.frm.userName.value.length == 0) {
		alert("이름을 써주세요.");
		frm.name.focus();
		return false;
	}
	if (document.frm.userID.value.length == 0) {
		alert("아이디를 써주세요");
		frm.userid.focus();
		return false;
	}
	if (document.frm.userID.value.length < 4) {
		alert("아이디는 4글자이상이어야 합니다.");
		frm.userid.focus();
		return false;
	}
	if (document.frm.userPassword.value == "") {
		alert("암호는 반드시 입력해야 합니다.");
		frm.pwd.focus();
		return false;
	}
	if (document.frm.userPassword.value != document.frm.userPassword_check.value) {
		alert("암호가 일치하지 않습니다.");
		frm.pwd.focus();
		return false;
	}
	/*if (document.frm.reid.value.length == 0) {
		alert("중복 체크를 하지 않았습니다.");
		frm.userid.focus();
		return false;
	}*/
	 if (document.frm.mail.value == "") {
         alert("이메일을 입력하지 않았습니다.")
         document.mail.focus();
         return false;
     }
     if (regex.test(mail) === false) {
         alert("잘못된 이메일 형식입니다.")
         document.frm.userEmail.value=""
         document.frm.userEmail.focus();
         return false;
     }

     for (var i = 0; i < document.f.mail.value.length; i++) {
         chm = document.f.mail.value.charAt(i)
         if (!(chm >= '0' && chm <= '9') && !(chm >= 'a' && chm <= 'z')&&!(chm >= 'A' && chm <= 'Z')) {
             alert("이메일은 영문 대소문자, 숫자만 입력가능합니다.")
             document.f.mail.focus();
             document.f.mail.select();
             return false;
         }
     }
	return true;
}

function idCheck() {
           window.name = "parentForm";
           window.open("../member/idCheck.jsp",
                   "chkForm", "width=500, height=300, resizable = no, scrollbars = no");    
       }
//아이디 입력창에 값 입력시 hidden에 idUncheck를 세팅한다.
// 중복체크 후 다시 아이디 창이 새로운 아이디를 입력했을 때
// 다시 중복체크를 하도록 한다.

function inputIdChk(){
    document.userInfo.idDuplication.value ="idUncheck";
}

