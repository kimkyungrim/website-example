<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ page import ="bbs.Bbs" %>

<%@ page import ="bbs.BbsDAO" %>

<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트 만들어주기위해 -->

<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 데이터를 UTF-8받기위해 -->

 

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

    }

    int bbsID = 0;

    if (request.getParameter("bbsID") != null) { //bbsID가 정상적으로  넘어왔을때 실행되는 함수

        bbsID = Integer.parseInt(request.getParameter("bbsID"));

    }

    if (bbsID == 0) { //bbsID가 null일경우 실행되는 함수

        PrintWriter script = response.getWriter();

        script.println("<script>");

        script.println("alert('유효하지 않은 글입니다.')");

        script.println("location.href = 'bbs.jsp'");

        script.println("</script>");

    }

    Bbs bbs = new BbsDAO().getBbs(bbsID); //bbs값이 있다면 bbs객체를 만들어 그안에 불러와주는 함수

    if (!userID.equals(bbs.getUserID())) {

        PrintWriter script = response.getWriter();

        script.println("<script>");

        script.println("alert('글 작성자만 수정할 수 있습니다.')");

        script.println("location.href = 'bbs.jsp'");

        script.println("</script>");

    } else {

          if(request.getParameter("bbsTitle") == null ||request.getParameter("bbsContent") == null

                  || request.getParameter("bbsTitle").equals(" ") || request.getParameter("bbsContent").equals(" ")) {

                PrintWriter script = response.getWriter();

                script.println("<script>");

                script.println("alert('모든 항목에 입력해 주세요.')");

                script.println("history.back()");

                script.println("</script>");

            } else{

                  BbsDAO bbsDAO = new BbsDAO();

                  int result = bbsDAO.update(bbsID, request.getParameter("bbsTitle"), request.getParameter("bbsContent")); 

                  if (result == -1) {

                    PrintWriter script = response.getWriter();

                    script.println("<script>");

                    script.println("alert('글 수정에 실패했습니다.')");

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