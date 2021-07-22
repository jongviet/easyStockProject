const alpha = alphavantage({ key: 'EKPQ647LZ3NMCEIZ' });

$(document).ready(function() {
	
	var now = new Date();

	hour = now.getHours();
	if((hour+"").length < 2){
	hour="0"+hour;      
	}
	
	min = now.getMinutes();
	if((hour+"").length < 2){
	min="0"+min;
	} 
	
	if((hour == 09) && (min == 00)) {
		tradable();
	}
	
	if((hour == 09) && (min == 01)) {
		tradable_account();
	}
});
	
function tradable() {

    let url_val = "/stock/tradable";
    
    $.getJSON(url_val, function(result) {
    	var tradableList = [];
    	
    	for(let i = 0; i < result.length; i++) {
    		tradableList.push(result[i].symbol);
    	}
    	
    	for(let idx in tradableList) {
		adjusted_close(tradableList[idx]);
		};
    
    }).fail(function(err) {
    	console.log(err);
    });
};

function tradable_account() {

    let url_val = "/stock/tradable";
    
    $.getJSON(url_val, function(result) {
    	var tradableList = [];
    	
    	for(let i = 0; i < result.length; i++) {
    		tradableList.push(result[i].symbol);
    	}
    	
    	for(let idx in tradableList) {
		adjusted_close_account(tradableList[idx]);
		};
    
    }).fail(function(err) {
    	console.log(err);
    });
};


function adjusted_close(input_val) { 
	
	alpha.data.daily_adjusted(input_val).then((data) => {
		
 		var bigObj = data["Time Series (Daily)"];
		
		/* JSON Object -> array[array(0), array(1), array(2)....] */
		var jsonArray = Object.entries(bigObj);
		
		var cur_price_val = jsonArray[0][1]["5. adjusted close"];
		
		/* input_val : symbol, cur_price_val : cur_price */
			
			let price_data = {
				symbol : input_val,
				cur_price : cur_price_val
			};
			$.ajax({
				url : "/stock/trade",
				type : "post",
				data : JSON.stringify(price_data),
				contentType : "application/json; charset=utf-8"
			});
  });
};


function adjusted_close_account(input_val) { 
	
	alpha.data.daily_adjusted(input_val).then((data) => {
		
 		var bigObj = data["Time Series (Daily)"];
		
		/* JSON Object -> array[array(0), array(1), array(2)....] */
		var jsonArray = Object.entries(bigObj);
		
		var cur_price_val = jsonArray[0][1]["5. adjusted close"];
		
		/* input_val : symbol, cur_price_val : cur_price */
			let price_data = {
				symbol : input_val,
				cur_price : cur_price_val
			};
			$.ajax({
				url : "/stock/account",
				type : "post",
				data : JSON.stringify(price_data),
				contentType : "application/json; charset=utf-8"
			});
  });
};