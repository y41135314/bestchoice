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
 	width: 60%;
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
</script>

<div id="commentDetailBoard">
	<label style="font-size: 16px;">◎ 관리자 게시판</label>
	<br>
	<input type="button" value="게시판 목록" onclick="location.href='<%=request.getContextPath()%>/adminCommentBoard.bc'" style="font-size: 8pt;"/> 
    <input type="button" value="수정" onclick="location.href='<%=request.getContextPath()%>/adCommentUpdate.bc?adminBoard_idx=${boardvo.adminBoard_idx}'" style="font-size: 8pt;"/> 
    <input type="button" value="삭제" onclick="location.href='<%=request.getContextPath()%>/adCommentDelete.bc?adminBoard_idx=${boardvo.adminBoard_idx}'" style="font-size: 8pt;"/> 
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
		<div style="border: solid 1px #ccc; width: 60%;">
			댓글 내용
		</div>	      
	   
		<form name="adminComment"  style="margin-top: 15px;">
			<div>
				<textarea cols="50" ></textarea>
			</div>                    
			<div>     
				<input type="text" value="${sessionScope.loginadmin.name}" style="font-size: 8pt; width: 7%; margin-bottom: 5px;" class="short"  readonly  /> 
				<input type="button" value="등록" style="font-size: 8pt; margin-left: 100;"/> 
			</div>
		</form>
	</div>
	
	<br/>
	<div style="margin-bottom: 1%; font-size: 9pt;">이전글 : <span class="move movePrev">${boardvo.previoussubject}</span></div>
	<div style="margin-bottom: 1%; font-size: 9pt;">다음글 : <span class="move moveNext">${boardvo.nextsubject}</span></div>
	
		
</div>   