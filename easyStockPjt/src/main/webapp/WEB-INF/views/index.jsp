<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/bootstrap/css/custom.css">
<link rel="icon" type="image/x-icon" href="/resources/assets/img/favicon.ico" />
<script src="https://kit.fontawesome.com/10e6240b9d.js"></script>

<style>
body { overflow: auto; } 
body::before { position: fixed; top: 0; left: 0; right: 0; bottom: 0; background-image: url(/resources/assets/img/bg.jpg); background-size: cover; -webkit-filter: blur(5px); -moz-filter: blur(5px); -o-filter: blur(5px); -ms-filter: blur(5px); filter: blur(5px); transform: scale(1.02); z-index: -1; content: ""; }
</style>

<body>
<c:if test="${ses ne null }">
	<script>
		location.href = "/member/main";
	</script>
</c:if>
<div class="container" id="memberForm">
	<h3 class="text-center" style="color: #f5f5f5; font-weight: bolder;"><i class='fab fa-grav mr-2' style='font-size:40px'></i>EasyStock</h3>
	<form action="/member/login" method="POST" id="form">
		<div class="form-group">
			<input class="form-control chk" type="email" name="email" id="email"
				placeholder="Email">
		</div>
		<div class="form-group">
			<input class="form-control chk" type="password" name="pwd"
				placeholder="Password">
		</div>
		<div class="form-group">
			<input class="form-control chk" type="hidden" name="pwdCfm"
				placeholder="Confirm Password">
		</div>
		<button class="btn btn-md mb-1" id="loginBtn" type="submit" style="background-color:#06486c80; color:f5f5f5;">Login</button>
		<div class="form-group text-center">
			<a href="#" id="join" style="color: #f5f5f5">회원가입</a> <a
				style="color: white">|</a> <a href="#" id="lookArd"
				style="color: #f5f5f5">비회원접속</a>
		</div>
	</form>
</div>
</body>
<script src="/resources/bootstrap/js/jquery-3.6.0.min.js"></script>
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<script src="/resources/bootstrap/js/autoUpdate.js"></script>
<script src="/resources/bootstrap/js/member.js"></script>

