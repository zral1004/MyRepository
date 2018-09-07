<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


 <!-- nav 헤더-->
    <nav class="navbar navbar-default">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="nav_logo_text navbar-brand" href="/finalproject/main.go" style="color:#fff;">MockCoin</a>
            </div>
            <div class="collapse navbar-collapse" id="myNavbar">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="/finalproject/trade.io">거래하기</a>
                    </li>
                    <!--세션이 없는경우 -->
                    <c:if test="${sessionScope.login==null}"> 
                    <li>
                        <a href="/finalproject/login.go">로그인</a>
                    </li>
                    <li>
                        <a href="/finalproject/login.go?type=join">회원가입</a>
                    </li>
                    </c:if>
                    <!--세션이 있는 경우 -->
                    <c:if test="${sessionScope.login!=null}"> 
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">${login.email}
                        <span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="/finalproject/mypage.go">비밀번호변경</a></li>
                            <!-- <li><a href="#">자산현황</a></li> -->
                        </ul>
                    </li>
                    <li>
                        <a href="/finalproject/logout.go">로그아웃</a>
                    </li> 
                    </c:if>
               
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">커뮤니티 <span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="/finalproject/BoardListCon.do">자유게시판</a></li>
                            <!-- <li><a href="#">코인소식</a></li>   -->
                        </ul>
                    </li>
                     <li>
                        <a href="/finalproject/rank.go">랭킹</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
