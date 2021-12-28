<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>

<!DOCTYPE html>

 

<html>

 

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta name="viewport" content="width=device-width" , initial-scale="1">

<!-- 반응형 웹설정 -->

<link rel="stylesheet" href="css/bootstrap.css">

<link rel="stylesheet" href="css/custom.css">

 

<title>	MCSOFT </title>

</head>

 

 

<body>

 

    <%

        String userID = null; /* 로그인 되어있지 않은 사람은 userID에 null값을 받음*/

        if (session.getAttribute("userID") != null) {

            userID = (String) session.getAttribute("userID"); /* 로그인 된 사람은 userID 에 본인 아이디 값을 받음 */

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

 

                <li class="active"><a href="main.jsp">메인</a></li>

 

                <li><a href="bbs.jsp">게시판</a></li>

 

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

        <div class="jumbotron">

            <div class="container">

                <h1>MCSOFT</h1>

                <p>국내최대 게임전문쇼핑몰 플레이스테이션4 공식 파트너샵</p>

            </div>

        </div>

    </div>

    <div class="container">

        <div id="myCarousel" class="carousel slide" data-ride="carousel">

            <ol class="carousel-indicators">

                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>

                <li data-target="#myCarousel" data-slide-to="1"></li>

                <li data-target="#myCarousel" data-slide-to="2"></li>

            </ol>

              <!-- 이미지 넣어주기 -->

            <div class="carousel-inner">

                <div class="item active">

                    <img src="https://storagekkl.blob.core.windows.net/mcsoft/c.jpeg">

                </div>

                <div class="item">

                    <img src="https://storagekkl.blob.core.windows.net/mcsoft/a.jpg">

                </div>

                <div class="item">

                    <img src="https://storagekkl.blob.core.windows.net/mcsoft/1.jpg">

                </div>

                <!-- 이미지 넘기는 버튼 생성 -->

                <a class="left carousel-control" href="#myCarousel" data-slide="prev">

                    <span class="glyphicon glyphicon-chevron-left"></span>

                </a>

                <a class="right carousel-control" href="#myCarousel" data-slide="next">

                    <span class="glyphicon glyphicon-chevron-right"></span>

                </a>

            </div>

        </div>

    

    </div>

 

        <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

 

        <!--애니메이션 담당할 제이쿼리 참조  -->

 

        <script src="js/bootstrap.js"></script>

 

        <!-- 부트스트랩에서 제공하는 자바스크립트 참조 -->

</body>

 

</html>