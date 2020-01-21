<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>      
<style>
.sidenav {
	margin-top: 15px;
	font-family: Arial, Helvetica, sans-serif, 돋움;
	font-size: 20px;  
}
.sidenav a {
	display: block;
	text-decoration: none;
	background-color: white;
	color: #F7323F;
	width: 150px;
	height: 30px;
	font-weight: bold;
	text-align: center;
	margin-bottom: 15px;
}  

.sidenav a:hover {
	color: white;
	background-color: #F7323F;
}

.sideDropdown {
	width: 150px;
	height: 30px;
	font-weight: bold;
	background-color: white;
	color: red;
	text-align: center;
	padding: 5px;
	margin-bottom: 15px;
}
   
.sideDropdown:hover {
	color: white;
	background-color: #F7323F;
	cursor: pointer;
	padding: 3px 0 ;
}   
  
.sideDropdown-container a {
	color: black;
	font-size: 18px;
}
   
</style>
    
<script>
	$(document).ready(function(){
		$(".sideDropdown-container").hide();
		
		$(".sideDropdown").click(function(){
			$(this).next().toggle();
		})
		   
	})
</script>
    
<div style="" class="sidenav">
	<a href="<%=ctxPath%>/salesStatistic.bc">매출 통계</a>

	<p class="sideDropdown">회원별 매출&nbsp;&nbsp;<i class="fa fa-caret-down"></i></p>
	<div class="sideDropdown-container">
	  <a href="<%=ctxPath%>/salesStatistic_average.bc">매출 평균</a>
	  <a href="<%=ctxPath%>/salesStatistic_chart.bc">매출 추이</a>
	</div>
	  
	<p class="sideDropdown">상품별 매출&nbsp;&nbsp;<i class="fa fa-caret-down"></i></p>
	<div class="sideDropdown-container">
	  <a href="#">호텔 종류</a>
	  <a href="#">수용 인원</a>
	</div>
	
	
	
</div>