<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="common/header.jsp" />
<jsp:include page="common/nav.jsp" />

<a data-toggle="modal" data-target="#buyModal" id="buying" href="#"
	class="greenFontBold">매수주문</a>

<script>
/* 거래하기 버튼 클릭 */
$("#buying").on("click", function() {
	$("#buyModal").css("z-index", "2000");
});

/* 매수하기 종목 조회  */
$(document).on("click", "#symbolSearch", function() {
	
	/* 종목 재검색 시, 매수 총액 , 거래 수량 제거 */
	$("#buyingAmount").text("");
	$("#tradeQty").val("");
	$("#balance").text("");
	
    let keyword_val = $("#keyword").val();
    let email_val = ses;
    let url_val = "/stock/buyList/"+keyword_val+"/"+email_val+".json";
    
    $.getJSON(url_val, function(result) {
    	
    		if(result.svo == null) {
            	/* 기 보유 시 */
            	var cur_price = result.avo.cur_price.toFixed(2);
            	var cur_price_comma = cur_price.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
            	var avg_h_price = result.avo.avg_h_price.toFixed(2);
            	var avg_h_price_comma = avg_h_price.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
            	var total = (parseInt(result.avo.h_qty) * parseInt(result.avo.cur_price)).toFixed(2);
            	var total_comma = total.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
            	
            	var deposit = result.deposit;
            	var deposit_comma = deposit.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
            	
            	$("#deposit_store").val(deposit);
            	$("#deposit").text(deposit_comma);
            	$("#cur_price").text(cur_price_comma);
            	$("#symbol").text(result.avo.symbol);
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
            	$("#deposit").text(deposit_comma);
   	        	$("#cur_price").text(cur_price_comma);
   	        	$("#symbol").text(result.svo.symbol);
   	        	$("#h_qty").text(0);
   	        	$("#avg_h_price").text(0);
   	        	$("#total").text(0);
   	        	$("#amountSearch").attr('disabled', false);
    		}
    }).fail(function(err) {
		console.log(err);
    });
});

/* 거래 대금 조회 */
$(document).on("click", "#amountSearch", function() {
	
	if($("#tradeQty") == null || $("#tradeQty") == '') {
		alert('거래 수량을 입력해주세요');
		return false;
	}
	
	var buyingAmount = (parseInt($("#tradeQty").val()) * parseInt($("#cur_price").text())).toFixed(2);
	var buyingAmount_comma = buyingAmount.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	
	$("#buyingAmount").text(buyingAmount_comma);
	
	/* 거래 후 잔액 처리 */
	var deposit = $("#deposit_store").val();
	var balance = (deposit - parseFloat(buyingAmount)).toFixed(2);
	var balance_comma = balance.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
	
	$("#balance").text(balance_comma);
	
});

/* 거래 취소 */
$(document).on("click", "#cancel", function() {
	$("#keyword").val("");
	$("#tradeQty").val("");
	
	$("#symbol").text("");
	$("#h_qty").text("");
	$("#avg_h_price").text("");
	$("#total").text("");
	$("#cur_price").text("");
	$("#buyingAmount").text("");
	$("#deposit").text("");
	$("#balance").text("");
});


/* 매수 진행; 잔액 부족 시 불가 */
$(document).on("click", "#buy", function() {
	
	/* 예수금 부족 */
	if(parseInt($("#balance").text()) < 0) {
		alert('예수금이 부족합니다.');
		return false;
	} 
	
	/* 매수 */
	var email_val = ses;
	var symbol_val = $("#symbol").text();
	var avg_h_price_val = $("#cur_price").text();
	var h_qty_val = $("#tradeQty").val();
	var cur_price_val = $("#cur_price").text();
	
	if($("#h_qty").text() == "") {
		alert('보유고 존재');
	} else {
		alert('신규 매수');
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
					alert('정상 작동');
				}
			}).fail(function(err) {
				console.log(err);
			})
		
	}
});



</script>

<!-- 거래 modal -->
<div class="modal fade" id="buyModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true"
	data-backdrop="static" style="z-index: -1;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title grayFontBold" id="exampleModalLabel">매수주문</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="input-group">
					<input class="form-control" type="text" id="keyword"
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
							<td id="symbol" class="grayFontBold"></td>
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
							<td id="deposit" class="grayFontBold"></td>
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


<jsp:include page="common/footer.jsp" />