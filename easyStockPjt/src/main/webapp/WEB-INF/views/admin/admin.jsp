<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../common/header.jsp" />
<jsp:include page="../common/nav.jsp" />

<div class="col-lg-12 col-md-12 mx-auto">
	<h3 class="float-left grayFontBold mt-1">신고내역</h3>
	<h6 class="grayFont mb-4" style="clear:both;">이용 회원들이 신고한 내역 및 신고 당한 댓글 내용을 확인할 수 있습니다. 관리자 확인 후 적절한 조치를 취할 수 있습니다.</h6>
	<table class="table table-hover text-center">
		<thead class="titleBackground">
			<tr class="greenLineBold">
				<th class="grayFontBold">코멘트번호</th>
				<th colspan="3" class="grayFontBold">신고내용</th>
				<th class="grayFontBold">조치사항</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${r_list}" var="rvo">
				<tr>
					<td class="grayFont">
					<a data-toggle="modal" data-target="#commentModal" id="comment" href="#" class="greenFontBold">${rvo.cNum }</a>
					</td>
					<td colspan="3" class="grayFont">${rvo.content}</td>
					<td class="text-center">
						<button type="button" class="btn mr-1 btn-sm btnBackground" id="accepted">댓글삭제</button>
						<button type="button" class="btn btn-sm btnBackground" id="denied">사유불충분</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="5" class="text-center"><jsp:include page="../common/paging.jsp" /></td>
			</tr>
		</tfoot>
	</table>
</div>
<hr>
<div class="modal fade" id="commentModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true"
	data-backdrop="static" style="z-index: -1;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title greenFontBold" id="exampleModalLabel"></h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body commentBox">
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btnBackground" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<div class="col-lg-12 col-md-12 mx-auto">
	<h3 class="float-left grayFontBold mt-3">신규 종목 데이터 등록</h3>
	<h6 class="grayFont mb-4" style="clear:both;">Symbol을 기준으로 회사 개요 및 5년치 earning 데이터를 등록합니다. 신규 상장되어 earning 데이터가 부족한 기업이 있을 수 있습니다.</h6>
	<div class="form-group mb-3">
		<form class="form-inline">
			<input type="text" id="input">
			<button type="button" class="btn btn-md ml-1 btnBackground" id="inputBtn">등록하기</button>
		</form>
	</div>
</div>
<hr>
<div class="col-lg-12 col-md-12 mx-auto">
	<h3 class="float-left grayFontBold mt-3">전일 종가 및 Member Account 현재가 업데이트</h3>
	<h6 class="grayFont mb-4" style="clear:both;">3월 말~10월 말까지는 서머타임의 적용을 받아, 한국 시각 기준 오전 7시 이후부터 전일 종가 업데이트가 가능합니다.</h6>
	<button type="button" id="priceUpdate" class="btn btnBackground">전일 종가 업데이트</button>
	<button type="button" id="accountUpdate" class="btn btnBackground">Member Account 현재가 업데이트</button>
</div>
<script src="/resources/bootstrap/js/admin.js"></script>
<jsp:include page="../common/footer.jsp" />


