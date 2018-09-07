<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${contextPath}/resources/js/js.cookie.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/main.css?ver=1">

<script type="text/javascript">
$(function() {
    $('#login-form-link').click(function(e) {
		$("#login-form").delay(100).fadeIn(100);
 		$("#register-form").fadeOut(100);
		$('#register-form-link').removeClass('active');
		$(this).addClass('active');
		e.preventDefault();
	});
	$('#register-form-link').click(function(e) {
		$("#register-form").delay(100).fadeIn(100);
 		$("#login-form").fadeOut(100);
		$('#login-form-link').removeClass('active');
		$(this).addClass('active');
		e.preventDefault();
	});
});


function validEmail(email)
{
	var filter=/^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	if(filter.test(email))
		{
		  return true;
		}
	else
		{
		 return false;
		}
}


function fValidCheck() {
	var filter=/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	var email=$("#email").val();
	
	if($.trim(email).length==0)
		{
		  alert("Email을 입력해주세요");
		  return false;
		}
	if(!filter.test(email))
	{
	  alert("올바른 이메일을 입력해주세요.");
	  return false;
	}
	
	/* if($("#password").val().length <= 0) {
		alert("비밀번호를 입력해 주세요.");
		return false;
	}
	if($("#confirm-password").val().length <= 0) {
		alert("동일한 비밀번호를 입력해 주세요.");
		return false;
	} */
	if($("#password1").val() != $("#confirm-password").val()) {
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	}
	return true;
}



</script>
</head>
<body>

<style type="text/css">

/* #loginwrap{
 
margin-top: 50px;
    overflow: hidden;
} */
.panel-login {
	border-color: #ccc;
	-webkit-box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
	-moz-box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
	box-shadow: 0px 2px 3px 0px rgba(0,0,0,0.2);
}
.panel-login>.panel-heading {
	color: #00415d;
	background-color: #fff;
	border-color: #fff;
	text-align:center;
}
.panel-login>.panel-heading a{
	text-decoration: none;
	color: #666;
	font-weight: bold;
	font-size: 15px;
	-webkit-transition: all 0.1s linear;
	-moz-transition: all 0.1s linear;
	transition: all 0.1s linear;
}
.panel-login>.panel-heading a.active{
	color: #029f5b;
	font-size: 18px;
}
.panel-login>.panel-heading hr{
	margin-top: 10px;
	margin-bottom: 0px;
	clear: both;
	border: 0;
	height: 1px;
	background-image: -webkit-linear-gradient(left,rgba(0, 0, 0, 0),rgba(0, 0, 0, 0.15),rgba(0, 0, 0, 0));
	background-image: -moz-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
	background-image: -ms-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
	background-image: -o-linear-gradient(left,rgba(0,0,0,0),rgba(0,0,0,0.15),rgba(0,0,0,0));
}
.panel-login input[type="text"],.panel-login input[type="email"],.panel-login input[type="password"] {
	height: 45px;
	border: 1px solid #ddd;
	font-size: 16px;
	-webkit-transition: all 0.1s linear;
	-moz-transition: all 0.1s linear;
	transition: all 0.1s linear;
}
.panel-login input:hover,
.panel-login input:focus {
	outline:none;
	-webkit-box-shadow: none;
	-moz-box-shadow: none;
	box-shadow: none;
	border-color: #ccc;
}
.btn-login {
	background-color: #59B2E0;
	outline: none;
	color: #fff;
	font-size: 14px;
	height: auto;
	font-weight: normal;
	padding: 14px 0;
	text-transform: uppercase;
	border-color: #59B2E6;
}
.btn-login:hover,
.btn-login:focus {
	color: #fff;
	background-color: #53A3CD;
	border-color: #53A3CD;
}
.forgot-password {
	text-decoration: underline;
	color: #888;
}
.forgot-password:hover,
.forgot-password:focus {
	text-decoration: underline;
	color: #666;
}

.btn-register {
	background-color: #1CB94E;
	outline: none;
	color: #fff;
	font-size: 14px;
	height: auto;
	font-weight: normal;
	padding: 14px 0;
	text-transform: uppercase;
	border-color: #1CB94A;
}
.btn-register:hover,
.btn-register:focus {
	color: #fff;
	background-color: #1CA347;
	border-color: #1CA347;
}
</style>

 <%@ include file="header.jsp" %>
    
<div class="login_wrapper">   
 <section id="loginwrap" class="login_section">
   <div class="container"> <!-- style="margin:0,auto; margin-bottom:20px;" -->
    	<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="panel panel-login">
					<div class="panel-heading">
						<div class="row">
						<c:choose>
						<c:when test="${type=='join'}">
							<div class="col-xs-6">
								<a href="#" id="login-form-link">${contextPath}로그인</a>
							</div>
							<div class="col-xs-6">
								<a href="#" class="active" id="register-form-link">회원가입</a>
							</div>
						    </c:when>	
							<c:otherwise>
							<div class="col-xs-6">
								<a href="#" class="active" id="login-form-link">로그인</a>
							</div>
							<div class="col-xs-6">
								<a href="#" id="register-form-link">회원가입</a>
							</div>
							</c:otherwise>
					    </c:choose>
						</div>
						<hr>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-lg-12">
							<c:choose>
							<c:when test="${type=='join'}">
							<form id="login-form" action="login.go" method="post" role="form" style="display: none;">
									<div class="form-group">
										<input type="text" name="userid" id="userid" tabindex="1" class="form-control" placeholder="아이디" value="">
									</div>
									<div class="form-group">
										<input type="password" name="password" id="password" tabindex="2" class="form-control" placeholder="비밀번호">
									</div>
									<div class="form-group text-center">
										<input type="checkbox" tabindex="3" class="" name="remember" id="remember">
										<label for="remember"> 아이디 기억하기</label>
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login" value="로그인">
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-lg-12">
												<div class="text-center">
													<a href="https://phpoll.com/recover" tabindex="5" class="forgot-password"></a>
												</div>
											</div>
										</div>
									</div>
								</form>
								<form id="register-form" action="register.go" method="post" role="form" style="display: block;" onSubmit="return fValidCheck()">
									<div class="form-group">
									    <!-- <label for="email" class="label">이메일</label> -->
										<input type="text" name="email" id="email" tabindex="1" class="form-control" placeholder="이메일 주소" >
									</div>
									<div class="form-group">
										<input type="text" name="userid" id="userid" tabindex="1" class="form-control" placeholder="아이디" >
									</div>
									<div class="form-group">
										<input type="password" name="password" id="password1" tabindex="2" class="form-control" placeholder="비밀번호">
									</div>
									<div class="form-group">
										<input type="password" name="confirm-password" id="confirm-password" tabindex="2" class="form-control" placeholder="비밀번호 확인">
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="submit" name="register-submit" id="register-submit" tabindex="4" class="form-control btn btn-register" value="회원가입하기">
											</div>
										</div>
									</div>
								</form>
								
								</c:when>
								<c:otherwise>
								<form id="login-form" action="login.go" method="post" role="form" style="display: block;">
									<div class="form-group">
										<input type="text" name="userid" id="userid" tabindex="1" class="form-control" placeholder="아이디">
									</div>
									<div class="form-group">
										<input type="password" name="password" id="password" tabindex="2" class="form-control" placeholder="비밀번호">
									</div>
									<div class="form-group text-center">
										<input type="checkbox" tabindex="3" class="" name="remember" id="remember">
										<label for="remember"> 아이디 기억하기</label>
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login" value="로그인">
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-lg-12">
												<div class="text-center">
													<a href="https://phpoll.com/recover" tabindex="5" class="forgot-password">비밀번호를 잊으셨나요?</a>
												</div>
											</div>
										</div>
									</div>
								</form>
								<form id="register-form" action="register.go" method="post" role="form" style="display: none;" onSubmit="return fValidCheck()">
									<div class="form-group">
									   <!--  <label for="email" class="label">이메일</label> -->
										<input type="text" name="email" id="email" tabindex="1" class="form-control" placeholder="이메일 주소" >
									</div>
									<div class="form-group">
										<input type="text" name="userid" id="userid" tabindex="1" class="form-control" placeholder="아이디" >
									</div>
									<div class="form-group">
										<input type="password" name="password" id="password1" tabindex="2" class="form-control" placeholder="비밀번호">
									</div>
									<div class="form-group">
										<input type="password" name="confirm-password" id="confirm-password" tabindex="2" class="form-control" placeholder="비밀번호 확인">
									</div>
									<div class="form-group">
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<input type="submit" name="register-submit" id="register-submit" tabindex="4" class="form-control btn btn-register" value="회원가입하기">
											</div>
										</div>
									</div>
								</form>
								
								</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</section>
</div>    

<%@ include file="footer.jsp" %>

  
</body>
</html>

