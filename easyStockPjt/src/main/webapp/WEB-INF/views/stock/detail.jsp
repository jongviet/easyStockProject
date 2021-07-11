<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<h3 style="float: left">${svo.fullName}</h3>
<h5 style="float: right;">Avg-Target : ${svo.avg_target} USD</h5>

<div id="canvasDiv">
	<canvas id="myChartOne" style="background-color: white;"></canvas>
</div>
<div class="text-center mt-2">
	<button type="button" class="btn btn-light btn-md" id="daily">Daily</button>
	<button type="button" class="btn btn-light btn-md" id="monthly">Monthly</button>
</div>
<div class="text-right">
	<a data-toggle="modal" data-target="#earningModal" id="earning"
		href="#">최근실적조회</a>
</div>

<div>
	<table class="table table-hover mt-3">
		<tbody>
			<tr>
				<td>Symbol</td>
				<td id="symbol" class="bold">${svo.symbol}</td>
				<td>Name</td>
				<td class="bold">${svo.fullName}</td>
			</tr>
			<tr>
				<td>Sector</td>
				<td class="bold">${svo.sector}</td>
				<td>MarketCapitalization</td>
				<td class="bold"><fmt:formatNumber
						value="${svo.m_capitalization}" pattern="#,###" />&nbsp;USD</td>
			</tr>
			<tr>
				<td>PER</td>
				<td class="bold">${svo.per }</td>
				<td>EPS</td>
				<td class="bold">${svo.eps}</td>
			</tr>

			<tr>
				<td>Insiders holding</td>
				<td class="bold">${svo.pxt_insiders}</td>
				<td>Institutions holding</td>
				<td class="bold">${svo.pxt_institutions}</td>
			</tr>
			<tr>
				<td>52w_high</td>
				<td class="bold">${svo.year_high}</td>
				<td>52w_low</td>
				<td class="bold">${svo.year_low}</td>
			</tr>
		</tbody>
	</table>
</div>

<!-- 댓글  작성 -->
<h2 class="float-left">Conversations</h2>
<div class="form-group">
	<form>
		<div class="input-group mb-3">
			<input type="text" class="form-control" id="comment"
				placeholder="${svo.fullName}에 대한 의견을 적어주세요.">
			<div class="input-group-append">
				<button class="btn btn-info" id="posting" style="width: 150px;"
					type="button">POST</button>
			</div>
		</div>
	</form>
</div>

<div id="cmtBox"></div>


<!-- 실적 modal -->
<div class="modal fade" id="earningModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true"
	data-backdrop="static" style="z-index: -1;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">${svo.fullName}</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				
				<table class="table table-hover">
					<thead>
						<tr>
							<th>reportedDate</th>
							<th>reportedEPS</th>
							<th>estimatedEPS</th>
						</tr>
					</thead>
					<tbody id="earningBox">
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" data-dismiss="modal">Close</button>

			</div>
		</div>
	</div>
</div>


<script>
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
	
	/* 댓글 리스트 출력  */
	function print_commentList(list) {
		
		if(list.length == 0) {
			console.log('댓글 없음, 당황 금지');
		} else {
			let cmtBox = $("#cmtBox");
			cmtBox.empty();
			
			for(let cvo of list) {
				let cmtList = '<div class="d-flex flex-row comment-row"><div class="comment-text w-150">';
				cmtList += '<h5>'+cvo.writer+'</h5><div class="comment-footer"><span class="mr-2">'+cvo.regdate+'</span>';
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
	
	/* 페이지 로딩 후 댓글 리스트 */
	$(function() {
		commentList($("#symbol").text());
	});
</script>
<jsp:include page="../common/footer.jsp" />