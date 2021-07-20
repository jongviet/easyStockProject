<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<a class="navbar-brand" id="reload" href="/member/main/?email=${ses}">Main</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#collapsibleNavbar">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="collapsibleNavbar">
		<ul class="navbar-nav">
			<li class="nav-item"><a class="nav-link" href="">${ses_id}님 환영합니다.</a></li>
			<li class="nav-item"><a class="nav-link" href="/member/main/?email=${ses}">내 포트폴리오</a></li>
			<li class="nav-item"><a class="nav-link" href="/stock/list">종목리스트</a></li>
			<li class="nav-item"><a class="nav-link" href="/member/admin">관리자모드(종목등록, 댓글처리)</a></li>
			<li class="nav-item"><a class="nav-link" href="/test">테스트</a></li>
			<li class="nav-item"><a class="nav-link" id="logout" href="/member/logout">로그아웃</a></li>
		</ul>
	</div>
</nav>

<script>
$("#logout").on("click", function(e) {
	e.preventDefault();
	
	$(function() {
		setCookie('Ck_01', '', -1);
		$('#logout').unbind();
		var logout_t = document.getElementById("logout");
		logout_t.click();
	});

});
</script>

<div class="container" style="margin-top: 30px">