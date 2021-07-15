<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<jsp:include page="common/header.jsp" />
<jsp:include page="common/nav.jsp" />
<!-- 메인용 chartjs -->
<script src="/resources/bootstrap/js/Chart.min.js"></script>
<script src="/resources/bootstrap/js/bundle.js"></script>
<script src="/resources/bootstrap/js/main.js"></script>

<script>
/* 종목 보유 내역 있을 시 작동 */
<c:if test="${h_list ne null}">
	var symbol_arr = [];
	var h_price_arr = [];
	var h_qty_arr = [];
	

	/* 해당 종목의 현재가 가져오기 */
	<c:forEach items="${h_list}" var="avo">
		var symbol = "${avo.symbol}";
		var h_price = "${avo.avg_h_price}";
		var h_qty = "${avo.h_qty}";
		symbol_arr.unshift(symbol);
		h_price_arr.unshift(Number(h_price));
		h_qty_arr.unshift(Number(h_qty));
		
	</c:forEach>
	
/* 	console.log(h_price_arr[0] * h_qty_arr[0]); */

</c:if>
</script>



<div class="container">
	<div class="row">
		<div class="col-lg-6 col-md-6 mx-auto float-left text-center">
			<h3 class="mb-4 text-center bold" style="color: #1F9688">${ses_id}<span style="color:#767675; !important">님의 자산현황</span></h3>
			<h5 class="text-center bold mb-3" style="color: #1F9688">총자산&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<span id="deposit">${deposit}</span>&nbsp;USD</h5>
			<table class="mb-5" style="width: 525px; height: 200px;">
				<tbody>
					<tr style="border-top: 1.8px solid #1F9688">
						<td colspan="2" class="bold">예수금</td>
						<td colspan="2" class="bold">2,000 USD</td>
					</tr>
					<tr style="border-top: 1px solid #1F968880">
						<td colspan="2" class="bold">주식</td>
						<td colspan="2" class="bold">3,100 USD</td>
					</tr>
					<tr style="border-top: 1px solid #1F968880">
						<td colspan="2" class="bold">손익</td>
						<td colspan="2" class="bold">100 USD</td>
					</tr>
					<tr style="border-top: 1px solid #1F968880">
						<td colspan="2" class="bold">수익률</td>
						<td colspan="2" class="bold">2%</td>
					</tr>
				</tbody>
			</table>
			<div class="mt-7">
				<canvas id="myChartTwo" style="background-color: white;" width="525"
					height="460"></canvas>
			</div>
		</div>
<script>
$(document).ready(function() {
	var deposit = 2000;
	var aapl = 2000;
	var amzn = 500;
	var msft = 600;
	var cost = 300;
	var uber = 500;
	
	var dataArr = [];
	dataArr.unshift(deposit);
	dataArr.unshift(aapl);
	dataArr.unshift(amzn);
	dataArr.unshift(msft);
	dataArr.unshift(cost);
	dataArr.unshift(uber);
	current_asset(dataArr);
});

function current_asset(dataArr) {
	var ctx = document.getElementById('myChartTwo');
	var config = {
		type: 'doughnut',
		data: {
			labels: ['예수금', 'AAPL', 'AMZN', 'MSFT', 'COST', 'UBER'],
			datasets: [{
				label: '# of Votes',
				data: dataArr,
				backgroundColor: [
					'#99E6B2',
					'#7AD2A8',
					'#5CBE9D',
					'#3DAA93',
					'#1F9688',
					'#00827E'
				],
				borderWidth: 2
			}],
		},
		animation : {
			animateScale : true,
			animateRotate : true
		},
		options: {
			responsive: false,
			scaleShowLabelBackdrop : true,
			showAllTooltips : true,
			tooltips: {
			    callbacks: {
			      label: function(tooltipItem, data) {
			        var dataset = data.datasets[tooltipItem.datasetIndex];
			        var meta = dataset._meta[Object.keys(dataset._meta)[0]];
			        var total = meta.total;
			        var currentValue = dataset.data[tooltipItem.index];
			        var percentage = parseFloat((currentValue/total*100).toFixed(1));
			        return currentValue + ' (' + percentage + '%)';
			      },
			      title: function(tooltipItem, data) {
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
</script>

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
			  "width": "550",
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

<jsp:include page="common/footer.jsp" />