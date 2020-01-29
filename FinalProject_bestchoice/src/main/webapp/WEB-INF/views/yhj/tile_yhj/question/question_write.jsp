<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 자주 묻는 질문 글쓰기 | 여기는어때</title>

<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Jua&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style type="text/css">
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
	
	#question_write {
		float: left;
		width: 80%;
		padding: 30px 0;
	}
	
	form[name=questionWriteForm] table {
		border-collapse: collapse;
	}
	
	form[name=questionWriteForm] table td {
		padding: 20px 0;
		/* border-top: solid 1px gray; */
		border-bottom: solid 1px gray;
	}
	
	form[name=questionWriteForm] select[name=category] {
		width: 95%;
	    height: 35px;
	    font-size: 12pt;
	    font-family: 'Nanum Gothic', sans-serif;
	    padding: 5px;
	}
	
	form[name=questionWriteForm] input[name=title] {
		width:95%;
		height:35px;
		font-size: 12pt;
		font-family: 'Nanum Gothic', sans-serif;
		padding: 10px;
	}
	
	form[name=questionWriteForm] textarea[name=content] {
		width:95%;
		height:500px;
		font-size: 12pt;
		font-family: 'Nanum Gothic', sans-serif;
		padding: 10px;
	}
	
	
	
	
	form[name=questionWriteForm] button{
		background-color: white;
	    border: solid 2px black;
	    padding: 5px 20px;
	    font-weight: bold;
	    font-family: 'Nanum Gothic', sans-serif;
	    transition: 0.5s;
	}
	
	form[name=questionWriteForm] button:hover {
		background-color: black;
		color: white;
	}
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		var revise = "${revise}";
		
		if(revise != null){
			
			$("input[name=revise]").val("${revise}");
			$("input[name=no]").val("${qvo.no}")
			$("select[name=category]").val("${qvo.category}");
			$("input[name=title]").val("${qvo.title}");
		}
		
		// 등록하기 클릭
		$("#questionWriteSubmit").click(function(){
			
			var frm = document.questionWriteForm;
			
			frm.method = "POST";
			frm.action = "writeEnd.bc";
			frm.submit(); 
			
		}); // end of 등록하기 ---------------------------
		
		// 수정하기 
		$("#questionReviseSubmit").click(function(){
			
			var frm = document.questionWriteForm;
			
			frm.method = "POST";
			frm.action = "writeEnd.bc";
			frm.submit(); 
		}); // end of 수정하기 -------------------------------
		
	}); // end of document ready -------------------------------------------
	
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
	    
		<div id="question_write">
		
			<form name="questionWriteForm" style="width:90%;">
				
				<input name="revise" type="hidden">
				<input name="no" type="hidden">
				
				<div style="font-family: 'Nanum Gothic', sans-serif; font-weight: bold; font-size: 16pt; 
					color: red; padding: 15px 0; border-bottom:solid 3px red">
					자주 묻는 질문 글쓰기
				</div>
				
				<table style="width: 100%;">
					
					<tr>
						<td style=" text-align: center; font-weight:bold;">카테고리</td>
						<td>
							<select name="category" >
								<option value="1">TOP6</option>
								<option value="2">이용문의</option>
								<option value="3">예약취소</option>
								<option value="4">결제/영수증</option>
								<option value="5">예약문의</option>
								<option value="6">쿠폰/포인트</option>
								<option value="7">회원정보</option>
								<option value="8">리뷰</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<td style="width:15%; text-align: center; font-weight:bold;">글제목</td>
						<td style="width:80%;">
							<input name="title" maxlength="30">
						</td>
					</tr>
					
					<tr>
						<td style=" text-align: center; font-weight:bold;">글내용</td>
						<td>
							<textarea name="content" maxlength="1000">${qvo.content}</textarea>
						</td>
					</tr>
					
				</table>
				
				<div align="center" style="padding: 30px;">
				
					<c:if test="${ revise != null }">
						<button type="button" id="questionReviseSubmit">수정하기</button>
					</c:if>
					<c:if test="${ revise == null }">
						<button type="button" id="questionWriteSubmit">등록하기</button>
					</c:if>
					<button type="button" onclick="javascript:history.go(0);">초기화하기</button>
					<button type="button" onclick="javascript:history.back();">뒤로가기</button>
				</div>
			</form>
		</div>
	</div>
	
	
	
</body>
</html>