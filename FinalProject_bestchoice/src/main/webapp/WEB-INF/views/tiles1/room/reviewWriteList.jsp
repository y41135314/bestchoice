<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%
	String ctxPath = request.getContextPath();
   //     /startspring 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

<!-- font -->
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">




<style type="text/css">
	
	#content { border: solid 0px red;
			   padding-top: 100px;
			   width: 1024px;
			   height: 100%;
			   clear: both;
			   margin: 0 auto; /*inline 속성 태그에서는 적용 안된다.*/
    }
	
	* {box-sizing: border-box;}
	
	div {outline: none;}   
	
	tr {line-height: 150%;}
	th {width: 100px; text-align: left;}
	/* ================== right ================== */
	

	/* ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ info ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ */
	.right .info > .build_badge {
	    /* vertical-align: top; */
	    font-size: 20px;
	    padding: 2px;
	    margin: 3px 5px 0 0;
	    line-height: 30px;
	}
	
	.right .info h2 {
		vertical-align: top;
	    display: inline;
	    margin: 9px 0 0 0;
	    font-family: 'Noto Sans KR', sans-serif;
	    font-size: 20px;
	    font-weight: bold;
	    color: rgba(0,0,0,0.87);
	}
	
	.right .info .score_cnt {
	    position: relative;
	    clear: both;
	    margin: 9px 0 6px 0;
	    font-size: 18px;
	    color: rgb(255,167,38);
	}
	
	.right .info .score_cnt span {
	    display: inline-block;
	    position: relative;
	    top: -3px;
	    height: 18px;
	    margin-right: 7px;
	    padding: 0 4px;
	    border-radius: 4px;
	    background: rgb(255,167,38);
	    font-size: 14px;
	    line-height: 17px;
	    color: #fff;
	}
	
	.right .info .address {
	    margin: 10px 0 14px 0;
	    font-size: 18px;
        padding-top: 6px;
    	color: rgba(0,0,0,0.56);
	}
	
	/* 객실안내 book*/
	
	.room {
		width:1024px; margin-bottom:25px; padding: 25px; border: 1px solid rgba(0,0,0,0.08); border-radius: 4px; display: inline-block;
	}
	
	.room .pic_view {
		display: inline-block; 
		cursor: pointer; 
		margin-right: 25px;  
		vertical-align: top;
		height: 240px; overflow: hidden; /*높이 벗어나면 사진 자르기*/
	}
	
	.room .pic_info {
		display: inline-block; 
		width: 540px;
	}
	
	.room .pic_info .title {
		height: 37px; 
		font-size: 20px; 
		font-weight: bold;
	}
	
	.room .pic_info .info {
		padding-top: 16px; display: inline-block; width: 540px;
	}
	
	.room .pic_info .info .price {
		"display: inline-block; width: 540px;
	}
	
	.room .pic_info .info .price strong {
		vertical-align: bottom; margin-top: 35px; font-size: 16px; font-weight: bold; height: 30px; display: inline-block;
	}
	
	.room_info .info .price .price_info {
	    display: inline-block; float: right;
	}
	
	.room_info .info .price .price_info b {
	    vertical-align: top; height: 30px; font-size: 20px; font-weight: bold; font-family: 'Noto Sans KR', sans-serif;
	}
	
	/* 가격정보 */
	.room_info .info .price div .through_none {
	    margin-bottom: 3px;
	    height: 29px;
	    padding-top: 13px;
	    font-size: 16px;
	    color: rgba(0,0,0,0.56);
	}
	
	
	
	/* 예약버튼 */
	.info button {
	    display: block;
	    width: 95%;
	    height: 40px;
	    border: none;
	    border-radius: 4px;
	    font-size: 16px;
	    font-weight: normal;
	    color: #fff;
	    text-align: center;
	    margin: 0 auto;
	}
	
	.info button:hover {
	    background-color: #AAA;
	}
	.gra_left_right_red {background: rgb(255,0,85);}
	
	.review_update {
		margin: 0 auto;
	}
	
	.review_update button {
		display: inline-block;
		width: 150px;
		margin: 13px;
	}
	
	.review_update button:hover {
	    background-color: #AAA;
	}
	
</style>

</head>
<body>

<!-- Content  -->
<div id="content" class="detail"> 

    
    <!-- tab_content -->
    <div class="tab_content">
	   		
	   		<c:if test="${useMyRoomList != null}">
	   		<c:forEach var="useMyRoomMap" items="${useMyRoomList}" varStatus="status">
			<div class="room">
				<div class="pic_view"><img class="pic_view_img" style="width: 380px; height: auto;" src="<%= ctxPath%>/resources/images/${useMyRoomMap.hotelImage_FileName}"/></div>
                <!-- pic_info -->
                <div class="pic_info">       
                	<!-- Right -->
			     	<div class="right">
						<div class="container" style="width : 500px; margin: 0; padding: 0; display: inline;">
							<!-- Info -->
			            	<div class="info">
				                <span class="build_badge" style="color: rgba(255,255,255,1); background-color: rgba(103,101,201,1);">${useMyRoomMap.hotel_Grade}성급</span>
				                <h2 id="hotelName">${useMyRoomMap.hotel_Name}</h2>
				                <p class="address">${useMyRoomMap.hotel_Addr}</p>
				                <table>
				                	<tr>
				                		<th>객실명</th>
				                		<td>${useMyRoomMap.room_name}</td>
				                	</tr>
				                	<tr>
				                		<th>결제금액</th>
				                		<td><fmt:formatNumber value="${useMyRoomMap.res_totalPrice}" pattern="###,###" /> 원</td>
				                	</tr>
				                	<tr>
				                		<th>이용날짜</th>
				                		<td>${useMyRoomMap.finish_date}</td>
				                	</tr>
				                </table>
				                <br/>
		          				
		          				<c:if test="${seqList != null }">
		          					<div class="btn${status.index}"></div>
		          				</c:if>
		          				
		          				<c:if test="${seqList.isEmpty()}">
		                		<div>
		                			 <button type="button" class="gra_left_right_red" onClick="javascript:location.href='<%= ctxPath%>/reviewWrite.bc?member_idx=${sessionScope.loginuser.member_idx}&seq=${useMyRoomMap.seq}'">리뷰 쓰기</button>
		                		</div>
				     			</c:if>
				            </div>
							<!-- Info -->
							
						</div>
			        </div>
			        <!-- Right -->
                	
                </div>
				<!-- pic_info -->
           
            </div>

            <input class="count count${status.index} ${status.index}" type="text" value="${useMyRoomMap.seq}"/>
            </c:forEach>
       		</c:if>
       		
       		<c:if test="${useMyRoomList.isEmpty()}"> <%-- List null 체크하는 방법은 .isEmpty()이다 --%>
       			<div style="margin: 0 auto; padding: 150px 0;"> 
       			<br/><br/>
       			<span style= "font-size: 40px; font-weight: bold; margin-left: 100px; line-height: 300%;">여기는 어때를 이용해주세요</span>
       			<img style= "width:20%; float: right; margin-right: 100px;" src="<%= ctxPath%>/resources/images/관리자헤더.png"/>
       			<br/><br/>
       			</div>
       		</c:if>
       		<input id="reviewCnt" type="hidden" value=""/>
       		
    </div>
    <!-- tab_content-->
    
    <br/><br/>
</div>
<!-- Content  -->






<script type="text/javascript">
	$(document).ready(function(){
		
		var count = document.getElementsByClassName("count");
		var cnt = 0;
		for(var i=0; i<count.length; i++) {
			cnt++;
		}
		
		$("#reviewCnt").val(cnt);
		
		
		// seq가 같다면 
		
			var flag1 = false; 
			var flag2 = false; 
			var html = ""; 
			var cnt = 0;
			<c:forEach var="useMyRoomMap" items="${useMyRoomList}" varStatus="status1">
				var count = $(".count${status1.index}").val();    
				
				<c:forEach var="seq" items="${seqList}" varStatus="status2">
			    	
					if(${seq} == count) {
						flag1 = true; // 같을 경우
						flag2 = false;
					}
					else {
						flag1 = false;
						flag2 = true; // 다를 경우
						
					}
					
				</c:forEach>
				
				if(flag1) {
					html += "<div class='review_update'>";
		    		html += "<button type='button' class='gra_left_right_red miniBtn reviewList' onClick='goReviewList()'>리뷰목록</button>";
		    		html += "<button type='button' class='gra_left_right_red miniBtn reviewUpdate'>수정</button>";
		    		html += "<button type='button' class='gra_left_right_red miniBtn reviewDelete'>삭제</button></div>";
					$(".btn${status1.index}").html(html);
					
				}
				else if(flag2){
					html = "<div style='margin: 13px;'><button type='button' class='gra_left_right_red reviewWrite' onClick='javascript:location.href='<%= ctxPath%>/reviewWrite.bc?member_idx=${sessionScope.loginuser.member_idx}&seq=${useMyRoomMap.seq}''>리뷰 쓰기</button></div>";
					$(".btn${status1.index}").html(html);
					
				}
				
			</c:forEach>
				
		$(".reviewUpdate").click( function(event){
			
			var $target = $(event.target);
			var btn = $target.parent().parent( 'div' ).attr("class");
			var lastChar = btn.charAt(btn.length-1);
			
			
			var seqClass = "."+lastChar+"";
			
			var seq = $(seqClass).val();
			alert(seq);
			window.location.href="<%= ctxPath%>/reviewEdit.bc?seq="+seq+"";
		});	
		
		
		$(".reviewDelete").click( function(event){
			
			var $target = $(event.target);
			var btn = $target.parent().parent( 'div' ).attr("class");
			var lastChar = btn.charAt(btn.length-1);
			
			var seqClass = "."+lastChar+"";
			
			var seq = $(seqClass).val();
			alert(seq);
			window.location.href="<%= ctxPath%>/reviewDel.bc?seq="+seq+"";
		});	
		
		$(".reviewWrite").click( function(event){
			
			var $target = $(event.target);
			var btn = $target.parent().parent( 'div' ).attr("class");
			var lastChar = btn.charAt(btn.length-1);
			
			var seqClass = "."+lastChar+"";
			
			var seq = $(seqClass).val();
			alert(seq);
			window.location.href="<%= ctxPath%>/reviewWrite.bc?member_idx=${sessionScope.loginuser.member_idx}&seq="+seq+"";
		});	
		
	}); // end of $(document).ready()--------------------------------------
	
	// 리뷰목록 가기
	function goReviewList(){
		window.location.href="<%= ctxPath%>/roomReview.bc";
	}
	
	
	
	

	
</script>


</body>
</html>


