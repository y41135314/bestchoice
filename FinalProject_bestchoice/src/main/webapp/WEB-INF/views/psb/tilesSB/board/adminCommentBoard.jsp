<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
<style type="text/css">
 #adminCommentBoard {
 	/* border: solid 1px black; */
 	min-height: 500px;   
 	/* margin-top: 200px; */
 	margin-top: 10px;
 	margin-bottom: 30px;
 }
 
 #commentBtn{
 	color: #F7323F;
 }
 
 #adminCommentTable {
 	border: solid 1px black;
 	border-collapse: collapse;  
 	width: 100%;
 	margin-top: 10px;
 }
 
 #adminCommentTable tr, #adminCommentTable th, #adminCommentTable td  {
 	border: solid 1px black;
 	padding: 5px;
 }
 
 #adminCommentTable th {
 	text-align: center;
 }
 
</style>

<script>
	$(document).ready(function(){
		
		$("#divSeller").css("border", "none");
		$("#divHotel").css("border", "none");
		$("#divHotel2").hide(); 
		$("#divSeller2").hide();  

		// 검색버튼 클릭 시, 검색 조건 및 검색어 값 유지시키기 
		if(${paraMap != null}){
			$("#searchType").val("${paraMap.searchType}");
			$("#searchWord").val("${paraMap.searchWord}");
		};
		
		$(".title").bind("mouseover",function(event){
			var $target = $(event.target); 
			$target.css({"font-weight":"bold", "cursor":"pointer"});
		});
		$(".title").bind("mouseout",function(event){
			var $target = $(event.target); 
			$target.css({"font-weight":"normal"});
		});  
		
		$("#searchWord").keydown(function(event){
			if(event.keyCode == 13) {
				goSearch();
			} 
		});
	})
	
	function goView( adminBoard_idx,rno) {
		var frm = document.goViewFrm;
		frm.adminBoard_idx.value = adminBoard_idx ;
		frm.rno.value=rno;
		frm.method="GET";
		frm.action="adCommentDetail.bc";
		frm.submit();
	}

	function goSearch(){
		var frm = document.searchFrm;
		frm.method="GET";
		frm.action = "<%= request.getContextPath()%>/adminCommentBoard.bc";
		frm.submit();
	}

</script>

<div id="adminCommentBoard">
	<label style="font-size: 16px;">◎ 관리자 게시판</label>
	<br>
	<form name="searchFrm">
		<input type="button" onclick="goSearch()" value="검색" style="margin: 15px;"/> 
		<select name="searchType" id="searchType" style="height: 20px; position: relative; top: 2px; ">
			<option value="title">제목</option>
			<option value="content">내용</option>
			<option value="name">작성자</option>
			<option value="fk_sellerName">판매자</option>
			<option value="fk_hotelName">호텔명</option>
		</select>   
		<input type="text" id="searchWord" name="searchWord" style="height: 20px;"/>
	</form>	
	<table id="adminCommentTable" >
		<tr style="background-color: #FAFAFA;">
			<th>번호</th>
			<th style="width: 30%;">제목</th>
			<th>작성자</th>
			<th>판매자</th>
			<th>호텔명</th>
			<th>작성일자</th>
		</tr>   
		
		<c:if test="${ boardList == null }">
			<tr>   
				<td colspan="6">작성 내용이 없습니다.</td>
			</tr>
	   </c:if>
	   
		<c:if test="${ boardList != null }">   
	      <c:forEach var="boardvo" items="${boardList}" varStatus="status"> 
		   	   <tr>
					<td align="center">${boardvo.rno}</td>
					
					<td align="center"> 
			   	  		<c:if test="${boardvo.depthno == 0}">
				   	   		 <c:if test="${boardvo.commentCount > 0}">	 
						    	<c:if test="${boardvo.fileName == null }">	 
						   	    	<span class="title" onclick="goView('${boardvo.adminBoard_idx}','${boardvo.rno}');">
						   	    	  ${boardvo.title}&nbsp;<span style="vertical-align: super;">[<span style="color: red; font-size: 9pt; font-style: italic; font-weight: bold;">${boardvo.commentCount}</span>]</span></span>
						    	</c:if>
						    	<c:if test="${boardvo.fileName != null }">	 
						   	    	 <span class="title" onclick="goView('${boardvo.adminBoard_idx}','${boardvo.rno}');">
						   	    	 ${boardvo.title}&nbsp;<span style="vertical-align: super;">[<span style="color: red; font-size: 9pt; font-style: italic; font-weight: bold;">${boardvo.commentCount}</span>]</span>
						    		  <img src="<%= request.getContextPath()%>/resources/images/disk.gif" />
						    		  </span>
						    	</c:if>
						     </c:if>
						    
						    <c:if test="${boardvo.commentCount == 0}">
						   	   <c:if test="${boardvo.fileName == null }">	 
						   	    	<span class="title" onclick="goView('${boardvo.adminBoard_idx}','${boardvo.rno}');"> ${boardvo.title}&nbsp;</span>
						    	</c:if>
						    	<c:if test="${boardvo.fileName != null }">	 
						   	    	 <span class="title" onclick="goView('${boardvo.adminBoard_idx}','${boardvo.rno}');"> ${boardvo.title}&nbsp;</span>
						    		 <img src="<%= request.getContextPath()%>/resources/images/disk.gif" />
						    	</c:if>
						    </c:if>
						    
				   		 </c:if>
				     
					      <%-- === 답변글인 경우 ===  --%>
					     <c:if test="${boardvo.depthno > 0}">
					   	     <c:if test="${boardvo.commentCount > 0}">	 <%-- 댓글쓰기게시판 ==> 댓글유무 --%>
						   	    <c:if test="${boardvo.fileName == null }">	 
						   	    	<span class="title" onclick="goView('${boardvo.adminBoard_idx}','${boardvo.rno}');" style="color:red; font-style: italic; padding-left: ${boardvo.depthno * 20 }px;">
						   	    	└RE&nbsp;&nbsp;</span>${boardvo.title}&nbsp;
						   	    	<span style="vertical-align: super;">[<span style="color: red; font-size: 9pt; font-style: italic; font-weight: bold;">${boardvo.commentCount}</span>] </span>
						    	</c:if>
						    	<c:if test="${boardvo.fileName != null }">	 
						   	    	 <span class="title" onclick="goView('${boardvo.adminBoard_idx}','${boardvo.rno}');" style="color:red; font-style: italic; padding-left: ${boardvo.depthno * 20 }px;">
						   	    	 └RE&nbsp;&nbsp;</span>${boardvo.title}&nbsp;
						   	    	  <img src="<%= request.getContextPath()%>/resources/images/disk.gif" />
						   	    	 <span style="vertical-align: super;">[<span style="color: red; font-size: 9pt; font-style: italic; font-weight: bold;">${boardvo.commentCount}</span>] </span>
						    	</c:if>
						     </c:if>
						     
						     <c:if test="${boardvo.commentCount == 0}">
						     	  <c:if test="${boardvo.fileName == null }">	 
						     	  	<span class="title" onclick="goView('${boardvo.adminBoard_idx}','${boardvo.rno}');">
						   	   			<span style="color:red; font-style: italic; padding-left: ${boardvo.depthno * 20 }px;">└RE&nbsp;&nbsp;</span>${boardvo.title}&nbsp;
						    		</span>
						     	  </c:if>
						     	  <c:if test="${boardvo.fileName != null }">	
						     	  	<span class="title" onclick="goView('${boardvo.adminBoard_idx}','${boardvo.rno}');">
						   	   			<span style="color:red; font-style: italic; padding-left: ${boardvo.depthno * 20 }px;">└RE&nbsp;&nbsp;</span>${boardvo.title}&nbsp;
						    			 <img src="<%= request.getContextPath()%>/resources/images/disk.gif" />
						    		</span> 
						     	  </c:if>
						    </c:if>
					     </c:if>
					</td>              
					<td align="center">${boardvo.name}</td>
					<td align="center">${boardvo.fk_sellerName}</td>
					<td align="center">${boardvo.fk_hotelName}</td>
					<td align="center">${boardvo.registerday}</td>
				</tr>	
				</c:forEach>					
		   </c:if>
	</table>
	
	<%-- === #126. 페이지바 보여주기 === --%> 
	<br/>
	<div align="center">
		${pagebar}
	</div>
	<form name="goViewFrm"> 
		<input type="hidden" name="adminBoard_idx"  />
		<input type="hidden" name="rno"  />
		<input type="hidden" name="gobackURL" value="${gobackURL}" /> 
	</form>

	<input type="button" value="글쓰기" onclick="location.href='<%=request.getContextPath()%>/adminWrite.bc'" style="font-size: 8pt; z-index: -1;" /> 
</div>   
