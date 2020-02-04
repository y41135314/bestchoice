<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
 
 .sellerNameone:hover, .hotelNameone:hover {
    font-weight: bold;
 } 
 
 .listStyle {
	 background-color: #ffb3b3; 
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
	    
		//쓰기버튼
		$("#btnWrite").click(function(){
			
			// == 스마트에디터 구현 : id가 content인 textarea에 에디터에서 대입 == // 
	        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
			  
			// 글제목 유효성 검사
			var title = $("#title").val().trim();
			if(title == "") {
				alert("제목을 입력하세요!!");
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
	  
	        /*    
	                   대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
	          ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 문자열의 따옴표는 없어야 한다는 점입니다. 
	                            그리고 뒤의 gi는 다음을 의미합니다.

	        	   g : 전체 모든 문자열을 변경 global
	        	   i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
	       */    
	        contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
	        contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
	        contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
	    
	        $("#content").val(contentval);
	        // alert(contentval);
		    <%-- === 스마트에디터 구현 끝 === --%>
	 
			// 폼을 submit
			var frm = document.adminWriteFrm;
			frm.method = "POST"; // 파일을 첨부할 경우이라면 반드시 POST 이어야만 가능하다. GET이라면 파일첨부가 안되어진다.
			frm.action = "<%= request.getContextPath() %>/adminBoardEnd.bc";
			frm.submit();
		});
  
		// 자동완성 
		$("#sellerDisplayList").hide();
		$("#hotelDisplayList").hide();
		
		var findvalSE = 0; 
		$("#fk_sellerName").keyup(function(event){
			$("#hotelDisplayList").hide();
			var wordLength = $("#fk_sellerName").val().length;
		
			if( wordLength == 0 ){
				$("#sellerDisplayList").hide();
			}	
			else {
				$.ajax({  
					url: "<%= request.getContextPath() %>/wordSellerSearchShow.bc" ,
					type: "GET",
					data:{ "fk_sellerName": $("#fk_sellerName").val() },
					dataType: "JSON",
					success: function(json){
						var n = 0;
						<%-- === #113. 검색어 입력시 자동글 완성하기 7 === --%> 
						if(json.length>0){ // 검색된 데이터가 있는 경우
							// 조회된 데이터가 없을 경우 if(json == null ) 이 아님 !! 
							// ==> B/C Controller 에서 이미 JSONObject jsonObj = new JSONObject(); 를 썼으므로.
		
							var html = "";
							
							$.each(json, function(index, item) {
								n = n+1;
								var word = item.word;
								var index = word.toLowerCase().indexOf( $("#fk_sellerName").val().toLowerCase() ); 
								
								var len = $("#fk_sellerName").val().length;
								var result = "";
								result = "<span class='first'>" +word.substr(0, index)+ "</span>" + "<span class='second' style='color:red; font-weight:bold;'>" +word.substr(index, len)+ "</span>" + "<span class='third'>" +word.substr(index+len, word.length - (index+len) )+ "</span>";  
								html += "<span id='stl" + n + "'  class='sellerNameone' style='cursor:pointer;'>"+ result +"</span><br/>";
							    
							})  
							$("#sellerDisplayList").html(html);
							$("#sellerDisplayList").show();

							if(event.keyCode == 8){
								findvalSE = 0;
							}
							
							if(event.keyCode == 40) {  
								if (findvalSE == 0 || findvalSE == n ) { 
									$("#sellerDisplayList").children(":first").addClass('listStyle');
									findvalSE= 1 ;
									
								} else {
									findvalSE = findvalSE+1;
									$("#stl" + findvalSE ).addClass('listStyle');  
									
								}
							} // end of keyCode = 40 =============== 
						
							if(event.keyCode == 38) {  
								if (findvalSE == 0 ) { 
									findvalSE= 1 ;
								} else {
									findvalSE = findvalSE-1;
									$("#stl" + findvalSE ).addClass('listStyle');  
								}	
							} // end of keyCode = 38 =============== 
							
							if(event.keyCode==13){
								var word = $("#stl" + findvalSE ).text();
								$("#fk_sellerName").val(word);
								$("#sellerDisplayList").hide();
							}
							
						}else{ // 검색된 데이터가 존재하지 않는 경우
							$("#sellerDisplayList").hide();
						}
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}	
				})
			}
			
   
		}) 
		
		$("#sellerDisplayList").click(function(){
			var word = "";	
			var $target = $(event.target);
			if($target.is(".first")){ // 내가 클릭한 곳이 first 라면 
				word = $target.text() + $target.next().text() + $target.next().next().text()
			}
			else if($target.is(".second")){
				word = $target.prev().text() + $target.text() + $target.next().text()
			}
			else if($target.is(".third")){
				word = $target.prev().prev().text() + $target.prev().text() + $target.text()
			}
			
			$("#fk_sellerName").val(word);
			$("#sellerDisplayList").hide();
		})	  
		
		var findval = 0; 
		$("#fk_hotelName").keyup(function(event){
			
			$("#sellerDisplayList").hide();	
			var wordLength = $("#fk_hotelName").val().length;
			
			if( wordLength == 0 ){
				$("#hotelDisplayList").hide();
			}	
			else {
				$.ajax({  
					url: "<%= request.getContextPath() %>/wordHotelSearchShow.bc" ,
					type: "GET",
					data:{ "fk_hotelName": $("#fk_hotelName").val() },
					dataType: "JSON",
					success: function(json){
						var n = 0;
						<%-- === #113. 검색어 입력시 자동글 완성하기 7 === --%> 
						if(json.length>0){ 
							var result = "";
							$.each(json, function(index, item) {
								n = n+1;
								var word = item.word; 
								var index = word.toLowerCase().indexOf( $("#fk_hotelName").val().toLowerCase() ); 
								var len = $("#fk_hotelName").val().length;
								result += "<span id='htl" + n + "' class='hotelNameone' style='cursor:pointer; width: 100%;'>";
								result += "<span class='first'>" +word.substr(0, index)+ "</span>" ;
								result += "<span class='second' style='color:red; font-weight:bold;'>" +word.substr(index, len)+ "</span>";
								result += "<span class='third'>" +word.substr(index+len, word.length - (index+len) )+ "</span></span><br/>";		
							})   
							
							$("#hotelDisplayList").html(result);
							$("#hotelDisplayList").show();      
                            
							if(event.keyCode == 8){
								findval = 0;
							}
							
							if(event.keyCode == 40) {  
								if (findval == 0 || findval == n ) { 
									$("#hotelDisplayList").children(":first").addClass('listStyle');
									findval= 1 ;
									
								} else {
									findval = findval+1;
									$("#htl" + findval ).addClass('listStyle');  
									
								}
							} // end of keyCode = 40 =============== 
						
							if(event.keyCode == 38) {  
								if (findval == 0 ) { 
									findval= 1 ;
								} else {
									findval = findval-1;
									$("#htl" + findval ).addClass('listStyle');  
								}	
							} // end of keyCode = 38 =============== 
							
							if(event.keyCode==13){
								var word = $("#htl" + findval ).text();
								$("#fk_hotelName").val(word);
								$("#hotelDisplayList").hide();
							}
							
						}   
						else{ // 검색된 데이터가 존재하지 않는 경우
							$("#hotelDisplayList").hide();
						}
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}	
				})
			}
		}) 
		
		$("#hotelDisplayList").click(function(){
			var word = "";	
			var $target = $(event.target);
			if($target.is(".first")){ // 내가 클릭한 곳이 first 라면 
				word = $target.text() + $target.next().text() + $target.next().next().text()
			}
			else if($target.is(".second")){
				word = $target.prev().text() + $target.text() + $target.next().text()
			}
			else if($target.is(".third")){
				word = $target.prev().prev().text() + $target.prev().text() + $target.text()
			}
			
			$("#fk_hotelName").val(word);
			$("#hotelDisplayList").hide();
		})	
	}); // end of document=======================================
		
	
</script>
  
<div id="adminWrite">
	<label style="font-size: 16px;">◎ 글 작성</label>    
	<br/>
	<form name="adminWriteFrm" enctype="multipart/form-data"> 
	<input type="text" name="name" value="${(sessionScope.loginadmin).name}" style="font-size: 8pt; width: 7%; margin-bottom: 5px;" class="short"  readonly  />  
	<input type="text" name="fk_sellerName" id="fk_sellerName" autocomplete="off"  placeholder="판매자" style="font-size: 8pt; width: 7%; margin-bottom: 5px;" class="short"  /> 
	<input type="text" class="hotelNameone" name="fk_hotelName" id="fk_hotelName" autocomplete="off"  placeholder="호텔명" style="font-size: 8pt; width: 7%; margin-bottom: 5px;" class="short"    /> 
	<br/>   
	  
	
	
	<input type="text" name="title" id="title" placeholder="제목" style="margin: 5px 0; " /><br/>	
	<textarea name="content" id="content" style="width: 50%;"></textarea>	
	<br/>
	
	<p style="display: inline-block;  font-size: 10pt; ">*파일첨부</p> <input type="file"  style="display: inline-block; font-size: 8pt;" name="attach" />
	
	<input type="hidden" name="fk_adminId" value="${sessionScope.loginadmin.adminId}" readonly />
	
	<input type="hidden" value="${fk_seq}" name="fk_seq"/> 
	<input type="hidden" value="${groupno}" name="groupno"/>
	<input type="hidden" value="${depthno}" name="depthno"/>
	
	</form>
	<br/>  
	<input type="button" id="btnWrite" value="등록" style="font-size: 8pt; margin-left: 100;"/> 
	<input type="button" value="취소" onclick="location.href='<%=request.getContextPath()%>/adminCommentBoard.bc'" style="font-size: 8pt; margin-left: 100;"/> 
 
	<div id="sellerDisplayList" style="width: 7%; font-size: 8pt; position: relative; left: 7.36%; min-height: 50px; margin-top: -374px;  border-top: none; border: solid 1px gray; background-color: white; z-index: 2 ">
	</div>   
	            
	<div id="hotelDisplayList" class="hotelDisplayList" style="width: 7%; font-size: 8pt; position: relative; left: 14.8%; min-height: 50px; margin-top: -374px;  border-top: none; border: solid 1px gray; background-color: white; z-index: 2 ">
	</div>        
	        
</div>


