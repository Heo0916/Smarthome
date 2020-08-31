<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.heo.member.MemberDao"%>
<%@ page import ="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="user" class="com.heo.member.MemberDto" scope="page" />
<jsp:setProperty property="userID" name="user"/>
<jsp:setProperty property="userPassword" name="user"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>loginAction</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if (userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
	
		MemberDao memberDao = new MemberDao();
		int result = memberDao.login(user.getUserID(),user.getUserPassword());
			if (result == 1){
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = '../main.jsp'");
				script.println("</script>");
			}
			else if (result == 0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호가 틀립니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else if (result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('존재하지 않는 아이디 입니다.')");
				script.println("history.back()");
				script.println("</script>");
				}
			else if (result == -2){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('서버 오류가 발생했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
	%>
</body>
</html>