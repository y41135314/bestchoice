<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1대1 문의 관리자페이지 | 여기는어때</title>

<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Jua&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style type="text/css">

	@media ( max-width : 991px) {
		
		#faq_container {
			width: 100%;
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
		
		#faq_admin_body {
			width:100%;
			padding: 30px 0;
		}
		
		form[name=faqSearchForm] {
			text-align: center;
	    	padding: 10px 0 30px 0;
		}
		
		form[name=faqSearchForm] select {
			border: none;
		    border-bottom: solid 3px #33cc33;
		    font-weight: bold;
		    font-size: 12pt;
		    padding: 5px 15px;
		    margin: 0 10px;
		    outline: none;
		}
		
		
		#faq_admin_body div table {
			border-collapse: collapse;
			width: 100%;
		}
		
		#faq_admin_body div table tr td {
			border: solid 1px #cccccc;
		}
		
		#faq_admin_body div table tr td:nth-child(1) {
			width: 10%;
		}
		
		#faq_admin_body div table tr td:nth-child(2) {
			width: 85%;
			padding: 20px 0;
		}
		
		.faq_member {
			border-bottom: solid 1px #cccccc;
			padding: 20px;
		}
		
		
		.faq_member > div > ul {
			list-style: none;
			text-align: left;
			padding: 0;
		}
		
		.faq_member > div > ul > li {
			display: inline-block;
			min-width: 15%;
			text-align: center;
			font-size: 9pt;
		}
		
		.faq_member_ul_li_head{
			border: solid 1px black;
			font-weight: bold;
		}
		
		.faq_member_ul_li_content {
			border-bottom: solid 1px black;
		}
		
		.faq_admin {
			padding: 20px;
		}
	
		.faq_admin_textarea textarea {
			height: 100px;
			width: 100%;
			padding: 5px;
		}
	
		.faq_admin_textarea button {
			/* width: 17%; */
			background-color: #ff8080;
		    border: solid 1px #ff8080;
		    border-radius: 4px;
		    color: white;
		    font-weight: bold; 
		    padding: 5px 15px;
		}
	
		.faq_admin_reply, .faq_admin_ajax_reply, .faq_admin_textarea {
			padding: 5px 15px;
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
		
		#faq_admin_body {
			width:75%;
			float:left; 
			padding: 30px 0;
		}
		
		form[name=faqSearchForm] {
			text-align: center;
	    	padding: 10px 0 30px 0;
		}
		
		form[name=faqSearchForm] select {
			border: none;
		    border-bottom: solid 3px #33cc33;
		    font-weight: bold;
		    font-size: 12pt;
		    padding: 5px 15px;
		    margin: 0 10px;
		    outline: none;
		}
		
		
		#faq_admin_body div table {
			border-collapse: collapse;
			width: 100%;
		}
		
		#faq_admin_body div table tr td {
			border: solid 1px #cccccc;
		}
		
		#faq_admin_body div table tr td:nth-child(1) {
			width: 10%;
		}
		
		#faq_admin_body div table tr td:nth-child(2) {
			width: 85%;
			padding: 20px 0;
		}
		
		.faq_member {
			border-bottom: solid 1px #cccccc;
			padding: 20px;
		}
		
		
		.faq_member > div > ul {
			list-style: none;
			text-align: left;
			padding: 0;
		}
		
		.faq_member > div > ul > li {
			display: inline-block;
			min-width: 15%;
			text-align: center;
			font-size: 9pt;
		}
		
		.faq_member_ul_li_head{
			border: solid 1px black;
			font-weight: bold;
		}
		
		.faq_member_ul_li_content {
			border-bottom: solid 1px black;
		}
		
		.faq_admin {
			padding: 20px;
		}
	
		.faq_admin_textarea textarea {
			height: 100px;
			width: 100%;
			padding: 5px;
		}
	
		.faq_admin_textarea button {
			/* width: 17%; */
			background-color: #ff8080;
		    border: solid 1px #ff8080;
		    border-radius: 4px;
		    color: white;
		    font-weight: bold;
		    padding: 5px 15px;
		}
	
		.faq_admin_reply, .faq_admin_ajax_reply, .faq_admin_textarea {
			padding: 5px 15px;
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
			
	}
	
	

	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$(".faq_admin_ajax_reply").css("display","none");
		
		// 넘어온 값 받기
		var category = "${category}";
		var period = "${period}";
		var replyStatus = "${replyStatus}";
		
		if(category != null && category != "") $("form[name=faqSearchForm] select[name=category]").val(category);
		if(period != null && period != "") $("form[name=faqSearchForm] select[name=period]").val(period);
		if(replyStatus != null && replyStatus != "") $("form[name=faqSearchForm] select[name=replyStatus]").val(replyStatus);
		
		// 카테고리 변경
		$("form[name=faqSearchForm] select").bind("change",function(){
			
			var frm = document.faqSearchForm;
			frm.method="GET";
			frm.action = "<%= request.getContextPath()%>/faq/main.bc";
			frm.submit();
			
		});
		
		
		
		
	}); // end of document ready --------------------------------------------------
	
	
	
	// 답변 등록하기 메소드
	function goReplyInsert(number){
		
		var insertConfirm = confirm('답변은 수정이 불가합니다. 정말 입력하시겠습니까?');
		   if (insertConfirm) {
				
			   content = $(".faq_admin_textarea"+number+" textarea[name=content]" ).val() ;
			   var reply_content = content.replace(/(?:\r\n|\r|\n)/g, '<br>');
			   
			   
				$.ajax({
				
					url: "<%= request.getContextPath() %>/faq/adminWrite.bc",
					type: "POST",
					data: { "no":number , "reply_content": reply_content  },
					dataType: "json",
					success: function(json){
						
						if(json.msg == 'success'){
							
							alert("답변을 등록했습니다.");
							
							$(".faq_admin_textarea"+number).css("display","none");
							$(".faq_admin_ajax_reply"+number).css("display","");
							$(".faq_admin_ajax_reply"+number).html(json.rep_content);
						}
						else {
							alert("답변 등록에 실패했습니다.");
						}
						
					}, 
					error: function(request, status, error){
						
						alert("code: "+request.status+"\n"+"message: "+request.responseTest+"\n"+"error: "+error);
					}
					
				});   
		   
		   }
		   else {
			   
			  $(".faq_admin_textarea"+number+" textarea[name=content]" ).val("");
		      return false;
		   }
		
		
		
		
	} // end of goReplyInsert -----------------------------------------
	
	
	
	
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
	    
		<div id="faq_admin_body" >
			
			<div style="border-bottom: solid 3px red; font-family: 'Nanum Gothic', sans-serif; font-weight: bold; font-size: 20pt;
				padding: 10px; margin-bottom: 15px;">
				FAQ 관리자 페이지
			</div>
			
			<div>
				<form name="faqSearchForm">
				
					<select name="category">
						<option value="0">카테고리 전체 보기</option>
						<option value="1">이벤트</option>
						<option value="2">예약/결제</option>
						<option value="3">이용문의</option>
						<option value="4">회원정보</option>
						<option value="5">리뷰</option>
						<option value="6">기타</option>
					</select>
					
					<select name="period">
						<option value="0">기간 전체 보기</option>
						<option value="1">7일 이내 보기</option>
						<option value="2">30일 이내 보기</option>
					</select>
					
					<select name="replyStatus">
						<option value="0">전체 보기</option>
						<option value="1">답변대기중만 보기</option>
						<option value="2">답변완료만 보기</option>
					</select>
					
				</form>
			</div>
				
			<div>
				<table style="font-family: 'Nanum Gothic', sans-serif;">
					
					<thead>
						<tr style="border: solid 2px #bf80ff;">
							<td style="text-align: center; font-weight: bold; padding: 15px 0; background-color:#bf80ff; color:white;">글번호</td>
							<td style="text-align: center; font-weight: bold; background-color:#bf80ff; color:white;">내역</td>
						</tr>
					</thead>
					
					<tbody>
						<c:if test="${ not empty faqList }">
							
							<c:forEach items="${ faqList }" var="vo"> 
								<tr style="border:solid 2px #737373;">
									
									<td style="text-align: center;">${vo.no}</td>
									<td>
										
										<div class="faq_member">
											<div>
												<ul>
													<li class="faq_member_ul_li_head">문의유형</li>
													<li class="faq_member_ul_li_content">${vo.type_str}</li>
													<li class="faq_member_ul_li_head">휴대폰</li>
													<li class="faq_member_ul_li_content">
														<c:if test="${ vo.phone != null }">${vo.phone }</c:if>
														<c:if test="${ vo.phone == null }">X</c:if>
													</li>
													<li class="faq_member_ul_li_head">등록일</li>
													<li class="faq_member_ul_li_content">${vo.writeday }</li> 
												</ul>	
											</div>
											<div>
												<span style="font-weight:bold;">▷ 사용자 질문 내역</span><br>
												<div style="padding: 5px 15px; ">
													${vo.content }
												</div>
											</div>
										</div>
										
										<div class="faq_admin">
											
											<c:if test="${ vo.rep_no == null }">
											
												<span style="font-weight:bold;">▶ 관리자 답변 내역</span><br>
												
												<div class="faq_admin_textarea faq_admin_textarea${vo.no}">
													<textarea name="content" placeholder="답변이 없습니다. 답변을 등록해주세요."></textarea><br>
													<div style="text-align: right;">
														<button type="button" onclick="goReplyInsert('${vo.no}')">답변 등록하기</button>
													</div>
												</div>
												
												<div class="faq_admin_ajax_reply faq_admin_ajax_reply${vo.no}">
												</div>
												
											</c:if>
											
											<c:if test="${ vo.rep_no != null }">
												<div>
													<span style="font-weight:bold;">▶ 관리자 답변 내역</span>
													&nbsp;&nbsp;
													<span style="font-size:9pt; color:#ff4d4d;">
														관리자 ${vo.rep_admin_idx}님이  ${ vo.rep_writeday }에 작성하셨습니다.
													</span>
													<div class="faq_admin_reply">
														${vo.rep_content}
													</div>
												</div>
											</c:if>
											
										</div>
									
									</td>
									
								</tr>
							</c:forEach>	
							
						</c:if> 
						
						<c:if test="${empty faqList }">
							
							<tr>
								<td colspan="2" style="text-align: center; padding: 40px 0;">조건에 맞는 FAQ 가 없습니다.</td>
							</tr>
							
						</c:if>
						
					</tbody>
				</table>
				
			</div>
			

			<div id="faq_pageBar">
				${ pageBar }
			</div>

		</div>
	</div>
	
	
</body>
</html>