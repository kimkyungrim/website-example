<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 만들어주기위해 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 데이터를 UTF-8받기위해 -->
<jsp:useBean id="user" class="user.User" scope="page" /> <!-- scope는 현페이지에서만 빈즈가 사용되어지도록 제한 -->
<!-- 회원가입시 입력받을 항목 -->
<jsp:setProperty name="user" property="userID" /> 
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" /> 
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" /> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MCSOFT</title>
</head>
<body>

    <%
        /* 로그인이 된 유저가  또다시 로그인 페이지와, 회원가입 페이지에 접속하지 못하도록 함 */
        String userID = null;
    if(session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID"); /* userID에 할당된 본인의 ID 세션을 담을 수 있도록 */
    }

    if(userID != null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 로그인이 되어 있습니다.')");
        script.println("location.href = 'main.jsp'");
        script.println("</script>");
    }
    if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || user.getUserGender() == null || user.getUserEmail() == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('모든 항목에 입력해 주세요.')");
        script.println("history.back()");
        script.println("</script>");
    } else{
          UserDAO userDAO = new UserDAO();
          int result = userDAO.join(user); 
          if (result == -1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('아이디가 이미 사용되어지고 있습니다.')");
            script.println("history.back()");
            script.println("</script>");
          }
          else{
        	  session.setAttribute("userID", user.getUserID()); 
        	  PrintWriter script = response.getWriter();
        	  script.println("<script>");
        	  script.println("location.href = 'main.jsp'");
        	  script.println("</script>");
          }
    }
    %>
</body>
</html>