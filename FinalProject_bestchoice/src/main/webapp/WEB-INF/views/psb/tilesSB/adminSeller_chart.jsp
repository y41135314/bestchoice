<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
 #adminSellerChart {
 	border: solid 1px black;
 	min-height: 500px;   
 	/* margin-top: 200px; */
 	margin-top: 10px;
 	margin-bottom: 30px;
 }
 
 #pSeller {
	background-color: #555555;
	color: #B7B7B7;
	}

 #sellerChartBtn{
 	color: #F7323F;
 }
 
</style>

<script>
	$(document).ready(function(){
		
		$("#divSeller").css("border-bottom", "solid 1px #555555");
		$("#divHotel").css("border", "none");
		$("#divSeller2").show();  
		$("#divHotel2").hide();
		
		$("#sellerChartBtn").bind("mouseover", function(){	
			$("#sellerChartBtn").css({"color":"white","background-color":"#F7323F"});
		})
		$("#sellerChartBtn").bind("mouseout", function(){	
			$("#sellerChartBtn").css({"color":"#F7323F","background-color":"rgba(225,225,225,0.0)"});
		})

	})
</script>

<div id="adminSellerChart">
판매자차트
</div>   