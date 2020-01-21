<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
 #adminReservList {
 	/* border: solid 1px black; */
 	min-height: 500px;   
 	/* margin-top: 200px; */
 	margin-top: 10px;
 	margin-bottom: 30px;
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
  
</style>    
    

<div id="adminReservList">      
	<label class="salesLabel" style="font-weight: bold;font-size: 16px;	margin-bottom: 10px;">◎ 예약 리스트</label>
	&nbsp;
	<input type="button" value="매출현황 메인페이지로" onclick="location.href='<%=request.getContextPath()%>/salesStatistic.bc'" style="font-size: 8pt;"/> 
	
	<form>
		<input type="button" value="검색" style="margin: 15px;"/> 
		<select name="" id="" style="height: 20px; position: relative; top: 2px; ">
			<option value="">회원ID</option>
			<option value="">호텔명</option>
		</select>   
		<input type="text" style="height: 20px;"/>
		&nbsp;&nbsp;|&nbsp;&nbsp;  
		<label>숙박예정 제외 합계액 : </label>
	</form>	
	
	<table class="salesTable" id="reservTable" style="width: 100%;" >
		<thead>
			<tr>
				<th>예약ID</th>
				<th>회원ID</th>
				<th>호텔ID</th>
				<th>결제금액</th>
				<th>결제일</th>
				<th>숙박시작일</th>
				<th>숙박종료일</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td colspan="7">예약내역이 없습니다.</td>
			</tr>
		</tbody>
	</table>
</div>