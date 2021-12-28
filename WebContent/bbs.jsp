<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>

<%@ page import="bbs.BbsDAO"%>

<%@ page import="bbs.Bbs"%>

<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html>

 

<html>

 

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta name="viewport" content="width=device-width" , initial-scale="1">

<!-- 반응형 웹설정 -->

<link rel="stylesheet" href="css/bootstrap.css">

<!-- css참조 -->

<link rel="stylesheet" href="css/custom.css">

<title>	MCSOFT </title>

</head>

 

<body>

 

    <%

        String userID = null; /* 로그인 되어있지 않은 사람은 userID에 null값을 받음*/

        if (session.getAttribute("userID") != null) {

            userID = (String) session.getAttribute("userID"); /* 로그인 된 사람은 userID 에 본인 아이디 값을 받음 */

        }

        int pageNumber = 1; //기본1페이지를 의미

        if (request.getParameter("pageNumber") != null) {

            pageNumber = Integer.parseInt(request.getParameter("pageNumber")); //넘어온 파라메터값을 정수형으로 바꿔줌

        }

    %>

 

    <!-- 네비게이션 -->

 

    <nav class="navbar navbar-default">

 

        <div class="navbar-header">

 

            <button type="button" class="navbar-toggle collapsed"

                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"

                aria-expanded="false">

 

                <span class="icon-bar"></span> <span class="icon-bar"></span> <span

                    class="icon-bar"></span>

 

            </button>

 

            <a class="navbar-brand" href="main.jsp">MCSOFT</a>

 

        </div>

 

        <div class="collapse navbar-collapse"

            id="bs-example-navbar-collapse-1">

 

            <ul class="nav navbar-nav">

 

                <li><a href="main.jsp">메인</a></li>

 

                <li class="active"><a href="bbs.jsp">게시판</a></li>

 

            </ul>

            <%

                if (userID == null) {

            %>

            <!-- 로그인 하지 않은 사람들이 볼 수 있는 페이지 -->

            <ul class="nav navbar-nav navbar-right">

 

                <li class="dropdown"><a href="#" class="dropdown-toggle"

                    data-toggle="dropdown" role="button" aria-haspopup="true"

                    aria-expanded="false">접속하기<span class="caret"></span></a>

 

                    <ul class="dropdown-menu">

 

                        <li><a href="login.jsp">로그인</a></li>

                        <li><a href="join.jsp">회원가입</a>

                        <li>

                    </ul></li>

 

            </ul>

            <%

                } else {

            %>

            <!-- 로그인 된사람들이 볼 수 있는 페이지 -->

            <ul class="nav navbar-nav navbar-right">

 

                <li class="dropdown"><a href="#" class="dropdown-toggle"

                    data-toggle="dropdown" role="button" aria-haspopup="true"

                    aria-expanded="false">회원관리<span class="caret"></span></a>

 

                    <ul class="dropdown-menu">

 

                        <li><a href="logoutAction.jsp">로그아웃</a></li>

                        <li>

                    </ul></li>

 

            </ul>

            <%

                }

            %>

        </div>

 

    </nav>

 

    <div class="container">

        <div class="row">

            <table class="table table-striped"

                style="text-align: center; border: 1px solid #dddddd">

                <thead>

                    <!-- 테이블 속성 -->

                    <tr>

                        <th style="background-color: #eeeeee; text-align: center;">번호</th>

                        <th style="background-color: #eeeeee; text-align: center;">제목</th>

                        <th style="background-color: #eeeeee; text-align: center;">작성자</th>

                        <th style="background-color: #eeeeee; text-align: center;">작성일</th>

                    </tr>

                </thead>

 

                <tbody>

                    <%

                        BbsDAO bbsDAO = new BbsDAO();

                        ArrayList<Bbs> list = bbsDAO.getList(pageNumber); //가져온 게시글 목록

                        for (int i = 0; i < list.size(); i++) { //가져온 목록을 리스트 사이즈 까지 하니씩 출력

                    %>

                    <tr>

                        <td><%=list.get(i).getBbsID()%></td>

                        <td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle().replaceAll(" ", " ").replaceAll("<", "<")

                        .replaceAll(">", ">").replaceAll("\n", "<br>")%></a></td>

                        <!-- 크로스사이트스크립트 해킹 방지 -->

                        <td><%=list.get(i).getUserID()%></td>

                        <td><%=list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시"

                        + list.get(i).getBbsDate().substring(14, 16) + "분"%></td>

                    </tr>

                    <%

                        }

                    %>

 

                </tbody>

            </table>

 

            <!-- 페이지 넘기기 -->

            <%

                if (pageNumber != 1) {

            %>

            <a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>"

                class="btn btn-primary btn-arrow-left">이전</a>

            <%

                }

                if (bbsDAO.nextPage(pageNumber)) {

            %>

            <a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>"

                class="btn btn-primary btn-arrow-left">다음</a>

            <%

                }

            %>

            <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>

        </div>

    </div>

    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

 

    <!--애니메이션 담당할 제이쿼리 참조  -->

 

    <script src="js/bootstrap.js"></script>

 

    <!-- 부트스트랩에서 제공하는 자바스크립트 참조 -->

</body>

 

</html>