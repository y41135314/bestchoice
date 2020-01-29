<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 자주 묻는 질문 | 여기는어때</title>

<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Jua&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style type="text/css">

	@media ( max-width : 991px) {
		
		#question_sideinfo {
			
			display:none;
		}
		
		#question_body {
			width:100%;
			padding: 30px 0;
		}
		
		#question_navbar ul {
			list-style: none;
			padding: 0;
			text-align: center;
		}
		
		#question_navbar ul li {
			display: inline-block;
			border-bottom: solid 2px white;
			padding: 15px;
			font-family: 'Nanum Gothic', sans-serif;
			text-decoration: none;
			cursor: pointer;
			color: black;
		}
		
		/* 화면 로딩되었을 때 해당 카테고리에 줄 액티브 클래스 */
		.question_navbar_active {
			color: red !important;
			font-weight: bold;
			border-bottom: solid 2px red !important;
		}
		
		#question_content {
			/* border-top: solid 1px #f2f2f2; */
		}
		
		#question_content table {
			width: 100%;
		}
		
		#question_content table td {
			border-top:solid 1px #bfbfbf;
			border-bottom: solid 1px #bfbfbf;
			padding: 30px 15px ;
		}
		
		.questionDetail {
			background-color: #f2f2f2;
		}
		
		.reviseBtn {
		padding: 5px 15px;
		border: solid 2px black;
		background-color: white;
		color: black;
		font-family: 'Nanum Gothic', sans-serif;
		font-weight: bold;
	}	
	}
	
	
	@media ( min-width : 992px) {
	
		#question_container {
			width: 80%;
			margin:0 auto;
		}
	
		#question_sideinfo ul {
			list-style: none;
			padding: 30px 0;
		}
		
		#question_sideinfo ul li {
			margin-bottom: 20px;
			font-family: 'Jua', sans-serif;
			font-size: 16pt;
		}
		
		#question_sideinfo ul li a {
			text-decoration: none;
			color:  #bfbfbf;
			word-spacing: -2px;
		}
		
		#question_body {
			width:80%;
			float:left;
			padding: 30px 0;
		}
		
		#question_navbar ul {
			list-style: none;
			padding: 0;
			text-align: center;
		}
		
		#question_navbar ul li {
			display: inline-block;
			border-bottom: solid 2px white;
			padding: 15px;
			font-family: 'Nanum Gothic', sans-serif;
			text-decoration: none;
			cursor: pointer;
			color: black;
		}
		
		/* 화면 로딩되었을 때 해당 카테고리에 줄 액티브 클래스 */
		.question_navbar_active {
			color: red !important;
			font-weight: bold;
			border-bottom: solid 2px red !important;
		}
		
		#question_content {
			/* border-top: solid 1px #f2f2f2; */
		}
		
		#question_content table {
			width: 100%;
		}
		
		#question_content table td {
			border-top:solid 1px #bfbfbf;
			border-bottom: solid 1px #bfbfbf;
			padding: 30px 15px ;
		}
		
		.questionDetail {
			background-color: #f2f2f2;
		}
		
		.reviseBtn {
		padding: 5px 15px;
		border: solid 2px black;
		background-color: white;
		color: black;
		font-family: 'Nanum Gothic', sans-serif;
		font-weight: bold;
	}	
		
	}






</style>

<script>
	
	$(document).ready(function(){
		
		$(".questionDetail").css("display","none");
		
		var category = "${ category }";
		
		if(category == null || category == ""){
			$("#question_category1").addClass("question_navbar_active");
		}
		else {
			$("#question_category"+category).addClass("question_navbar_active");
		}
		
		
		
	}); // end of document ready -------------------------------------------
	
	// 카테고리 이동하기
	function goCategory(number){
		
		location.href = "<%= request.getContextPath()%>/question/main.bc?category="+number;
		
	} // end of goCategory -----------------------------------------------
	
	// 자주묻는질문 내용 보이기
	function goQuestionDetail(number){
		
		var display = $(".questionDetail"+number).css("display");
		
		if(display == "none"){
			
			$(".questionDetail").css("display","none");
			$(".questionDetail"+number).css("display","table-row");
		}
		else {
			$(".questionDetail").css("display","none");
		}
		
	} // end of goQuestionDetail ----------------------------------------
	
	
	// 자주묻는질문 수정하기
	function goQuestionRevise(number){
		
		location.href="write.bc?revise=1&no="+number;
		
	} // end of goQuestionRevise ----------------------------------------
	
	// 자주묻는질문 삭제하기
	function goQuestionDelete(number){
		
		location.href="delete.bc?no="+number;
	}
	
</script>

</head>
<body>

	<div id="question_container">
	
		<div id="question_sideinfo" style="width:20%;float:left;">
	    	
	        <ul>
	        
	        	<li><a href="<%=request.getContextPath()%>/notice/main.bc">공지사항</a></li>
	        	<li><a href="<%=request.getContextPath()%>/event/main.bc">이벤트</a></li>
	            <li><a href="<%=request.getContextPath()%>/question/main.bc" style="color: red;">자주 묻는 질문</a></li>
	            <li><a href="<%=request.getContextPath()%>/faq/main.bc">1대1 문의</a></li>
	        
	        </ul>
	        
	    </div>
	    
	    <div id="question_body">
	    	<div id="question_navbar">
	    		<ul>
	    			<li id="question_category1" onclick="goCategory(1)">TOP6</li>
	    			<li id="question_category2" onclick="goCategory(2)">이용문의</li>
	    			<li id="question_category3" onclick="goCategory(3)">예약취소</li>
	    			<li id="question_category4" onclick="goCategory(4)">결제/영수증</li>
	    			<li id="question_category5" onclick="goCategory(5)">예약문의</li>
	    			<li id="question_category6" onclick="goCategory(6)">쿠폰/포인트</li>
	    			<li id="question_category7" onclick="goCategory(7)">회원정보</li>
	    			<li id="question_category8" onclick="goCategory(8)">리뷰</li>
	    		</ul>
	    	</div>
	    	
	    	<div id="question_content">
	    		<table> 
		    		<c:if test="${ not empty questionList }">
		    			
		    			<c:forEach var="vo" items="${ questionList }">
		    			
		    				<tr onclick="goQuestionDetail('${vo.no}')" style="cursor:pointer;">
		    					<td>${ vo.title }</td>
		    				</tr>
		    				<tr class="questionDetail questionDetail${vo.no}">
		    					<td style="padding-left: 30px;">
		    						${ vo.content }
		    						
		    						<c:if test="${ sessionScope.loginadmin != null }">
		    							<br>
		    							<c:if test="${ vo.reviseday != null }">
		    								<br><span style="color: red; font-size: 9pt;">${ vo.reviseday }에 수정됨</span>
		    							</c:if>
		    							<br>
		    							<button class="reviseBtn" type="button" onclick="goQuestionRevise('${vo.no}')">수정하기</button>
		    							<button class="reviseBtn" type="button" onclick="goQuestionDelete('${vo.no}')">삭제하기</button>
		    						</c:if>
		    					</td>
		    				</tr>
		    			</c:forEach>
		    			
		    		</c:if>
		    		
		    		<c:if test="${ empty questionList }">
		    			
		    			<tr>
		    				<td style="text-align: center;">자주묻는 질문이 없습니다.</td>
		    			</tr>
		    			
		    		</c:if>
	    		</table>
	    		<c:if test="${ sessionScope.loginadmin != null }">
		    		<div style="text-align: right; padding: 20px 0;">
		    			<button type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/question/write.bc'"
		    			style="border: solid 2px black; background-color: #cc00cc; color:white; font-weight:bold; padding: 5px 10px;">자주묻는질문 작성하기</button>
		    		</div>
	    		</c:if>
	    	</div>
	    </div>

	</div>

</body>
</html>