<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />


<input type="text" id="input">
<button type="button" class="btn btn-info" id="inputBtn">종목 등록</button>



<script>

$("#inputBtn").on("click", function() {
	let input_val = $("#input").val();
	overview_input(input_val);
});

/* company_overview */
function overview_input(input_val) {
    alpha.fundamental.company_overview(input_val).then((data) => {
    	
    	let stock_data = {
	    	symbol : data["Symbol"],
	        name : data["Name"],
	        description : data["Description"],
	        sector : data["Sector"],
	        m_capital : data["MarketCapitalization"],
	        per : data["PERatio"],
	        eps : data["EPS"],
	        pxt_insiders : data["PercentInsiders"],
	        pxt_institutions : data["PercentInstitutions"],
	        year_high : data["52WeekHigh"],
	        year_low : data["52WeekLow"],
	        avg_target : data["AnalystTargetPrice"]
    	};
    	
    	console.log(stock_data);
    	
    	$.ajax({
			url : "/stock/c_register",
			type : "post",
			data : JSON.stringify(stock_data),
			contentType : "application/json; charset=utf-8"
		}).done(function(result) {
			earning_input(input_val);
		}).fail(function(err) {
			console.log(err);
		})
		


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
             jsonData.e_eps = data["quarterlyEarnings"][i]["estimatedEPS"];
             
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
   });
};
</script>

<script src="/resources/bootstrap/js/bundle.js"></script>
<script src="/resources/bootstrap/js/admin.js"></script>
<jsp:include page="../common/footer.jsp" />