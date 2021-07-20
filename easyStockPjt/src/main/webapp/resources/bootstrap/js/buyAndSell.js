/* 매수; 거래하기 버튼 클릭 */
$(document).on("click", "#buying", function() {
	$("#buyModal").css("z-index", "2000");
	var symbol = $(this).data("symbol");
	$("#keyword_buy").val(symbol);
});

/* 매도; 거래하기 버튼 클릭 */
$(document).on("click", "#selling", function() {
	$("#sellModal").css("z-index", "2000");
	var symbol = $(this).data("symbol");
	$("#keyword_sell").val(symbol);
});

/* 매수하기 종목 조회  */
$(document).on("click", "#symbolSearch", function() {
	
	/* 종목 재검색 시, 매수 총액 , 거래 수량 제거 */
	$("#buyingAmount").text("");
	$("#tradeQty").val("");
	$("#balance").text("");
	
    let keyword_val = $("#keyword_buy").val();
    let email_val = ses;
    let url_val = "/stock/list/"+keyword_val+"/"+email_val+".json";
    
    $.getJSON(url_val, function(result) {
    	
    		if(result.svo == null) {
            	/* 기 보유 시 */
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
   	        	/* 미 보유 시 */
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


/* 매도하기 종목 조회  */
$(document).on("click", "#symbolSearch_sell", function() {
	
	/* 종목 재검색 시, 매도 총액 , 거래 수량 제거 */
	$("#sellingAmount").text("");
	$("#tradeQty_sell").val("");
	$("#balance_sell").text("");
	
    let keyword_val = $("#keyword_sell").val();
    let email_val = ses;
    let url_val = "/stock/list/"+keyword_val+"/"+email_val+".json";
    
    $.getJSON(url_val, function(result) {
    	
    		if(result.svo == null) {
            	/* 기 보유 시 */
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
   	        	/* 미 보유 시 */
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


/* 매수 거래 대금 조회 */
$(document).on("click", "#amountSearch", function() {
	
	/* 매수 수량 오류  */
	if(parseInt($("#tradeQty").val()) <= 0 || $("#tradeQty").val() == '' || $("#tradeQty").val() == null) {
		alert('거래 수량을 정확히 입력해주세요.');
		return false;
	}
	
	/* 천달러 이상 종목 거래용 처리 : 아마존, 구글 */	
	var amt = $("#cur_price").text().replace(/,/g, '');
	var amt_no_comma = parseFloat(amt);
	
	var buyingAmount = (parseInt($("#tradeQty").val()) * amt_no_comma).toFixed(2);
	var buyingAmount_comma = buyingAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	
	$("#buyingAmount").text(buyingAmount_comma);
	
	/* 거래 후 잔액 처리 */
	var deposit = $("#deposit_store").val();
	var balance = (deposit - parseFloat(buyingAmount)).toFixed(2);
	var balance_comma = balance.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	
	$("#balance").text(balance_comma);
});

/* 매도 거래 대금 조회 */
$(document).on("click", "#amountSearch_sell", function() {
	
	/* 매도 수량 오류  */
	if(parseInt($("#tradeQty_sell").val()) <= 0 || $("#tradeQty_sell").val() == '' || $("#tradeQty_sell").val() == null) {
		alert('거래 수량을 정확히 입력해주세요.');
		return false;
	}
	
	/* 판매 수량 부족 */
	if(parseInt($("#h_qty_sell").text()) < parseInt($("#tradeQty_sell").val())) {
		alert('매도할 수량이 부족합니다.');
		return false;
	}
	
	/* 천달러 이상 종목 거래용 처리 : 아마존, 구글 */	
	var amt = $("#cur_price_sell").text().replace(/,/g, '');
	var amt_no_comma = parseFloat(amt);
	
	var sellingAmount = (parseInt($("#tradeQty_sell").val()) * amt_no_comma).toFixed(2);
	var sellingAmount_comma = sellingAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	
	$("#sellingAmount").text(sellingAmount_comma);
	
	/* 거래 후 잔액 처리 */
	var deposit = $("#deposit_store_sell").val();
	var balance = (Number(deposit) + parseFloat(sellingAmount)).toFixed(2);
	var balance_comma = balance.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	
	$("#balance_sell").text(balance_comma);
});

/* 매수 거래 취소 하단 거래취소 버튼 */
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

/* 매도 거래 취소 하단 거래취소 버튼 */
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

/* 매수 거래 취소 상단 x 버튼 */
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

/* 매도 거래 취소 상단 x 버튼 */
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


/* 매수 진행  */
$(document).on("click", "#buy", function() {

	/* 무 종목 매수 방지 */
	if($("#symbol_buy").text() == '' || $("#symbol_buy").text() == null) {
		alert('종목을 선택해주세요.');
		return false;
	}
	
	/* 예수금 부족 */
	if(parseInt($("#balance").text()) < 0) {
		alert('예수금이 부족합니다.');
		return false;
	}
	
	/* 매수 수량 오류 */
	if(parseInt($("#tradeQty").val()) <= 0 || $("#tradeQty").val() == '' || $("#tradeQty").val() == null) {
		alert('매수 수량을 정확히 입력해주세요.');
		return false;
	}
	
	/* 천달러 이상 종목 거래용 처리 : 아마존, 구글 */	
	var amt = $("#cur_price").text().replace(/,/g, '');
	
	/* 매수 */
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



/* 매도 진행; 보유량 부족 시 불가 */
$(document).on("click", "#sell", function() {

	/* 무 종목 매도 방지 */
	if($("#symbol_sell").text() == '' || $("#symbol_sell").text() == null) {
		alert('종목을 선택해주세요.');
		return false;
	}

	/* 판매 수량 부족 */
	if(parseInt($("#h_qty_sell").text()) < parseInt($("#tradeQty_sell").val())) {
		alert('매도할 수량이 부족합니다.');
		return false;
	}
	
	/* 매도 수량 오류  */
	if(parseInt($("#tradeQty_sell").val()) <= 0 || $("#tradeQty_sell").val() == '' || $("#tradeQty_sell").val() == null) {
		alert('매도 수량을 정확히 입력해주세요.');
		return false;
	}
	
    /* 천달러 이상 종목 거래용 처리 : 아마존, 구글 */      
    var amt = $("#cur_price_sell").text().replace(/,/g, '');
	
	/* 매도 */
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