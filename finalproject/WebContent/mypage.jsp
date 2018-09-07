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
					<h2 class="title_text">My Page</h2>
				</div>
			</div>
		</div>
	</section>
<section class="mypage_wrapper">
<div class="container">
 <div class="row">
  <div class="col-lg-12">
   <div class="pw_change_box">
    <form action="mypage.go" method="POST" onSubmit="return fValidCheck()">
    <input type="hidden" id="email" name="email" value="${login.email}">
    <input type="hidden" id="userid" name="userid" value="${userid}">
    <table class="table">
     <tbody>
      <tr>
      <th>이메일</th>
      <td>${login.email}</td>
      </tr>
       <tr>
      <th>현재 비밀번호</th>
      <td><input type="password" id="pwd" name="pwd" placeholder="" required></td>
      </tr>
       <tr>
      <th>새 비밀번호</th>
      <td><input type="password" id="new_pwd" name="new_pwd" placeholder="" required></td>
      </tr>
       <tr style="border-bottom: 1px solid #ddd;">
      <th>새 비밀번호 확인</th>
      <td><input type="password" id="new_pwd2" name="new_pwd2" placeholder="" required></td>
      </tr>     
     
     </tbody>
    </table>
    <div class="mypage_btn" style="padding: 0 40%">
      <button type="submit" class="btn btn-primary pw_change_btn">변경하기</button>
     
    </div>
    </form>
   </div>
  </div>
 </div>
</div>
</section>

<!-- footer -->
<%@ include file="footer.jsp" %>
<!--footer end  -->

</body>
</html>

<SCRIPT type="text/javascript">
function fValidCheck() {
	if($("#pwd").val().length <= 0) {
		alert("현재 비밀번호를 입력해 주세요.");
		return false;
	}
	if($("#new_pwd").val().length < 6) {
		alert("새 비밀번호는 6자리 이상으로 입력해 주세요.");
		return false;
	}
	if($("#new_pwd").val() != $("#new_pwd2").val()) {
		alert("새 비밀번호가 일치하지 않습니다.");
		return false;
	}
	return true;
}
</SCRIPT>