<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    

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
 	padding: 5px;
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
  
  .gobtn{
  	color: #ff6666;
  }
  .gobtn:hover{
 	color: #ffb3b3;
 	cursor: pointer;
  }
  
  .BTN:hover {
  	cursor: pointer;
  	background-color: #eee;
  }
</style>    
    

<script>
	$(document).ready(function(){

		// 검색어값 유지 
		if( ${paraMap.startDate != null} && ${paraMap.endDate != null} ){
			$("#startDate").val("${paraMap.startDate}");
			$("#endDate").val("${paraMap.endDate}");
		};	
		
		if( ${paraMap.res_startday != null} && ${paraMap.res_startdayEnd != null} ){
			$("#res_startday").val("${paraMap.res_startday}");
			$("#res_startdayEnd").val("${paraMap.res_startdayEnd}");
		};	
		
		if(${paraMap.searchWord != ""}){
			$("#searchType").val("${paraMap.searchType}");
			$("#searchWord").val("${paraMap.searchWord}");
		};
	
	}); // $(document).ready(function(){})============================
	
	function goSearch(){
		var frm = document.searchFrm;
		frm.method="GET";
		frm.action = "<%= request.getContextPath()%>/adminReservList.bc";
		frm.submit();
	}
	
</script>

<div id="adminReservList">      
	<label class="salesLabel" style="font-weight: bold;font-size: 16px;	margin-bottom: 10px;">◎ 예약 리스트 (총 : <span>${totalReserve}</span>건)</label>
	&nbsp;
	<input type="button" value="매출현황 메인페이지로" onclick="location.href='<%=request.getContextPath()%>/salesStatistic.bc'" style="font-size: 8pt;"/> 
	&nbsp;&nbsp;&nbsp; ====    
	<label>숙박 완료 합계액 : <sapn style="color: #ff5c33;"><fmt:formatNumber value="${endPay}" pattern="#,###"/>&nbsp;원</sapn></label> &nbsp;&nbsp; | &nbsp;&nbsp; <label>검색된 예약 : </label>&nbsp;&nbsp;<span style="color: #ff5c33;">${totalCount}&nbsp;건</span>
	<form name="searchFrm">     
		<input type="button" value="검색" style="margin: 15px;" onclick="goSearch();"  />   
		<select name="searchType" id="searchType" style="height: 20px; position: relative; top: 2px; ">
			<option value="name">회원이름</option>
			<option value="hotel_name">호텔명</option>  
			<option value="seller_name">판매자</option>
			<option value="fk_member_idx">회원번호</option>
		</select>   
		<input type="text" name="searchWord" id="searchWord" style="height: 20px;"/>
		&nbsp;&nbsp;|&nbsp;&nbsp;   
		<label>결제일 선택 : </label>     
		<input type="date" id="startDate" name="startDate" style="width: 140px;"/> ~ <input type="date" id="endDate" name="endDate" style="width: 140px;"/>
		&nbsp;&nbsp;|&nbsp;&nbsp;  
		<label>숙박 시작일 선택 : </label>     
		<input type="date" id="res_startday" name="res_startday" style="width: 140px;"/> ~ <input type="date" id="res_startdayEnd" name="res_startdayEnd" style="width: 140px;"/>
		&nbsp;&nbsp;&nbsp;<span class="BTN" id="resetBtn" style="border: solid 1px gray; padding: 5px; " onclick="location.href='<%= request.getContextPath() %>/adminReservList.bc'">검색 초기화</span>
		&nbsp;&nbsp;&nbsp;<span class="BTN" style="border: solid 1px gray; padding: 5px;" >엑셀다운</span>
  
	</form>	
	
	<table class="salesTable" id="reservTable" style="width: 100%;" >
		<thead>
			<tr>
				<th>예약번호</th>
				<th>회원번호</th>
				<th>회원이름</th>
				<th>호텔명</th>
				<th>판매자</th>
				<th>결제금액</th>
				<th>결제일</th>
				<th>결제유형</th>
				<th>숙박시작일</th>
				<th>숙박종료일</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${ rserveList == null }">
				<tr>   
					<td colspan="10">예약내역이 없습니다.</td>
				</tr>
		   </c:if>
	
		   <c:if test="${ rserveList != null }">
				<c:forEach var="reservo" items="${rserveList}" varStatus="status" > 
				<tr id="reserve" style="text-align: center;"  >   
					<td>${reservo.res_number}</td>
					<td>${reservo.fk_member_idx}</td>
					<td class="gobtn" onclick="location.href = '<%= request.getContextPath() %>/memberDetail.bc?member_idx=${reservo.fk_member_idx}'">${reservo.name}</td>
					<td  >${reservo.hotel_name}</td>
					<td >${reservo.seller_name}</td>
					<td><fmt:formatNumber value="${reservo.res_totalprice}" pattern="#,###"/>원</td>
					<td>${reservo.res_paymentDay}</td>
					<c:if test="${reservo.res_payment == 0 }"><td>카드</td></c:if>
					<c:if test="${reservo.res_payment == 1 }"><td>카카오페이</td></c:if>
					<c:if test="${reservo.res_payment == 2 }"><td>네이버</td></c:if>
					<td>${reservo.resstatus_in_day}</td>
					<td>${reservo.resstatus_out_day}</td>
				</tr>
				</c:forEach>
		   </c:if>
		   
		</tbody>
	</table>
	<br/>
	<div align="center" style="color: black;">   
		${pagebar}
	</div>
	
</div>