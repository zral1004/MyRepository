<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/main.css?ver=1">
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="header.jsp" %>
<section id="free_board_title">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<h2 class="title_text">RANKING</h2>
				</div>
			</div>
		</div>
	</section>

<section id="rank-board_wrap" style="margin-bottom:50px; margin-top:50px;">	
<div class="container">
 <div class="row">
  <div class="col-lg-12 free_board">
  
   <div class="rank_one">
    <div>
     <img src="img/rank1.png" alt="" class="rank_1">
    </div>
    <div class="rank_class">
     <p class="rank_1_title">Rank_No.1</p>
     </div>
     <p class="rank_1_id">${userid0}&nbsp</p>
     <p class="rank_1_id">총 자산:&nbsp
       <span class="rank_per">${asset0}</span>원
     </p>
   </div>
   
   <div class="col-md-6 rank_two">
    <div>
    <img src="img/rank2.png" alt="" class="rank_1">
    </div>
     <div class="rank_class">
     <p class="rank_1_title">Rank_No.2</p>
     </div>
     <p class="rank_1_id">${userid1}</p>
      <p class="rank_1_id">총 자산:&nbsp
       <span class="rank_per">${asset1}</span>원
     </p>
   </div>
   
   <div class="col-md-6 rank_three">
    <div>
    <img src="img/rank3.png" alt="" class="rank_1">
    </div>
     <div class="rank_class">
     <p class="rank_1_title">Rank_No.3</p>
     </div>
     <p class="rank_1_id">${userid2}</p>
      <p class="rank_1_id">총 자산:&nbsp
       <span class="rank_per">${asset2}</span>원
     </p>
   </div>
   
   <div class="rank_view_row">
   <span class="badge">4</span>
   <p class="rank_view_row_id">${userid3}</p>  <!-- 아이디 -->
   <p class="rank_view_row_date">
       총 자산:&nbsp
    <span class="row_rank_per">${asset3}</span>원
   </p>
   </div>
   
   <div class="rank_view_row">
   <span class="badge">5</span>
   <p class="rank_view_row_id">${userid4}</p>  <!-- 아이디 -->
   <p class="rank_view_row_date">
       총 자산:&nbsp
    <span class="row_rank_per">${asset4}</span>원
   </p>
   </div>
 
   <div class="rank_view_row">
   <span class="badge">6</span>
   <p class="rank_view_row_id">${userid5}</p>  <!-- 아이디 -->
   <p class="rank_view_row_date">
       총 자산:&nbsp
    <span class="row_rank_per">${asset5}</span>원
   </p>
   </div>
   <div class="rank_view_row">
   <span class="badge">7</span>
   <p class="rank_view_row_id">${userid6}</p>  <!-- 아이디 -->
   <p class="rank_view_row_date">
       총 자산:&nbsp
    <span class="row_rank_per">${asset6}</span>원
   </p>
   </div>
   <div class="rank_view_row">
   <span class="badge">8</span>
   <p class="rank_view_row_id">${userid7}</p>  <!-- 아이디 -->
   <p class="rank_view_row_date">
       총 자산:&nbsp
    <span class="row_rank_per">${asset7}</span>원
   </p>
   </div>
   <div class="rank_view_row">
   <span class="badge">9</span>
   <p class="rank_view_row_id">${userid8}</p>  <!-- 아이디 -->
   <p class="rank_view_row_date">
       총 자산:&nbsp
    <span class="row_rank_per">${asset8}</span>원
   </p>
   </div>
   <div class="rank_view_row">
   <span class="badge">10</span>
   <p class="rank_view_row_id">${userid9}</p>  <!-- 아이디 -->
   <p class="rank_view_row_date">
       총 자산:&nbsp
    <span class="row_rank_per">${asset9}</span>원
   </p>
   </div>
    
  </div>
 </div>
</div>
</section>
 
<%@ include file="footer.jsp" %>
</body>
</html>