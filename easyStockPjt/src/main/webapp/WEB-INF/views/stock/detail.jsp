<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<h3 style="float: left">${svo.fullName}</h3>
<h5 style="float: right;">Avg-Target : ${svo.avg_target} USD</h5>

<div id="canvasDiv">
	<canvas id="myChartOne" style="background-color: white;"></canvas>
</div>
<div class="text-center mt-2">
	<button type="button" class="btn btn-light btn-md" id="daily">Daily</button>
	<button type="button" class="btn btn-light btn-md" id="monthly">Monthly</button>
</div>
<div class="text-right">
	<a data-toggle="modal" data-target="#earningModal" id="earning" href="#" style="font-weight: bold;">최근실적조회</a> | 
	<a href="/stock/list?pageIndex=${pgvo.pageIndex}&countPerPage=${pgvo.countPerPage}&range=${pgvo.range}&keyword=${pgvo.keyword}" style="font-weight: bold;">종목 리스트</a>
</div>

<div>
	<table class="table table-hover mt-3">
		<tbody>
			<tr>
				<td>Symbol</td>
				<td id="symbol" class="bold">${svo.symbol}</td>
				<td>Name</td>
				<td class="bold">${svo.fullName}</td>
			</tr>
			<tr>
				<td>Sector</td>
				<td class="bold">${svo.sector}</td>
				<td>Market Capitalization</td>
				<td class="bold"><fmt:formatNumber
						value="${svo.m_capitalization}" pattern="#,###" />&nbsp;USD</td>
			</tr>
			<tr>
				<td>PER</td>
				<td class="bold">${svo.per }</td>
				<td>EPS</td>
				<td class="bold">${svo.eps}</td>
			</tr>

			<tr>
				<td>Insiders holding</td>
				<td class="bold">${svo.pxt_insiders}</td>
				<td>Institutions holding</td>
				<td class="bold">${svo.pxt_institutions}</td>
			</tr>
			<tr>
				<td>52w_high</td>
				<td class="bold">${svo.year_high}</td>
				<td>52w_low</td>
				<td class="bold">${svo.year_low}</td>
			</tr>
		</tbody>
	</table>
</div>

<!-- 댓글  작성 -->
<h2 class="float-left">Conversations</h2>
<div class="form-group">
	<form>
		<div class="input-group mb-3">
			<input type="text" class="form-control" id="comment"
				placeholder="${svo.fullName}에 대한 의견을 적어주세요.">
			<div class="input-group-append">
				<button class="btn btn-info" id="posting" style="width: 150px;"
					type="button">POST</button>
			</div>
		</div>
	</form>
</div>

<div id="cmtBox" onload="commentList(${svo.symbol});"></div>

<!-- 실적 modal -->
<div class="modal fade" id="earningModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true"
	data-backdrop="static" style="z-index: -1;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">${svo.fullName}</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">

				<table class="table table-hover">
					<thead>
						<tr>
							<th>reportedDate</th>
							<th>reportedEPS</th>
							<th>estimatedEPS</th>
						</tr>
					</thead>
					<tbody id="earningBox">
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<script src="/resources/bootstrap/js/bundle.js"></script>
<script src="/resources/bootstrap/js/detail.js"></script>
<jsp:include page="../common/footer.jsp" />