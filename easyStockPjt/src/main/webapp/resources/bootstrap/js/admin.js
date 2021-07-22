const alpha = alphavantage({ key: 'EKPQ647LZ3NMCEIZ' });
    
$("#inputBtn").on("click", function() {
	$(function() {
		let input_val = $("#input").val();
		
		if(input_val == null || input_val == '') {
			alert('symbol을 입력해주세요');
			return false;
		}
		overview_input(input_val);
	});
});

function overview_input(input_val) {
    alpha.fundamental.company_overview(input_val).then((data) => {
        	
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

function earning_input(input_val) {
	let input = input_val.toUpperCase();
    alpha.fundamental.earnings(input).then((data) => {
       
       var jsonArray = [];
       
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

$(document).ready(function() {

	$("#priceUpdate").on("click", function() {
		tradable();
		alert('전일 종가 업데이트 완료');
	});
	
	$("#accountUpdate").on("click", function() {
		tradable_account();
		alert('Member Account 현재가 업데이트 완료');
	});
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
		
		var jsonArray = Object.entries(bigObj);
		
		var cur_price_val = jsonArray[0][1]["5. adjusted close"];
					
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
		
		var jsonArray = Object.entries(bigObj);
		
		var cur_price_val = jsonArray[0][1]["5. adjusted close"];
		
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

function print_comment(cvo) {
	let commentBox = $(".commentBox");
	commentBox.empty();	
	
	let cmtData = '<h5 class="greenFontBold">작성자 : '+cvo.writer+'</h5><h6 class="grayFont">'+cvo.comment+'</h6>';
	
	$("#exampleModalLabel").text("코멘트 번호 : " + cvo.cNum + " / " + "좋아요 : " + cvo.t_up + " / " + "종목 : " + cvo.symbol);
	commentBox.append(cmtData);
};

$(document).on("click", "#comment", function() {

		$("#commentModal").css("z-index", "3000");
		
		let cNum_val = $(this).text();
		let url_val = "/comment/cNum/"+cNum_val;
		
		$.getJSON(url_val, function(result) {
			print_comment(result);
		}).fail(function(err) {
			console.log(err);
		});
});

$(function () {
	$(document).on("click", "#accepted", function() {
	let cNum_val = $(this).parent().parent().find("#comment").text();
	
		$.ajax({
			url : "/comment/accepted/"+cNum_val,
			type : "delete"		
		}).done(function(result) {
			if(parseInt(result) > 0) {
				alert('신고 내역 처리 후, 댓글이 정상적으로 삭제 조치되었습니다.');
				window.location.reload();
			};
		});;
	
	});
});

$(function () {
	$(document).on("click", "#denied", function() {
	let cNum_val = $(this).parent().parent().find("#comment").text();
	
		$.ajax({
			url : "/comment/denied/"+cNum_val,
			type : "delete"		
		}).done(function(result) {
			if(parseInt(result) > 0) {
				alert('신고 내역을 무효화 처리하였습니다.');
				window.location.reload();
			};
		});;
	
	});
});






