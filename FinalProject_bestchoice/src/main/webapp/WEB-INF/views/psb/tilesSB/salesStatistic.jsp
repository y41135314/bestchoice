<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<% String ctxPath = request.getContextPath(); %>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
  
<style type="text/css">
 #salesStatistic {
 	/* border: solid 1px black; */
 	min-height: 500px;   
 	/* margin-top: 200px; */
 	margin-top: 10px;
 	margin-bottom: 30px;
 }
 .allStat {
 	/* padding: 10px; */
 }
 .salesLabel {
 	font-weight: bold;
 	font-size: 17px;
 	margin-bottom: 10px;
 }
 .salesTable tr, .salesTable th, .salesTable td {
 	border: solid 1px black;
 }
 	
 .salesTable {
  	border-collapse: collapse;
  }  
  
  .salesTable th {
  	background-color: #FAFAFA;
  	text-align: center;
  }
  
  .salesTable th, .salesTable td {
   	padding: 5px;
  }
  
  #tdMoney{
  	text-align: right;
  }
  
  #salesGenderTable th, #salesAgeTable th {
  	text-align: center;           
  }
  #salesGenderTable td, #salesAgeTable td {
  	text-align: right;           
  	width: 100px;
  }               
</style>

<script>
//viewPrice
	$(document).ready(function(){
	
		$("#viewPrice").click(function(){
			
			   var startDatelth = $("#startDate").val().length;
			   var endDatelth = $("#endDate").val().length;
			   
			   if( startDatelth == 0 || endDatelth == 0){
				   alert("날짜를 입력하세요");
				   return;
			   }
			   else {
					$.ajax({  
						url: "<%= request.getContextPath() %>/viewPrice.bc" ,
						type: "GET",
						data:{ "startDate": $("#startDate").val(), "endDate": $("#endDate").val() },
						dataType: "JSON",
						success: function(json){
							
							var item = json.searchPrice;
							
							var searchPriceVal = numberDot(item);
							
							$("#searchPriceVal").html(searchPriceVal);
							
						},
						error: function(request, status, error){
							alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}	
					}) 
			   }
		})
		
		chart_MonthlyPrice();
		
	}) // end of document==========================
	
	// AJAX 로 받은 값 천 단위 콤마 함수 
	function numberDot(x){
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	function chart_MonthlyPrice(){
		$.ajax({
			url: "<%= request.getContextPath() %>/chart_MonthlyPrice.bc",
			dataType: "JSON",
			success:function(json){
				
				var resultArrPrice = [] ; 
				var resultArrCount = []; 
				
				var Day = "";
				for (var i = 0; i < json.length; i++) {		
					Day += json[i].MONTH;
				}	
				
			    var bool = Day.includes('2019-03');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {    
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2019-03' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2019-04');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2019-04' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2019-05');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2019-05' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2019-06');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2019-06' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2019-07');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2019-07' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2019-08');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2019-08' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2019-09');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2019-09' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2019-10');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2019-10' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2019-11');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2019-11' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2019-12');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2019-12' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2020-01');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2020-01' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2020-02');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2020-02' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
				}
				
				Highcharts.setOptions({

					lang: {

						thousandsSep: ','

					}

				});
				
				Highcharts.chart('chart_MontlyPrice', {
				    chart: {
				        zoomType: 'xy'
				    },
				    title: {
				        text: ''
				    },
				    subtitle: {
				        text: ''
				    },
				    xAxis: [{
				        categories: ['2019-03','2019-04','2019-05','2019-06','2019-07',
		        	          '2019-08','2019-09','2019-10','2019-11','2019-12','2020-01','2020-02'],
				        crosshair: true
				    }],
				    yAxis: [{ // Primary yAxis
				        labels: {
				            format: '{value:,.0f}원',
				            style: {
				                color: '#cc3300'
				            }
				        },
				        title: {
				            text: '매출액',
				            style: {
				                color: '#cc3300'
				            }
				        }
				    }, { // Secondary yAxis
				        title: {
				            text: '예약건수',
				            style: {
				                color: 'gray'
				            }
				        },
				        labels: {
				            format: '{value} 건',
				            style: {
				                color: 'gray'    
				            }
				        },
				        opposite: true
				    }],
				    tooltip: {
				        shared: true
				    },
				    legend: {
				        layout: 'vertical',
				        align: 'left',
				        x: 120,
				        verticalAlign: 'top',
				        y: 100,
				        floating: true,
				        backgroundColor:
				            Highcharts.defaultOptions.legend.backgroundColor || // theme
				            'rgba(255,255,255,0.25)'
				    },
				    series: [{
				        name: '예약건수',
				        type: 'column',
				        yAxis: 1,
				        data: resultArrCount,
				        tooltip: {
				            valueSuffix: ' 건'
				        },
			            color: '#d1d1e0' 

				    }, {
				        name: '매출액',
				        type: 'spline',
				        data: resultArrPrice,  
				        tooltip: {
				            valueSuffix: '원'
				        },
				        color: '#F7323F'
				    }]
				});
				
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		})
	}
	
</script>

<div id="salesStatistic">  
	<div class="allStat" style="border: solid 1px red; padding: 10px;">
		<label class="salesLabel">◎ 누적 매출액</label>&nbsp;
		<input type="button" value="예약내역 조회" onclick="location.href='<%=request.getContextPath()%>/adminReservList.bc'" style="font-size: 8pt;"/> 
		<div>
			<table class="salesTable" id="salesMainTable">
				<thead>
					<tr>
						<th>총 누적 매출액</th>
						<th>2019년 누적 매출액</th>
						<th>2020년 누적 매출액</th>
						<th>당월 누적 매출액</th>
						<th>일매출액</th>
						<th><input type="date" id="startDate" style="width: 130px;"/> ~ <input type="date" id="endDate" style="width: 130px;"/>&nbsp;&nbsp;
						 <input type="button" id="viewPrice" value="매출조회" style="font-size: 8pt; font-weight: normal;"/></th>
					</tr>
				</thead>
				<tbody>
					<tr style="text-align: right;">
						<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${toal_Price}" />원</td>
						<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${last_yearPrice}" />원</td>
						<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${yearPrice}" />원</td>
						<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${monthPrice}" />원</td>
						<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${dayPrice}" />원</td>
						<td><span id="searchPriceVal"></span>원</td>
					</tr>
				</tbody>
			</table>
		</div>
	
		<div style="margin-top: 20px; border: solid 1px black;" id="chart_MontlyPrice">
		
		</div>     
	</div>
	
	  
	<div class="allStat" style="margin-top: 30px; border: solid 1px blue; padding: 10px;">  
		<div>
			<label class="salesLabel" >◎ 회원별 매출액</label>&nbsp;
			<input type="button" value="연령대/성별 점유율" onclick="location.href='<%=request.getContextPath()%>/adminMember_chart.bc'" style="font-size: 8pt;"/> 
		</div>  
		
		<table class="salesTable" id="salesGenderTable" style="float: left; height: 100px; min-width: 200px;">
			<thead>
				<tr>
					<th colspan="5" style="text-align: left; background-color: white;">▶ 성별 기준
					<!-- <input type="button" value="매출합계추이" style="font-size: 8pt; font-weight: normal; float: right;"/> --></th>
				</tr>
			</thead>
			<tbody>
				<tr>                 
					<td style="font-size: 8pt; text-align: right;"><!-- 단위 : 원 --></td>   
					<th>남자</th>
					<th>여자</th>
				</tr>   
				<tr style="text-align: right;">
					<th style="font-size: 10pt;"><span></span>결제건수 </th>
					<td>${M_RCount}건  </td>
					<td>${F_RCount}건   </td>
				</tr>
				<tr>
					<th style="font-size: 10pt;"><span></span>총 매출액</th>
					<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${M_totalPrice}" />원  </td>
					<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${F_totalPrice}" />원  </td>
				</tr>
				<tr>
					<th style="font-size: 10pt;"><span></span>1인 평균</th>
					<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${M_AVG}" />원 </td>
					<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${F_AVG}" />원 </td>
				</tr>
			</tbody>
		</table>     
		<table class="salesTable" id="salesAgeTable" style="float: right; height: 100px; margin-right: 20%; " >
			<thead>  
				<tr>
					<th colspan="8" style="text-align: left; background-color: white;">▶ 연령대별 기준
					<!-- <input type="button" value="매출합계추이" style="font-size: 8pt; font-weight: normal; float: right;"/> -->
					</th>
				</tr>
				<tr>
					<td style="font-size: 8pt; text-align: right;"><!-- 단위 : 원 --></td>      
					<th>0~10대</th>
					<th>20대</th>
					<th>30대</th>
					<th>40대</th>
					<th>50대</th>          
					<th>60대</th>
					<th>70대 이상</th>
				</tr>
			</thead>
			<tbody>
				<tr style="text-align: right;">
					<th style="font-size: 10pt;"><span></span>결제건수</th>
				    <td>${RCount_10} 건  </td>
					<td>${RCount_20} 건  </td>
					<td>${RCount_30} 건  </td>
					<td>${RCount_40} 건  </td>
					<td>${RCount_50} 건  </td>
					<td>${RCount_60} 건  </td>
					<td>${RCount_70} 건  </td> 
				</tr>
				<tr>
					<th style="font-size: 10pt;"><span></span>총 매출액</th>
				    <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice_10}" /> </td>
					<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice_20}" /></td>
					<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice_30}" /></td>
					<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice_40}" /></td>
					<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice_50}" /></td>
					<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice_60}" /></td>
					<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice_70}" /></td>
				</tr>
				<tr style="text-align: right;">
					<th style="font-size: 10pt;"><span></span>1인 평균</th>
					<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${AVG_10}" />  </td> 
					<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${AVG_20}" /> </td> 
					<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${AVG_30}" /> </td> 
				    <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${AVG_40}" /> </td> 
					<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${AVG_50}" /> </td> 
					<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${AVG_60}" /> </td> 
					<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${AVG_70}" /> </td> 
				</tr>
			</tbody>
		</table>
	
		<div style="clear: both; padding-top: 20px;">
		<!-- 여자 고객 매출 합계 추이 + 남자 고객 매출 합계 추이 
		or 
		연령대별 고객 매출 합계 추이 -->    
		</div> 

  	</div>   
  	
  	<div class="allStat" style="margin-top: 30px; border: solid 1px green; padding: 10px;">  
		<div>
			<label class="salesLabel" >◎ 상품별 매출액</label> 
			<br/>
			<label>&nbsp;> 기간선택&nbsp;&nbsp;</label><input type="date" style="width: 130px;"/> ~ <input type="date" style="width: 130px;"/> 
		</div>  
		
		<div style="text-align: center; width: 100%; margin-top: 10px; vertical-align: bottom;">
			<div style="display: inline-block; width: 30%; min-height: 300px; margin-right: 20px; ">
				<table class="salesTable" style="float: left; width: 100%; ">
					<thead>
						<tr>
							<th colspan="2" style="background-color: white;">호텔등급 기준</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>등급</th>
							<th>매출총액</th>
						</tr>   
						<tr>
							<td>5성</td>
							<td id="tdMoney"><span></span>원  </td>
						</tr>
						<tr>
							<td>4성</td>
							<td id="tdMoney"><span></span>원  </td>
						</tr>
						<tr>
							<td>3성</td>
							<td id="tdMoney"><span></span>원  </td>
						</tr>
						<tr>
							<td>2성미만</td>
							<td id="tdMoney"><span></span>원  </td>
						</tr>
					</tbody>
				</table>     
			</div>
			
			<div style="display: inline-block; width: 30%; min-height: 300px;  margin-right: 20px;">
				<table class="salesTable" style="float: left; width: 100%;">
					<thead>
						<tr>
							<th colspan="2" style="background-color: white;">수용인원 기준</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>수용인원</th>
							<th>매출총액</th>
						</tr>   
						<tr>
							<td>2~3인</td>
							<td id="tdMoney"><span></span>원  </td>
						</tr>
						<tr>
							<td>4인</td>
							<td id="tdMoney"><span></span>원  </td>
						</tr>
						<tr>
							<td>6인</td>
							<td id="tdMoney"><span></span>원  </td>
						</tr>
						<tr>
							<td>8인 이상</td>
							<td id="tdMoney"><span></span>원  </td>
						</tr>
					</tbody>
				</table>     
			</div>              
			
			<div style="display: inline-block; width: 30%; min-height: 300px;">
				<table class="salesTable" style="float: left; width: 100%;">
					<thead>
						<tr>           
							<th colspan="2" style="background-color: white;">호텔위치 기준</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>호텔위치</th>
							<th>매출총액</th>
						</tr>   
						<tr>
							<td>서울</td>
							<td id="tdMoney"><span></span>원  </td>
						</tr>
						<tr>
							<td>경기/인천</td>
							<td id="tdMoney"><span></span>원  </td>
						</tr>
						<tr>
							<td>강원</td>
							<td id="tdMoney"><span></span>원  </td>
						</tr>
						<tr>
							<td>대전/충남/충북</td>
							<td id="tdMoney"><span></span>원  </td>
						</tr>
							<tr>
							<td>경남/경북</td>
							<td id="tdMoney"><span></span>원  </td>
						</tr>
							<tr>
							<td>전남/전북</td>
							<td id="tdMoney"><span></span>원  </td>
						</tr>
							<tr>
							<td>제주/울릉</td>
							<td id="tdMoney"><span></span>원  </td>
					</tbody>
				</table>      	          	
			</div>                        
		</div>	
		
  	</div>
	
</div>   


