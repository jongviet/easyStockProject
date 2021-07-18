<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<div class="container">
	<div class="row">
		<div class="col-lg-12 col-md-12 mx-auto text-center">
			<h3 class="float-left grayFontBold">종목리스트</h3>
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
					<button type="submit" class="btn"
						style="background-color: #1F9688; color: white">조회</button>
				</form>
			</div>
			<table class="table table-hover">
				<thead>
					<tr class="greenLineBold">
						<th class="grayFontBold">Symbol</th>
						<th class="grayFontBold">Name</th>
						<th class="grayFontBold">Sector</th>
						<th class="text-right grayFontBold">Market_Capitalization</th>
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
							<td><a href="#"><i class="fas fa-cart-plus"
									style='font-size: 24px; color: #1F9688;'></i></a></td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="6"><jsp:include page="../common/paging.jsp" /></td>
					</tr>
				</tfoot>
			</table>
		</div>
		<div class="col-lg-6 col-md-6 ml-10 pl-10"
			style="float: left; border: 1px solid black; text-align: center;">
			<h1>NEWS!</h1>
		</div>
		<!-- trading view chart import -->
		<div class="col-lg-6 col-md-6 ml-10 pl-10"
			style="float: right; text-align: center;">
			<div class="tradingview-widget-container">
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
			  "isTransparent": false,
			  "showSymbolLogo": false,
			  "width": "530",
			  "height": "800",
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
	</div>
</div>

<script src="/resources/bootstrap/js/list.js"></script>
<jsp:include page="../common/footer.jsp" />