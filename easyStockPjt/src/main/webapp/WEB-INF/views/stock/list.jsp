<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<h3 class="float-left">종목리스트</h3>
<div class="form-group float-right">
	<form action="/stock/list" class="form-inline">
		<select class="form-control" name="range">
			<option value="tcw"
				<c:out value="${pghdl.pgvo.range eq 'tcw' ? 'selected' : '' }"/>>
				전체</option>
			<option value="t"
				<c:out value="${pghdl.pgvo.range eq 't' ? 'selected' : '' }"/>>
				Symbol</option>
			<option value="c"
				<c:out value="${pghdl.pgvo.range eq 'c' ? 'selected' : '' }"/>>
				Name</option>
			<option value="w"
				<c:out value="${pghdl.pgvo.range eq 'w' ? 'selected' : '' }"/>>
				Sector</option>
		</select> 
		<input class="form-control" type="text" name="keyword" value='<c:out value="${pghdl.pgvo.keyword }"/>'>
		<button type="submit" class="btn btn-info">조회</button>
	</form>
</div>
<div style="overflow-x:auto; clear:both;">
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
				<td><a class="text-primary" href="/stock/detail?symbol=${svo.symbol}">${svo.fullName}</a></td>
				<td>${svo.sector }</td>
				<td>${svo.per }&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td>${svo.eps }</td>
				<td class="text-right">$<fmt:formatNumber value="${svo.m_capitalization}" pattern="#,###"/>&nbsp;&nbsp;&nbsp;</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</div>

<jsp:include page="../common/footer.jsp" />