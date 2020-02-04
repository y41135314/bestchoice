<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css">
 #adminHotelList {
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

 #hotelListBtn{
 	color: #F7323F;
 }
 
 #tableHotelList {
 	border: solid 1px black;
 	border-collapse: collapse;  
 	width: 100%;
 	margin-top: 10px;
 }
 
 #tableHotelList tr, #tableHotelList th, #tableHotelList td  {
 	border: solid 1px black;
 	padding: 5px;
 }
 #tableHotelList th {
 	text-align: center;
 }
  #hotel:hover{
 	cursor: pointer;
 	font-weight: bold;
 	color: #ff5c33;
 }
</style>

<script>
	$(document).ready(function(){
		
		$("#divHotel").css("border-bottom", "solid 1px #555555");
		$("#divSeller").css("border", "none");
		$("#divHotel2").show();  
		$("#divSeller2").hide();  
		
		$("#hotelListBtn").bind("mouseover", function(){	
			$("#hotelListBtn").css({"color":"white","background-color":"#F7323F"});
		})
		$("#hotelListBtn").bind("mouseout", function(){	
			$("#hotelListBtn").css({"color":"#F7323F","background-color":"rgba(225,225,225,0.0)"});
		})
		
		// 검색어값 유지 
		if( ${paraMap.startDate != null} && ${paraMap.endDate != null} ){
			$("#startDate").val("${paraMap.startDate}");
			$("#endDate").val("${paraMap.endDate}");
		};	
		
		if(${paraMap.searchWord != ""}){
			$("#searchType").val("${paraMap.searchType}");
			$("#searchWord").val("${paraMap.searchWord}");
		};
	
		$("#orderType").val("${paraMap.orderType}");
		
		if( ${paraMap.hotel_Status != null} ){
			
			if( ${ paraMap.hotel_Status == "1" }) {
				$("input:radio[id='hotel_Status1']").prop("checked", true);
			}
			else if( ${ paraMap.hotel_Status == "0"} ) {
				$("input:radio[id='hotel_Status0']").prop("checked", true);
			};
		};
		
		if(${paraMap.hotel_Category != ""}){
			$("#hotel_Category").val("${paraMap.hotel_Category}");
		};
		
		if(${paraMap.hotel_Addr1 != ""}){
			$("#hotel_Addr1").val("${paraMap.hotel_Addr1}");
		} else {
			$("#hotel_Addr1").val("");
		};
		
		/* // 엑셀 파일 다운 버튼
		$("#btnExcel").click(function(){

			var frm = document.searchSellerFrm;
			frm.method="POST";
			frm.action="memberExcelFile.bc";
			frm.submit();
			
		}) // end of $("#btnExcel").click(function(){})================== */
	});
	
	function goSearch(){
		var frm = document.searchHotelFrm;
		frm.method="GET";
		frm.action = "<%= request.getContextPath()%>/adminHotel_list.bc";
		frm.submit();
	}
	
</script>

<div id="adminHotelList">
<div>
		<label style="font-size: 16px;">◎ 호텔 리스트 (총 : <span>${totalHotel}</span>개)</label>
		<br/>
		<form name="searchHotelFrm">
		<input type="button" value="검색" style="margin: 15px;" onclick="goSearch();" /> 
		<label>영업 상태 :</label> 
			영업가능&nbsp;<input type="radio" name="hotel_Status" value="1" id="hotel_Status1" ondblclick="this.checked=false"/>
			영업중단&nbsp;<input type="radio" name="hotel_Status" value="0" id="hotel_Status0" ondblclick="this.checked=false"/>
		&nbsp;&nbsp;|&nbsp;&nbsp;
		<label>등록기간 : </label>     
		<input type="date" id="startDate" name="startDate" style="width: 140px;"/> ~ <input type="date" id="endDate" name="endDate"  style="width: 140px;"/>
		&nbsp;&nbsp;|&nbsp;&nbsp;	
		<label>호텔등급 : </label>
		<select name="hotel_Category" id="hotel_Category" style="height: 20px;">
			<option value="">전체</option>
			<option value="5">5성</option>
			<option value="4">4성</option>
			<option value="3">3성</option>
			<option value="2">2성</option>
			<option value="1">기타</option>
		</select>  
		&nbsp;&nbsp;|&nbsp;&nbsp;	
		<label>위치 : </label>  
		<select name="hotel_Addr1" id="hotel_Addr1" style="height: 20px;">
			<option value="">전국</option>
			<option value="서울">서울</option>  
			<option value="경기,인천">경기/인천</option>
			<option value="강원">강원</option>
			<option value="대전,충남,충북">대전/충남/충북</option>
			<option value="대구,경남,경북">대구/경남/경북</option>
			<option value="울산,부산">울산/부산</option>
			<option value="광주,전남,전북">광주/전남/전북</option>
			<option value="제주">제주</option>
		</select>  
		<br/>
		<select name="searchType" id="searchType" style="height: 20px; margin-left: 80px; position: relative; top: 2px;">
			<option value="hotel_Name" >호텔명</option>
			<option value="seller_Name">판매자</option>  
		</select>   
		<input type="text" name="searchWord" id="searchWord"  style="height: 20px;"/>
		&nbsp;&nbsp;|&nbsp;&nbsp;	
		<label>조회순서 : </label>
		<select name="orderType" id="orderType" style="height: 20px;">
			<option value="hotel_registerday">등록일자</option>
			<option value="totalPrice">누적결재액</option>
			<option value="totalCount">누적예약건수</option>
		</select>  
		&nbsp;&nbsp;|&nbsp;&nbsp;
		<label>검색된 호텔 :  </label>&nbsp;&nbsp;<span style="color: #ff5c33">${totalCount}&nbsp;개 </span>
	
		 <input type="button" value="엑셀다운" style="float:right; font-size: 8pt; z-index: 1;" /> 
		</form>
		
		<table id="tableHotelList">
			<tr style="background-color: #ffe6e6;">
				<th>호텔번호</th>
				<th>호텔명</th>
				<th>호텔등급</th>
				<th>판매자</th>  
				<th>주소(시,도)</th>
				<th>등록일자</th>
				<th>누적판매액</th>
				<th>누적예약수</th>
			</tr>
			
			<c:if test="${ hotelList == null }">
				<tr>   
					<td colspan="7">등록된 호텔이 없습니다.</td>
				</tr>
		   </c:if>
		   
		   <c:if test="${ hotelList != null }">
				<c:forEach var="hotelvo" items="${hotelList}" varStatus="status" > 
				
				<tr id="hotel" style="text-align: center;" onclick="location.href='<%=request.getContextPath()%>/hotelDetail.bc?hotel_idx=${hotelvo.hotel_idx}'" >   
					<td>${hotelvo.hotel_idx}</td>
					<td>${hotelvo.hotel_name}</td>
					<c:if test="${hotelvo.hotel_Category ==0 }"><td> 일반</td></c:if>
					<c:if test="${hotelvo.hotel_Category ==1 }"><td> 특급</td></c:if>
					<c:if test="${hotelvo.hotel_Category ==2 }"><td> 특1급</td></c:if>
					<td>${hotelvo.seller_Name}</td>
					<td>${hotelvo.hotel_Addr1}</td>
					<td>${hotelvo.hotel_registerday}</td>
					<td><fmt:formatNumber value="${hotelvo.totalPrice}" pattern="#,###"/></td>
					<td><fmt:formatNumber value="${hotelvo.totalCount}" pattern="#,###"/></td>
				</tr>
				</c:forEach>
		   </c:if>
			
		</table>

</div>
</div>   