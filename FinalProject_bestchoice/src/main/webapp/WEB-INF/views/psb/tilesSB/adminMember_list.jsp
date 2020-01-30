<%@page import="org.apache.taglibs.standard.tag.common.xml.ForEachTag"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
 #adminMemberList {
 /* 	border: solid 1px black; */
 	min-height: 500px;   
 	/* margin-top: 200px; */
 	margin-top: 10px;
 	margin-bottom: 30px;
 }
 
 #adminMemberListBTN{
 	color: #F7323F;
 }
 
 #tableMemberList {
 	border: solid 1px black;
 	border-collapse: collapse;  
 	width: 100%;
 	margin-top: 10px;
 }
 
 #tableMemberList tr, #tableMemberList th, #tableMemberList td  {
 	border: solid 1px black;
 	padding: 5px;
 }
 
 #tableMemberList th {
 	text-align: center;
 }
 
 #member:hover{
 	cursor: pointer;
 	font-weight: bold;
 }
</style>

<script>
	$(document).ready(function(){
		$("#adminMemberChartBTN").bind("mouseover", function(){	
			$("#adminMemberChartBTN").css({"color":"white","background-color":"#F7323F"});
		})
		$("#adminMemberChartBTN").bind("mouseout", function(){
			$("#adminMemberChartBTN").css({"color":"rgba(0,0,0,0.56)","background-color":"white"});
		}) 
		
		$("#adminMemberListBTN").bind("mouseover", function(){	
			$("#adminMemberListBTN").css({"color":"white","background-color":"#F7323F"});
		})
		$("#adminMemberListBTN").bind("mouseout", function(){	
			$("#adminMemberListBTN").css({"color":"#F7323F","background-color":"white"});
		})

		// 검색어값 유지 
		if( ${paraMap.gender != null} ){
			if( ${ paraMap.gender == "1" }) {
				$("input:radio[id='gender1']").prop("checked", true);
			}
			else if( ${ paraMap.gender == "2"} ) {
				$("input:radio[id='gender2']").prop("checked", true);
			};
		};

		if( ${paraMap.ageStr != null} ){
			//alert("${paraMap.ageStr}");
			var age = "${paraMap.ageStr}".split(",");
			for ( var i in age ) {
				$("input:checkbox[id=" + age[i] + "]").prop("checked", true);
			}
		}	  
		
		if( ${paraMap.startDate != null} && ${paraMap.endDate != null} ){
			$("#startDate").val("${paraMap.startDate}");
			$("#endDate").val("${paraMap.endDate}");
		};	
		
		if(${paraMap.searchWord != ""}){
			$("#searchType").val("${paraMap.searchType}");
			$("#searchWord").val("${paraMap.searchWord}");
		};
	
		$("#orderType").val("${paraMap.orderType}");
		
		if( ${paraMap.mstatus != null} ){
			
			if( ${ paraMap.mstatus == "1" }) {
				$("input:radio[id='mstatus1']").prop("checked", true);
			}
			else if( ${ paraMap.mstatus == "0"} ) {
				$("input:radio[id='mstatus0']").prop("checked", true);
			};
		};	
	
		// 엑셀 파일 다운 버튼
		$("#btnExcel").click(function(){

			var frm = document.searchFrm;
			frm.method="POST";
			frm.action="memberExcelFile.bc";
			frm.submit();
			
		}) // end of $("#btnExcel").click(function(){})==================
	
	}); // $(document).ready(function(){})============================
	
	function goSearch(){
		var frm = document.searchFrm;
		frm.method="GET";
		frm.action = "<%= request.getContextPath()%>/adminMember_list.bc";
		frm.submit();
	}
	
</script>

<div id="adminMemberList">
	<div>
		<label style="font-size: 16px;">◎ 회원 리스트 (총 : <span>${totalMember}</span>명)</label>
		<br/>
		<form name="searchFrm">
		<input type="button" value="검색" style="margin: 15px;" onclick="goSearch();"  /> 
		<label>성별 :</label> 
			남&nbsp;<input type="radio"  name="gender" id="gender1" value="1"  ondblclick="this.checked=false"/> <!--  라디오 버튼 체크 해제 -->
			여&nbsp;<input type="radio"  name="gender" id="gender2" value="2"  ondblclick="this.checked=false"/>
		&nbsp;&nbsp;|&nbsp;&nbsp; 	
		<label>나이 : </label> 
			10대&nbsp;<input type="checkbox" name="age" value="10" id="10"/>
			20대&nbsp;<input type="checkbox" name="age" value="20" id="20"/>
			30대&nbsp;<input type="checkbox" name="age" value="30" id="30"/>
			40대&nbsp;<input type="checkbox" name="age" value="40" id="40"/>
			50대&nbsp;<input type="checkbox" name="age" value="50" id="50"/>
			60대&nbsp;<input type="checkbox" name="age" value="60" id="60"/>
			70대이상&nbsp;<input type="checkbox" name="age" value="70" id="70"/>
		&nbsp;&nbsp;|&nbsp;&nbsp;
		<label>가입기간 : </label>     
		<input type="date" id="startDate" name="startDate" style="width: 130px;"/> ~ <input type="date" id="endDate" name="endDate" style="width: 130px;"/>
		<br/>  
		<select name="searchType" id="searchType" style="height: 20px; margin-left: 80px; position: relative; top:2px;">
			<option value="name">이름</option>
			<option value="member_idx">회원번호</option>
		</select>   
		<input type="text" name="searchWord" id="searchWord" style="height: 20px;"/>
		&nbsp;&nbsp;|&nbsp;&nbsp;	
		<label>조회순서 : </label>
		<select name="orderType" id="orderType" style="height: 20px;">  
			<option value="registerday">가입일자</option>
			<option value="totalPrice">누적결재액</option>                    
			<option value="totalCount">누적예약건수</option>
		</select>  
		&nbsp;&nbsp;|&nbsp;&nbsp;	
		<label>가입상태 : </label>    
			가입&nbsp;<input type="radio" name="mstatus" id="mstatus1" value="1"  ondblclick="this.checked=false"/>
			탈퇴&nbsp;<input type="radio" name="mstatus" id="mstatus0" value="0"  ondblclick="this.checked=false"/>
		&nbsp;&nbsp;|&nbsp;&nbsp;	    
		<label>검색된 회원 : </label>&nbsp;총&nbsp;<span>${totalCount}</span>명
		  
        <input type="button" id="btnExcel" value="엑셀다운" style="float:right; font-size: 8pt; z-index: 1;" /> 
		</form>
		
		<table id="tableMemberList">
			<tr style="background-color: #FAFAFA;">
				<th style="width: 8%;">회원번호</th>
				<th style="width: 20%;">이름</th>
				<th style="width: 20%;">이메일</th>
				<th>휴대폰번호</th>
				<th>가입일자</th>
				<th>성별</th>
				<th>나이</th>
				<th>누적결제액</th>
				<th>누적예약수</th>
			</tr>
			
			<c:if test="${ memberList == null }">
				<tr>   
					<td colspan="9">가입된 회원이 없습니다.</td>
				</tr>
		   </c:if>
	   
			<c:if test="${ memberList != null }">
				<c:forEach var="membervo" items="${memberList}" varStatus="status" > 
				
				<tr id="member" style="text-align: center;" onclick="location.href='<%=request.getContextPath()%>/memberDetail.bc?member_idx=${membervo.member_idx}'" >   
					<td>${membervo.member_idx}</td>
					<td>${membervo.name}</td>
					<td>${membervo.email}</td>
					<td>
						 ${membervo.hp1}-${membervo.hp2}- ${membervo.hp3}
					</td>
					<td>${membervo.registerday}</td>
					<td>
						<c:if test="${membervo.gender == 1}">
						남
						</c:if>	
						<c:if test="${membervo.gender == 2}">
						여
						</c:if>	
					</td>
					<td>${membervo.age}</td>
					<td> <fmt:formatNumber value="${membervo.totalPrice}" pattern="#,###"/></td>
					<td><fmt:formatNumber value="${membervo.totalCount}" pattern="#,###"/></td>
				</tr>
				</c:forEach>
		   </c:if>
		   
		</table>
		
		<br/>
	
	</div>
	
	<div align="center" style="color: black;">   
		${pagebar}
	</div>
	
</div>   