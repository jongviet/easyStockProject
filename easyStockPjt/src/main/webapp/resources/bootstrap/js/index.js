/* 전일 종가 업데이트 거래소용  */
    /**
     * Init Alpha Vantage with your API key.
     *
     * @param {String} key
     *   Your Alpha Vantage API key.
     */
    const alpha = alphavantage({ key: 'EKPQ647LZ3NMCEIZ' });

$(document).ready(function() {
	
	/* 매일 오전 8시 30분에 모든 데이터 업데이트  */
	var now = new Date();   //현재시간
	         
	year = now.getFullYear();   // 'yyyy'
	month = now.getMonth()+1;   //  'MM' month는 0부터 시작, +1 처리  
	if((month+"").length < 2){
	    month="0"+month;   //달의 숫자가 1자리면 앞에 0을 붙임.
	}
	date = now.getDate();      // 'dd'
	if((date+"").length < 2){
	    date="0"+date;      
	}
	hour = now.getHours();   // 'hh'
	if((hour+"").length < 2){
	hour="0"+hour;      
	}
	
	min = now.getMinutes(); // 'mm'
	if((hour+"").length < 2){
	min="0"+min;
	} 
	
	today = year + "" + month + "" + date+ "" + hour; //오늘 날짜 완성
	
	if((hour == 8) && (min == 30)) {
		tradeable();
	}
});
	
function tradeable() {
	
	var tradeableList = ['AAPL', 'MSFT', 'AMZN', 'GOOG', 'FB', 'TSLA', 'TSM', 'BABA', 'V', 'NVDA', 'JPM', 'JNJ', 'WMT', 'UNH', 'MA',
			'BAC', 'HD', 'PG', 'DIS', 'XOM', 'NKE', 'NFLX', 'VZ', 'KO', 'INTC', 'ORCL', 'PFE', 'CVX', 'UPS', 'COST', 
			'TXN', 'MCD', 'QCOM', 'HON', 'BMY', 'NEE', 'BA', 'UBER', 'FDX', 'ATVI', 'F', 'SPG', 'LUV', 'O', 'OHI'];																			

	for(let idx in tradeableList) {
		adjusted_close(tradeableList[idx]);
	};
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
				url : "/comment/trade",
				type : "post",
				data : JSON.stringify(price_data),
				contentType : "application/json; charset=utf-8"
			});
  });
};