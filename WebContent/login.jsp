<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                <li><a href="bbs.jsp">게시판</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown"><a href="#" class="dropdown-toggle"
                    data-toggle="dropdown" role="button" aria-haspopup="true"
                    aria-expanded="false">접속하기<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li class="active"><a href="login.jsp">로그인</a></li>
                        <!-- active는 현재 선택된 메뉴로 한페이지에서 한개만 사용가능-->
                        <li><a href="join.jsp">회원가입</a>
                        <li>
                    </ul></li>
            </ul>
        </div>
    </nav>
    <!-- 로그인 양식 -->
    <div class="container">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <div class="jumbotron" style="padding-top: 20px;">
                <form method="post" action="loginAction.jsp">
                    <!-- LoginAction으로 로그인 정보를 보냄 -->
                    <h3 style="text-align: center;">로그인 화면</h3>
                    <div class="from-group">
                        <input type="text" class="form-control" placeholder="아이디"
                            name="userID" maxlength="20">
                    </div>
                    <div class="from-group">
                        <input type="password" class="form-control" placeholder="비밀번호"
                            name="userPassword" maxlength="20">
                    </div>
                    <input type="submit" class="btn btn-primary form-control"
                        value="로그인">
                </form>
            </div>
            <div class="col-lg-4"></div>
        </div>
        <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
        <!--애니메이션 담당할 제이쿼리 참조  -->
        <script src="js/bootstrap.js"></script>
        <!-- 부트스트랩에서 제공하는 자바스크립트 참조 -->
</body>
</html>

