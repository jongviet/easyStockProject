/* Detail page 차트 시작 */

/* 최초 로딩  */
$(document).ready(function() {
	let symbol = $("#symbol").text();
	let input = symbol.toLowerCase();

	alpha_input_init(input);
});



$("#daily").on("click", function() {

	let symbol = $("#symbol").text();
	let input = symbol.toLowerCase();

	alpha_input_daily(input);

});


$("#monthly").on("click", function() {

	let symbol = $("#symbol").text();
	let input = symbol.toLowerCase();

	alpha_input_monthly(input);

});


function alpha_input_init(input) { 
	
	alpha.data.monthly_adjusted(input, 'full').then((data) => {
		
		/* default : monthly */
 		var bigObj = data["Monthly Adjusted Time Series"];
		
		var jsonArray = Object.entries(bigObj);
		var dateArray = [];
		var valArray = [];
		
		for(let i = 0; i < Object.keys(jsonArray).length; i++) {
			for(let j = 0; j < 1; j++) {
				
				let year_month = jsonArray[i][j].substr(0,7);
				dateArray.unshift(year_month);
				valArray.unshift(jsonArray[i][j+1]["5. adjusted close"]);
			}
		};
		show_graph_monthly(dateArray, valArray, input);
  });
};


function alpha_input_daily(input) { 
	
	alpha.data.daily_adjusted(input, 'full').then((data) => {
		
		/* daily */
 		var bigObj = data["Time Series (Daily)"];
		
		var jsonArray = Object.entries(bigObj);
		var dateArray = [];
		var valArray = [];
		
		for(let i = 0; i < 150; i++) {
			for(let j = 0; j < 1; j++) {
				
				dateArray.unshift(jsonArray[i][j]);
				valArray.unshift(jsonArray[i][j+1]["5. adjusted close"]);
			}
		};
		
		$("#myChartOne").remove();
		$("#canvasDiv").append("<canvas id='myChartOne' style='background-color: white;'></canvas>");
		show_graph_daily(dateArray, valArray, input);
  });
};

function alpha_input_monthly(input) { 
	
	alpha.data.monthly_adjusted(input, 'full').then((data) => {
		
		/* default : monthly */
 		var bigObj = data["Monthly Adjusted Time Series"];
		
		var jsonArray = Object.entries(bigObj);
		var dateArray = [];
		var valArray = [];
		
		for(let i = 0; i < Object.keys(jsonArray).length; i++) {
			for(let j = 0; j < 1; j++) {
				
				let year_month = jsonArray[i][j].substr(0,7);
				dateArray.unshift(year_month);
				valArray.unshift(jsonArray[i][j+1]["5. adjusted close"]);
			}
		};
		$("#myChartOne").remove();
		$("#canvasDiv").append("<canvas id='myChartOne' style='background-color: white;'></canvas>");
		show_graph_monthly(dateArray, valArray, input);
  });
};


	function show_graph_monthly(dateArray, valArray, input) {
		
		const myChartOne = document.getElementById("myChartOne").getContext("2d");

		const barChar = new Chart(myChartOne, {
			  type: "line",
			  data: {
			    labels: dateArray,
			    datasets: [
			      {
			        label: input.toUpperCase(),
			        data: valArray,
			        backgroundColor: "lightblue",
			        borderColor: 'rgb(75, 192, 192)',
			        tension: 0.1
			      },
			    ],
			  },
			});
		
	};
	
	function show_graph_daily(dateArray, valArray, input) {
		
		const myChartOne = document.getElementById("myChartOne").getContext("2d");

		const barChar = new Chart(myChartOne, {
			  type: "line",
			  data: {
			    labels: dateArray,
			    datasets: [
			      {
			        label: input.toUpperCase(),
			        data: valArray,
			        backgroundColor: "lightblue",
			        borderColor: 'rgb(75, 192, 192)',
			        tension: 0.1
			      },
			    ],
			  },
			});
		
	};
	
/* Detail page 차트 끝 */


/* Detail page 댓글 시작  */

	/* 실적 리스트 */
	function print_earningList(list) {
		let earningBox = $("#earningBox");
		earningBox.empty();
		
		for(let evo of list) {
			
			let beat = evo.reportedEPS > evo.estimatedEPS ? '<td style="color:red; font-weight:bold;">&nbsp;&nbsp;&nbsp;&nbsp;'+evo.reportedEPS+'</td>' : '<td style="color:blue; font-weight:bold;">&nbsp;&nbsp;&nbsp;&nbsp;'+evo.reportedEPS+'</td>';
						
			let earningList = '<tr><td>'+evo.reportedDate+'</td>';
			earningList += ''+beat+'';
			earningList += '<td>&nbsp;&nbsp;&nbsp;&nbsp;'+evo.estimatedEPS+'</td></tr>';
			earningBox.append(earningList);
		}
	};


	/* 실적 조회 버튼 클릭 */
	$("#earning").on("click", function() {
		$("#earningModal").css("z-index", "2000");
		
		let symbol_val = $("#symbol").text();
		let url_val = "/comment/earning/"+symbol_val;
		
		$.getJSON(url_val, function(result) {
			print_earningList(result);
		}).fail(function(err) {
			console.log(err);
		});
		
	});


	/* 좋아요 추가  */
	$(function () {
		$(document).on("click", "#t_up", function(e) {
			e.preventDefault();
			let cNum = $(this).parent().parent("div.comment-footer").find("input[name='cNum']").val();
			let writer = 'jongviet@gmail.com';  /* 로그인한 이메일로 변경 필요! */
			
			let url_val = "/comment/cNum/"+cNum+"/"+writer + ".json";
			
			$.getJSON(url_val, function(result) {
				commentList($("#symbol").text());
			}).fail(function(err) {
				console.log(err);
			});
		});
	});
	
	/* 댓글 삭제 */
	$(function () {
			$(document).on("click", "#cmtDel", function(e) {
			e.preventDefault();
			
			/* writer 가져와서 검증 후 제거 */	
			let cmtWriter = $(this).parent().find("h5").text();
			let cNum = $(this).parent().parent().find("div.comment-footer").find("input[name='cNum']").val();
			let symbol_val = $("#symbol").text();
			
			if(cmtWriter == 'jongviet@gmail.com') {
			
				var cfmDel = confirm('정말 삭제하시겠습니까?');
				
				if(cfmDel) {
					$.ajax({
						url : "/comment/cNum/"+cNum,
						type : "delete"
					
					}).done(function(result) {
						alert('삭제되었습니다');
						commentList($("#symbol").text());
					});
				} else {
				return false;
				}
			} else {
				alert('삭제 권한이 없습니다');
				return false; //페이지 리로드 되지 않게 처리
			}
		});
	});


	
	/* 댓글 리스트 출력  */
	function print_commentList(list) {
		
		if(list.length == 0) {
			console.log('댓글 없음, 당황 금지');
		} else {
			let cmtBox = $("#cmtBox");
			cmtBox.empty();
			
			for(let cvo of list) {
				let cmtList = '<div class="d-flex flex-row comment-row"><div class="comment-text w-150"><h5>'+cvo.writer+'</h5>';
				cmtList += '<a href="" style="color:black" id="cmtDel"><i class="fa fa-trash-o"></i></a>';
				cmtList += '<i class="fa fa-minus-circle ml-2" style="color:black; cursor:pointer;" data-cNum="'+cvo.cNum+'" data-writer="'+cvo.writer+'"></i>';
				cmtList += '<div class="comment-footer"><span class="mr-2">'+cvo.regdate+'</span>'
				cmtList += '<span><a href="" id="t_up"><i class="fa fa-thumbs-o-up"></i></a></span><span id="t_count">'+cvo.t_up+'</span>';
				cmtList += '<input type="hidden" name="cNum" value="'+cvo.cNum+'"></div><p class="mt-1">'+cvo.comment+'</p></div></div><hr>';
				cmtBox.append(cmtList);
			}
		}
	};

	/* 댓글 리스트 가져오기  */
	function commentList(symbol) {
		let url_val = "/comment/symbol/"+symbol;
		
		$.getJSON(url_val, function(result) {
			print_commentList(result);
		}).fail(function(err) {
			console.log(err);
		});
	};

	/* 댓글 쓰기  */
	function posting() {
		let symbol_val = $("#symbol").text();
		let writer_val = 'jongviet@gmail.com';  /* 로그인한 이메일로 변경 필요! */
		let comment_val = $("#comment").val();

		if (comment_val == null || comment_val == '') {
			alert('종목에 대한 의견을 적어주세요.');
			return false;
		} else {
			let cmt_data = {
				symbol : symbol_val,
				writer : writer_val,
				comment : comment_val
			};
			$.ajax({
				url : "/comment/post",
				type : "post",
				data : JSON.stringify(cmt_data),
				contentType : "application/json; charset=utf-8"
			}).done(function(result) {
				commentList(symbol_val);
			}).fail(function(err) {
				console.log(err);
			}).always(function() {
				$("#comment").val("");
			});
		}
	};
	
	/* 댓글 쓰기 */
	$(document).on("click", "#posting", posting);
	
	/* 댓글 신고 */
    $(document).on("click", ".fa-minus-circle", function() {
        let cNum_val = $(this).data("cnum");
        let writer_val = $(this).data("writer");
        var reportContent = prompt('허위 신고는 제재의 대상이 될 수 있습니다. 신고하시려면 사유를 적어주세요.');
                
        if(reportContent != null) {
            let reportData = {
    				cNum : cNum_val,
    				writer : writer_val,
    				content : reportContent
    			};
    			$.ajax({
    				url : "/comment/report",
    				type : "post",
    				data : JSON.stringify(reportData),
    				contentType : "application/json; charset=utf-8"
    			}).done(function(result) {
    				alert('정상 신고 되었습니다. 관리자 검토 후 조치될 예정입니다.');
    				commentList($("#symbol").text());
    			}).fail(function(err) {
    				console.log(err);
    			})
        } else {
        	return false;
        }
    });
	
	/* 페이지 로딩 후 댓글 리스트 */
	$(function() {
		commentList($("#symbol").text());
	});


/* Detail page 댓글 끝 */

