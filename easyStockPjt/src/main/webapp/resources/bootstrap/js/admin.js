/* company_overview + earning key */
    /**
     * Init Alpha Vantage with your API key.
     *
     * @param {String} key
     *   Your Alpha Vantage API key.
     */
    const alpha = alphavantage({ key: 'EKPQ647LZ3NMCEIZ' });
    
    $("#inputBtn").on("click", function() {
	let input_val = $("#input").val();
	overview_input(input_val);
});

/* company_overview */
function overview_input(input_val) {
    alpha.fundamental.company_overview(input_val).then((data) => {
        	
    	/* 적자 기업 PER 처리 */
    	if(data["PERatio"] == 'None') {
    		var per_val = 0;
    	} else {
    		var per_val = data["PERatio"];
    	};
    	
    	let stock_data = {
	    	symbol : data["Symbol"],
	    	fullName : data["Name"],
	        description : data["Description"],
	        sector : data["Sector"],
	        m_capitalization : data["MarketCapitalization"],
	        per : per_val,
	        eps : data["EPS"],
	        pxt_insiders : data["PercentInsiders"],
	        pxt_institutions : data["PercentInstitutions"],
	        year_high : data["52WeekHigh"],
	        year_low : data["52WeekLow"],
	        avg_target : data["AnalystTargetPrice"]
    	};
    	
    	
    	$.ajax({
			url : "/stock/c_register",
			type : "post",
			data : JSON.stringify(stock_data),
			contentType : "application/json; charset=utf-8"
		}).done(function(result) {
			if(result == "1") {
		   		alert('company_overview 등록 완료 -> earning 데이터를 등록합니다.');
				earning_input(input_val);
			};
		}).fail(function(err) {
			console.log(err);
		});
		


    });
};

/* earning data */
function earning_input(input_val) {
	let input = input_val.toUpperCase();
    alpha.fundamental.earnings(input).then((data) => {
       
       var jsonArray = [];
       
       /* 분기 어닝 발표 20회 이상 시, 20 아닐 시, length 사용 */
       if(Object.keys(data["quarterlyEarnings"]).length >= 20) {
    	   var e_count = 20;
       } else {
    	   var e_count = Object.keys(data["quarterlyEarnings"]).length;
       }
       
       for (let i = 0; i < e_count; i++) {
             
             var jsonData = {
                           symbol : input,
                           date : "",
                           r_eps : "",
                           e_eps : ""
             };
             jsonData.date = data["quarterlyEarnings"][i]["reportedDate"];
             jsonData.r_eps = data["quarterlyEarnings"][i]["reportedEPS"];
             
             /* 신생기업 e_eps 데이터 미 존재 시 0 처리  */
             if(data["quarterlyEarnings"][i]["estimatedEPS"] == 'None') {
            	 jsonData.e_eps = "-0.000";
             } else {
                 jsonData.e_eps = data["quarterlyEarnings"][i]["estimatedEPS"];
             }
             jsonArray.push(jsonData);
       };
       
       var dataToCtrl = JSON.stringify(jsonArray);
       
        $.ajax({
             url : "/stock/e_register",
             type: "post",
             traditional : true,
             data : {
                    'jsonData' : dataToCtrl
             },
             dataType: 'json'
       });
       alert('earning 데이터 등록 완료');

   });
};