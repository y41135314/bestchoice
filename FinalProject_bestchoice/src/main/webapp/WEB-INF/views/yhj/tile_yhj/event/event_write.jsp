<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 글쓰기 | 여기는어때</title>

<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Jua&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">
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
	
	#event_write {
		float: left;
		width: 80%;
		padding: 30px 0;
	}
	
	
	form[name=eventWriteForm] table , form[name=eventReviseForm] table{
		border-collapse: collapse;
	}
	
	form[name=eventWriteForm] table td , form[name=eventReviseForm] table td {
		padding: 20px 0;
		/* border-top: solid 1px gray; */
		border-bottom: solid 1px gray;
	}
	
	form[name=eventWriteForm] input[name=event_name] , form[name=eventReviseForm] input[name=event_name]{
		width:95%;
		height:20px;
		font-size: 12pt;
		font-family: 'Nanum Gothic', sans-serif;
		padding: 10px;
	}
	
	form[name=eventWriteForm] textarea[name=event_explain] , form[name=eventReviseForm] textarea[name=event_explain] {
		width:95%;
		height:150px;
		font-size: 12pt;
		font-family: 'Nanum Gothic', sans-serif;
		padding: 10px;
	}
	
	
	
	
	form[name=eventWriteForm] button , form[name=eventReviseForm] button {
		background-color: white;
	    border: solid 2px black;
	    padding: 5px 20px;
	    font-weight: bold;
	    font-family: 'Nanum Gothic', sans-serif;
	    transition: 0.5s;
	}
	
	form[name=eventWriteForm] button:hover , form[name=eventReviseForm] button:hover {
		background-color: black;
		color: white;
	}
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		var revise = "${revise}";
		
		if(revise != ""){		// 수정하기
			
			$("form[name=eventWriteForm]").hide();
			$("form[name=eventReviseForm]").show();
			
			$("input[name=revise]").val("${revise}");
			$("input[name=event_code]").val("${event_code}");
			
			$("form[name=eventReviseForm] input[name=event_name]").val("${eventMap.event_name}");	
			
			$("form[name=eventReviseForm] input[name=event_discountMon]").val("${eventMap.event_discountmon}");
			$("form[name=eventReviseForm] input[name=event_discountPct]").val("${eventMap.event_discountpct}");
			
			
			var startday = "${eventMap.event_startday}";
			$("form[name=eventReviseForm] input[name=event_startday]").val(startday);
			
			var endday = "${eventMap.event_endday}";
			$('form[name=eventReviseForm] input[name=event_endday]').val(endday);
			
			
		}
		else {		// 신규 이벤트 등록
			
			$("form[name=eventWriteForm]").show();
			$("form[name=eventReviseForm]").hide();
		}
		
		
		
		
		$( "input[name=event_startday]" ).datepicker({ 
			minDate: 0, maxDate: "+2M"  ,
			dateFormat: "yy-mm-dd",
			showMonthAfterYear: true ,
			yearSuffix: "년",
			dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], // 요일의 한글 형식.
			monthNames: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 월의 한글 형식.
			
		});
		$( "input[name=event_endday]" ).datepicker({ 
			
			minDate: 0, maxDate: "+2M"  ,
			dateFormat: "yy-mm-dd",
			showMonthAfterYear: true ,
			yearSuffix: "년",
			dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], // 요일의 한글 형식.
			monthNames: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] // 월의 한글 형식.
		
		});
		
		
		
		// 등록하기 클릭
		$("#eventInsert").click(function(){
			
			var event_name = $("form[name=eventWriteForm] input[name=event_name]").val();
			if(event_name.trim() == ""){
				alert("이벤트 제목을 입력하세요");
				return;
			}
			
			var event_explain = $("form[name=eventWriteForm] textarea[name=event_explain]").val(); 
			if(event_explain.trim() == ""){
				alert("이벤트 설명을 입력하세요");
				return;
			}
			
			var event_discountMon = $("form[name=eventWriteForm] input[name=event_discountMon]").val();
			var regExp = /^[0-9]+$/;
			var bool1 = regExp.test(event_discountMon);
			var event_discountPct = $("form[name=eventWriteForm] input[name=event_discountPct]").val();
			var bool2 = regExp.test(event_discountPct);
			
			if(bool1 == false || bool2 == false){
				alert("숫자만 입력해주세요.");
				return;
			}
			
			var event_startday = $("form[name=eventWriteForm] input[name=event_startday]").val();
			var event_endday = $("form[name=eventWriteForm] input[name=event_endday]").val();
			
			if(event_startday =="" || event_endday==""){
				alert("시작일과 종료일을 다시 체크해주세요.")
				return;
			}
			
			if(event_startday >= event_endday){
				
				alert("시작일과 종료일을 다시 체크해주세요.");
				return;
			}
			
			var frm = document.eventWriteForm;
			
			frm.action = "<%= request.getContextPath()%>/event/writeEnd.bc";
			frm.submit(); 
			
		}); // end of 등록하기 ---------------------------
		
		
		// 수정하기 클릭
		$("#eventRevise").click(function(){
			
			var event_name = $("form[name=eventReviseForm] input[name=event_name]").val();
			if(event_name.trim() == ""){
				alert("이벤트 제목을 입력하세요");
				return;
			}
			
			var event_explain = $("form[name=eventReviseForm] textarea[name=event_explain]").val(); 
			if(event_explain.trim() == ""){
				alert("이벤트 설명을 입력하세요");
				return;
			}
			
			var event_discountMon = $("form[name=eventReviseForm] input[name=event_discountMon]").val();
			var regExp = /^[0-9]+$/;
			var bool1 = regExp.test(event_discountMon);
			var event_discountPct = $("form[name=eventReviseForm] input[name=event_discountPct]").val();
			var bool2 = regExp.test(event_discountPct);
			
			if(bool1 == false || bool2 == false){
				alert("숫자만 입력해주세요.");
				return;
			}
			
			var event_startday = $("form[name=eventReviseForm] input[name=event_startday]").val();
			var event_endday = $("form[name=eventReviseForm] input[name=event_endday]").val();
			
			if(event_startday =="" || event_endday==""){
				alert("시작일과 종료일을 다시 체크해주세요.")
				return;
			}
			
			if(event_startday >= event_endday){
				
				alert("시작일과 종료일을 다시 체크해주세요.");
				return;
			}
			
			var frm = document.eventReviseForm;
			
			frm.action = "<%= request.getContextPath()%>/event/writeEnd.bc";
			frm.submit(); 
			
		}); // end of 수정하기 ---------------------------
		
		
	}); // end of document ready -------------------------------------------
	
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
	    
		<div id="event_write">
			
			<form name="eventWriteForm" style="width:90%;" method="post" enctype="multipart/form-data" >
				
				<div style="font-family: 'Nanum Gothic', sans-serif; font-weight: bold; font-size: 16pt; 
					color: red; padding: 15px 0; border-bottom:solid 3px red">
					신규 이벤트 등록하기
				</div>
				
				<table style="width: 100%;">
				
					<tr>
						<td style="width:20%; text-align: center; font-weight:bold;">이벤트 제목</td>
						<td style="width:80%;">
							<input name="event_name" type="text" maxlength="30">
						</td>
					</tr>
					
					<tr>
						<td style=" text-align: center; font-weight:bold;">이벤트 설명</td>
						<td>
							<textarea name="event_explain" maxlength="500"></textarea>
						</td>
					</tr>
					
					<tr>
						<td style=" text-align: center; font-weight:bold;">할인금액 / 적립금액</td>
						<td>
							<input type="text" name="event_discountMon" placeholder="숫자만 입력해주세요">
						</td>
					</tr>
					
					<tr>
						<td style=" text-align: center; font-weight:bold;">할인율 / 적립율</td>
						<td>
							<input type="text" name="event_discountPct" placeholder="숫자만 입력해주세요">
						</td>
					</tr>
					
					<tr>
						<td style=" text-align: center; font-weight:bold;">이벤트 시작일</td>
						<td>
							<input name="event_startday" >
						</td>
					</tr>
					
					<tr>
						<td style=" text-align: center; font-weight:bold;">이벤트 종료일</td>
						<td>
							<input name="event_endday" >
						</td>
					</tr>
					
					<tr>
						<td style=" text-align: center; font-weight:bold;">이벤트 사진</td>
						<td>
							사진은 하나당 10mb 이하만 가능합니다.<br><br>
							메인 이미지 : <input name="attach" class="image1" type="file"><br>
							본문 이미지 1 : <input name="attach" class="image2" type="file"><br>
							본문 이미지 2 : <input name="attach" class="image3" type="file"><br>
							본문 이미지 3 : <input name="attach" class="image4" type="file">
						</td>
					</tr>
					
				</table>
				
				<div align="center" style="padding: 30px;">
					
					<button type="button" id="eventInsert">등록하기</button>
					
					<button type="button" onclick="javascript:history.go(0);">초기화하기</button>
					<button type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/event/main.bc';">이벤트로 돌아가기</button>
				</div>
			</form>
			
			
			
			<%-- 수정하기 폼 --%>
			<form name="eventReviseForm" style="width:90%;" method="post" enctype="multipart/form-data" >
				
				
				<input type="hidden" name="revise">
				<input type="hidden" name="event_code">
				
				<div style="font-family: 'Nanum Gothic', sans-serif; font-weight: bold; font-size: 16pt; 
					color: red; padding: 15px 0; border-bottom:solid 3px red">
					기존 이벤트 수정하기
				</div>
				
				<table style="width: 100%;">
				
					<tr>
						<td colspan="2" style="font-weight: bold; text-align: center;">
							관리자 ${ eventMap.admin_name } 님께서 ${ eventMap.event_createday } 에 생성하신 이벤트입니다.
						</td>
						
					</tr>
					
					<tr>
						<td style="width:20%; text-align: center; font-weight:bold;">이벤트 제목</td>
						<td style="width:80%;">
							<input name="event_name" type="text" maxlength="30">
						</td>
					</tr>
					
					<tr>
						<td style=" text-align: center; font-weight:bold;">이벤트 설명</td>
						<td>
							<textarea name="event_explain" maxlength="500">${eventMap.event_explain}</textarea>
						</td>
					</tr>
					
					<tr>
						<td style=" text-align: center; font-weight:bold;">할인금액 / 적립금액</td>
						<td>
							<input type="text" name="event_discountMon" placeholder="숫자만 입력해주세요">
						</td>
					</tr>
					
					<tr>
						<td style=" text-align: center; font-weight:bold;">할인율 / 적립율</td>
						<td>
							<input type="text" name="event_discountPct" placeholder="숫자만 입력해주세요">
						</td>
					</tr>
					
					<tr>
						<td style=" text-align: center; font-weight:bold;">이벤트 시작일</td>
						<td>
							<input name="event_startday" >
						</td>
					</tr>
					
					<tr>
						<td style=" text-align: center; font-weight:bold;">이벤트 종료일</td>
						<td>
							<input name="event_endday" >
						</td>
					</tr>
					
					<tr>
						<td style=" text-align: center; font-weight:bold;">이벤트 사진</td>
						<td>
							<div>
								<c:if test="${ not empty eventImgMap  }">
									<c:forEach items="${ eventImgMap }" var="map">
										<img style="width:100%;" src="<%= request.getContextPath()%>/resources/images/yhj/event/${ map.wasfilename }">
										<br>
									</c:forEach>
								</c:if>
							</div>
							<br>
							<span style="font-weight: bold; font-size:16pt;">사진을 수정하려면 아래에 다시 업로드해주시기 바랍니다.</span><br>
							사진은 하나당 10mb 이하만 가능합니다.
							<br><br>
							메인 이미지 : <input name="attach" class="image1" type="file"><br>
							본문 이미지 1 : <input name="attach" class="image2" type="file"><br>
							본문 이미지 2 : <input name="attach" class="image3" type="file"><br>
							본문 이미지 3 : <input name="attach" class="image4" type="file">
						</td>
					</tr>
					
					
					
				</table>
				
				<div align="center" style="padding: 30px;">
					
					<button type="button" id="eventRevise">수정하기</button>
					
					<button type="button" onclick="javascript:history.go(0);">초기화하기</button>
					<button type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/event/main.bc';">이벤트로 돌아가기</button>
				</div>
			</form>
			
			
		</div>
	</div>
	
	
	
</body>
</html>