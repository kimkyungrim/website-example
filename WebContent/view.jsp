<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>

<%@ page import="bbs.Bbs"%>

<!-- 실제 데이터를 사용할 수 있도록 bbs클래스 가져오기 -->

<%@ page import="bbs.BbsDAO"%>

<!DOCTYPE html>

 

<html>

 

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta name="viewport" content="width=device-width" , initial-scale="1">

<!-- 반응형 웹설정 -->

<link rel="stylesheet" href="css/bootstrap.css">

<!-- css참조 -->

<link rel="stylesheet" href="css/custom.css">

<title>MCSOFT</title>

</head>

 

<body>

 

    <%

        String userID = null; /* 로그인 되어있지 않은 사람은 userID에 null값을 받음*/

        if (session.getAttribute("userID") != null) {

            userID = (String) session.getAttribute("userID"); /* 로그인 된 사람은 userID 에 본인 아이디 값을 받음 */

        }

        //매개변수및 기본셋팅

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

            <!-- 작성된 글은, 아래의 submit을 통해 writeAction.jsp로 보냄 -->

            <table class="table table-striped"

                style="text-align: center; border: 1px solid #dddddd">

                <thead>

                    <!-- 테이블 속성 -->

                    <tr>

                        <th colspan="3"

                            style="background-color: #eeeeee; text-align: center;">게시판 글</th>

                    </tr>

                </thead>

                <!-- 테이블 내용 -->

                <tbody>

                    <tr>

                        <td style="width: 20%;">글제목</td>

                        <td colspan="2"><%=bbs.getBbsTitle()%></td>

                    </tr>

                    <tr>

                        <td>작성자</td>

                        <td colspan="2"><%=bbs.getUserID()%></td>

                    </tr>

                    <tr>

                        <td>작성일자</td>

                        <td colspan="2"><%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시"

                    + bbs.getBbsDate().substring(14, 16) + "분"%></td>

                    </tr>

                    <tr>

                        <td>내용</td>

                        <td colspan="2" style="min-height: 200px; tex-align: left;"><%=bbs.getBbsContent().replaceAll(" ", " ").replaceAll("<", "<").replaceAll(">", ">").replaceAll("\n", "<br>")%></td>

                        <!-- 특수문자처리 -->

                    </tr>

                    <tr>

                        <td>bbsID</td>

                        <td colspan="2"><%=bbs.getBbsID()%></td>

                    </tr>

                </tbody>

            </table>

            <!--버튼 만들기  -->

            <a href="bbs.jsp" class="btn btn-primary">목 록</a>

            <%

                /* 해당 글 작성자가 로그인 상태인 본인일 경우에만, 수정 및 삭제 버튼 활성화 */

                if (userID != null && userID.equals(bbs.getUserID())) {

            %>

            <a href="update.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">수 정</a>

                <a onclick="return confirm('정말로 삭제하시겠습니까')" href="deleteAction.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">삭 제</a>

            <%

                }

            %>

        </div>

    </div>

 

    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

 

    <!--애니메이션 담당할 제이쿼리 참조  -->

 

    <script src="js/bootstrap.js"></script>

 

    <!-- 부트스트랩에서 제공하는 자바스크립트 참조 -->

</body>

 

</html>