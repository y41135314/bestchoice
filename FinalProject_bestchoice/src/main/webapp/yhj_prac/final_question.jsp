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
	#question_container {
		width: 60%;
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
		border-top: solid 1px #f2f2f2;
	}
	
</style>

<script>
	
	$(document).ready(function(){
		
		var category = "${ category }";
		$("#question_category"+category).addClass("question_navbar_active");
		
		
	}); // end of document ready -------------------------------------------
	
	function goCategory(number){
		
		location.href = "?category="+number;
		
	} // end of goCategory -----------------------------------------------
	
</script>

</head>
<body>

	<div id="question_container">
	
		<div id="question_sideinfo" style="width:20%;float:left;">
	    	
	        <ul>
	        
	        	<li><a href="">공지사항</a></li>
	        	<li><a href="">이벤트</a></li>
	            <li><a href="" style="font-weight: bold; color: red;">자주 묻는 질문</a></li>
	            <li><a href="">1대1 문의</a></li>
	        
	        </ul>
	        
	    </div>
	    
	    <div id="question_body">
	    	<div id="question_navbar">
	    		<ul>
	    			<li id="question_category1" onclick="goCategory(1)">TOP7</li>
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
	    		 
	    		<c:if test="${ questionList != null }">
	    			
	    			<c:forEach var="map" items="${ questionList }">
	    			
	    				
	    				
	    			</c:forEach>
	    			
	    		</c:if>
	    		
	    		<c:if test="${ questionList == null }">
	    			
	    		</c:if>
	    		
	    	</div>
	    </div>

	</div>

</body>
</html>