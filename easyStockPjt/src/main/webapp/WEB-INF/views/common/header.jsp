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
  
  <!-- 차트 -->
  <script type="module" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.4.1/chart.min.js"></script>

  <!-- 아이콘  -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">  
  <script src="/resources/bootstrap/js/bundle.js"></script>
  <script type="application/javascript">
    /**
     * Init Alpha Vantage with your API key.
     *
     * @param {String} key
     *   Your Alpha Vantage API key.
     */
    const alpha = alphavantage({ key: '72FY7BZXTG91TJBV' });
  </script>
</head>
<body>
<div class="jumbotron text-center" style="margin-bottom:0">
  <h1>HEADER</h1>
</div>