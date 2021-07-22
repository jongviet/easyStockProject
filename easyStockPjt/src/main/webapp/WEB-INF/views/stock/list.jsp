<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />
<script src="/resources/bootstrap/js/list.js"></script>

<div class="container">
	<div class="row">
		<div class="col-lg-12 col-md-12 mx-auto text-center">
			<h3 class="float-left greenFontBold">종목리스트</h3>
			<div class="form-group float-right">
				<form action="/stock/list" class="form-inline">
					<select class="form-control" name="range">
						<option value="snc"
							<c:out value="${pghdl.pgvo.range eq 'snc' ? 'selected' : '' }"/>>
							전체</option>
						<option value="s"
							<c:out value="${pghdl.pgvo.range eq 's' ? 'selected' : '' }"/>>
							Symbol</option>
						<option value="n"
							<c:out value="${pghdl.pgvo.range eq 'n' ? 'selected' : '' }"/>>
							Name</option>
						<option value="c"
							<c:out value="${pghdl.pgvo.range eq 'c' ? 'selected' : '' }"/>>
							Sector</option>
					</select> <input class="form-control" type="text" name="keyword"
						value='<c:out value="${pghdl.pgvo.keyword }"/>'>
					<button type="submit" class="btn btnBackground">조회</button>
				</form>
			</div>
			<table class="table table-hover">
				<thead class="titleBackground">
					<tr class="greenLineBold">
						<th class="grayFontBold">종목코드</th>
						<th class="grayFontBold">종목명</th>
						<th class="grayFontBold">그룹</th>
						<th class="text-center grayFontBold">시가총액</th>
						<th class="grayFontBold">거래하기</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${s_list}" var="svo">
						<tr>
							<td class="grayFont" id="symbol_watch">${svo.symbol }</td>
							<td class="grayFont"><a
								href="/stock/detail?symbol=${svo.symbol}&pageIndex=${pghdl.pgvo.pageIndex}&countPerPage=${pghdl.pgvo.countPerPage}&range=${pghdl.pgvo.range}&keyword=${pghdl.pgvo.keyword}&email=${ses}"
								class="greenFont">${svo.fullName}</a></td>
							<td class="grayFont">${svo.sector }</td>
							<td class="text-right grayFont">$<fmt:formatNumber
									value="${svo.m_capitalization}" pattern="#,###" />&nbsp;&nbsp;&nbsp;
							</td>
							<td><a data-symbol="${svo.symbol}" data-toggle="modal"
								data-target="#buyModal" id="buying" href="#"><i
									class="material-icons" style="font-size: 24px; color: #FF8C69">shopping_cart</i></a>
								<a data-symbol="${svo.symbol}" data-toggle="modal"
								data-target="#sellModal" id="selling" href="#"><i
									class="material-icons" style="font-size: 24px; color: #FF8C69">remove_shopping_cart</i></a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="5"><jsp:include page="../common/paging.jsp" /></td>
					</tr>
				</tfoot>
			</table>
		</div>
		<div class="col-lg-6 col-md-6 ml-10 pl-10"
			style="float: left; text-align: center;">
			<div class="tradingview-widget-container" style="border-top: 1px solid #1F9688;">
				<div class="tradingview-widget-container__widget"></div>
				<script type="text/javascript"
					src="https://s3.tradingview.com/external-embedding/embed-widget-market-overview.js"
					async="true">
			  {
			  "colorTheme": "light",
			  "dateRange": "12M",
			  "showChart": true,
			  "locale": "en",
			  "largeChartUrl": "",
			  "isTransparent": true,
			  "showSymbolLogo": false,
			  "width": "530",
			  "height": "650",
			  "plotLineColorGrowing": "rgba(61, 170, 147, 1)",
			  "plotLineColorFalling": "rgba(61, 170, 147, 1)",
			  "gridLineColor": "rgba(240, 243, 250, 1)",
			  "scaleFontColor": "rgba(61, 170, 147, 1)",
			  "belowLineFillColorGrowing": "rgba(61, 170, 147, 0.12)",
			  "belowLineFillColorFalling": "rgba(61, 170, 147, 0.12)",
			  "symbolActiveColor": "rgba(61, 170, 147, 0.12)",
			  "tabs": [
			   	  {
				      "title": "Forex",
				      "symbols": [
				        {
				          "s": "FX_IDC:USDKRW",
				          "d": "USD:KRW"
				        },
				        {
				          "s": "FX_IDC:USDEUR",
				          "d": "USD:EUR"
				        },
				        {
				          "s": "FX_IDC:USDCNY",
				          "d": "USD:CNY"
				        },
				        {
				          "s": "FX_IDC:USDJPY",
				          "d": "USD:JPY"
				        }
				      ],
				      "originalTitle": "Forex"
				    },						  
				    {
				      "title": "Indices",
				      "symbols": [
				        {
				          "s": "FOREXCOM:SPXUSD",
				          "d": "S&P 500"
				        },
				        {
				          "s": "FOREXCOM:NSXUSD",
				          "d": "Nasdaq 100"
				        },
				        {
				          "s": "FOREXCOM:DJI",
				          "d": "Dow 30"
				        }
				      ],
				      "originalTitle": "Indices"
				    },
				    {
				      "title": "Commodities",
				      "symbols": [
				        {
				          "s": "COMEX:GC1!",
				          "d": "Gold"
				        },
				        {
				          "s": "NYMEX:CL1!",
				          "d": "Crude Oil"
				        },
				        {
				          "s": "NYMEX:NG1!",
				          "d": "Natural Gas"
				        },
				        {
				          "s": "COMEX:SI1!",
				          "d": "Silver"
				        },
				        {
				          "s": "COMEX:HG1!",
				          "d": "Copper"
				        }
				      ],
				      "originalTitle": "Commodities"
				    }
				  ]
				}
				</script>
			</div>
		</div>
		<div class="col-lg-6 col-md-6 mr-10 pr-10" style="float: right; text-align: center;">
			<h3 class="greenFontBold text-center">섹터별 성과 지표</h3>
			<table class="table table-hover">
				<thead class="titleBackground">
					<tr class="greenLineBold">
						<th class="grayFontBold">Sector</th>
						<th class="grayFontBold">Daily</th>
						<th class="grayFontBold">Monthly</th>
						<th class="grayFontBold">YTD</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="grayFont">Communication Services</td>
						<td class="grayFont" id="cs_d"></td>
						<td class="grayFont" id="cs_m"></td>
						<td class="grayFont" id="cs_y"></td>
					</tr>
					<tr>
						<td class="grayFont">Consumer Discretionary</td>
						<td class="grayFont" id="cd_d"></td>
						<td class="grayFont" id="cd_m"></td>
						<td class="grayFont" id="cd_y"></td>
					</tr>
					<tr>
						<td class="grayFont">Consumer Staples</td>
						<td class="grayFont" id="cst_d"></td>
						<td class="grayFont" id="cst_m"></td>
						<td class="grayFont" id="cst_y"></td>
					</tr>
					<tr>
						<td class="grayFont">Energy</td>
						<td class="grayFont" id="e_d"></td>
						<td class="grayFont" id="e_m"></td>
						<td class="grayFont" id="e_y"></td>
					</tr>
					<tr>
						<td class="grayFont">Financials</td>
						<td class="grayFont" id="f_d"></td>
						<td class="grayFont" id="f_m"></td>
						<td class="grayFont" id="f_y"></td>
					</tr>
					<tr>
						<td class="grayFont">Health Care</td>
						<td class="grayFont" id="h_d"></td>
						<td class="grayFont" id="h_m"></td>
						<td class="grayFont" id="h_y"></td>
					</tr>
					<tr>
						<td class="grayFont">Industrials</td>
						<td class="grayFont" id="i_d"></td>
						<td class="grayFont" id="i_m"></td>
						<td class="grayFont" id="i_y"></td>
					</tr>
					<tr>
						<td class="grayFont">Information Technology</td>
						<td class="grayFont" id="it_d"></td>
						<td class="grayFont" id="it_m"></td>
						<td class="grayFont" id="it_y"></td>
					</tr>
					<tr>
						<td class="grayFont">Materials</td>
						<td class="grayFont" id="m_d"></td>
						<td class="grayFont" id="m_m"></td>
						<td class="grayFont" id="m_y"></td>
					</tr>
					<tr>
						<td class="grayFont">Real Estate</td>
						<td class="grayFont" id="re_d"></td>
						<td class="grayFont" id="re_m"></td>
						<td class="grayFont" id="re_y"></td>
					</tr>
					<tr>
						<td class="grayFont">Utilities</td>
						<td class="grayFont" id="u_d"></td>
						<td class="grayFont" id="u_m"></td>
						<td class="grayFont" id="u_y"></td>
					</tr>
				</tbody>
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

<script src="/resources/bootstrap/js/buyAndSell.js"></script>
<jsp:include page="../common/footer.jsp" />