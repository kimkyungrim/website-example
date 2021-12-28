<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ page import ="bbs.BbsDAO" %>

<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 만들어주기위해 -->

<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 데이터를 UTF-8받기위해 -->

 

<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" /> <!-- scope는 현페이지에서만 빈즈가 사용되어지도록 제한 -->

<!-- 회원가입시 입력받을 항목 -->

<jsp:setProperty name="bbs" property="bbsTitle" /> 

<jsp:setProperty name="bbs" property="bbsContent" />

 

<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>MCSOFT</title>

</head>

 

<body>

    <%

        /* 로그인이 된 유저가 로그인 페이지와, 회원가입 페이지에 접속하지 못하도록 함 */

        String userID = null;

    if(session.getAttribute("userID") != null) {

        userID = (String) session.getAttribute("userID"); /* userID에 할당된 본인의 ID 세션을 담을 수 있도록 */

    }

    if(userID == null) {

        PrintWriter script = response.getWriter();

        script.println("<script>");

        script.println("alert('로그인이 필요한페이지 입니다.')");

        script.println("location.href = 'login.jsp'"); /* 이전페이지로 보내기 */

        script.println("</script>");

    } else {

          if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {

                PrintWriter script = response.getWriter();

                script.println("<script>");

                script.println("alert('모든 항목에 입력해 주세요.')");

                script.println("history.back()");

                script.println("</script>");

            } else{

                  BbsDAO bbsDAO = new BbsDAO();

                  /* 글입력하게 해주는 int문 */

                  int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent()); 

 

                  if (result == -1) {

                    PrintWriter script = response.getWriter();

                    script.println("<script>");

                    script.println("alert('작성된 글 저장에 실패했습니다.')");

                    script.println("history.back()");

                    script.println("</script>");

                  }

 

                  else {       

                      PrintWriter script = response.getWriter();

                      script.println("<script>");

                      script.println("location.href = 'bbs.jsp'");

                      script.println("</script>");

                  } 

            }

    }

    

  

 

    %>

</body>

 

</html>