<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>      
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua&display=swap" rel="stylesheet">

<style type="text/css">

.sidenav {
	margin-top: 15px;
	font-family: 'Jua', sans-serif, 돋움;
}
.sidenav a {
	display: block;
	text-decoration: none;
/* 	background-color: white;*/
	color: #F7323F; 
	color: rgba(0,0,0,0.56);
	width: 150px;
	height: 30px;
	font-weight: bold;  
	text-align: center;
	margin-bottom: 15px;
	font-size: 24px;  
}  

.sidenav a:hover {
	color: white;
	background-color: #F7323F;
	vertical-align: middle !important;
}

.sideDropdown {
	width: 150px;
	height: 30px;
	font-weight: bold;
	background-color: white;
	color: rgba(0,0,0,0.56);
	text-align: center;
	margin-bottom: 15px;
	font-size: 24px !important;
}
   
.sideDropdown:hover {
	cursor: pointer;
	background-color: #555555;  
	color: #B7B7B7;
}   
 
.sideDropdown-container a {
	color: rgba(0,0,0,0.56);
	font-size: 24px;
	vertical-align: middle !important;
}
        
.sideBtn {
	margin-bottom: 20px;
}     
#commentBtn:hover{
	color: white;
	background-color: #F7323F;
}  
</style>
    
<script>
	$(document).ready(function(){
		$(".sideDropdown-container").hide();
		
		$(".sideDropdown").click(function(){
			
			$(this).next().toggle();
			
			if ( $(this).next().css('display') != "none" ){
				$(this).parent().css({"border-bottom":"solid 1px #555555"});
				$(this).css({"color":"#B7B7B7"});
			}
			else{
				$(this).parent().css({"border":"none"});
				$(this).css({"background-color":"white","color":"rgba(0,0,0,0.56)"});
			}
		})  
		  
	})
</script>   
    
<div style="" class="sidenav">
	<div class="sideBtn" id="divSeller" style="width: 150px;">  
	<p id="pSeller" class="sideDropdown">판매자&nbsp;&nbsp;<i class="fa fa-caret-down"></i></p>
		<div class="sideDropdown-container" id="divSeller2">
		  <a id="sellerListBtn" href="<%=ctxPath%>/adminSeller_list.bc">판매자 리스트 </a>
		 <%--  <a id="sellerChartBtn" href="<%=ctxPath%>/adminSeller_chart.bc">그래프/통계</a> --%>
		</div>
	</div> 
	
	<div class="sideBtn" id="divHotel" style="width: 150px;">
		<p id="pHotel" class="sideDropdown">호텔&nbsp;&nbsp;<i class="fa fa-caret-down"></i></p>
		<div class="sideDropdown-container" id="divHotel2">
		  <a id="hotelListBtn" href="<%=ctxPath%>/adminHotel_list.bc">호텔  리스트 </a>
		  <a id="hotelChartBtn" href="<%=ctxPath%>/adminHotel_chart.bc">호텔 통계</a>
		</div>
	</div>
	
	<a class="sideBtn"  id="commentBtn" href="<%=ctxPath%>/adminCommentBoard.bc">관리자 게시판</a>
	
</div>