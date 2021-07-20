<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
<!-- 디테일용 chartjs -->
<script type="module" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.4.1/chart.min.js"></script>

<h3 class="greenFontBold" style="float: left">${svo.fullName}
<c:choose>
	<c:when test="${hasWatch eq 1}">
		<a href='#'><i class='fa fa-star' id='remove_watch' style='font-size: 24px; color: #1F9688;'></i></a>
	</c:when>
	<c:otherwise>
		<a href='#'><i class='fa fa-star-o' id='add_watch' style='font-size: 24px; color: #1F9688;'></i></a>
	</c:otherwise>
</c:choose>
<a data-symbol="${svo.symbol}" data-toggle="modal" data-target="#buyModal" id="buying" href="#"><i class="material-icons" style="font-size:24px;color:#FF8C69">shopping_cart</i></a>
<a data-symbol="${svo.symbol}" data-toggle="modal" data-target="#sellModal" id="selling" href="#"><i class="material-icons" style="font-size:24px;color:#FF8C69">remove_shopping_cart</i></a>
</h3>
<h5 class="grayFontBold" style="float: right;">Avg-Target : ${svo.avg_target} USD</h5>

<div id="canvasDiv">
	<canvas id="myChartOne" style="background-color: white;"></canvas>
</div>
<div class="text-center mt-2">
	<button type="button" class="btn btn-light btn-md grayFontBold" id="daily">Daily</button>
	<button type="button" class="btn btn-light btn-md grayFontBold" id="monthly">Monthly</button>
</div>
<div class="text-right">
	<a data-toggle="modal" data-target="#earningModal" id="earning" href="#" class="greenFontBold">최근실적조회</a> | 
	<a href="/stock/list?pageIndex=${pgvo.pageIndex}&countPerPage=${pgvo.countPerPage}&range=${pgvo.range}&keyword=${pgvo.keyword}" class="greenFontBold">종목 리스트</a> 
</div>

<div>
	<table class="table table-hover mt-3">
		<tbody>
			<tr>
				<td>Symbol</td>
				<td id="symbol" class="grayFontBold">${svo.symbol}</td>
				<td>Name</td>
				<td class="grayFontBold">${svo.fullName}</td>
			</tr>
			<tr>
				<td>Sector</td>
				<td class="grayFontBold">${svo.sector}</td>
				<td>Market Capitalization</td>
				<td class="grayFontBold"><fmt:formatNumber
						value="${svo.m_capitalization}" pattern="#,###" />&nbsp;USD</td>
			</tr>
			<tr>
				<td>PER</td>
				<td class="grayFontBold">${svo.per }</td>
				<td>EPS</td>
				<td class="grayFontBold">${svo.eps}</td>
			</tr>

			<tr>
				<td>Insiders holding</td>
				<td class="grayFontBold">${svo.pxt_insiders}</td>
				<td>Institutions holding</td>
				<td class="grayFontBold">${svo.pxt_institutions}</td>
			</tr>
			<tr>
				<td>52w_high</td>
				<td class="grayFontBold">${svo.year_high}</td>
				<td>52w_low</td>
				<td class="grayFontBold">${svo.year_low}</td>
			</tr>
		</tbody>
	</table>
</div>

<!-- 댓글  작성 -->
<h2 class="float-left greenFontBold">Conversations</h2>
<div class="form-group">
	<form>
		<div class="input-group mb-3">
			<input type="text" class="form-control" id="comment"
				placeholder="${svo.fullName}에 대한 의견을 적어주세요.">
			<div class="input-group-append">
				<button class="btn" id="posting" style="width: 150px; background-color:#1F9688; color:white; font-weight:bold;"
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
				<h5 class="modal-title grayFontBold" id="exampleModalLabel">${svo.fullName}</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<table class="table table-hover">
					<thead>
						<tr>
							<th class="grayFontBold">reportedDate</th>
							<th class="grayFontBold">reportedEPS</th>
							<th class="grayFontBold">estimatedEPS</th>
						</tr>
					</thead>
					<tbody id="earningBox">
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn" style="background-color:#1F9688; color:white;" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>


<!-- 매수  modal -->
<div class="modal fade" id="buyModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true"
	data-backdrop="static" style="z-index: -1;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title grayFontBold" id="exampleModalLabel">매수주문</h5>
				<button type="button" class="close" data-dismiss="modal" id="cancel2"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="input-group">
					<input class="form-control" type="text" id="keyword_buy"
						placeholder="종목명을 입력해주세요">
					<div class="input-group-append">
						<button type="button" class="btn"
							style="background-color: #1F9688; color: white" id="symbolSearch">종목조회</button>
					</div>
				</div>
				<div class="input-group mt-1">
					<input class="form-control" type="text" name="tradeQty" id="tradeQty"
						placeholder="거래 수량을 입력해주세요">
					<div class="input-group-append">
						<button type="button" class="btn" id="amountSearch" disabled="disabled"
							style="background-color: #1F9688; color: white">대금조회</button>
					</div>
				</div>
				<table class="table table-borderless mt-3" style="table-layout:fixed;">
					<tbody>
						<tr>
							<td>종목명</td>
							<td id="symbol_buy" class="grayFontBold"></td>
							<td>보유량</td>
							<td id="h_qty" class="grayFontBold"></td>
						</tr>
						<tr>
							<td>매입가</td>
							<td id="avg_h_price" class="grayFontBold"></td>
							<td>평가금액</td>
							<td id="total" class="grayFontBold"></td>
						</tr>
						<tr>
							<td>현재가</td>
							<td id="cur_price" class="grayFontBold"></td>
							<td>매수총액</td>
							<td id="buyingAmount" class="grayFontBold"></td>
						</tr>
						<tr>
							<td>예수금</td>
							<td id="deposit_buy" class="grayFontBold"></td>
							<td>거래후 잔액</td>
							<td id="balance" class="grayFontBold"></td>
						</tr>
					</tbody>
				</table>
				<input type="hidden" id="deposit_store">
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn" id="buy" style="background-color: #1F9688; color: white;">매수하기</button>
				<button type="button" class="btn" id="cancel" style="background-color: #1F9688; color: white;" data-dismiss="modal">거래취소</button>
			</div>
		</div>
	</div>
</div>

<!-- 매도  modal -->
<div class="modal fade" id="sellModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true"
	data-backdrop="static" style="z-index: -1;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title grayFontBold" id="exampleModalLabel">매도주문</h5>
				<button type="button" class="close" data-dismiss="modal" id="cancel2_sell"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="input-group">
					<input class="form-control" type="text" id="keyword_sell"
						placeholder="종목명을 입력해주세요">
					<div class="input-group-append">
						<button type="button" class="btn"
							style="background-color: #1F9688; color: white" id="symbolSearch_sell">종목조회</button>
					</div>
				</div>
				<div class="input-group mt-1">
					<input class="form-control" type="text" name="tradeQty_sell" id="tradeQty_sell"
						placeholder="거래 수량을 입력해주세요">
					<div class="input-group-append">
						<button type="button" class="btn" id="amountSearch_sell" disabled="disabled"
							style="background-color: #1F9688; color: white">대금조회</button>
					</div>
				</div>
				<table class="table table-borderless mt-3" style="table-layout:fixed;">
					<tbody>
						<tr>
							<td>종목명</td>
							<td id="symbol_sell" class="grayFontBold"></td>
							<td>보유량</td>
							<td id="h_qty_sell" class="grayFontBold"></td>
						</tr>
						<tr>
							<td>매입가</td>
							<td id="avg_h_price_sell" class="grayFontBold"></td>
							<td>평가금액</td>
							<td id="total_sell" class="grayFontBold"></td>
						</tr>
						<tr>
							<td>현재가</td>
							<td id="cur_price_sell" class="grayFontBold"></td>
							<td>매도총액</td>
							<td id="sellingAmount" class="grayFontBold"></td>
						</tr>
						<tr>
							<td>예수금</td>
							<td id="deposit_sell" class="grayFontBold"></td>
							<td>거래후 잔액</td>
							<td id="balance_sell" class="grayFontBold"></td>
						</tr>
					</tbody>
				</table>
				<input type="hidden" id="deposit_store_sell">
			</div>
			<div class="modal-footer">
				<button type="submit" class="btn" id="sell" style="background-color: #1F9688; color: white;">매도하기</button>
				<button type="button" class="btn" id="cancel_sell" style="background-color: #1F9688; color: white;" data-dismiss="modal">거래취소</button>
			</div>
		</div>
	</div>
</div>

<script src="/resources/bootstrap/js/buyAndSell.js"></script>
<script src="/resources/bootstrap/js/detail.js"></script>
<jsp:include page="../common/footer.jsp" />