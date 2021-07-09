<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<table class="table table-hover">
	<thead>
		<tr>
			<th>Symbol</th>
			<th>Name</th>
			<th>Sector</th>
			<th>PER&nbsp;&nbsp;&nbsp;&nbsp;</th>
			<th>EPS</th>
			<th class="text-right">Market_Capitalization</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${s_list}" var="svo">
			<tr>
				<td>${svo.symbol }</td>
				<td><a href="/stock/detail?symbol=${svo.symbol}">${svo.fullName}</a></td>
				<td>${svo.sector }</td>
				<td>${svo.per }&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>${svo.eps }</td>
				<td class="text-right">$<fmt:formatNumber value="${svo.m_capitalization}" pattern="#,###"/>&nbsp;&nbsp;&nbsp;</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<jsp:include page="../common/footer.jsp" />