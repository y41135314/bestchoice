<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
 #adminHotelChart {
 	/* border: solid 1px black; */
 	min-height: 500px;   
 	/* margin-top: 200px; */
 	margin-top: 10px;
 	margin-bottom: 30px;
 }
 #pHotel {
	background-color: #555555;
	color: #B7B7B7;
}

 #hotelChartBtn{
 	color: #F7323F;
 }
</style>

<script>
	$(document).ready(function(){
		
		$("#divHotel").css("border-bottom", "solid 1px #555555");
		$("#divSeller").css("border", "none");
		$("#divHotel2").show();  
		$("#divSeller2").hide();  
		
		$("#hotelChartBtn").bind("mouseover", function(){	
			$("#hotelChartBtn").css({"color":"white","background-color":"#F7323F"});
		})
		$("#hotelChartBtn").bind("mouseout", function(){	
			$("#hotelChartBtn").css({"color":"#F7323F","background-color":"rgba(225,225,225,0.0)"});
		})

	})
</script>

<div id="adminHotelChart">
	<div style="border: solid 1px red; margin-bottom: 30px;" > 
		<label style="font-size: 16px;">◎ 위치 점유율 </label>
		<div style="">
		차트
		</div>
	</div>
	
	<div style="border: solid 1px blue; margin-bottom: 30px;"> 
		<label style="font-size: 16px;">◎ 호텔등급 점유율  </label>
		<div>
		차트
		</div>
	</div>  
</div>   