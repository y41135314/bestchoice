<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>


<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Jua&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style>

	@media ( max-width : 991px) {
		
		#notice_container {
			width: 100%;
			margin:0 auto;
		}
	
		#notice_sideinfo ul {
			display:none;
		}
		
		#notice_sideinfo ul li {
			margin-bottom: 20px;
			font-family: 'Jua', sans-serif;
			font-size: 16pt;
		}
		
		#notice_sideinfo ul li a {
			text-decoration: none;
			color:  #bfbfbf;
			word-spacing: -2px;
		}
		
		#notice_body {
			width:100%;
			padding-bottom: 30px;
		}
		
		#notice_header {
			
			padding-top: 30px;
			width: 90%;
		}
	
		#notice_header div {
			font-family: 'Nanum Gothic', sans-serif;
			font-weight:bold;
			font-size: 16pt;
			color: red;
			width: 150px;
			padding: 15px 0;
			border-bottom: solid 3px red;
		}
		
		#notice_content {
			padding: 30px 0;
		}
		
		#notice_content thead {
			border-bottom: solid 2px black;
		}
		
		#notice_content thead th {
			text-align: center;
		}
		
		#notice_content table td, #notice_content table th {
			padding: 15px 0 ;
			font-family: 'Nanum Gothic', sans-serif;
		}
		
		.not_title {
			text-align: left;
			padding-left: 25px;
		}
		
		.not_content {
			text-align: left;
			background-color: #f2f2f2;
		}
		
		#notice_write {
			
			background-color: white;
		    border: solid 2px black;
		    padding: 5px 20px;
		    font-weight: bold;
		    font-family: 'Nanum Gothic', sans-serif;
		    transition: 0.5s;
		}
		
		#notice_write:hover {
			
			background-color: black;
			color: white;
		}
		
		.revised_content{
			width: 100%;
			height: 150px;
		}
		
		.reviseBtn {
			padding: 5px 15px;
			border: solid 2px black;
			background-color: white;
			color: black;
			font-family: 'Nanum Gothic', sans-serif;
			font-weight: bold;
		}		
		
		#notice_pageBar ul {
			list-style: none;
		}
		
		#notice_pageBar ul li {
			display: inline-block;
			margin: 0px 3px;
		}
		
		#notice_pageBar ul li a {
			color: black;
			text-decoration: none;
		}
		
	}


	@media ( min-width : 992px) {
		
		
		#notice_container {
			width: 80%;
			margin:0 auto;
		}
	
		#notice_sideinfo ul {
			list-style: none;
			padding: 30px 0;
		}
		
		#notice_sideinfo ul li {
			margin-bottom: 20px;
			font-family: 'Jua', sans-serif;
			font-size: 16pt;
		}
		
		#notice_sideinfo ul li a {
			text-decoration: none;
			color:  #bfbfbf;
			word-spacing: -2px;
		}
		
		#notice_header {
			
			padding-top: 30px;
			width: 90%;
		}
		
		#notice_body {
			width:80%;
			float:left;
			padding-bottom: 30px;
		}
		
		#notice_header div {
			font-family: 'Nanum Gothic', sans-serif;
			font-weight:bold;
			font-size: 16pt;
			color: red;
			width: 150px;
			padding: 15px 0;
			border-bottom: solid 3px red;
		}
		
		#notice_content {
			padding: 30px 0;
		}
		
		#notice_content thead {
			border-bottom: solid 2px black;
		}
		
		#notice_content thead th {
			text-align: center;
		}
		
		#notice_content table td, #notice_content table th {
			padding: 15px 0 ;
			font-family: 'Nanum Gothic', sans-serif;
		}
		
		.not_title {
			text-align: left;
			padding-left: 25px;
		}
		
		.not_content {
			text-align: left;
			background-color: #f2f2f2;
		}
		
		#notice_write {
			
			background-color: white;
		    border: solid 2px black;
		    padding: 5px 20px;
		    font-weight: bold;
		    font-family: 'Nanum Gothic', sans-serif;
		    transition: 0.5s;
		}
		
		#notice_write:hover {
			
			background-color: black;
			color: white;
		}
		
		.revised_content{
			width: 100%;
			height: 150px;
		}
		
		.reviseBtn {
			padding: 5px 15px;
			border: solid 2px black;
			background-color: white;
			color: black;
			font-family: 'Nanum Gothic', sans-serif;
			font-weight: bold;
		}		
		
		#notice_pageBar ul {
			list-style: none;
		}
		
		#notice_pageBar ul li {
			display: inline-block;
			margin: 0px 3px;
		}
		
		#notice_pageBar ul li a {
			color: black;
			text-decoration: none;
		}
		
	}








	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
		$(".not_content").css("display","none");
		
		
		
		// 관리자 계정으로 공지사항 글 쓰기
		$("#notice_write").click(function(){
			
			location.href = "<%= request.getContextPath()%>/notice/write.bc";
			
		});
		
		
		
	}); // end of document ready ----------------------------------------
	
	
	// 공지사항 내용 보이기
	function not_goClick(number){
		
		var display = $(".not_content"+number).css("display");
		
		if(display =="none"){
			$(".not_content").css("display","none");
			$(".not_content"+number).css("display","table-row");
		}
		else {
			$(".not_content"+number).css("display","none");
		}
		
	} // end of not_goClick ----------------------------------------------
	
	
	// 관리자가 공지사항 수정하기	
	function goReviseNotice(number){
		
		location.href="write.bc?no="+number+"&revise=1";
		
	} // end of goReviseNotice ----------------------------------------------
	
	
	// 관리자가 공지사항 삭제하기
	function goDeleteNotice(number){
		
		location.href="delete.bc?no="+number;
	}
	
	
</script>


<title>공지사항 | 여기는어때</title>
<body>


	<div id="notice_container">
		<div id="notice_sideinfo" style="width:20%;float:left;">
	    	
	        <ul>
	        
	        	<li><a href="<%=request.getContextPath()%>/notice/main.bc" style="color: red;">공지사항</a></li>
	        	<li><a href="<%=request.getContextPath()%>/event/main.bc">이벤트</a></li>
	            <li><a href="<%=request.getContextPath()%>/question/main.bc">자주 묻는 질문</a></li>
	            <li><a href="<%=request.getContextPath()%>/faq/main.bc">1대1 문의</a></li>
	        
	        </ul>
	        
	    </div>



		<div id="notice_body" >
		
			
			<div id="notice_header">
				<div>공지사항</div>
			</div>
			
			<div id="notice_content">
				
				<table style="border-collapse: collapse; width:90%; text-align: center; border-bottom: solid 2px black; border-top: solid 2px black;">
				
					<thead>
						<tr>
							<th style="width: 10%;">번호</th>
							<th style="width: 70%;">제목</th>
							<th style="width: 20%;">작성일</th>
						</tr>
					</thead>
				
					<tbody style="font-family: 'Nanum Gothic', sans-serif;">
						
						<c:if test="${ not empty noticeList }">
						
							<c:forEach var="vo" items="${noticeList}" >
							
								<tr style="border-bottom: solid 1px #b3b3b3; border-top: solid 1px #b3b3b3;" onclick="not_goClick('${vo.no}')">
									<td>${ vo.no }</td>
									<td><div class="not_title">${ vo.title }</div></td>
									<td style="color: #808080;">
										${ vo.writeday }
										<c:if test="${ sessionScope.loginadmin != null && vo.reviseday != null }">
											<br><span style="color:red; font-size:9pt;">${ vo.reviseday } 에 수정됨</span>
										</c:if>
									</td>
								</tr>
								<tr class="not_content not_content${vo.no}">
									<td> </td>
									<td style="padding-left: 25px;">${ vo.content }
										<c:if test="${ sessionScope.loginadmin != null }">
											<br>
											<button class="reviseBtn" type="button" onclick="goReviseNotice('${vo.no}')">수정하기</button>
											<button class="reviseBtn" type="button" onclick="goDeleteNotice('${vo.no}')">삭제하기</button>
										</c:if>
									</td>
									<td> </td>
								</tr>
							</c:forEach>
							
						</c:if>
						
						<c:if test="${ empty noticeList }">
							<tr>
								<td colspan="3">공지사항이 없습니다.</td>
							</tr>
						</c:if>
						
					</tbody>
				
				</table>
				
			</div>
			
			<c:if test="${ sessionScope.loginadmin != null }">
				<div style="width:90%; text-align: right;">
					<button type="button" id="notice_write" >공지사항 글쓰기</button>
				</div>
			</c:if>
			
			<div id="notice_pageBar" align="center" style="width:90%;">
				<c:if test="${ not empty pageBar }">
					${ pageBar }
				</c:if>
			</div>
		
		</div>
		
	</div>	
		
	
	









</body>
</html>