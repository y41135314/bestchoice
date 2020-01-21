<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  
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
 	font-size: 16px;
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


<div id="salesStatistic">  
	<div class="allStat" style="border: solid 1px red;">
		<label class="salesLabel">◎ 누적 매출액</label>&nbsp;
		<input type="button" value="예약내역 조회" onclick="location.href='<%=request.getContextPath()%>/adminReservList.bc'" style="font-size: 8pt;"/> 
		<div>
			<table class="salesTable" id="salesMainTable">
				<thead>
					<tr>
						<th>2019년 누적 매출액</th>
						<th>2020년 누적 매출액</th>
						<th>당월 누적 매출액</th>
						<th>일매출액</th>
						<th><input type="date" style="width: 130px;"/> ~ <input type="date" style="width: 130px;"/>&nbsp;&nbsp;
						 <input type="button" value="매출조회" style="font-size: 8pt; font-weight: normal;"/></th>
					</tr>
				</thead>
				<tbody>
					<tr style="text-align: right;">
						<td> <span></span>원</td>
						<td> <span></span>원</td>
						<td> <span></span>원</td>
						<td><span></span>원</td>
						<td><span></span>원</td>
					</tr>
				</tbody>
			</table>
		</div>
	
		<div style="margin-top: 20px; border: solid 1px black;">
		월 평균 매출액 그래프
		</div>     
	</div>
	
	  
	<div class="allStat" style="margin-top: 30px; border: solid 1px blue;">  
		<div>
			<label class="salesLabel" >◎ 회원별 매출액</label>&nbsp;
			<input type="button" value="연령대/성별 점유율" onclick="location.href='<%=request.getContextPath()%>/adminMember_chart.bc'" style="font-size: 8pt;"/> 
		</div>  
		
		<table class="salesTable" id="salesGenderTable" style="float: left; height: 100px; min-width: 200px;">
			<thead>
				<tr>
					<th colspan="5" style="text-align: left; background-color: white;">▶ 성별 기준
					<input type="button" value="매출합계추이" style="font-size: 8pt; font-weight: normal; float: right;"/></th>
				</tr>
			</thead>
			<tbody>
				<tr>                 
					<td style="font-size: 8pt; text-align: right;">단위 : 원</td>   
					<th>남자</th>
					<th>여자</th>
				</tr>   
				<tr style="text-align: right;">
					<th style="font-size: 10pt;"><span></span>총 인원 </th>
					<td><span></span>원  </td>
					<td><span></span>원  </td>
				</tr>
				<tr>
					<th style="font-size: 10pt;"><span></span>총 매출액</th>
					<td><span></span>원  </td>
					<td><span></span>원  </td>
				</tr>
				<tr>
					<th style="font-size: 10pt;"><span></span>1인 평균</th>
					<td><span></span>원  </td>
					<td><span></span>원  </td>
				</tr>
			</tbody>
		</table>     
		<table class="salesTable" id="salesAgeTable" style="float: right; height: 100px; margin-right: 20%; " >
			<thead>  
				<tr>
					<th colspan="8" style="text-align: left; background-color: white;">▶ 연령대별 기준
					<input type="button" value="매출합계추이" style="font-size: 8pt; font-weight: normal; float: right;"/>
					</th>
				</tr>
				<tr>
					<td style="font-size: 8pt; text-align: right;">단위 : 원</td>      
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
					<th style="font-size: 10pt;"><span></span>총 인원 </th>
					<td><span></span>원  </td>
					<td><span></span>원  </td>
					<td><span></span>원  </td>
					<td><span></span>원  </td>
					<td><span></span>원  </td>
					<td><span></span>원  </td>
					<td><span></span>원  </td>
				</tr>
				<tr>
					<th style="font-size: 10pt;"><span></span>총 매출액</th>
					<td><span></span>원  </td>
					<td><span></span>원  </td>
					<td><span></span>원  </td>
					<td><span></span>원  </td>
					<td><span></span>원  </td>
					<td><span></span>원  </td>
					<td><span></span>원  </td>
				</tr>
				<tr style="text-align: right;">
					<th style="font-size: 10pt;"><span></span>1인 평균</th>
					<td><span></span>원  </td>
					<td><span></span>원</td>
					<td><span></span>원  </td>
					<td><span></span>원  </td>
					<td><span></span>원  </td>
					<td><span></span>원  </td>
					<td><span></span>원  </td>
				</tr>
			</tbody>
		</table>
	
		<div style="clear: both; padding-top: 20px; border: solid 1px black;">
		여자 고객 매출 합계 추이 + 남자 고객 매출 합계 추이 
		or 
		연령대별 고객 매출 합계 추이
		</div>

  	</div>   
  	
  	<div class="allStat" style="margin-top: 30px; border: solid 1px green;">  
		<div>
			<label class="salesLabel" >◎ 상품별 매출액</label> 
			<br/>
			<label>&nbsp;기간선택&nbsp;&nbsp;</label><input type="date" style="width: 130px;"/> ~ <input type="date" style="width: 130px;"/> 
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


