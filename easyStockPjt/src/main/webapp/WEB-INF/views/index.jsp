<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="common/header.jsp" />
<jsp:include page="common/nav.jsp" />

<ul>
	<li><a href="/stock/list">종목리스트 : 페이징, 종목디테일, 댓글토론</a></li>
	<li><a href="#">마이페이지 : 매수, 환전(모달?), 예수금 등</a></li>
	<li><a href="#">메인페이지 : 3대지수, 환율정보, CNBC 주요 뉴스 등</a></li>
	<li><a href="/admin">관리자페이지 : 종목 등록 처리</a></li>
</ul>



<jsp:include page="common/footer.jsp" />