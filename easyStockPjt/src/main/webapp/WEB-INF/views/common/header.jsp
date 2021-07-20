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
  <script src="/resources/bootstrap/js/bundle.js"></script>

  <!-- favicon -->
  <link rel="icon" type="image/x-icon" href="/resources/assets/img/favicon.ico" />

  <!-- 아이콘  -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://kit.fontawesome.com/10e6240b9d.js" crossorigin="anonymous"></script>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  
</head>
<script>
/* session */
const ses = "<%=(String)session.getAttribute("ses")%>";
const ses_id = "<%=(String)session.getAttribute("ses_id")%>";
const ses_tester = "<%=(String)session.getAttribute("ses_tester")%>";

/* 쿠키 */
function setCookie(cName, cValue, cDay){
var expire = new Date();
expire.setDate(expire.getDate() + cDay);
cookies = cName + '=' + escape(cValue) + '; path=/ ';
if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
document.cookie = cookies;
}

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