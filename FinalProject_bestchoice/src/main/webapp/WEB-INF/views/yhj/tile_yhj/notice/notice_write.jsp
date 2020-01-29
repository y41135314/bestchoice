<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글쓰기 | 여기는어때</title>

<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Jua&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/smarteditor_yhj/js/HuskyEZCreator.js" charset="utf-8"></script>

<style type="text/css">
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
	
	#notice_write {
		float: left;
		width: 80%;
		padding: 30px 0;
	}
	
	form[name=noticeWriteForm] table {
		border-collapse: collapse;
	}
	
	form[name=noticeWriteForm] table td {
		padding: 20px 0;
		/* border-top: solid 1px gray; */
		border-bottom: solid 1px gray;
	}
	
	form[name=noticeWriteForm] input[name=title] {
		width:95%;
		height:30px;
		font-size: 12pt;
		font-family: 'Nanum Gothic', sans-serif;
		padding: 10px;
	}
	
	form[name=noticeWriteForm] textarea[name=content] {
		width:95%;
		height:500px;
		font-size: 12pt;
		font-family: 'Nanum Gothic', sans-serif;
		padding: 10px;
	}
	
	
	
	
	form[name=noticeWriteForm] button{
		background-color: white;
	    border: solid 2px black;
	    padding: 5px 20px;
	    font-weight: bold;
	    font-family: 'Nanum Gothic', sans-serif;
	    transition: 0.5s;
	}
	
	form[name=noticeWriteForm] button:hover {
		background-color: black;
		color: white;
	}
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		var revise = "${revise}";
		
		if(revise != null){
			
			$("input[name=revise]").val("${revise}");
			$("input[name=no]").val("${nvo.no}");
			$("input[name=title]").val("${nvo.title}")
		}
		
		
		
		// 스마트 에디터 구현하기
		//전역변수
	    var obj = [];
	    
	    //스마트에디터 프레임생성
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: obj,
	        elPlaceHolder: "yhj_notice_content",		// ID가 content 인 곳에 위치
	        sSkinURI: "<%= request.getContextPath() %>/resources/smarteditor_yhj/SmartEditor2Skin.html",
	        htParams : {
	            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseToolbar : true,            
	            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : true,    
	            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseModeChanger : true,
	        }
	    });
		
	
		
		// 등록하기 클릭
		$("#noticeWriteSubmit").click(function(){
			
			obj.getById["yhj_notice_content"].exec("UPDATE_CONTENTS_FIELD", []);
			
			var frm = document.noticeWriteForm;
			
			frm.method = "POST";
			frm.action = "<%=request.getContextPath()%>/notice/writeEnd.bc";
			frm.submit(); 
			
		}); // end of 등록하기 ---------------------------
		
		// 수정하기 클릭
		$("#noticeReviseSubmit").click(function(){
			
			obj.getById["yhj_notice_content"].exec("UPDATE_CONTENTS_FIELD", []);
			
			var frm = document.noticeWriteForm;
			
			frm.method = "POST";
			frm.action = "<%=request.getContextPath()%>/notice/writeEnd.bc";
			frm.submit(); 
			
		}); // end of 수정하기 -----------------------------
		
		
	}); // end of document ready -------------------------------------------
	
</script>

</head>
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
	    
		<div id="notice_write">
		
			<form name="noticeWriteForm" style="width:90%;">
				
				<input type="hidden" name="revise">
				<input type="hidden" name="no">
				
				<div style="font-family: 'Nanum Gothic', sans-serif; font-weight: bold; font-size: 16pt; 
					color: red; padding: 15px 0; border-bottom:solid 3px red">
					공지사항 글쓰기
				</div>
				
				<table style="width: 100%;">
				
					<tr>
						<td style="width:15%; text-align: center; font-weight:bold;">글제목</td>
						<td style="width:80%;">
							<input name="title" maxlength="30">
						</td>
					</tr>
					
					<tr>
						<td style=" text-align: center; font-weight:bold;">글내용</td>
						<td>
							<textarea name="content" id="yhj_notice_content">
								<c:if test="${ not empty revise }">
									${nvo.content }
								</c:if>
							</textarea>
						</td>
					</tr>
					
				</table>
				
				<div align="center" style="padding: 30px;">
					<c:if test="${ revise != null }">
						<button type="button" id="noticeReviseSubmit">수정하기</button>
					</c:if>
					<c:if test="${ revise == null }">
						<button type="button" id="noticeWriteSubmit">등록하기</button>
					</c:if>
					<button type="button" onclick="javascript:history.go(0);">초기화하기</button>
					<button type="button" onclick="javascript:history.back();">뒤로가기</button>
				</div>
			</form>
		</div>
	</div>
	
	
	
</body>
</html>