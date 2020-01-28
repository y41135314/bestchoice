<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<style type="text/css">
 #commentDetailBoard {
 	/* border: solid 1px black; */
 	min-height: 500px;   
 	/* margin-top: 200px; */
 	margin-top: 10px;
 	margin-bottom: 30px;
 }
 
 #commentBtn{
 	color: #F7323F;
 }
 
 #adCommentDetailTable {
 	border: solid 1px black;
 	border-collapse: collapse;  
 	width: 70%;
 	margin-top: 10px; 
 }
 
 #adCommentDetailTable tr, #adCommentDetailTable th, #adCommentDetailTable td  {
 	border: solid 1px black;
 }
 
 #adCommentDetailTable th {
 	text-align: center;
 	background-color: #FAFAFA;
 }
 
 .move:hover {cursor: pointer;}
 .moveColor { font-weight: bold;}
         
  .commentName {
  	font-size: 9pt;
  	font-weight: bold;
  }
  
  .commentDay{
  	font-style: italic;
  	font-size: 8pt;
  }
  
  #updateCommentBtn:hover, #delimg:hover {
  	cursor: pointer;
  }
  
</style>

<script>
	$(document).ready(function(){
		
		$("#divSeller").css("border", "none");
		$("#divHotel").css("border", "none");
		$("#divHotel2").hide(); 
		$("#divSeller2").hide();  
		
		$(".move").hover(function(){
						   $(this).addClass("moveColor");	
						 },
				         function(){
						   $(this).removeClass("moveColor");
		});

		var prevRno = Number(${rno})-1 ;
		var nextRno = Number(${rno})+1 ;
		$(".movePrev").click(function(){
			location.href='adCommentDetail.bc?adminBoard_idx=${boardvo.previousseq}&rno=' + prevRno;
		})
		
		$(".moveNext").click(function(){
			location.href='adCommentDetail.bc?adminBoard_idx=${boardvo.nextseq}&rno=' + nextRno;
		})

	})
	
	// === 댓글 쓰기 === //
	function addComment() {
		var frm = document.adminComment;
		var contentVal = frm.content.value.trim();
		
		if (contentVal == ""){
			alert("댓글 내용을 입력하세요!!");
			return;
		}
		
		var form_data = $("form[name=adminComment]").serialize(); // 폼에 있는 name 값이 키워드가 되어 데이터가 된다.
		$.ajax({
			url: "<%= request.getContextPath() %>/adComment.bc",
			data: form_data,
			type: "POST",
			dataType: "JSON",
			success: function(json){
				location.reload();
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		})
	}
	
	// 댓글 삭제
	function delComment(adminComment_idx,fk_parentIdx,fk_adminId){
		
		if ( (fk_adminId != '${sessionScope.loginadmin.adminId}') && ${sessionScope.loginadmin.grade} != 10) {
			alert("다른사람의 댓글은 삭제 불가합니다.");
		}
		else {
			$.ajax({
				url: "<%= request.getContextPath() %>/adDelComment.bc",
				data: {"adminComment_idx": adminComment_idx,"fk_parentIdx":fk_parentIdx },
				type: "POST",
				dataType: "JSON",
				success: function(json){    
				
					location.reload();
					
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			
			})
		}
	}	
	
	function updateComment(adminComment_idx,fk_adminId,content){
		
		if ( fk_adminId != '${sessionScope.loginadmin.adminId}' ) {
			alert("다른사람의 댓글은 수정 불가합니다.");  
		}
		else {
			var html = "";
			html += content;  
			$("#contentTxt").html(html);
			
			$("#Btn").hide();
			
			var html2 = "";
			html2 = "<input type='button' onclick='updateEndComment( + " + adminComment_idx + ");' value='수정' style='font-size: 8pt; margin-left: 100;' />";
			$("#divBtn").html(html2);
		}
	}
	
	function updateEndComment(adminComment_idx){
		
		var frm = document.adminComment;
		var contentVal = frm.content.value.trim();
		
		if (contentVal == ""){
			alert("댓글 내용을 입력하세요!!");
			return;
		}
		
		var fk_parentIdx = frm.fk_parentIdx.value.trim();
		
		$.ajax({
			url: "<%= request.getContextPath() %>/upComment.bc",
			data: {"adminComment_idx":adminComment_idx,"content":contentVal,"fk_parentIdx":fk_parentIdx},
			type: "POST",
			dataType: "JSON",
			success: function(json){
				location.reload();
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		})
	
	};
	
</script>

<div id="commentDetailBoard">
	<label style="font-size: 16px;">◎ 관리자 게시판</label>
	<br>
	<input type="button" value="게시판 목록" onclick="location.href='<%=request.getContextPath()%>/adminCommentBoard.bc'" style="font-size: 8pt;"/> 
    <input type="button" value="수정" onclick="location.href='<%=request.getContextPath()%>/adCommentUpdate.bc?adminBoard_idx=${boardvo.adminBoard_idx}&rno=${rno}'" style="font-size: 8pt;"/> 
    <input type="button" value="삭제" onclick="location.href='<%=request.getContextPath()%>/adBoardDelete.bc?adminBoard_idx=${boardvo.adminBoard_idx}'" style="font-size: 8pt;"/> 
    <input type="button" value="답글" onclick="location.href='<%=request.getContextPath()%>/adminWrite.bc?fk_seq=${boardvo.adminBoard_idx}&groupno=${boardvo.groupno}&depthno=${boardvo.depthno}'" style="font-size: 8pt;"/> 
    <br>
      
	<table id="adCommentDetailTable">
		<tr>  
			<th style="width: 5%;">번호</th> <td style="width: 10%; text-align: center;">${rno}</td>
			<th style="width: 8%;">작성자</th> <td style="width: 10%; text-align: center;">${boardvo.name}</td>
			<th style="width: 8%;">판매자</th> <td style="width: 10%; text-align: center;">${boardvo.fk_sellerName}</td>
			<th style="width: 8%;">호텔명</th> <td style="width: 10%; text-align: center;">${boardvo.fk_hotelName}</td>
			<th style="width: 8%;">작성일자</th> <td style="text-align: center;">${boardvo.registerday}</td>
		</tr>
		<tr>	
			<th style="width: 8%;">첨부파일</th> 
			<td  colspan="9" style="width: 10%;">
				<a href="<%= request.getContextPath()%>/adminDownload.bc?adminBoard_idx=${boardvo.adminBoard_idx}">  
					&nbsp;${boardvo.orgFilename}&nbsp;
				</a>
				<c:if test="${boardvo.fileSize !=  null}">
				(크기 : ${boardvo.fileSize} )
				</c:if>
			</td>
		</tr>
		<tr>
			<th>제목</th> <td colspan="9">&nbsp;${boardvo.title}</td>
		</tr>
	</table>    
	    
	<div style=" width: 60%; min-height: 100px; margin-top: 5px; padding: 10px 0;"> 
	${boardvo.content}
	</div>	
	
	<div style="margin-top: 15px;">       
		<label>▶댓글</label>
		<div style="border: solid 1px #ccc; width: 70%; padding: 10px; line-height: 2;" id="commentDisplay">  
			<c:if test="${empty commentList}">
				등록된 댓글이 없습니다.	
			</c:if>    
			
			<c:if test="${!empty commentList}">
				<c:forEach var="commentvo" items="${commentList}" varStatus="stauts">
						<span class="commentName">${commentvo.name}</span>&nbsp;&nbsp;(ID : ${commentvo.fk_adminId})&nbsp;&nbsp;<span class="commentDay">${commentvo.registerday}</span>
						&nbsp; 
						<span id="updateCommentBtn" onclick="updateComment(${commentvo.adminComment_idx},'${commentvo.fk_adminId}','${commentvo.content}');" style="font-size: 8pt;">[수정]</span>&nbsp; 
						<img id="delimg" src="./resources/images/458595.png" onclick="delComment(${commentvo.adminComment_idx},${commentvo.fk_parentIdx}, '${commentvo.fk_adminId}' );" style="width: 10px; height: 10px;"/>
						<br/><span class="commentContent">${commentvo.content}</span> 
						<hr>
				</c:forEach>        
			</c:if>
		</div>	      
	   
		<form name="adminComment"  style="margin-top: 15px;">
			<div>           
				<textarea name="content" id="contentTxt" cols="80" ></textarea>
				<input type="hidden" name="fk_parentIdx" value="${boardvo.adminBoard_idx}"  />
				<input type="hidden" name="fk_adminId" value="${sessionScope.loginadmin.adminId}" />
			</div>                    
			<div>     
				<input type="text" name="name" value="${sessionScope.loginadmin.name}" style="font-size: 8pt; width: 7%; margin-bottom: 5px;" class="short"  readonly  /> 
				<span id="divBtn">
				<input type="button" id="Btn" onclick="addComment();" value="등록" style="font-size: 8pt; margin-left: 100;"/>
				</span> 
			</div>
		</form>
	</div>          
	          
	<br/>
	<div style="margin-bottom: 1%; font-size: 9pt;">이전글 : <span class="move movePrev">${boardvo.previoussubject}</span></div>
	<div style="margin-bottom: 1%; font-size: 9pt;">다음글 : <span class="move moveNext">${boardvo.nextsubject}</span></div>
	
		
</div>   