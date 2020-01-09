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

	#notice_container {
		width: 60%;
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
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
		$(".not_content").css("display","none");
		
		
		
		// 관리자 계정으로 공지사항 글 쓰기
		$("#notice_write").click(function(){
			
			// location.href = "<%= request.getContextPath()%>/";
			
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
		
		/* $.ajax({
			
			url: "",
			type: "POST",
			data: { "no":number , "revised_content": $("#revised_content"+number)  },
			dataType: "json",
			success: function(json){
				
				
			}, 
			error: function(request, status, error){
				
				alert("code: "+request.status+"\n"+"message: "+request.responseTest+"\n"+"error: "+error);
			}
			
		}); */
		
	} // end of goReviseNotice ----------------------------------------------
	
</script>


<title>더보기 - 공지사항 | 여기는어때</title>
<body>


	<div id="notice_container">
		<div id="notice_sideinfo" style="width:20%;float:left;">
	    	
	        <ul>
	        
	        	<li><a href="" style="font-weight: bold; color: red;">공지사항</a></li>
	        	<li><a href="">이벤트</a></li>
	            <li><a href="">자주 묻는 질문</a></li>
	            <li><a href="">1대1 문의</a></li>
	        
	        </ul>
	        
	    </div>



		<div id="notice_body" style="width:80%;float:left;">
		
			
			<div id="notice_header">
				<div>공지사항</div>
			</div>
			
			<div id="notice_content">
				
				<table style="border-collapse: collapse; width:90%; text-align: center; border-bottom: solid 2px black; border-top: solid 2px black;">
				
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성일</th>
						</tr>
					</thead>
				
					<tbody style="font-family: 'Nanum Gothic', sans-serif;">
						
						<c:if test="${ noticeList != null }">
						
							<c:forEach var="map" items="${noticeList}" >
								<tr style="border-bottom: solid 1px #b3b3b3; border-top: solid 1px #b3b3b3;">
									<td>${ map.no }</td>
									<td><div class="not_title" onclick="not_goClick('${map.no}')">${ map.title }</div></td>
									<td style="color: #808080;">${ map.writeday }${ map.reviseday }</td>
								</tr>
								<tr class="not_content not_content${map.no}">
									<td> </td>
									<td style="padding-left: 25px;">${ map.content }
										
										<c:if test="${ sessionScope.loginuser.email == 'admin@admin.com' }">
											<br>
											<br>
											<div>
												<textarea name="revised_content${map.no}" class="revised_content" maxlength="1000"></textarea>
												<button class="reviseBtn" type="button" onclick="goReviseNotice('${map.no}')">수정하기</button>
											</div>
										</c:if>
										
									</td>
									<td> </td>
								</tr>
							</c:forEach>
							
						</c:if>
						
						<c:if test="${ noticeList == null }">
							<tr>
								<td colspan="3">공지사항이 없습니다.</td>
							</tr>
						</c:if>
						
						<tr style="border-bottom: solid 1px #b3b3b3; border-top: solid 1px #b3b3b3;">
							<td>1</td>
							<td><div class="not_title" onclick="not_goClick(1)">1번째 제목은 바로 이것</div></td>
							<td style="color: #808080;">2019-11-31</td>
						</tr>
						<tr class="not_content not_content1">
							<td> </td>
							<td style="padding-left: 20px;">내용</td>
							<td> </td>
						</tr>
						
						
						<tr style="border-bottom: solid 1px #b3b3b3; border-top: solid 1px #b3b3b3;">
							<td></td>
							<td><div class="not_title" onclick="not_goClick(2)">2번째 제목은 바로 이것</div></td>
							<td></td>
						</tr>
						<tr class="not_content not_content2">
							<td> </td>
							<td style="padding-left: 15px;">내용</td>
							<td> </td>
						</tr>
						
					
					</tbody>
				
				</table>
				
			</div>
			
			<c:if test="${ sessionScope.email == 'admin@admin.com' }">
				<div style="width:90%; text-align: right;">
					<button type="button" id="notice_write" >글쓰기</button>
				</div>
			</c:if>
			
			<div id="notice_pageBar">
				${ pageBar }
			</div>
		
		</div>
		
	</div>	
		
	
	









</body>
</html>