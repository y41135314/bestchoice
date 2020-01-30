<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1대1 문의 | 여기는어때</title>

<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Jua&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style type="text/css">

	@media ( max-width : 991px) {
		
		#faq_container {
			width: 80%;
			margin:0 auto;
		}
	
		#faq_sideinfo ul {
			display:none;
			list-style: none;
			padding: 30px 0;
		}
		
		#faq_sideinfo ul li {
			margin-bottom: 20px;
			font-family: 'Jua', sans-serif;
			font-size: 16pt;
		}
		
		#faq_sideinfo ul li a {
			text-decoration: none;
			color:  #bfbfbf;
			word-spacing: -2px;
		}
		
		.faq_navbar_list {
			display: inline-block;
			list-style: none;
			cursor: pointer;
			font-size: 14pt;
			margin-right: 15px;
			font-family: 'Nanum Gothic', sans-serif;
			color :  #999999;
			padding-bottom: 10px;
		}
		
		.faq_active {
			border-bottom: solid 3px red;
			color: red;
			font-weight: bold;
		}
		
		#faq_body {
			width:100%;
			/* float:left;  */
			padding: 30px 0;
		}
		
		#myFaq table {
			width:100%; 
			border-collapse: collapse;
			margin-top: 50px;
		}
		
		#myFaq table td {
			border-top: solid 1px #999999;
			border-bottom: solid 1px #999999;
			padding: 20px 0;
		}
		
		#faq_pageBar {
			width: 90%;
			text-align: center;
			padding-top: 20px;
		}
		
		#faq_pageBar ul li {
			display: inline-block;
	    	margin: 0px 3px;
		}
		
		#faq_pageBar ul li a {
			color: black;
		}
		
		.faq_det td div {
			margin: 5px 0;
			font-family: 'Nanum Gothic', sans-serif;
		}
		
		.myfaq_reply {
			border: solid 1px black;
			border-radius: 4px;
			padding: 2px;
			font-weight: bold;
		}
		
		#insertFaq {
			font-size: 12pt;
		}
		
		#insertFaq form[name=faqWriteForm] button {
			padding: 5px 15px;
			border: solid 2px black;
			color : black;
			background-color: white;
			font-family: 'Nanum Gothic', sans-serif;
			font-weight: bold;
			cursor: pointer;
			font-size: 12pt;
		}
		
		#insertFaq form[name=faqWriteForm] input , #insertFaq form[name=faqWriteForm] textarea {
			padding: 5px 15px;
			width: 94%;
			font-size: 12pt;
			font-family: 'Nanum Gothic', sans-serif;
		}
		
		#insertFaq form[name=faqWriteForm] div {
			margin-bottom: 10px;
		}
		
	}


	@media ( min-width : 992px) {
		
		#faq_container {
			width: 80%;
			margin:0 auto;
		}
	
		#faq_sideinfo ul {
			list-style: none;
			padding: 30px 0;
		}
		
		#faq_sideinfo ul li {
			margin-bottom: 20px;
			font-family: 'Jua', sans-serif;
			font-size: 16pt;
		}
		
		#faq_sideinfo ul li a {
			text-decoration: none;
			color:  #bfbfbf;
			word-spacing: -2px;
		}
		
		.faq_navbar_list {
			display: inline-block;
			list-style: none;
			cursor: pointer;
			font-size: 14pt;
			margin-right: 15px;
			font-family: 'Nanum Gothic', sans-serif;
			color :  #999999;
			padding-bottom: 10px;
		}
		
		.faq_active {
			border-bottom: solid 3px red;
			color: red;
			font-weight: bold;
		}
		
		#faq_body {
			width:70%;
			float:left; 
			padding: 30px 0;
		}
		
		#myFaq table {
			width:100%; 
			border-collapse: collapse;
			margin-top: 50px;
		}
		
		#myFaq table td {
			border-top: solid 1px #999999;
			border-bottom: solid 1px #999999;
			padding: 20px 0;
		}
		
		#faq_pageBar {
			width: 90%;
			text-align: center;
			padding-top: 20px;
		}
		
		#faq_pageBar ul li {
			display: inline-block;
	    	margin: 0px 3px;
		}
		
		#faq_pageBar ul li a {
			color: black;
		}
		
		.faq_det td div {
			margin: 5px 0;
			font-family: 'Nanum Gothic', sans-serif;
		}
		
		.myfaq_reply {
			border: solid 1px black;
			border-radius: 4px;
			padding: 2px;
			font-weight: bold;
		}
		
		#insertFaq {
			font-size: 12pt;
		}
		
		#insertFaq form[name=faqWriteForm] button {
			padding: 5px 15px;
			border: solid 2px black;
			color : black;
			background-color: white;
			font-family: 'Nanum Gothic', sans-serif;
			font-weight: bold;
			cursor: pointer;
			font-size: 12pt;
		}
		
		#insertFaq form[name=faqWriteForm] input , #insertFaq form[name=faqWriteForm] textarea {
			padding: 5px 15px;
			width: 94%;
			font-size: 12pt;
			font-family: 'Nanum Gothic', sans-serif;
		}
		
		#insertFaq form[name=faqWriteForm] div {
			margin-bottom: 10px;
		}
	}


	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$(".faq_det").css("display", "none");
		
		$("#faq_myFaq").addClass("faq_active");
		$("#insertFaq").css("display","none");
		
		// 나의 질문 내역들 보여주기
		$("#faq_myFaq").click(function(){
			
			$(".faq_navbar_list").removeClass("faq_active");
			$("#faq_myFaq").addClass("faq_active");
			
			$("#insertFaq").css("display","none");
			$("#myFaq").css("display","");
			
			var frm = document.faqWriteForm;
			frm.reset();
			
		});
		
		// 질문하기
		$("#faq_newFaq").click(function(){
			
			$(".faq_navbar_list").removeClass("faq_active");
			$("#faq_newFaq").addClass("faq_active");
			
			$("#myFaq").css("display","none");
			$("#insertFaq").css("display","");
			
		});
		
	}); // end of document ready --------------------------------------------------
	
	// 디테일 정보 보이기
	function goDetail(number){
		
		var display = $(".faq_det"+number).css("display");
		
		if(display =="none"){
			$(".faq_det").css("display","none");
			$(".faq_det"+number).css("display","table-row");
		}
		else {
			$(".faq_det"+number).css("display","none");
		}
		
		
	} // end of goDetail ----------------------------------------------
	
	
	
	// 문의글 등록하기
	function goFaqInsert(){
		
		var type = $("form[name=faqWriteForm] select[name=type]").val();
		
		if(type ==""){
			alert("문의 유형을 선택해주세요.");
			return false;
		}
		
		// 정규표현식
		var faq_phone = $("form[name=faqWriteForm] input[name=phone]").val().trim();
		var regExp = /^[0-9]{10,11}$/;
		var bool1 = regExp.test(faq_phone);
		
		if(bool1 == false){
			
			if( faq_phone != "" ){
				alert("휴대폰 번호는 10~11 자리의 숫자로 입력해주세요.");
				return false;
			}
			
		}
		
		
		var faq_content = $("form[name=faqWriteForm] textarea[name=content]").val().trim();
		
		if(faq_content.length < 10){
			alert("질문 내용은 10글자 이상 입력해주셔야 합니다.");
			return false;
		}
		
		var frm = document.faqWriteForm;
		frm.method = "POST";
		frm.action = "<%= request.getContextPath()%>/faq/memberWrite.bc";
		frm.submit();
		
	} // end of goFaqInsert -------------------------------------------------
	
</script>

</head>
<body>
	
	
	<div id="faq_container">
	
		<div id="faq_sideinfo" style="width:20%;float:left;">
	    	
	        <ul>
	        	<li><a href="<%=request.getContextPath()%>/notice/main.bc">공지사항</a></li>
	        	<li><a href="<%=request.getContextPath()%>/event/main.bc">이벤트</a></li>
	            <li><a href="<%=request.getContextPath()%>/question/main.bc">자주 묻는 질문</a></li>
	            <li><a href="<%=request.getContextPath()%>/faq/main.bc" style="color: red;">1대1 문의</a></li>
	        </ul>
	        
	    </div>
	    
		<div id="faq_body" >
			
			<div id="faq_navbar">
				<ul style="border-bottom: solid 1px #f2f2f2;">
					<li class="faq_navbar_list" id="faq_myFaq">나의 문의내역</li>
					<li class="faq_navbar_list" id="faq_newFaq">새 문의 작성</li>
				</ul>
			</div>
			
			<div id="faq_content">
			
				<div id="myFaq" style="min-height:350px;">
					
					<c:if test="${ faqList != null }"> 
						<table>
							<c:forEach var="vo" items="${ faqList }">  
						
							<tr style="cursor: pointer;" onclick="goDetail('${vo.no}')">
								<td style="width: 20%; font-weight: bold;">${vo.type_str}</td>
								<td style="width: 50%;">${ vo.content_short }</td>
								<td>
									<c:if test="${ vo.rep_no == null }"><span class="myfaq_reply">답변대기중</span></c:if>
									<c:if test="${ vo.rep_no != null }"><span class="myfaq_reply" style="color:red;">답변완료</span></c:if>
								</td>
								<td>${vo.writeday }</td>
							</tr>
							<tr class="faq_det faq_det${vo.no}">
								<td colspan="4" style="padding: 20px 0 20px 30px; background-color: #f2f2f2;">
									<div style="font-weight:bold;">문의</div>
									<div>${ vo.content }</div>
									
									<c:if test="${ vo.rep_no != null }"> 
										<br>
										<div style="padding-left: 5px;">
											<div style="font-weight:bold;">▶ 답변 
											<span style="font-size: 9pt;font-weight: 100;">작성일 ${ vo.rep_writeday }</span></div>
											<div>${ vo.rep_content }</div>
										</div>
									</c:if> 
									
								</td>
							</tr>
						
							</c:forEach>
						</table>
					 </c:if>
					
					<c:if test="${ faqList == null }">  
						
						<div style="text-align: center; padding-top: 50px;">
							<div style="font-weight: bold; font-family: 'Nanum Gothic', sans-serif; font-size:16pt;">등록된 1:1 문의가 없습니다.</div>
							<div style="color: #999999; margin-top: 20px;">여기는어때는 회원님들의 소중한 의견에 귀기울여</div>
							<div style="color: #999999; margin-top: 5px;">신속하고 정확하게 답변드리도록 하겠습니다.</div>
						</div>
					
					</c:if> 
					
					<div id="faq_pageBar">
						${pageBar}
					</div>
					
				</div>
				
				
				<div id="insertFaq">
					<div>
					
						<div style="margin: 30px 0;font-family: 'Nanum Gothic', sans-serif;">
							여기는어때 이용 중 불편하신 점을 문의주시면 최대한 빠른 시일 내에 답변 드리겠습니다.
						</div>
						
						<form name="faqWriteForm">
							
							<div>문의유형</div>
							<select name="type" style="width:97%;height:35px;font-size: 12pt; padding: 5px;">
								<option value="">문의 유형을 선택하세요.</option>
								<option value="1">이벤트</option>
								<option value="2">예약/결제</option>
								<option value="3">이용문의</option>
								<option value="4">회원정보</option>
								<option value="5">리뷰</option>
								<option value="6">기타</option>
							</select>
							<br><br>
							
							<div>휴대폰 번호 ( -를 빼고 입력해주세요 ) </div>
							<input type="text" name="phone" placeholder="선택사항입니다." style="height:35px;">
							<br><br>
							
							<div>문의 내용</div>
							<textarea name="content" style="height:150px;" maxlength="1000" 
							placeholder="문의하실 내용을 10자 이상 입력해주세요. 
							
휴대폰 번호는 유선 답변을 위해 수집되며, 답변 완료 후 즉시 삭제합니다."></textarea>
							<br><br>
							<div align="center"><button type="button" onclick="goFaqInsert()" >작성완료</button></div>
							
						</form>
						
					</div>
				</div>
			</div>
			
		</div>
	</div>
	
	
	
</body>
</html>