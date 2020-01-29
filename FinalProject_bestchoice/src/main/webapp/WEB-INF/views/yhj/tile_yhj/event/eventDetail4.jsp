<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> ${eventMap.event_name } | 여기는어때</title>

<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Jua&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>


<style type="text/css">

	@media  ( max-width : 991px) {
		
		#event_container {
			width: 100%;
			margin:0 auto;
		}
	
		#event_sideinfo ul {
			display:none;
			list-style: none;
			padding: 30px 0;
		}
		
		#event_sideinfo ul li {
			margin-bottom: 20px;
			font-family: 'Jua', sans-serif;
			font-size: 16pt;
		}
		
		#event_sideinfo ul li a {
			text-decoration: none;
			color:  #bfbfbf;
			word-spacing: -2px;
		}
		
		#eventDet_explanation {
			font-weight: bold;
		    font-size: 12pt;
		    padding: 15px 0;
		}
		
		#event_body {
			width:100%;
			/* float:left; */ 
			padding: 30px 0;
		}
		
		#eventDet_content {
			text-align: center;
		}
		
		#eventDet_content img {
			width: 90%;
		}
		
		#eventDet_prevNnext {
			margin: 30px 0;
			width: 100%;
		}
		
		#eventDet_prevNnext tr {
			cursor: pointer;
		}
		
		#eventDet_prevNnext .td1 {
			width: 15%;
			padding: 17px 0;
			color: #ff6666;
			border-top : solid 1px #cccccc;
			border-bottom: solid 1px #cccccc; 
		}
			
		#eventDet_prevNnext .td2 {
			width: 55%;
			font-weight: bold;
			border-top : solid 1px #cccccc;
			border-bottom: solid 1px #cccccc; 
		}
		
		#eventDet_prevNnext .td3 {
			width: 30%;
			color: #999999;
			border-top : solid 1px #cccccc;
			border-bottom: solid 1px #cccccc; 
		}
		
		#event_button {
			margin: 20px 0;
			color: white;
			background-color: #0000e6;
			border-radius: 9px ;
			border: solid 2px #0000e6 ;
			font-weight: bold;
			font-size: 16pt;
			padding: 10px 40px;
		}
		
		#event_back button {
			padding: 10px 30px;
			font-size: 14pt;
			font-weight: bold;
			color: white;
			background-color: #ff1a75;
			border: none;
			border-radius: 4px ;
			
		}
	}

	
	@media ( min-width : 992px) { 

		#event_container {
		width: 80%;
		margin:0 auto;
		}
	
		#event_sideinfo ul {
			list-style: none;
			padding: 30px 0;
		}
		
		#event_sideinfo ul li {
			margin-bottom: 20px;
			font-family: 'Jua', sans-serif;
			font-size: 16pt;
		}
		
		#event_sideinfo ul li a {
			text-decoration: none;
			color:  #bfbfbf;
			word-spacing: -2px;
		}
		
		#eventDet_explanation {
			font-weight: bold;
		    font-size: 12pt;
		    padding: 15px 0;
		}
		
		#event_body {
			width:70%;
			float:left; 
			padding: 30px 0;
		}
		
		#eventDet_content {
			text-align: center;
		}
		
		#eventDet_content img {
			width: 90%;
		}
		
		#eventDet_prevNnext {
			margin: 30px 0;
			width: 100%;
		}
		
		#eventDet_prevNnext tr {
			cursor: pointer;
		}
		
		#eventDet_prevNnext .td1 {
			width: 15%;
			padding: 17px 0;
			color: #ff6666;
			border-top : solid 1px #cccccc;
			border-bottom: solid 1px #cccccc; 
		}
			
		#eventDet_prevNnext .td2 {
			width: 55%;
			font-weight: bold;
			border-top : solid 1px #cccccc;
			border-bottom: solid 1px #cccccc; 
		}
		
		#eventDet_prevNnext .td3 {
			width: 30%;
			color: #999999;
			border-top : solid 1px #cccccc;
			border-bottom: solid 1px #cccccc; 
		}
		
		#event_button {
			margin: 20px 0;
			color: white;
			background-color: #0000e6;
			border-radius: 9px ;
			border: solid 2px #0000e6 ;
			font-weight: bold;
			font-size: 16pt;
			padding: 10px 40px;
		}
		
		#event_back button {
			padding: 10px 30px;
			font-size: 14pt;
			font-weight: bold;
			color: white;
			background-color: #ff1a75;
			border: none;
			border-radius: 4px ;
			
		}
	}



	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
		
		
	});
	
	function goEventDetail(number){
		
		location.href="<%= request.getContextPath()%>/event/detail.bc?no="+number ;
	}
	
	function doEvent(number){
		
		$("form[name=eventSubmitForm] input[name=event_code]").val(number);
		
		var frm = document.eventSubmitForm;
		
		frm.action = "<%= request.getContextPath()%>/event/detailEnd4.bc";
		frm.method = "POST";
		frm.submit();
	}
	
	// 수정하기
	function goEventRevise(number){
		
		location.href= "<%= request.getContextPath()%>/event/write.bc?event_code="+number;
	}
	
	// 삭제하기
	function goEventDelete(number){
		
		location.href= "<%= request.getContextPath()%>/event/delete.bc?event_code="+number;
	}
	
</script>

</head>
<body>

	<div id="event_container">
		
			<div id="event_sideinfo" style="width:20%;float:left;">
		    	
		        <ul>
		        	<li><a href="<%=request.getContextPath()%>/notice/main.bc">공지사항</a></li>
		        	<li><a href="<%=request.getContextPath()%>/event/main.bc" style="color: red;">이벤트</a></li>
		            <li><a href="<%=request.getContextPath()%>/question/main.bc">자주 묻는 질문</a></li>
		            <li><a href="<%=request.getContextPath()%>/faq/main.bc">1대1 문의</a></li>
		        </ul>
		        
		    </div>
		    
			<div id="event_body">
				
				<div id="eventDet_content">
					
					<div id="eventDet_explanation">
					
						<c:if test="${ sessionScope.loginadmin != null || sessionScope.loginseller != null }">
							▶ 이벤트 설명<br><br>
							${ eventMap.event_explain }
						</c:if>
						
					</div>
					
					<c:forEach var="map" varStatus="status" items="${ eventImgMapList }">
						
						<c:if test="${ map.main != 1 }">
							<img src="<%= request.getContextPath()%>/resources/images/yhj/event/${map.wasfilename}"><br>
						</c:if>
						
						<c:if test="${ status.index == 1 }">
							<button type="button" id="event_button" onclick="doEvent('${eventMap.event_code}')">
							<span style="color:gold;">내 적립금</span> 받으러 가기 &gt; </button><br>
						</c:if>
						
					</c:forEach>
					
					
				</div>
				
				<table id="eventDet_prevNnext">
				
					<c:if test="${eventMap.prev_event_code != null }">
					
						<tr onclick="goEventDetail('${eventMap.prev_event_code}')">
							<td class="td1">이전글</td>
							<td class="td2">${ eventMap.prev_event_name }</td>
							<td class="td3">기간 : ${ eventMap.prev_event_startday } ~ ${ eventMap.prev_event_endday }</td>
						</tr>
					
					</c:if>
					
					<c:if test="${eventMap.next_event_code != null }">
					
						<tr onclick="goEventDetail('${eventMap.next_event_code}')">
							<td class="td1">다음글</td>
							<td class="td2">${ eventMap.next_event_name }</td>
							<td class="td3">기간 : ${ eventMap.next_event_startday } ~ ${ eventMap.next_event_endday }</td>
						</tr>
					
					</c:if>
					
				</table>
				
				<div id="event_back" align="center">
				
					<c:if test="${ sessionScope.loginadmin != null }">
						<button type="button" onclick="goEventRevise('${eventMap.event_code}')">수정하기</button>
						<button type="button" onclick="goEventDelete('${eventMap.event_code}')">삭제하기</button>
					</c:if>
				
					<button type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/event/main.bc'">목록보기</button>
				</div>
				
			</div>
	</div>		
	
	<form name="eventSubmitForm" style="display:none;">
		<input name="event_code" >
	</form>
	
</body>	
</html>