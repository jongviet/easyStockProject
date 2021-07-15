<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Spring</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="/resources/bootstrap/css/custom.css">
  <script src="/resources/bootstrap/js/jquery-3.6.0.min.js"></script>
  <script src="/resources/bootstrap/js/popper.min.js"></script>
  <script src="/resources/bootstrap/js/bootstrap.min.js"></script>
  
  <!-- favicon -->
  <link rel="icon" type="image/x-icon" href="/resources/assets/img/favicon.ico" />

  <!-- 아이콘  -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">  
</head>
<script>
const ses = "<%=(String)session.getAttribute("ses")%>";
const ses_id = "<%=(String)session.getAttribute("ses_id")%>";
const ses_tester = "<%=(String)session.getAttribute("ses_tester")%>";

/* 쿠키 */
//쿠키 생성 함수
function setCookie(cName, cValue, cDay){
var expire = new Date();
expire.setDate(expire.getDate() + cDay);
cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
document.cookie = cookies;
}

//쿠키 가져오기 함수
function getCookie(cName) {
cName = cName + '=';
var cookieData = document.cookie;
var start = cookieData.indexOf(cName);
var cValue = '';
if(start != -1){
start += cName.length;
var end = cookieData.indexOf(';', start);
if(end == -1)end = cookieData.length;
cValue = cookieData.substring(start, end);
}
return unescape(cValue);
}

</script>
<body>
<div class="jumbotron text-center" style="margin-bottom:0">

<a href="/stock/list">종목리스트 - 완료</a><br>
<a href="#">메인페이지 - 완료</a><br>
<a href="/admin">관리자페이지 : 종목 등록, 댓글 처리(신고 들어온 내용에 대해 조치 or 미조치 가능) - 거의 완료</a><br>
<a href="#">주식 거래소 : 보유종목 현황 테이블(각 종목별 손익, 수익률, 예수금, investing 형식), 매수&매도 버튼, 환전(정회원만 가능), CNBC 뉴스(파이썬)</a><br>

</div>