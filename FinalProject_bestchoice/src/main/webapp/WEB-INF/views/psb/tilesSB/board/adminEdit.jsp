<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<style type="text/css">
 #adminWrite {
 	/* border: solid 1px black; */
 	min-height: 500px;   
 	/* margin-top: 200px; */
 	margin-top: 10px;
 	margin-bottom: 30px;
 }
 
 #commentBtn{
 	color: #F7323F;
 }
 
 #fileDel:hover{
 	cursor: pointer;
 }
</style>


<script>
	$(document).ready(function(){
		
		$("#divSeller").css("border", "none");
		$("#divHotel").css("border", "none");
		$("#divHotel2").hide(); 
		$("#divSeller2").hide();  
		
		// === 스마트에디터 구현  === // 
		//전역변수
	    var obj = [];
	    
	    //스마트에디터 프레임생성
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: obj,
	        elPlaceHolder: "content",   // 스마트에디터 적용할 곳의 ID 
	        sSkinURI: "<%= request.getContextPath() %>/resources/smarteditor/SmartEditor2Skin.html",
	        htParams : {
	            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseToolbar : true,            
	            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : true,    
	            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseModeChanger : true,
	        }
	    });
	   // === ===============================  === // 
 
	    //스마트에디터 너비 조절    
	    var width=700; // 원하는 너비
	    $("#content").css('width',width);  
	    $("#huskey_editor_jinto_set_id").css('width',width);
	    
		//수정완료버튼
		$("#btnEdit").click(function(){
			
	        //id가 content인 textarea에 에디터에서 대입
	        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	          
			// 글제목 유효성 검사
			var subjectval = $("#title").val().trim();
			if(subjectval == "") {
				alert("글제목을 입력하세요!!");
				return;
			}
			
			<%-- === 스마트에디터 구현 시작 (글내용 유효성 검사) === --%>
			//스마트에디터 사용시 무의미하게 생기는 p태그 제거
			
	        var contentval = $("#content").val();
		        
	        // === 확인용 ===
	        // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
	        // 아무것도 안쓸 때 : "<p>&nbsp;</p>" 이라고 나온다.
	        
	        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
	        // 글내용 유효성 검사 
	        if(contentval == "" || contentval == "<p>&nbsp;</p>") { 
	        	alert("글내용을 입력하세요!!");
	        	return;
	        }
	        
	        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기 
	        contentval = $("#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
	    
	        contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
	        contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
	        contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
	    
	        $("#content").val(contentval);
	        // alert(contentval);
		    <%-- === 스마트에디터 구현 끝 === --%>
			
			// 폼을 submit
			var frm = document.adminEditFrm;
			frm.method = "POST";
			frm.action = "<%= request.getContextPath() %>/adBoardEditEnd.bc";
			frm.submit();
		});
		
		$("#fileDel").click(function(){
			
			$.ajax({
				url: "<%= request.getContextPath() %>/fileDel.bc",
				data: {"adminBoard_idx" : ${boardvo.adminBoard_idx} },
				dataType: "JSON",
				success: function(json){
					var html = "";
					if(json.n==1){
						$("#nowFile").css("text-decoration", "line-through");
					}
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			})
			<%-- location.href="<%=request.getContextPath()%>/fileDel.bc"; --%>
		})

	})
</script>

<div id="adminWrite">
	<label style="font-size: 16px;">◎ 글 수정</label>
	<br/>
	<form name="adminEditFrm" enctype="multipart/form-data"> 
	 <input type="hidden" name="adminBoard_idx" value="${boardvo.adminBoard_idx}" />
	<input type="text" name="name" value="${(sessionScope.loginadmin).name}" style="font-size: 8pt; width: 7%; margin-bottom: 5px;" class="short"  readonly  />  
	<input type="text" name="fk_sellerName" value="${boardvo.fk_sellerName}" style="font-size: 8pt; width: 7%; margin-bottom: 5px;" class="short"  readonly/> 
	<input type="text" name="fk_hotelName" value="${boardvo.fk_hotelName}" style="font-size: 8pt; width: 7%; margin-bottom: 5px;" class="short"   readonly /> 
	<br/>
	<input type="text" name="title" id="title" value="${boardvo.title}" style="margin: 5px 0;" /><br/>	
	<textarea name="content" id="content" style="width: 50%;">${boardvo.content}</textarea>	
	<br/>
	<p style="display: inline-block;  font-size: 10pt; ">*파일첨부</p> <input type="file" style="display: inline-block; font-size: 8pt;" name="attach" />
	<c:if test="${boardvo.orgFilename!=null}">
		<br/>
		└현재 파일 : <span id="nowFile" style="color: black;">${boardvo.orgFilename}</span> 
		<a id="fileDel" style="text-decoration: none;">x</a>			
	</c:if>
	<input type="hidden" name="fk_adminId" value="${sessionScope.loginadmin.adminId}" readonly />
	
	<input type="hidden" value="${fk_seq}" name="fk_seq"/>
	<input type="hidden" value="${groupno}" name="groupno"/>
	<input type="hidden" value="${depthno}" name="depthno"/>
	
	</form>
	<br/>  
	<input type="button" id="btnEdit" value="완료" style="font-size: 8pt; margin-left: 100;"/> 
	<input type="button" value="취소" onclick="location.href='<%=request.getContextPath()%>/adminCommentBoard.bc'" style="font-size: 8pt; margin-left: 100;"/> 

</div>


    