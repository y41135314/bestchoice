<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
 #adminMember {
 	/* border: solid 1px black; */
 	min-height: 500px;   
 	/* margin-top: 200px; */
 	margin-top: 10px;
 	margin-bottom: 30px;
 }
 
 #adminMemberChartBTN{
 	color: #F7323F;
 }
 
</style>

<script>
	$(document).ready(function(){
	
		$("#adminMemberListBTN").bind("mouseover", function(){	
			$("#adminMemberListBTN").css({"color":"white","background-color":"#F7323F"});
		})
		$("#adminMemberListBTN").bind("mouseout", function(){
			$("#adminMemberListBTN").css({"color":"rgba(0,0,0,0.56)","background-color":"white"});
		}) 
		
		$("#adminMemberChartBTN").bind("mouseover", function(){	
			$("#adminMemberChartBTN").css({"color":"white","background-color":"#F7323F"});
		})
		$("#adminMemberChartBTN").bind("mouseout", function(){	
			$("#adminMemberChartBTN").css({"color":"#F7323F","background-color":"white"});
		})

	})
</script>

<div id="adminMember">
	<div style="float: left; width: 45%; border: solid 1px red; margin-bottom: 30px;" > 
		<label style="font-size: 16px;">◎ 연령대 점유율 </label>
		<div style="">
		차트
		</div>
	</div>
	
	<div style="float: right; width: 45%; border: solid 1px blue; margin-right: 70px; margin-bottom: 30px;"> 
		<label style="font-size: 16px;">◎ 성별 점유율  </label>
		<div>
		차트
		</div>
	</div>  
	
	<div style="clear: both; border: solid 1px gray; "> 
		<label style="font-size: 16px;">◎ 월별 회원수 추이</label>
		<div>
		차트
		</div>
		<div style="border: solid 1px black; margin-bottom: 15px;">월 연령대/성별 점유율 테이블 </div>
	</div>
	
	
</div>   