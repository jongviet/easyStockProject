<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="/resources/bootstrap/js/nav.js"></script>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark"
	style="background-color: #1F9688 !important; background-image: url(/resources/assets/img/bg.jpg); background-size: cover;">
	<a class="navbar-brand" style="font-weight: bolder; font-size: 40px;"><i class='fab fa-grav mr-2' style='font-size:36px'></i>EasyStock</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#collapsibleNavbar">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="collapsibleNavbar">
		<ul class="navbar-nav"
			style="color: white !important; font-weight: bolder; font-size: 1.1em !important; z-index: 2000 !important;">
			<li class="nav-item"><a class="nav-link" id="reload" href="/member/main/?email=${ses}">내 포트폴리오</a></li>
			<li class="nav-item"><a class="nav-link" href="/stock/list">종목/지수/환율/섹터</a></li>
			<li class="nav-item"><a class="nav-link" href="/stock/detail/?email=${ses}&symbol=AAPL">개별종목상세</a></li>
			<c:if test="${ses eq 'jongki6161@naver.com' }">
				<li class="nav-item"><a class="nav-link" id="admin" href="/member/admin">관리자모드</a></li>
			</c:if>
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