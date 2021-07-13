<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/bootstrap/css/custom.css">

<c:if test="${Ses_email ne null }">
	<script>
		location.href = "main.jsp";
	</script>
</c:if>
	<div class="container" id="memberForm">
		<h3 style="color:#f5f5f5; font-weight:bolder;">EasyStock</h3>
		<form method="post" id="form">
			<input type="hidden" name="nextSt" value="login">
			<div class="form-group">
				<input class="form-control chk" type="email" name="email" id="email" placeholder="Email">
			</div>
			<div class="form-group">
				<input class="form-control chk" type="password" name="pwd" placeholder="Password">
			</div>
			<div class="form-group">
				<input class="form-control chk" type="hidden" name="pwdCfm" placeholder="Password Confirm">
			</div>
			<button class="btn btn-md btn-dark" id="loginBtn" type="submit">Login</button>
			<div class="form-group text-center">
				<a href="#" id="join" style="color:#f5f5f5">Join</a>
				<a style="color:white">/</a>
				<a href="#" id="look" style="color:#f5f5f5">Look Around</a>
			</div>
		</form>
	</div>

<script src="/resources/bootstrap/js/jquery-3.6.0.min.js"></script>
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<script src="/resources/bootstrap/js/member.js"></script>

