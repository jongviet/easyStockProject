<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:include page="common/header.jsp" />
<jsp:include page="common/nav.jsp" />
<script src="/resources/bootstrap/js/Chart.min.js"></script>
<script src="/resources/bootstrap/js/main.js"></script>
<script>
	/* 종목 보유 내역 있을 시 가격 업데이트 */
/*  	<c:if test="${h_list ne null}"> */
 	var symbol_arr = [];
	var h_price_arr = [];
	var h_qty_arr = [];
	var c_price_arr = [];
	
	var deposit = "${deposit}";
	var deposit_val = Number(deposit);

	/* 해당 종목 가져오기 */
	<c:forEach items="${h_list}" var="avo">
	var symbol = "${avo.symbol}";
	var h_price = "${avo.avg_h_price}";
	var h_qty = "${avo.h_qty}";
	var c_price = "${avo.cur_price}";
	symbol_arr.unshift(symbol);
	h_price_arr.unshift(Number(h_price));
	h_qty_arr.unshift(Number(h_qty));
	c_price_arr.unshift(Number(c_price));
	</c:forEach>

	/* asset 처리 */
	var asset = 0.0;
	var asset_input = 0.0;

	for (let i = 0; i < h_qty_arr.length; i++) {
		asset += c_price_arr[i] * h_qty_arr[i];
	}

	for (let i = 0; i < h_qty_arr.length; i++) {
		asset_input += h_price_arr[i] * h_qty_arr[i];
	}

	/* 매매 기준 전체 총 평가액 */
	var asset_input_val = (deposit_val + asset_input).toFixed(2);

	/* 현재 기준 전체 총 평가액 */
	var asset_val = (deposit_val + asset).toFixed(2);

	/* 현재 기준 주식 총 평가액 */
	var stock_val = asset.toFixed(2);

	var earning = (asset_val - asset_input_val).toFixed(2);
	var earningPer = (((asset_val - asset_input_val) / asset_input_val) * 100)
			.toFixed(2);

	$(function() {
		$("#percentage").text(earningPer);
		$("#profit").text(earning);
		$("#stock").text(stock_val);
		$("#asset").text(asset_val);

		/* 예수금 포함 각 주식 별 금액 던지기 */
		var eachStockVal = [];

		for (let i = 0; i < c_price_arr.length; i++) {
			eachStockVal.unshift(c_price_arr[i] * h_qty_arr[i]);
		}

		/* 예수금 추가 */
		symbol_arr.unshift('예수금');
		eachStockVal.unshift(deposit_val);

		current_asset(symbol_arr, eachStockVal);
	});
/* 	</c:if> */

	function current_asset(symbol_arr, eachStockVal) {
		var ctx = document.getElementById('myChartTwo');
		var config = {
			type : 'doughnut',
			data : {
				labels : symbol_arr,
				datasets : [ {
					label : 'Stock',
					data : eachStockVal,
					backgroundColor : [ '#99E6B2', '#7AD2A8', '#5CBE9D',
							'#3DAA93', '#1F9688', '#00827E' ],
					borderWidth : 2
				} ],
			},
			animation : {
				animateScale : true,
				animateRotate : true
			},
			options : {
				responsive : false,
				scaleShowLabelBackdrop : true,
				showAllTooltips : true,
				tooltips : {
					callbacks : {
						label : function(tooltipItem, data) {
							var dataset = data.datasets[tooltipItem.datasetIndex];
							var meta = dataset._meta[Object.keys(dataset._meta)[0]];
							var total = meta.total;
							var currentValue = dataset.data[tooltipItem.index];
							var percentage = parseFloat((currentValue / total * 100)
									.toFixed(1));
							return currentValue + ' (' + percentage + '%)';
						},
						title : function(tooltipItem, data) {
							return data.labels[tooltipItem[0].index];
						}
					}
				},
				legend : {
					display : false,
					labels : {
						fontColor : 'rgb(255, 255, 255)',
						fontSize : 12
					}
				}
			}
		};
		var myDoughnutChart = new Chart(ctx, config);
	};

	if (ses_tester != null && ses_tester != "") {

		var checkEvent = getCookie("Ck_01");

		if (checkEvent == "on") {

		} else {
			var trigger = document.getElementById("reload");
			trigger.click();
			setCookie("Ck_01", "on", "0"); /* 맨마지막 0으로 설정해야지 브라우저 종료 시 쿠키 사라짐?! -> 확인해보기  */
		}
	};
</script>
<div class="container">
	<div class="row">
		<div class="col-lg-6 col-md-6 mx-auto float-left text-center">
			<h3 class="mb-4 text-center greenFontBold">${ses_id}<span
					class="grayFontBold">님의 자산현황</span>
			</h3>
			<h5 class="text-center greenFontBold mb-3">
				<span>총자산&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span id="asset"></span>
				<span>&nbsp;USD</span>
			</h5>
			<table class="mb-5" style="width: 525px; height: 200px;">
				<tbody>
					<tr class="greenLineBold">
						<td colspan="2" class="grayFontBold">예수금</td>
						<td colspan="2" class="grayFontBold" id="deposit">${deposit}<span>&nbsp;USD</span></td>
					</tr>
					<tr class="greenLine">
						<td colspan="2" class="grayFontBold">주식</td>
						<td colspan="2" class="grayFontBold"><span id="stock"></span><span>&nbsp;USD</span></td>
					</tr>
					<tr class="greenLine">
						<td colspan="2" class="grayFontBold">손익</td>
						<td colspan="2" class="grayFontBold"><span id="profit"></span><span>&nbsp;USD</span></td>
					</tr>
					<tr class="greenLine">
						<td colspan="2" class="grayFontBold">수익률</td>
						<td colspan="2" class="grayFontBold"><span id="percentage"></span><span>&nbsp;%</span></td>
					</tr>
				</tbody>
			</table>
			<div class="mt-7">
				<canvas id="myChartTwo" style="background-color: white;" width="525"
					height="460"></canvas>
			</div>
		</div>
		<!-- table -->
		<div class="col-lg-6 col-md-6 ml-10 pl-10"
			style="float: right; text-align: center;">
			<h3 class="mb-4 text-center grayFontBold">내 보유종목</h3>
			<table class="table table-hover">
				<thead>
					<tr class="greenLineBold">
						<th class="grayFontBold">종목명</th>
						<th class="grayFontBold">현재가</th>
						<th class="grayFontBold">매입가</th>
						<th class="grayFontBold">보유량</th>
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
							<td
								class="${ ((1- (avo.h_qty * avo.avg_h_price) / (avo.h_qty * avo.cur_price))) < 0 ? 'minus' : 'plus'}">
								<fmt:formatNumber
									value="${(1- (avo.h_qty * avo.avg_h_price) / (avo.h_qty * avo.cur_price)) }"
									pattern="#,###.00%" />
							</td>
						</tr>
					</c:forEach>
				</tbody>
				<c:if test="${h_list[0] eq null }">
				<tfoot>
					<tr>
						<td colspan="5" class="grayLight">보유 종목을 추가 해보세요!&nbsp;&nbsp;<a href="/stock/trade"><i class="fas fa-cart-plus" style='font-size: 24px; color: #1F9688;'></i></a></td>
					</tr>
				</tfoot>
				</c:if>
			</table>
			<h3 class="mb-4 mt-5 text-center grayFontBold">내 관심종목</h3>
			<table class="table table-hover">
				<thead>
					<tr class="greenLineBold">
						<th class="grayFontBold">종목명</th>
						<th class="grayFontBold">현재가</th>
						<th class="grayFontBold">평균목표가</th>
						<th class="grayFontBold">52주 최고가</th>
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
							<td class="grayFont"><a href="#"><i class="fas fa-cart-plus"
									style='font-size: 24px; color: #1F9688;'></i></a></td>
						</tr>
					</c:forEach>
				</tbody>
				<c:if test="${w_list eq null}">
				<tfoot>
					<tr>
						<td colspan="5" class="grayLight">관심 종목을 추가 해보세요!&nbsp;&nbsp;<a href="/stock/list"><i class="fas fa-cart-plus" style='font-size: 24px; color: #1F9688;'></i></a></td>
					</tr>
				</tfoot>
				</c:if>
			</table>
		</div>
	</div>
</div>
<jsp:include page="common/footer.jsp" />