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
 
 .hotelchart_table > table {   
	border-collapse: collapse;
	border: solid 1px black;
	margin: 0 auto;
	width: 80%;
}
     
.hotelchart_table td {   
	border: solid 1px black;
}
</style>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

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

		chart_Location();
		chart_Grade();
	})
	
	function chart_Location(){
		$.ajax({
		   url: "<%= request.getContextPath() %>/chartHotelLocation.bc",
		   dataType: "JSON",
		   success:function(json){
			   
			   var resultArr = [] ; // 자바스크립트에서의 배열 선언 
				
			   var html = "<table><tr style='border: solid 1px black;text-align: center; font-weight: bold; background-color: #eee;' > "
			       html += "<td>위치(시,도)</td><td>COUNT</td><td>PERCENT</td></tr>"			
			   
			   for (var i = 0; i < json.length; i++) {
				   
			   		if ( json[i].hotel_addr1 != null ) {
						// 자바스크립트에서의 객체 선언 
						
						var obj = { name : json[i].hotel_addr1 , 
								    y: Number(json[i].PERCENTAGE) };  // ★ DB에서 받을 때 문자열로 가져왔기 때문에, 다시 숫자로 바꿔야 한다!!!
						   
						// 배열 속에 객체 넣기   [{},{},{},...]
						resultArr.push(obj); 
								    	 
						html += "<tr style='border: solid 1px black; text-align: center;'><td style='font-weight: bold;background-color: #eee;'>" + json[i].hotel_addr1  + "</td>"
						html += "<td>" + json[i].count + "&nbsp;개</td><td>" + Number(json[i].PERCENTAGE) + "&nbsp;%</td></tr>"	
					}
			   		
			   }
			       
			   html += "</table>"
			   $("#LocationTable").html(html);
			   
			   var pieColors = (function () {
				   var colors = [];
				   colors.push("#79a6d2","#ff4d4d","#70db70","#d24dff","#d2ff4d","#9494b8","#ffd24d",
						        "#4dffd", "#4dd2ff", "#ff4dff","#c3c388","#ff4dc4","#94b8b8","#a6a6a6",
						        "#a64dff","#666600"
				                );
				    return colors;
				}());
				
			   // Build the chart
			   Highcharts.chart('hotelLocation', {
			       chart: {
			           plotBackgroundColor: null,
			           plotBorderWidth: null,
			           plotShadow: false,
			           type: 'pie'
			       },
			       title: {
			           text: ''
			       },
			       tooltip: {
			           pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
			       },
			       accessibility: {
			           point: {
			               valueSuffix: '%'
			           }
			       },
			       plotOptions: {
			           pie: {
			               allowPointSelect: true,
			               cursor: 'pointer',
			               colors: pieColors,
			               dataLabels: {
			                   enabled: true,
			                   format: '<span>{point.name}</span><br>{point.percentage:.1f} %',
			                   distance: -50,
			                   filter: {
			                       property: 'percentage',
			                       operator: '>',
			                       value: 4
			                   }
			               }
			           }
			       },
			       series: [{
			           name: '비율',
			           data: resultArr
			       }]
			   });
			
			   
		   },
		   error: function(request, status, error){
		   	 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   } 
	   })   
	};
	
	function chart_Grade() {
		$.ajax({
		   url: "<%= request.getContextPath() %>/chartHotelGrade.bc",
		   dataType: "JSON",
		   success:function(json){
			   
			   var resultArr = [] ; // 자바스크립트에서의 배열 선언 
				
			   var html = "<table><tr style='border: solid 1px black;text-align: center; font-weight: bold; background-color: #eee;' > "
			       html += "<td>등급</td><td>COUNT</td><td>PERCENT</td></tr>"			
			   
			   for (var i = 0; i < json.length; i++) {
				   
			   		if ( json[i].hotel_Category != null ) {
						// 자바스크립트에서의 객체 선언 
						
						var grade = "";
						if(json[i].hotel_Category == 0 ){
							var obj = { name : "일반" , 
									    y: Number(json[i].PERCENTAGE) };
							grade = "일반"
							
						} else if(json[i].hotel_Category == 1 ){
							var obj = { name : "특급" , 
								           y: Number(json[i].PERCENTAGE) };
							grade = "특급"
						} else {
							var obj = { name : "특1급" , 
							           y: Number(json[i].PERCENTAGE) };
							grade = "특1급"
					    }
						   
						// 배열 속에 객체 넣기   [{},{},{},...]
						resultArr.push(obj); 
								    	 
						html += "<tr style='border: solid 1px black; text-align: center;'><td style='font-weight: bold;background-color: #eee;'>" + grade  + "</td>"
						html += "<td>" + json[i].count + "&nbsp;개</td><td>" + Number(json[i].PERCENTAGE) + "&nbsp;%</td></tr>"	
					}
			   		
			   }
			       
			   html += "</table>"
			   $("#GradeTable").html(html);
			   
			   var pieColors = (function () {
				   var colors = [];  
				   colors.push("#b3b3b3","#e6c300","#996600");
				    return colors;
				}());
				
			   // Build the chart
			   Highcharts.chart('hotelGrade', {
			       chart: {
			           plotBackgroundColor: null,
			           plotBorderWidth: null,
			           plotShadow: false,
			           type: 'pie'
			       },
			       title: {
			           text: ''
			       },
			       tooltip: {
			           pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
			       },
			       accessibility: {
			           point: {
			               valueSuffix: '%'
			           }
			       },
			       plotOptions: {
			           pie: {
			               allowPointSelect: true,
			               cursor: 'pointer',
			               colors: pieColors,
			               dataLabels: {
			                   enabled: true,
			                   format: '<span>{point.name}</span><br>{point.percentage:.1f} %',
			                   distance: -50,
			                   filter: {
			                       property: 'percentage',
			                       operator: '>',
			                       value: 4
			                   }
			               }
			           }
			       },
			       series: [{
			           name: '비율',
			           data: resultArr
			       }]
			   });
			
			   
		   },
		   error: function(request, status, error){
		   	 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   } 
	   })
	};
</script>

<div id="adminHotelChart">
	<div style="float: left; min-height: 608px; margin-left: 35px; width: 45%; border: solid 1px gray; margin-bottom: 30px; padding: 10px;" > 
		<label style="font-size: 16px;">◎ 호텔등급 점유율  </label>
		<div id="hotelGrade"></div>
		<div id="GradeTable" class="hotelchart_table" style="margin: 0 auto; padding-top: 50px; margin-bottom: 50px;"></div>
	</div> 
	
	<div style="float: right; min-height: 608px; width: 45%; border: solid 1px gray; margin-right: 35px; margin-bottom: 30px; padding: 10px;" > 
		<label style="font-size: 16px;">◎ 위치 점유율 </label>
		<div id="hotelLocation"></div>
		<div id="LocationTable" class="hotelchart_table" style="margin: 0 auto; padding-top: 50px; margin-bottom: 50px;"></div>
	</div>
	
	 
</div>   