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
	#faq_container {
		width: 60%;
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
	
	.faq_det td div {
		margin: 5px 0;
		font-family: 'Nanum Gothic', sans-serif;
	}
	
	.myfaq_reply {
		border: solid 1px black;
		border-radius: 4px;
		padding: 2px;
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
			$(".faq_det"+number).css("display","table-row");
		}
		else {
			$(".faq_det"+number).css("display","none");
		}
		
		
	} // end of goDetail ----------------------------------------------
	
	// 답변 등록하기 메소드
	function goReplyInsert(number){
		
		var reply_content = $("form[name=replyInsertForm"+number+"] textarea[name=replyContent]").val();
		
		/* $.ajax({
			
			url: "",
			type: "POST",
			data: { "no":number , "reply_content": reply_content  },
			dataType: "json",
			success: function(json){
				
				
			}, 
			error: function(request, status, error){
				
				alert("code: "+request.status+"\n"+"message: "+request.responseTest+"\n"+"error: "+error);
			}
			
		}); */
		
	} // end of goReplyInsert -----------------------------------------
	
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
		var bool = regExp.test(faq_phone);
		
		if(bool == false){
			alert("휴대폰 번호는 10~11 자리의 숫자로 입력해주세요.");
			return false;
		}
		
		
		var faq_content = $("form[name=faqWriteForm] textarea[name=content]").val().trim();
		
		if(faq_content.length < 10){
			alert("질문 내용은 10글자 이상 입력해주셔야 합니다.");
			return false;
		}
		
		var frm = document.faqWriteForm;
		frm.method = "POST";
		frm.action = "";
		// frm.submit();
		
	} // end of goFaqInsert -------------------------------------------------
	
</script>

</head>
<body>
	
	
	<div id="faq_container">
	
		<div id="faq_sideinfo" style="width:20%;float:left;">
	    	
	        <ul>
	        	<li><a href="">공지사항</a></li>
	        	<li><a href="">이벤트</a></li>
	            <li><a href="">자주 묻는 질문</a></li>
	            <li><a href="" style="font-weight: bold; color: red;">1대1 문의</a></li>
	        </ul>
	        
	    </div>
	    
		<div id="faq_body" style="width:70%;float:left; padding: 30px 0;">
			
			<div id="faq_navbar">
				<ul style="border-bottom: solid 1px #f2f2f2;">
					<li class="faq_navbar_list" id="faq_myFaq">나의 문의내역</li>
					<li class="faq_navbar_list" id="faq_newFaq">새 문의 작성</li>
				</ul>
			</div>
			
			<div id="faq_content">
			
				<div id="myFaq">
				
					
					<%-- <c:if test="${ faqList != null }"> --%>
						<table>
							<%-- <c:forEach var="map" items="${ faqList }">  --%>
						
							<tr style="cursor: pointer;" onclick="goDetail('${map.no}')">
								<td style="width: 20%;">유형</td>
								<td style="width: 50%;">문의</td>
								<td>
									<c:if test="${ map.reply == null }"><span class="myfaq_reply">문의등록</span></c:if>
									<c:if test="${ map.reply != null }"><span class="myfaq_reply" style="color:red;">답변완료</span></c:if>
								</td>
								<td>작성일</td>
							</tr>
							<tr class="faq_det faq_det${map.no}">
								<td colspan="4" style="padding: 20px 0 20px 30px; background-color: #f2f2f2;">
									<div style="font-weight:bold;">문의</div>
									<div>질의한 내용은 이것</div>
									
									<%-- <c:if test="${ map.reply != null }"> --%>
										<br>
										<div style="padding-left: 5px;">
											<div style="font-weight:bold;">▶ 답변</div>
											<div>관리자의 답변은 이것</div>
										</div>
									<%-- </c:if> --%>
									
									<c:if test="${ map.reply == null && sessionScope.loginuser.email == 'admin@admin.com' }">
										<br>
										<form name="replyInsertForm${map.no}">
											<textarea name="replyContent" id="reply_content" maxlength="1000" placeholder="답변은 수정이 어렵습니다. 신중하게 부탁드립니다."></textarea>
											<button type="button" class="replyRegisterBtn" onclick="goReplyInsert('${map.no}')">답변 등록하기</button>
										</form>
									</c:if>
									
								</td>
							</tr>
						
							<%-- </c:forEach> --%>
						</table>
					 <%-- </c:if>
					
					<c:if test="${ faqList == null }">  --%>
						
						<div style="text-align: center; padding-top: 50px;">
							<div style="font-weight: bold; font-family: 'Nanum Gothic', sans-serif; font-size:16pt;">등록된 1:1 문의가 없습니다.</div>
							<div style="color: #999999; margin-top: 20px;">여기는어때는 회원님들의 소중한 의견에 귀기울여</div>
							<div style="color: #999999; margin-top: 5px;">신속하고 정확하게 답변드리도록 하겠습니다.</div>
						</div>
					
					<%-- </c:if> --%>
					
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
							<input type="text" name="phone" placeholder="선택사항입니다." style="height:25px;">
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