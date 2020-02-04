<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<style type="text/css">
 #adminSellerList {
 	/* border: solid 1px black; */
 	min-height: 500px;   
 	/* margin-top: 200px; */
 	margin-top: 10px;
 	margin-bottom: 30px;
 }
 
 #pSeller {
	background-color: #555555;
	color: #B7B7B7;
}

 #sellerListBtn{
 	color: #F7323F;
 }
 
 #tableSellerList {
 	border: solid 1px black;
 	border-collapse: collapse;  
 	width: 100%;
 	margin-top: 10px;
 }
 
 #tableSellerList tr, #tableSellerList th, #tableSellerList td  {
 	border: solid 1px black;
 	padding: 5px;
 }
 
  #tableSellerList th {
 	text-align: center;
 }
 
 #seller:hover{
 	cursor: pointer;
 	font-weight: bold;
 	color: #ff5c33;
 }
</style>

<script>
	$(document).ready(function(){
		
		$("#divSeller").css("border-bottom", "solid 1px #555555");
		$("#divHotel").css("border", "none");
		$("#divSeller2").show();            
		$("#divHotel2").hide();
		
		$("#sellerListBtn").bind("mouseover", function(){	
			$("#sellerListBtn").css({"color":"white","background-color":"#F7323F"});
		})
		$("#sellerListBtn").bind("mouseout", function(){	
			$("#sellerListBtn").css({"color":"#F7323F","background-color":"rgba(225,225,225,0.0)"});
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
		
		if( ${paraMap.seller_realStatus != null} ){
			
			if( ${ paraMap.seller_realStatus == "1" }) {
				$("input:radio[id='seller_realStatus1']").prop("checked", true);
			}
			else if( ${ paraMap.seller_realStatus == "0"} ) {
				$("input:radio[id='seller_realStatus0']").prop("checked", true);
			};
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
		var frm = document.searchSellerFrm;
		frm.method="GET";
		frm.action = "<%= request.getContextPath()%>/adminSeller_list.bc";
		frm.submit();
	}
	
</script>

<div id="adminSellerList">
<div>
		<label style="font-size: 16px;">◎ 판매자 리스트 (총 : <span>${totalSeller}</span>명)</label>
		<br/>
		<form name="searchSellerFrm">
		<input type="button" value="검색" style="margin: 15px;" onclick="goSearch();" /> 
		<!-- <label>영업상태 :</label> 
			영업중&nbsp;<input type="checkbox"/>
			영업중지&nbsp;<input type="checkbox"/>
		&nbsp;&nbsp;|&nbsp;&nbsp; -->
		<label>가입기간 : </label>     
		<input type="date" id="startDate" name="startDate" style="width: 140px;"/> ~ <input type="date" id="endDate" name="endDate" style="width: 140px;"/>
		<br/>
		<select name="searchType" id="searchType" style="height: 20px; margin-left: 80px;">
			<option value="seller_Id">ID</option>
			<option value="seller_Name">판매자</option>
		</select>   
		<input type="text" name="searchWord" id="searchWord" style="height: 20px;"/>
		&nbsp;&nbsp;|&nbsp;&nbsp;	
		<label>조회순서 : </label>
		<select name="orderType" id="orderType" style="height: 20px;">
			<option value="seller_registerday">가입일자</option>
			<option value="totalPrice">누적판매액</option>
			<option value="totalCount">누적예약건수</option>
		</select>  
		&nbsp;&nbsp;|&nbsp;&nbsp;
		<label>계정 상태 : </label>    
			활성&nbsp;<input type="radio" name="seller_realStatus" value="1" id="seller_realStatus1" ondblclick="this.checked=false"/>      
			휴먼&nbsp;<input type="radio" name="seller_realStatus" value="0" id="seller_realStatus0" ondblclick="this.checked=false"/>
		&nbsp;&nbsp;|&nbsp;&nbsp;	    	    
		<label>검색된 판매자 : </label>&nbsp;&nbsp;<span style="color: #ff5c33;">${totalCount}&nbsp;명</span>
	 
		<input type="button" value="엑셀다운" style="float:right; font-size: 8pt; z-index: 1;" />  
		</form>
		
		<table id="tableSellerList">
			<tr style="background-color:#ffe6e6;">
				<th style="width: 8%;">판매자 번호</th>
				<th style="width: 20%;"> ID</th>
				<th>판매자</th>
				<th>대표번호</th>
				<th>대표자명</th>
				<th>가입일자</th>
				<th>누적판매액</th>
				<th>누적예약수</th>
			</tr>
			
			<c:if test="${ sellerList == null }">
				<tr>   
					<td colspan="8">가입한 판매자가 없습니다.</td>
				</tr>
		   </c:if>
	   
			<c:if test="${ sellerList != null }">
				<c:forEach var="sellervo" items="${sellerList}" varStatus="status" > 
				
				<tr id="seller" style="text-align: center;" onclick="location.href='<%=request.getContextPath()%>/sellerDetail.bc?seller_idx=${sellervo.seller_idx}'" >   
					<td>${sellervo.seller_idx}</td>
					<td>${sellervo.seller_Id}</td>
					<td>${sellervo.seller_Name}</td>
					<td>${sellervo.seller_Phone}</td>
					<td>${sellervo.seller_RepName}</td>
					<td>${sellervo.seller_registerday}</td>
					<td> <fmt:formatNumber value="${sellervo.totalPrice}" pattern="#,###"/></td>
					<td><fmt:formatNumber value="${sellervo.totalCount}" pattern="#,###"/></td>
				</tr>
				</c:forEach>
			</c:if>
			
		</table>
		
</div>
</div>   