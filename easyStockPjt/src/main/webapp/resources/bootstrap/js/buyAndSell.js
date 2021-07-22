$(document).on("click", "#buying", function() {
	$("#buyModal").css("z-index", "2000");
	var symbol = $(this).data("symbol");
	$("#keyword_buy").val(symbol);
});

$(document).on("click", "#selling", function() {
	$("#sellModal").css("z-index", "2000");
	var symbol = $(this).data("symbol");
	$("#keyword_sell").val(symbol);
});

$(document).on("click", "#symbolSearch", function() {
	
	$("#buyingAmount").text("");
	$("#tradeQty").val("");
	$("#balance").text("");
	
    let keyword_val = $("#keyword_buy").val();
    let email_val = ses;
    let url_val = "/stock/list/"+keyword_val+"/"+email_val+".json";
    
    $.getJSON(url_val, function(result) {
    	
    		if(result.svo == null) {
            	var cur_price = result.avo.cur_price.toFixed(2);
            	var cur_price_comma = cur_price.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
            	var avg_h_price = result.avo.avg_h_price.toFixed(2);
            	var avg_h_price_comma = avg_h_price.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
            	var total = (parseInt(result.avo.h_qty) * parseFloat(result.avo.cur_price)).toFixed(2);
            	var total_comma = total.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");   
            	
            	var deposit = result.deposit;
            	var deposit_comma = deposit.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");            	
            	
            	$("#deposit_store").val(deposit);
            	$("#deposit_buy").text(deposit_comma);
            	$("#cur_price").text(cur_price_comma);
            	$("#symbol_buy").text(result.avo.symbol);
            	$("#h_qty").text(result.avo.h_qty);
            	$("#avg_h_price").text(avg_h_price_comma);
            	$("#total").text(total_comma);
            	$("#amountSearch").attr('disabled', false);
    		} else if(result.avo == null) {
   	        	var cur_price = result.svo.cur_price.toFixed(2);
   	        	var cur_price_comma = cur_price.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
            	var deposit = result.deposit;
            	var deposit_comma = deposit.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
            	
            	$("#deposit_store").val(deposit);
            	$("#deposit_buy").text(deposit_comma);
   	        	$("#cur_price").text(cur_price_comma);
   	        	$("#symbol_buy").text(result.svo.symbol);
   	        	$("#h_qty").text(0);
   	        	$("#avg_h_price").text(0);
   	        	$("#total").text(0);
   	        	$("#amountSearch").attr('disabled', false);
    		}
    }).fail(function(err) {
		console.log(err);
    });
});

$(document).on("click", "#symbolSearch_sell", function() {
	
	$("#sellingAmount").text("");
	$("#tradeQty_sell").val("");
	$("#balance_sell").text("");
	
    let keyword_val = $("#keyword_sell").val();
    let email_val = ses;
    let url_val = "/stock/list/"+keyword_val+"/"+email_val+".json";
    
    $.getJSON(url_val, function(result) {
    	
    		if(result.svo == null) {
            	var cur_price = result.avo.cur_price.toFixed(2);
            	var cur_price_comma = cur_price.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
            	var avg_h_price = result.avo.avg_h_price.toFixed(2);
            	var avg_h_price_comma = avg_h_price.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
            	var total = (parseInt(result.avo.h_qty) * parseFloat(result.avo.cur_price)).toFixed(2);
            	var total_comma = total.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
            	
            	var deposit = result.deposit;
            	var deposit_comma = deposit.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
            	
            	$("#deposit_store_sell").val(deposit);
            	$("#deposit_sell").text(deposit_comma);
            	$("#cur_price_sell").text(cur_price_comma);
            	$("#symbol_sell").text(result.avo.symbol);
            	$("#h_qty_sell").text(result.avo.h_qty);
            	$("#avg_h_price_sell").text(avg_h_price_comma);
            	$("#total_sell").text(total_comma);
            	$("#amountSearch_sell").attr('disabled', false);
    		} else if(result.avo == null) {
   	        	var cur_price = result.svo.cur_price.toFixed(2);
   	        	var cur_price_comma = cur_price.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
            	var deposit = result.deposit;
            	var deposit_comma = deposit.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
            	
            	$("#deposit_store_sell").val(deposit);
            	$("#deposit_sell").text(deposit_comma);
   	        	$("#cur_price_sell").text(cur_price_comma);
   	        	$("#symbol_sell").text(result.svo.symbol);
   	        	$("#h_qty_sell").text(0);
   	        	$("#avg_h_price_sell").text(0);
   	        	$("#total_sell").text(0);
   	        	$("#amountSearch_sell").attr('disabled', false);
    		}
    }).fail(function(err) {
		console.log(err);
    });
});

$(document).on("click", "#amountSearch", function() {
	
	if(parseInt($("#tradeQty").val()) <= 0 || $("#tradeQty").val() == '' || $("#tradeQty").val() == null) {
		alert('거래 수량을 정확히 입력해주세요.');
		return false;
	}
	
	var amt = $("#cur_price").text().replace(/,/g, '');
	var amt_no_comma = parseFloat(amt);
	
	var buyingAmount = (parseInt($("#tradeQty").val()) * amt_no_comma).toFixed(2);
	var buyingAmount_comma = buyingAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	
	$("#buyingAmount").text(buyingAmount_comma);
	
	var deposit = $("#deposit_store").val();
	var balance = (deposit - parseFloat(buyingAmount)).toFixed(2);
	var balance_comma = balance.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	
	$("#balance").text(balance_comma);
});

$(document).on("click", "#amountSearch_sell", function() {
	
	if(parseInt($("#tradeQty_sell").val()) <= 0 || $("#tradeQty_sell").val() == '' || $("#tradeQty_sell").val() == null) {
		alert('거래 수량을 정확히 입력해주세요.');
		return false;
	}
	
	if(parseInt($("#h_qty_sell").text()) < parseInt($("#tradeQty_sell").val())) {
		alert('매도할 수량이 부족합니다.');
		return false;
	}
	
	var amt = $("#cur_price_sell").text().replace(/,/g, '');
	var amt_no_comma = parseFloat(amt);
	
	var sellingAmount = (parseInt($("#tradeQty_sell").val()) * amt_no_comma).toFixed(2);
	var sellingAmount_comma = sellingAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	
	$("#sellingAmount").text(sellingAmount_comma);
	
	var deposit = $("#deposit_store_sell").val();
	var balance = (Number(deposit) + parseFloat(sellingAmount)).toFixed(2);
	var balance_comma = balance.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	
	$("#balance_sell").text(balance_comma);
});

$(document).on("click", "#cancel", function() {
	$("#keyword_buy").val("");
	$("#tradeQty").val("");
	
	$("#symbol_buy").text("");
	$("#h_qty").text("");
	$("#avg_h_price").text("");
	$("#total").text("");
	$("#cur_price").text("");
	$("#buyingAmount").text("");
	$("#deposit_buy").text("");
	$("#balance").text("");
	$("#amountSearch").attr('disabled', true);
});

$(document).on("click", "#cancel_sell", function() {
	$("#keyword_sell").val("");
	$("#tradeQty_sell").val("");
	
	$("#symbol_sell").text("");
	$("#h_qty_sell").text("");
	$("#avg_h_price_sell").text("");
	$("#total_sell").text("");
	$("#cur_price_sell").text("");
	$("#sellingAmount").text("");
	$("#deposit_sell").text("");
	$("#balance_sell").text("");
	$("#amountSearch_sell").attr('disabled', true);
});

$(document).on("click", "#cancel2", function() {
	$("#keyword_buy").val("");
	$("#tradeQty").val("");
	
	$("#symbol_buy").text("");
	$("#h_qty").text("");
	$("#avg_h_price").text("");
	$("#total").text("");
	$("#cur_price").text("");
	$("#buyingAmount").text("");
	$("#deposit_buy").text("");
	$("#balance").text("");
	$("#amountSearch").attr('disabled', true);
});

$(document).on("click", "#cancel2_sell", function() {
	$("#keyword_sell").val("");
	$("#tradeQty_sell").val("");
	
	$("#symbol_sell").text("");
	$("#h_qty_sell").text("");
	$("#avg_h_price_sell").text("");
	$("#total_sell").text("");
	$("#cur_price_sell").text("");
	$("#sellingAmount").text("");
	$("#deposit_sell").text("");
	$("#balance_sell").text("");
	$("#amountSearch_sell").attr('disabled', true);
});

$(document).on("click", "#buy", function() {

	if($("#symbol_buy").text() == '' || $("#symbol_buy").text() == null) {
		alert('종목을 선택해주세요.');
		return false;
	}
	
	if(parseInt($("#balance").text()) < 0) {
		alert('예수금이 부족합니다.');
		return false;
	}
	
	if(parseInt($("#tradeQty").val()) <= 0 || $("#tradeQty").val() == '' || $("#tradeQty").val() == null) {
		alert('매수 수량을 정확히 입력해주세요.');
		return false;
	}
	
	var amt = $("#cur_price").text().replace(/,/g, '');
	
	var email_val = ses;
	var symbol_val = $("#symbol_buy").text();
	var avg_h_price_val = amt;
	var h_qty_val = $("#tradeQty").val();
	var cur_price_val = amt;
	
	if($("#h_qty").text() != 0) {
        let accountData = {
				email : email_val,
				symbol : symbol_val,
				avg_h_price : avg_h_price_val,
				h_qty : h_qty_val,
				cur_price : cur_price_val
			};
			$.ajax({
				url : "/stock/additionalBuy",
				type : "post",
				data : JSON.stringify(accountData),
				contentType : "application/json; charset=utf-8"
			}).done(function(result) {
				if(parseInt(result) > 0) {
					alert('정상 추가 매수 하였습니다.');
					$("#cancel").click();
					window.location.reload();					
				}
			}).fail(function(err) {
				console.log(err);
			});
	} else if($("#h_qty").text() == 0) {
        let accountData = {
				email : email_val,
				symbol : symbol_val,
				avg_h_price : avg_h_price_val,
				h_qty : h_qty_val,
				cur_price : cur_price_val
			};
			$.ajax({
				url : "/stock/newBuy",
				type : "post",
				data : JSON.stringify(accountData),
				contentType : "application/json; charset=utf-8"
			}).done(function(result) {
				if(parseInt(result) > 0) {
					alert('정상 매수 하였습니다.');
					$("#cancel").click();
					window.location.reload();					
				}
			}).fail(function(err) {
				console.log(err);
			})
	}
});


$(document).on("click", "#sell", function() {

	if($("#symbol_sell").text() == '' || $("#symbol_sell").text() == null) {
		alert('종목을 선택해주세요.');
		return false;
	}

	if(parseInt($("#h_qty_sell").text()) < parseInt($("#tradeQty_sell").val())) {
		alert('매도할 수량이 부족합니다.');
		return false;
	}
	
	if(parseInt($("#tradeQty_sell").val()) <= 0 || $("#tradeQty_sell").val() == '' || $("#tradeQty_sell").val() == null) {
		alert('매도 수량을 정확히 입력해주세요.');
		return false;
	}
	
    var amt = $("#cur_price_sell").text().replace(/,/g, '');
	
	var email_val = ses;
	var symbol_val = $("#symbol_sell").text();
	var avg_h_price_val = amt;
	var h_qty_val = $("#tradeQty_sell").val();
	var cur_price_val = amt;
	
        let accountData = {
				email : email_val,
				symbol : symbol_val,
				avg_h_price : avg_h_price_val,
				h_qty : h_qty_val,
				cur_price : cur_price_val
			};
			$.ajax({
				url : "/stock/sell",
				type : "post",
				data : JSON.stringify(accountData),
				contentType : "application/json; charset=utf-8"
			}).done(function(result) {
				if(parseInt(result) > 0) {
					alert('정상 매도 하였습니다.');
					$("#cancel_sell").click();
					window.location.reload();					
				}
			}).fail(function(err) {
				console.log(err);
			});
});


	function current_asset_show(symbol_arr, eachStockVal) {
		$("#myChartTwo").remove();
		$("#canvasDivTwo").append("<canvas id='myChartTwo' style='background-color: #f5f5f5;' width='525' height='460'></canvas>");
		
		var ctx = document.getElementById('myChartTwo');
		var config = {
			type : 'doughnut',
			data : {
				labels : symbol_arr,
				datasets : [ {
					label : 'Stock',
					data : eachStockVal,
					backgroundColor : [ '#99E6B2', '#7AD2A8', '#5CBE9D',
							'#3DAA93', '#1F9688', '#00827E', '#008562', '#009D74', '#006E50', '#00563E'],
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
	
	function current_asset_hide(symbol_arr, eachStockVal) {
		$("#myChartTwo").remove();
		$("#canvasDivTwo").append("<canvas id='myChartTwo' style='background-color: #f5f5f5;' width='525' height='460'></canvas>");
		
		var ctx = document.getElementById('myChartTwo');
		var config = {
			type : 'doughnut',
			data : {
				labels : symbol_arr,
				datasets : [ {
					label : 'Stock',
					data : eachStockVal,
					backgroundColor : [ '#99E6B2', '#7AD2A8', '#5CBE9D',
							'#3DAA93', '#1F9688', '#00827E', '#008562', '#009D74', '#006E50', '#00563E'],
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
				showAllTooltips : false,
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
			setCookie("Ck_01", "on", "0");
		}
	};






