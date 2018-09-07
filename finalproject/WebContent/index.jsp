<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/main.css?ver=1">

<!-- 배경화면 슬라이스 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<!--about us -->
<link href="css/grayscale.min.css" rel="stylesheet">
  
<!--service / icon 관련-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" crossorigin="anonymous">

<!--font  -->
<link href="https://fonts.googleapis.com/css?family=Playfair+Display" rel="stylesheet">

<style>
.carousel-caption
{
  right:0;
  left:0;
  bottom:0;
  width:100%;
  height:100%;
  background: rgba(100,100,100,0.5); /*블러 효과*/

}

.carousel-caption h3,#explain,#btn1     /* p태그 그냥 사용시 다 적용되서 아이디 부여 */
{
  position:relative;
  top:45%;
  left:0;
  right:0;
  transform: translateY(-50%);
  text-shadow: none;
  font-family: 'Playfair Display', serif;
}
/* 글자 사이즈 */
.carousel-caption h3     
{
  font-size:5em;
}

.carousel-caption #explain    
{
  font-size: 2em;
}

.mainBtn:hover
{
 background-color:#e27a32;
 color:#fff;
 border-color:#fa4d01;
}

.mainBtn
{
font-family: 'Playfair Display', serif;
font-size:16px;
border-radius:13px;
background-color:#e27a32;

border-color:#e27a32;
height:50px;
min-width:200px;
}

</style>
 

 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

 <!-- nav 헤더-->
    <nav class="navbar navbar-default transparent navbar-fixed-top" >
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
                        <a href="trade.io">거래하기</a>
                    </li>
                    <!--세션이 없는경우 -->
                    <c:if test="${sessionScope.login==null}"> 
                    <li>
                        <a href="login.go">로그인</a>
                    </li>
                    <li>
                        <a href="login.go?type=join">회원가입</a>
                    </li>
                    </c:if>
                    <!--세션이 있는 경우 -->
                    <c:if test="${sessionScope.login!=null}"> 
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">${login.email}
                        <span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="/finalproject/mypage.go">비밀번호변경</a></li>
                            
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
                           
                        </ul>
                    </li>
                    <li>
                        <a href="/finalproject/rank.go">랭킹</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
<!--nav end -->


	<section class="section-slide">
		<div id="myslider" class="carousel slide" data-ride="carousel">
			<div class="carousel-inner">
				<div class="item active">
					<img src="img/2wallstreets.jpg" style="width:100%; height:974px;" alt="">
					<div class="carousel-caption">
						<h3>Welcome</h3>
						<p id="explain">Mock Coin is <br> Awesome Coin Trade Training Tool</p>
						<p id="btn1"><a class="btn btn-primary btn-lg mainBtn" href="#service">About Us</a></p>
					</div>
				</div>
				
				<div class="item">
					<img src="img/bitcon.png" style="width:100%; height:974px;" alt="">
					<div class="carousel-caption">
						<h3>Begining</h3>
						<p id="explain">" Only Jonbeo is Life Way " <br>- Warren Buffet -</p>
						<p id="btn1"><a class="btn btn-primary btn-lg mainBtn" href="trade.io">Let's Go</a></p>
					</div>
				</div>
			</div>

			<a class="left carousel-control" href="#myslider" role="button" data-slide="prev"> 
			<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#myslider" role="button" data-slide="next"> 
			<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
	</section>
	
<!-- service  -->	
<div id="service">
   <section id="services">
      <div class="container">
        <div class="row">
         <div class="col-lg-12 text-center" style="margin-top: 60px;">
            <h2 class="section-heading text-uppercase text-white">Our Service</h2>
         </div>
        </div>
      </div>
      <div class="container">
       <div class="row" style="margin-bottom: 30px; ">
        <div class="col-lg-4 col-md-6 text-center">
         <div class="service-box mt-5 mx-auto">
              <i class="fab fa-bitcoin text-primary fa-5x sr-icons" data-sr-id="2" style="; visibility: visible;  -webkit-transform: scale(1); opacity: 1;transform: scale(1); opacity: 1;-webkit-transition: -webkit-transform 0.6s cubic-bezier(0.6, 0.2, 0.1, 1) 0s, opacity 0.6s cubic-bezier(0.6, 0.2, 0.1, 1) 0s; transition: transform 0.6s cubic-bezier(0.6, 0.2, 0.1, 1) 0s, opacity 0.6s cubic-bezier(0.6, 0.2, 0.1, 1) 0s; color:#fff;"></i>
              <h3 class="mb-3" style="padding-top:10px;">모의투자 트레이닝</h3>
              <p class="text-muted mb-0">빗썸, 코인원, 코빗의 실제 데이터를 <br>기준으로 거래합니다.</p>
         </div>
        </div>
      
        <div class="col-lg-4 col-md-6 text-center">
         <div class="service-box mt-5 mx-auto">
              <i class="fa fal fa-balance-scale text-primary fa-5x sr-icons" data-sr-id="3" style="; visibility: visible;  -webkit-transform: scale(1); opacity: 1;transform: scale(1); opacity: 1;-webkit-transition: -webkit-transform 0.6s cubic-bezier(0.6, 0.2, 0.1, 1) 0s, opacity 0.6s cubic-bezier(0.6, 0.2, 0.1, 1) 0s; transition: transform 0.6s cubic-bezier(0.6, 0.2, 0.1, 1) 0s, opacity 0.6s cubic-bezier(0.6, 0.2, 0.1, 1) 0s; color:#fff;"></i>
              <h3 class="mb-3" style="padding-top:10px;">자산관리</h3>
              <p class="text-muted mb-0">각 거래소별, 코인별 모의투자 현황을 분석 할 수 있습니다.</p>
         </div>
        </div>
        
         <div class="col-lg-4 col-md-6 text-center">
         <div class="service-box mt-5 mx-auto">
              <i class="fa fa-chart-line text-primary fa-5x sr-icons" data-sr-id="4" style="; visibility: visible;  -webkit-transform: scale(1); opacity: 1;transform: scale(1); opacity: 1;-webkit-transition: -webkit-transform 0.6s cubic-bezier(0.6, 0.2, 0.1, 1) 0s, opacity 0.6s cubic-bezier(0.6, 0.2, 0.1, 1) 0s; transition: transform 0.6s cubic-bezier(0.6, 0.2, 0.1, 1) 0s, opacity 0.6s cubic-bezier(0.6, 0.2, 0.1, 1) 0s; color:#fff; "></i>
              <h3 class="mb-3" style="padding-top:10px;">실시간 시세확인</h3>
              <p class="text-muted mb-0">빗썸, 코인원, 코빗 거래소의 실시간 정보를 한곳에서 확인 할 수 있습니다</p>
         </div>
        </div>
       </div>
      </div>
    </section>

	


	<!-- About Section -->
    <section class="section-about text-center" id="about">
      <div class="container">
        <div class="row">
				<div class="col-xl-8 mx-auto">
					<h2 class="text-uppercase text-white">About US</h2>
					<hr class="star-light mb-5"> <!--별모양 아이콘 추가 안됨 -->
					<p>코인시장의 가치 유동성이 너무나도 빠르게 변하고 있으며,<br>점점 예측이 불가해지는 방향으로 가고 있는
						느낌입니다.</p>
					<p>
						무크코인은 순수히 트레이닝을 위하여 개발 되었습니다.<br> 무크코인이 실제 트레이닝에 얼마나 많은
						효과가 있을지는<br> 무크코인을 사용하시는 유저분들의 손에 달려있습니다.</p>
					<p> 무크코인에서 실제 트레이닝이란 생각으로 분석하고,
						계획적으로 사용하시어<br> 실제 트레이드에서 의미있는 결과를 만들어 내시길 바랍니다.
					</p>
					<!-- social icon -->
					<ul id="social-ul">
					<li id="social-li"><a href="https://ko-kr.facebook.com/">
					<i class="fab fa-facebook-f" aria-hidden="ture"></i></a></li>
					<li id="social-li"><a href="https://twitter.com/?lang=ko"><i class="fab fa-twitter" aria-hidden="ture"></i></a></li>
					<li id="social-li"><a href="https://www.google.com/"><i class="fab fa-google" aria-hidden="ture"></i></a></li>
					<li id="social-li"><a href="https://www.instagram.com/?hl=ko"><i class="fab fa-instagram" aria-hidden="ture"></i></a></li>
				    </ul>
							
				</div>
			</div>
		  </div>
		</div> 
    </section>
 </div>   
   
 
<!-- footer -->
<%@ include file="../footer.jsp" %>
<!--footer end  -->

</body>
</html>