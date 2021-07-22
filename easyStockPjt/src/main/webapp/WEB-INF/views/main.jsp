<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:include page="common/header.jsp" />
<jsp:include page="common/nav.jsp" />
<script src="/resources/bootstrap/js/Chart.min.js"></script>
<script src="/resources/bootstrap/js/main.js"></script>

<c:choose>
<c:when test="${ses ne null}">
<div class="container">
	<div class="row">
		<div class="col-lg-6 col-md-6 mx-auto float-left text-center">
			<h3 class="mb-4 text-center greenFontBold">${ses_id}<span
					class="grayFontBold mr-2">님의 자산현황</span><a href="/member/main/?email=${ses}"><i class="fa fa-refresh" style='font-size: 22px; color: #1F9688;'></i></a>
			</h3>
			<h5 class="text-center greenFontBold mb-3">
				<span>총자산&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span id="asset"></span>
				<span>&nbsp;USD</span>
			</h5>
			<table class="mb-5" style="width: 525px; height: 200px;">
				<tbody>
					<tr class="greenLineBold">
						<td colspan="2" class="grayFontBold titleBackground">예수금</td>
						<td colspan="2" class="grayFontBold" id="deposit"><fmt:formatNumber value="${deposit}" pattern="#,###.00"/>
						<span>&nbsp;USD</span></td>
					</tr>
					<tr class="grayLine">
						<td colspan="2" class="grayFontBold titleBackground">주식</td>
						<td colspan="2" class="grayFontBold"><span id="stock"></span><span>&nbsp;USD</span></td>
					</tr>
					<tr class="grayLine">
						<td colspan="2" class="grayFontBold titleBackground">손익</td>
						<td colspan="2" class="grayFontBold"><span id="profit"></span><span>&nbsp;USD</span></td>
					</tr>
					<tr class="grayLine">
						<td colspan="2" class="grayFontBold titleBackground">수익률</td>
						<td colspan="2" class="grayFontBold"><span id="percentage"></span><span>&nbsp;%</span></td>
					</tr>
				</tbody>
			</table>
			<div class="mt-7" id="canvasDivTwo">
				<canvas id="myChartTwo" style="background-color: #f5f5f5;" width="525"
					height="460"></canvas>
			</div>
			<div class="text-center mt-2">
				<button type="button" class="btn btn-light btn-md grayFontBold titleBackground" id="show">Show</button>
				<button type="button" class="btn btn-light btn-md grayFontBold titleBackground" id="hide">Hide</button>
			</div>
		</div>
		<div class="col-lg-6 col-md-6 ml-10 pl-10"
			style="float: right; text-align: center;">
			<h3 class="mb-4 text-center greenFontBold">내 보유종목</h3>
			<table class="table table-hover">
				<thead class="titleBackground">
					<tr class="greenLineBold">
						<th class="grayFontBold">종목코드</th>
						<th class="grayFontBold">현재가</th>
						<th class="grayFontBold">매입가</th>
						<th class="grayFontBold">보유량</th>
						<th class="grayFontBold">평가금액</th>
						<th class="grayFontBold">수익률</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${h_list}" var="avo">
						<tr>
							<td class="grayFont">${avo.symbol }</td>
							<td class="grayFont">${avo.cur_price }</td>
							<td class="grayFont">${avo.avg_h_price }</td>
							<td class="grayFont">${avo.h_qty }</td>
							<td class="grayFont"><fmt:formatNumber value="${avo.cur_price * avo.h_qty }" pattern="#,###.00" />&nbsp;USD</td>
							<td class="${ ((1- (avo.h_qty * avo.avg_h_price) / (avo.h_qty * avo.cur_price))) < 0 ? 'minus' : 'plus'} 
										${ ((1- (avo.h_qty * avo.avg_h_price) / (avo.h_qty * avo.cur_price))) == 0 ? 'none' : ''}">
								<fmt:formatNumber value="${(1- (avo.h_qty * avo.avg_h_price) / (avo.h_qty * avo.cur_price)) }" pattern="#,##0.00%" />
							</td>
						</tr>
					</c:forEach>
				</tbody>
				<c:if test="${h_list[0] eq null }">
				<tfoot>
					<tr>
						<td colspan="6" class="grayLight">상세 정보를 확인해보세요&nbsp;&nbsp;<a href="/stock/detail?symbol=AAPL&email=${ses}"><i class="fas fa-cart-plus" style='font-size: 24px; color: #1F9688;'></i></a></td>
					</tr>
				</tfoot>
				</c:if>
			</table>
			<h3 class="mb-4 mt-5 text-center greenFontBold">내 관심종목</h3>
			<table class="table table-hover">
				<thead class="titleBackground">
					<tr class="greenLineBold">
						<th class="grayFontBold">종목코드</th>
						<th class="grayFontBold">현재가</th>
						<th class="grayFontBold">목표가</th>
						<th class="grayFontBold">52주 최고가</th>
						<th class="grayFontBold">상세</th>
						<th class="grayFontBold">거래하기</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${w_list}" var="svo">
						<tr>  
							<td class="grayFont">${svo.symbol }</td>
							<td class="grayFont">${svo.cur_price }</td>
							<td class="grayFont">${svo.avg_target }</td>
							<td class="grayFont">${svo.year_high }</td>
							<td class="grayFont"><a href="/stock/detail?symbol=${svo.symbol}&email=${ses}"><i class="fas fa-info-circle"
									style='font-size: 24px; color: #1F9688;'></i></a></td>
							<c:choose>
							<c:when test="${ses ne null}">
							<td class="grayFont">
								<a data-symbol="${svo.symbol}" data-toggle="modal" data-target="#buyModal" id="buying" href="#"><i class="material-icons" style="font-size:24px;color:#FF8C69">shopping_cart</i></a>
								<a data-symbol="${svo.symbol}" data-toggle="modal" data-target="#sellModal" id="selling" href="#"><i class="material-icons" style="font-size:24px;color:#FF8C69">remove_shopping_cart</i></a>
							</td>
							</c:when>
							<c:otherwise>
							<td>
							세션미확인
							</td>
							</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</tbody>
				<c:if test="${w_list eq null}">
				<tfoot>
					<tr>
						<td colspan="6" class="grayLight">종목 리스트를 둘러보세요&nbsp;&nbsp;<a href="/stock/list/?email=${ses}"><i class="fas fa-cart-plus" style='font-size: 24px; color: #1F9688;'></i></a></td>
					</tr>                                                    
				</tfoot>
				</c:if>
			</table>
		</div>
	</div>
</div>

<div class="modal fade" id="buyModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true"
	data-backdrop="static" style="z-index: -1;">
	<div class="modal-dialog">
		<div class="modal-content" style="background-color:#FFEEE9">
			<div class="modal-header">
				<h5 class="modal-title grayFontBold" id="exampleModalLabel">매수주문<i class="material-icons ml-1" style="font-size:24px;color:#FF8C69">shopping_cart</i></h5>
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
						<button type="button" class="btn btnBackgroundTrade" id="symbolSearch">종목조회</button>
					</div>
				</div>
				<div class="input-group mt-1">
					<input class="form-control" type="text" name="tradeQty" id="tradeQty"
						placeholder="거래 수량을 입력해주세요">
					<div class="input-group-append">
						<button type="button" class="btn btnBackgroundTrade" id="amountSearch" disabled="disabled">대금조회</button>
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
				<button type="submit" class="btn btnBackgroundTrade" id="buy">매수하기</button>
				<button type="button" class="btn btnBackgroundTrade" id="cancel" data-dismiss="modal">거래취소</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="sellModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true"
	data-backdrop="static" style="z-index: -1;">
	<div class="modal-dialog">
		<div class="modal-content" style="background-color:#FFEEE9"> 
			<div class="modal-header">
				<h5 class="modal-title grayFontBold" id="exampleModalLabel">매도주문<i class="material-icons ml-1" style="font-size:24px;color:#FF8C69">remove_shopping_cart</i></h5>
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
						<button type="button" class="btn btnBackgroundTrade" id="symbolSearch_sell">종목조회</button>
					</div>
				</div>
				<div class="input-group mt-1">
					<input class="form-control" type="text" name="tradeQty_sell" id="tradeQty_sell"
						placeholder="거래 수량을 입력해주세요">
					<div class="input-group-append">
						<button type="button" class="btn btnBackgroundTrade" id="amountSearch_sell" disabled="disabled">대금조회</button>
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
				<button type="submit" class="btn btnBackgroundTrade" id="sell">매도하기</button>
				<button type="button" class="btn btnBackgroundTrade" id="cancel_sell" data-dismiss="modal">거래취소</button>
			</div>
		</div>
	</div>
</div>
</c:when>
<c:otherwise>
	<h1 class="text-center">비정상적인 접근이 감지되었습니다. 다시 로그인해주세요.</h1>
</c:otherwise>
</c:choose>
<script>
 	var symbol_arr = [];
	var h_price_arr = [];
	var h_qty_arr = [];
	var c_price_arr = [];
	
	var deposit = "${deposit}";
	var deposit_val = Number(deposit);

	<c:forEach items="${h_list}" var="avo">
	var symbol = "${avo.symbol}";
	var h_price = "${avo.avg_h_price}";
	var h_qty = "${avo.h_qty}";
	var c_price = "${avo.cur_price}";
	symbol_arr.push(symbol);
	h_price_arr.push(Number(h_price));
	h_qty_arr.push(Number(h_qty));
	c_price_arr.push(Number(c_price));
	</c:forEach>

	var asset = 0.0;
	var asset_input = 0.0;

	for (let i = 0; i < h_qty_arr.length; i++) {
		asset += c_price_arr[i] * h_qty_arr[i];
	}

	for (let i = 0; i < h_qty_arr.length; i++) {
		asset_input += h_price_arr[i] * h_qty_arr[i];
	}

	var asset_input_val = (deposit_val + asset_input).toFixed(2);
	
	var asset_val = (deposit_val + asset).toFixed(2);
	var asset_val_comma = asset_val.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");

	var stock_val = asset.toFixed(2);
	var stock_val_comma = stock_val.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");

	var earning = (asset_val - asset_input_val).toFixed(2);
	var earning_comma = earning.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	
	var earningPer = (((asset_val - asset_input_val) / asset_input_val) * 100).toFixed(2);
	var earningPer_comma = earningPer.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	
	$(function() {
		
		$("#percentage").text(earningPer_comma);
		$("#profit").text(earning_comma);
		$("#stock").text(stock_val_comma);
		$("#asset").text(asset_val_comma);

		var eachStockVal = [];

		for (let i = 0; i < c_price_arr.length; i++) {
			eachStockVal.push( (c_price_arr[i] * h_qty_arr[i]).toFixed(2));
		}
		
		symbol_arr.push('예수금');
		eachStockVal.push(deposit_val);

		current_asset_show(symbol_arr, eachStockVal);	
	});
	
	$(document).on("click", "#show", function() {
		
	 	var symbol_arr = [];
		var h_price_arr = [];
		var h_qty_arr = [];
		var c_price_arr = [];
		
		var deposit = "${deposit}";
		var deposit_val = Number(deposit);

		<c:forEach items="${h_list}" var="avo">
		var symbol = "${avo.symbol}";
		var h_price = "${avo.avg_h_price}";
		var h_qty = "${avo.h_qty}";
		var c_price = "${avo.cur_price}";
		symbol_arr.push(symbol);
		h_price_arr.push(Number(h_price));
		h_qty_arr.push(Number(h_qty));
		c_price_arr.push(Number(c_price));
		</c:forEach>

		var asset = 0.0;
		var asset_input = 0.0;

		for (let i = 0; i < h_qty_arr.length; i++) {
			asset += c_price_arr[i] * h_qty_arr[i];
		}

		for (let i = 0; i < h_qty_arr.length; i++) {
			asset_input += h_price_arr[i] * h_qty_arr[i];
		}

		var asset_input_val = (deposit_val + asset_input).toFixed(2);

		
		var asset_val = (deposit_val + asset).toFixed(2);
		var asset_val_comma = asset_val.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");

		var stock_val = asset.toFixed(2);
		var stock_val_comma = stock_val.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");

		var earning = (asset_val - asset_input_val).toFixed(2);
		var earning_comma = earning.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
		
		var earningPer = (((asset_val - asset_input_val) / asset_input_val) * 100).toFixed(2);
		var earningPer_comma = earningPer.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
		
		$(function() {
			
			$("#percentage").text(earningPer_comma);
			$("#profit").text(earning_comma);
			$("#stock").text(stock_val_comma);
			$("#asset").text(asset_val_comma);

			var eachStockVal = [];

			for (let i = 0; i < c_price_arr.length; i++) {
				eachStockVal.push( (c_price_arr[i] * h_qty_arr[i]).toFixed(2));
			}
			
			symbol_arr.push('예수금');
			eachStockVal.push(deposit_val);

			current_asset_show(symbol_arr, eachStockVal);	
		});
	});

	$(document).on("click", "#hide", function() {
		
	 	var symbol_arr = [];
		var h_price_arr = [];
		var h_qty_arr = [];
		var c_price_arr = [];
		
		var deposit = "${deposit}";
		var deposit_val = Number(deposit);

		<c:forEach items="${h_list}" var="avo">
		var symbol = "${avo.symbol}";
		var h_price = "${avo.avg_h_price}";
		var h_qty = "${avo.h_qty}";
		var c_price = "${avo.cur_price}";
		symbol_arr.push(symbol);
		h_price_arr.push(Number(h_price));
		h_qty_arr.push(Number(h_qty));
		c_price_arr.push(Number(c_price));
		</c:forEach>

		var asset = 0.0;
		var asset_input = 0.0;

		for (let i = 0; i < h_qty_arr.length; i++) {
			asset += c_price_arr[i] * h_qty_arr[i];
		}

		for (let i = 0; i < h_qty_arr.length; i++) {
			asset_input += h_price_arr[i] * h_qty_arr[i];
		}

		var asset_input_val = (deposit_val + asset_input).toFixed(2);

		var asset_val = (deposit_val + asset).toFixed(2);
		var asset_val_comma = asset_val.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");

		var stock_val = asset.toFixed(2);
		var stock_val_comma = stock_val.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");

		var earning = (asset_val - asset_input_val).toFixed(2);
		var earning_comma = earning.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
		
		var earningPer = (((asset_val - asset_input_val) / asset_input_val) * 100).toFixed(2);
		var earningPer_comma = earningPer.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
		
		$(function() {
			
			$("#percentage").text(earningPer_comma);
			$("#profit").text(earning_comma);
			$("#stock").text(stock_val_comma);
			$("#asset").text(asset_val_comma);

			var eachStockVal = [];

			for (let i = 0; i < c_price_arr.length; i++) {
				eachStockVal.push( (c_price_arr[i] * h_qty_arr[i]).toFixed(2));
			}
			
			symbol_arr.push('예수금');
			eachStockVal.push(deposit_val);

			current_asset_hide(symbol_arr, eachStockVal);
		});
	});
</script>


<script src="/resources/bootstrap/js/buyAndSell.js"></script>
<jsp:include page="common/footer.jsp" />