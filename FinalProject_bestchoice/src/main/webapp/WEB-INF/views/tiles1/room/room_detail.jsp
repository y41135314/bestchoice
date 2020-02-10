<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<!--  달력 아이콘 -->
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> -->
<!-- datePicker -->
<link rel="stylesheet" type="text/css" href="https://npmcdn.com/flatpickr/dist/themes/material_red.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<!-- 슬라이더 -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/slick-1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/slick-1.8.1/slick/slick-theme.css"/>
<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/resources/slick-1.8.1/slick/slick.min.js"></script>
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
	
	.top { width : 1024px;
		   margin: 0 auto;
		   padding: 0 31px;
		   float: left;
		 /*   display: inline; */
	}
	
	/* ================== left ================== */
	.left { /* border: solid 1px red */;
		width : 490px;
		margin: 0;
		display: inline-block;
			
	}
	
	div.mainImg img {
		border: 0px solid red !important;
		border-radius: 0 !important;
	}
	
	.slider-nav {margin: 0 30px;}
	
	#slider-nav img {
		padding: 2px;
		opacity: 0.6;
		border: 1px solid rgba(0,0,0,0);
	}
	
	#slick-current img {
		opacity: 1.0 !important;
		border-radius: 4px;
		border: 1px solid rgba(0,0,0,0.38); !important;
	}
	
	
	/* ================== right ================== */
	
	.right { 
		/* border: solid 1px red; */
		width : 424px;
		margin: 0;
		clear: both;
		float: right;
		display: inline-block;
	}
	/* ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ info ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ */
	.right .info > .build_badge {
	    /* vertical-align: top; */
	    font-size: 22px;
	    padding: 2px;
	    margin: 3px 5px 0 0;
	    line-height: 30px;
	}
	
	.right .info h2 {
		vertical-align: top;
	    display: inline;
	    margin: 9px 0 0 0;
	    font-family: 'Noto Sans KR', sans-serif;
	    font-size: 29px;
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
	    margin: 6px 0 8px 0;
	    font-size: 18px;
        padding-top: 6px;
    	color: rgba(0,0,0,0.56);
	}
	/* ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ event ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ */
	.event_link {
	    margin-top: 16px;
	    padding: 0;
	    background: none;
	}
	
	.event_link section:after {
	    display: inline-block;
	    content: "";
	    position: absolute;
	    top: 50%;
	    right: 16px;
	    width: 12px;
	    height: 24px;
	    margin-top: -12px;
	    background: url(//image.goodchoice.kr/images/web_v3/ico_arr_gt.png) right 50% no-repeat;
	    background-size: 12px auto;
	    color: #fff;
	}
	
	/* ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ comment ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ */
	.right .comment {
	    display: block;
	    position: relative;
	    margin-top: 16px;
	    padding: 26px 24px;
	    background: rgb(250,250,250);
	}
	
	.right .comment strong {
	    display: block;
	    margin-bottom: 15px;
	    font-size: 16px;
	    color: rgba(0,0,0,0.87);
	}
	
	.right .comment button {
	    position: absolute;
	    top: 24px;
	    right: 24px;
	    background: none;
	    border: none;
	    font-size: 16px;
	    color: rgb(0,121,107);
	    outline: 0;
	}
	
	.right .comment div {
	    display: block;
	    overflow: hidden;
	    height: auto;
	    font-size: 14px;
	    line-height: 26px;
	    color: rgba(0,0,0,0.56);
	    white-space:pre-line;
	}
	
	.right .comment .clamp {
	    display: -webkit-box;
	    -webkit-line-clamp: 2;
	    -webkit-box-orient: vertical;
	    height: 52px;
	    text-overflow: ellipsis;
	}
	
	
	/* ================== tab menu ================== */
	.tab {
		clear: both;
		float: left;
	    width: 1024px;
	    margin: 0 auto;
	    padding: 0 15px;
	    margin-top: 38px;
	    border-bottom: 1px solid rgba(0,0,0,0.08);
	}
	
	.tab .on {
	    border-bottom: 2px solid rgb(242,17,76);
	    font-weight: bold;
	    color: rgb(230,28,81);
	}

	.tab button {
	    float: none;
	    width: auto;
	    height: 72px;
	    margin-right: 24px;
	    padding: 0;
	    border: none;
	    border-bottom: 2px solid #fff;
	    background: none;
	    font-size: 18px;
	    color: rgba(0,0,0,0.38);
	    outline: none;
	}

	.tab_content {display: inline-block;}
	
	
	/* Style the tab content */
	.tabcontent {
	  display: none;
	  width: 1024px;
/* 	  padding: 6px 12px;
	  border: 1px solid #ccc; */
	  border-top: none;
	}
	
	#datepicker{
		display: inline-block;
		background-color: white;
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
	
	.room .pic_info .info .price span {
		margin-left:20px; vertical-align: bottom; font-size: 16px; font-weight: bold; height: 30px; display: inline-block;
	}
	
	.room_info .info .price .price_info {
	    display: inline-block; float: right; margin-bottom: 10px; 
	}
	
	.room_info .info .price .price_info b {
	    margin-right:20px; float:right; vertical-align: top; height: 30px; font-size: 20px; font-weight: bold; font-family: 'Noto Sans KR', sans-serif;
	}
	
	.roomStock span {
	   /* border: solid 1px red;  */ text-align:right; width: 540px; padding-right:40px; color: rgba(0,0,0,0.46); font-size: 16px; margin-bottom: -10px;
	}
	
	/* 가격정보 */
	.room_info .info .price div .through_none {
	    margin-bottom: 3px;
	    height: 29px;
	    padding-top: 13px;
	    font-size: 16px;
	    color: rgba(0,0,0,0.56);
	}
	
	/* 가격문의 버튼*/
	.room_info .info .price button {
		width:540px; 
		border: 0; 
		outline: 0; 
		border-top: 1px solid rgba(0,0,0,0.08);
	    height: 66px;
	    padding: 20px 0 0 0;
	    background: #fff url(//image.goodchoice.kr/images/web_v3/ico_arr_gt_2.png) 100% 80% no-repeat;
	    background-size: 15px auto;
	    font-size: 16px;
	    color: rgba(0,0,0,0.87);
	    text-align: left;
	}
	
	/* 예약버튼 */
	.room_info .info button {
	    display: block;
	    width: 100%;
	    height: 40px;
	    border: none;
	    border-radius: 4px;
	    font-size: 16px;
	    font-weight: normal;
	    color: #fff;
	    text-align: center;
	}
	.gra_left_right_red {background: rgb(255,0,85);}
	
	
	/* The Modal (background) */
	.modal {
	  display: none; /* Hidden by default */
	  position: fixed; /* Stay in place */
	  z-index: 10; /* Sit on top */
	  padding-top: 100px; /* Location of the box */
	  left: 0;
	  top: 0;
	  width: 100%; /* Full width */
	  height: 100%; /* Full height */
	  overflow: hidden;
	  background-color: rgb(0,0,0); /* Fallback color */
	  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
	  
	}
	
	/* Modal Content */
	.modal-content {
	  position: relative;
	  background-color: #fefefe;
	  margin: auto;
	  padding: 0;
	  border: 1px solid #888;
	  width: 35%; /* Full width */
	  height: 100%; /* Full height */
	  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
	  -webkit-animation-name: animatetop;
	  -webkit-animation-duration: 0.4s;
	  animation-name: animatetop;
	  animation-duration: 0.4s;
	  max-height: 70vh; /* max 70% of the viewport height */
      overflow-y: auto;
	}
	
	/* 스크롤되지만 스크롤 안보이게 */
	.modal-content::-webkit-scrollbar {display: none;}
	

	/* Add Animation */
	@-webkit-keyframes animatetop {
	  from {top:-300px; opacity:0} 
	  to {top:0; opacity:1}
	}
	
	@keyframes animatetop {
	  from {top:-300px; opacity:0}
	  to {top:0; opacity:1}
	}
	
	/* The Close Button */
	.modal-close, .pic_close {
	  padding-right: 5px;
	  color: black;
	  float: right;
	  font-size: 28px;
	  font-weight: bold;
	  opacity: .2;
	}
	
	.modal-close:hover,
	.modal-close:focus,
	.pic_close:hover,
	.pic_close:focus {
	  color: black;
	  text-decoration: none;
	  cursor: pointer;
	  opacity: .5;
	}
	
	.modal-header {
	  z-index: 10;  /* header 고정 후 body보다 index 위로 보내주기*/
	  position: sticky; /* header 고정*/
	  top: 0;
	  border-radius: 4px 4px 0 0;
	  height: 66px;	
	  padding: 15px 16px;
	  background: white;
	  color: rgb(255,0,85);
	  opacity: 1.0;
	}
	
	.modal-body {padding: 0 16px;}
	
	.modal-body section {
	    margin: 0;
	    padding: 18px 0 5px 0;
	    border-bottom: 1px solid rgba(0,0,0,0.08);
	    font-size: 16px;
	    color: rgba(0,0,0,0.56);
	    text-align: left;
	}
	
	.modal-body strong {margin: 10px 0 0 10px !important;}
	
	.dot_txt {padding-left: 20px !important;}
	
	.dot_txt li {
	    padding-left: 14px;
	    line-height: 26px;
	    background: url(//image.goodchoice.kr/images/web_v3/ico_bul_3.png) -1px 0 no-repeat;
	    background-size: 12px auto;
	    list-style: none;
	}
	
	/* 대표사진 클릭시 내부사진 슬라이더*/
	.pic_allview {
		border: solid 0px red;
		display: inline-block;
		width: 974px;
		padding: 50px 70px 30px 70px;
		background-color: rgba(192,192,192,0.08);
	}
	
	
	.pic_slider {
		width: 650px;
		height: auto; 
		margin: 0 auto;
	}
	
	
	.pic_next {
	    background-color:rgba(255,255,255,0.9); 
	    cursor: pointer; 
	    position: absolute; 
	    top: 50%; 
	    width: auto; 
	    margin-top: -22px; 
	    padding: 13px; 
	    color: rgba(0,0,0,0.4); 
	    font-weight: bold; 
	    font-size: 30px; 
	    transition: 0.6s ease; 
	    border-radius: 3px 0 0 3px; 
	    border: none; 
	    outline: none;
	    user-select: none; 
	    right: 0; 
	    z-index:2;
	}
	
	.pic_prev {
		background-color:rgba(255,255,255,0.9);
	    font-size: 40px;
	    cursor: pointer; 
	    position: absolute; 
	    top: 50%; 
	    width: auto; 
	    margin-top: -22px; 
	    padding: 13px; 
	    color: rgba(0,0,0,0.4); 
	    font-weight: bold;
	    font-size: 30px; 
	    transition: 0.6s ease; 
	    border-radius: 0 3px 3px 0;
	    border: none; 
	    outline: none; 
	    user-select: none; 
	    z-index:2;
	}
	
	.pic_prev:hover, .pic_next:hover {
		background-color:rgba(255,255,255,1.0);
		color: rgba(100,100,100,1.0); 
	}
	
	.pic_prev.slick-disabled, .pic_next.slick-disabled {
		background-color:rgba(255,255,255,0.3);
		color: rgba(0,0,0,0.3); 
	}
	
	.pic_close {
		position: absolute;
		font-size: 35px;
		left: 1150px;
	}
	
</style>

</head>
<body>

<!-- Content  -->
<div id="content" class="detail"> 
	
    <!-- Top -->
    <div class="top">
	
        <!-- Left -->
  		<div class="left">
			<div class="container" style="width : 500px; margin: 0; padding: 0; display: inline;">
				<div class="slider slider-for" id="slider-for">
					<div class="mainImg"><img src="<%= ctxPath%>/resources/images/1.jpg" style="width:100%"></div>
					<div class="mainImg"><img src="<%= ctxPath%>/resources/images/2.jpg" style="width:100%"></div>
					<div class="mainImg"><img src="<%= ctxPath%>/resources/images/3.jpg" style="width:100%"></div>
					<div class="mainImg"><img src="<%= ctxPath%>/resources/images/4.jpg" style="width:100%"></div>
					<div class="mainImg"><img src="<%= ctxPath%>/resources/images/5.jpg" style="width:100%"></div>
					<div class="mainImg"><img src="<%= ctxPath%>/resources/images/6.jpg" style="width:100%"></div>
				</div>
			    
			  	<br/>
				   
			    <div class="slider slider-nav" id="slider-nav" style="width:90%; margin: 0 auto;">
					<div id="slick-current"><img src="<%= ctxPath%>/resources/images/1.jpg" style="width:100%"></div>
					<div><img src="<%= ctxPath%>/resources/images/2.jpg" style="width:100%"></div>
					<div><img src="<%= ctxPath%>/resources/images/3.jpg" style="width:100%"></div>
					<div><img src="<%= ctxPath%>/resources/images/4.jpg" style="width:100%"></div>
					<div><img src="<%= ctxPath%>/resources/images/5.jpg" style="width:100%"></div>
					<div><img src="<%= ctxPath%>/resources/images/6.jpg" style="width:100%"></div>
				</div>
				 
		
        	</div>
        </div>	
        <!-- Left -->
        
        <!-- Right -->
     	<div class="right">
			<div class="container" style="width : 500px; margin: 0; padding: 0; display: inline;">
				<!-- Info -->
            	<div class="info">
	                <span class="build_badge" style="color: rgba(255,255,255,1); background-color: rgba(103,101,201,1);">${hotel_Category}</span>
	                <h2 id="hotelName">${hotelInfoVO.hotel_Name}</h2>
	                
	                <c:if test="${gradeMap.allReviewNum != 0}">
		                <div class="score_cnt">
		                    <span>${gradeMap.allGrade}</span>${gradeMap.str_allGrade}
		                </div>
	                </c:if>
	                
	                <p class="address">${hotel_Addr}</p>
	            	</div>
				<!-- Info -->
            	
				<!-- comment -->
				<div class="comment">
	                <strong>사장님 한마디</strong>
	                <button id="commentBtn">더보기</button>
	                <div id="comment">상암동에 위치한 호텔로서 디지털미디어센터, 월드컵경기장, 하늘공원과 인접해 편리한 접근성을 제공합니다.
						 3층 전 층을 활용한 피트니스클럽이 인상적이며, 4층 전면에 위치한 정원이 매우 아름다운 호텔입니다</div>
                </div>
				<!-- comment -->
			</div>
        </div>
        <!-- Right -->
    </div>
    <!-- Top -->	
    
    
    <!-- Tab Menu -->
    <div class="tab">
        <button class="tablinks book on" onClick="javascript:location.href='<%= ctxPath %>/roomDetail.bc?hotel_idx=${hotelInfoVO.hotel_idx}&startday=${startday}&endday=${endday}'"><span>객실안내/예약</span></button>
        <button class="tablinks detail_info" onClick="javascript:location.href='<%= ctxPath %>/roomService.bc?hotel_idx=${hotelInfoVO.hotel_idx}&startday=${startday}&endday=${endday}'"><span>숙소정보</span></button>
        <button class="tablinks tab_review" onClick="javascript:location.href='<%= ctxPath %>/roomReview.bc?hotel_idx=${hotelInfoVO.hotel_idx}&startday=${startday}&endday=${endday}'"><span>리뷰</span></button>
    </div>
    
    <!-- tab_content -->
    <div class="tab_content">
	    <div id="book" class="tabcontent room_info" style="display: block;">
			<div class="input-group col-sm-3" id="datepicker" style="margin: 30px 0;">
				<a class="input-group-addon" title="toggle" data-toggle style="display: inline-block; width: 40px; float: left; height: 34px; padding: 8px;"><i class="icon-calendar fa fa-calendar bigger-110" style="vertical-align: middle;"></i></a>
				<form id="roomDetailFrm" name="roomDetailFrm" method="GET">
					<input type="hidden" name="hotel_idx" id="hotel_idx" value="${hotelInfoVO.hotel_idx}">
					<input type="text" data-input class="form-control" name="datepicker" style="display: inline-block; width: 200px; background-color: white; z-index: 0;" autocomplete="off"/>
				</form>
				
			</div>
			<c:if test="${roomInfoList != null}">
			<c:forEach var="roomInfoMap" items="${roomInfoList}">
			<div class="room">
				<div class="pic_view"><img class="pic_view_img" style="width: 380px; height: auto;" src="<%= ctxPath%>/resources/images/1.jpg"/></div>
                <!-- pic_info -->
                <div class="pic_info">       
                	<strong class="title">${roomInfoMap.room_name}</strong>
                	<div class="info">
		                <div class="price">
		                	<!-- <div class="price_info" style="display: inline-block; float: right;">
		                	<span>가격</span>
		                	<span>99,000원</span> -->
		                	
		                	<c:if test="${roomInfoMap.cnt > 1}">
			                	<div class="roomStock">
			                		<span>${roomInfoMap.cnt}박 이용가능</span>
			                	</div>
		                	</c:if>
		                	
			                <span>가격</span>
			                <div class="price_info" style="display: inline-block; float: right;">
				                <c:if test="${roomInfoMap.cnt == 1}">
									<p><b><fmt:formatNumber value="${roomInfoMap.roomprice}" pattern="###,###" />원</b></p>
								</c:if>
								<c:if test="${roomInfoMap.cnt > 1}">
									<p><b><fmt:formatNumber value="${roomInfoMap.roomprice/roomInfoMap.cnt}" pattern="###,###" />원 / 1박</b></p>
								</c:if>
							</div>
							<button type="button" id="myBtn" class="infoBtn"><span>객실 이용 안내</span></button>
							
							<!-- The Modal -->
							<div id="myModal" class="modal">
							
							  <!-- Modal content -->
								<div class="modal-content">
								  <div class="modal-header">
								    <span class="modal-close">&times;</span>
								    <h4>객실 이용 안내</h4>
								  </div>
								  <div class="modal-body">
								    <c:if test="${bedtypeList != null}">
								    <c:forEach var="bedtypeMap" items="${bedtypeList}">
								    <c:if test="${roomInfoMap.room_idx == bedtypeMap.room_idx}">
								    <section>
								    	<strong>기본정보</strong>
								    	<ul class="dot_txt">
								    		<li class="dot_content">${bedtypeMap.room_person}인 기준 최대 ${bedtypeMap.room_addperson}인</li>
								    		<li class="dot_content">${bedtypeMap.bedtype} 1개</li>
								    		<li class="dot_content">개실+욕실 / 8.00평</li>
								    	</ul>
							    	</section>
							    	</c:if>
							    	</c:forEach>
							    	</c:if>
							    	
							    	<c:if test="${spatypeList != null}">
								    <section>
								    	<strong>스파시설</strong>
								    	<ul class="dot_txt spatype">
								    		<c:forEach var="spatypeMap" items="${spatypeList}" varStatus="status">
								    		<c:if test="${roomInfoMap.room_idx == spatypeMap.room_idx}">
								    			<li class="dot_content">${spatypeMap.spatype}</li>
								    		</c:if>
								    		<c:if test="${roomInfoMap.room_idx != spatypeMap.room_idx}">
								    		</c:if>
								    		</c:forEach>
								    	</ul>
							    	</section>
							    	</c:if>
								  
							    	
							    	<c:if test="${servicetypeList != null}">
								    <section>
								    	<strong>편의시설</strong>
								    	<ul class="dot_txt servicetype">
								    		<c:forEach var="servicetypeMap" items="${servicetypeList}" varStatus="status">
								    		<c:if test="${roomInfoMap.room_idx == servicetypeMap.room_idx}">
								    		<li class="dot_content">${servicetypeMap.servicetype}</li>
								    		</c:if>
								    		
								    		<c:if test="${roomInfoMap.room_idx != servicetypeMap.room_idx}">
								    		</c:if>
								    		</c:forEach>
								    	</ul>
							    	</section>
							    	</c:if>
							    	
							    	<c:if test="${themetypeList != null}">
							    	<section>
								    	<strong>패키지 정보</strong>
								    	<ul class="dot_txt themetype">
								    		<c:forEach var="themetypeMap" items="${themetypeList}" varStatus="status">
								    		<c:if test="${roomInfoMap.room_idx == themetypeMap.room_idx}">
								    		<li class="dot_content">${themetypeMap.themetype}</li>
								    		</c:if>
								    		
								    		<c:if test="${roomInfoMap.room_idx != themetypeMap.room_idx}">
								    		</c:if>
								    		</c:forEach>
								    	</ul>
							    	</section>
							    	
							    	</c:if>
							    	
							    	<section>
								    	<strong>선택날짜</strong>
								    	<ul class="dot_txt">
								    		<li><fmt:formatDate value="${startday}" pattern="yyyy.MM.dd"/> ~ <fmt:formatDate value="${endday}" pattern="yyyy.MM.dd"/></li>
								    	</ul>
							    	</section>
							    	<br/><br/>
								  </div>
								
								</div>
							
							</div>
						
						
						</div>
						<br/>
						<c:if test="${roomInfoMap.cnt == 1}">
						<button type="button" class="gra_left_right_red" onClick="javascript:location.href='<%= ctxPath %>/pay/reserve.bc?fk_room_idx=${roomInfoMap.room_idx}&startday=${startday}&endday=${endday}'">예약하기</button>
						</c:if>
						<c:if test="${roomInfoMap.cnt > 1}">
							<button type="button" class="gra_left_right_red" onClick="javascript:location.href='<%= ctxPath %>/pay/reserve.bc?fk_room_idx=${roomInfoMap.room_idx}&startday=${startday}&endday=${endday}'">
							예약하기 | <fmt:formatNumber value="${roomInfoMap.roomprice}" pattern="###,###" />원 (${roomInfoMap.cnt}박)
							</button>
						</c:if>
						
                	</div>
                
                </div>
				<!-- pic_info -->
                
                <c:if test="${roomImageList != null}">
                <div class="pic_allview">
                	<span class="pic_close">&times;</span>
                	<div class="pic_slider" style="clear: both;">
                		<c:forEach var="roomImageVO" items="${roomImageList}" varStatus="status">
                			<c:if test="${roomImageVO.fk_room_idx == roomInfoMap.room_idx}">
	                		<img id="roomImage${status.index}" src='<%= ctxPath%>/resources/images/${roomImageVO.roomImage_FileName}'>
	                		</c:if>
	                	</c:forEach>
                	</div>
               	</div>
               	</c:if>
               	<c:if test="${roomImageList.isEmpty()}">
               		<div style="margin: 0 auto;"> 
               		<span style= "margin:30px 0 0 250px; font-size: 30px; font-weight: bold; line-height: 300%;">이미지 준비중....</span>
					<img style= "margin:30px 250px 0 0; width:15%; float: right;" src="<%= ctxPath%>/resources/images/관리자헤더.png"/>
					</div>
               	</c:if>
            </div>
            </c:forEach>
            </c:if>
            <!-- room -->
            <c:if test="${roomInfoList.isEmpty()}">
            	<div style="margin: 0 auto; margin-left: 200px; display: inline-block;"> 
       			<br/><br/>
       			<span style= "font-size: 50px; font-weight: bold; line-height: 300%; display: inline-block;">이용가능한 객실이 없습니다.</span>
       			<img style= "width:28%; float: right; display: inline-block;" src="<%= ctxPath%>/resources/images/관리자헤더.png"/>
       			<br/><br/>
     			</div>
            </c:if>
            
        </div>	
		<!-- book -->
		
    </div>
    <!-- tab_content-->
    
    
</div>
<!-- Content  -->
<br/><br/><br/>





<script type="text/javascript">
	$(document).ready(function(){
		
		//다음버튼 누른 후 id 부여하기
		$('#slider-nav').on('afterChange', function(event, slick, currentSlide, nextSlide){
			console.log($('.slick-slide.slick-current.slick-active').attr('id', 'slick-current'));
		});
		// 다음버튼 누르기 전 id 빼기
		$('#slider-nav').on('beforeChange', function(event, slick, currentSlide, nextSlide){
			console.log($('.slick-slide.slick-current.slick-active').attr('id', ''));
		});
		
		// 첫번째 사진 보이기
		$('.slider-for').slick({
			  slidesToShow: 1,
			  slidesToScroll: 1,
			  arrows: false,
			  fade: false,
			  asNavFor: '.slider-nav'
		});
		
		// 두번째 네비게이션
		$('.slider-nav').slick({
		  slidesToShow: 4,
		  slidesToScroll: 1,
		  asNavFor: '.slider-for',
		  dots: false,
		  arrows: true,
		  //centerMode: true,
		  focusOnSelect: true,
		  infinite: true,
		});
		
		// 로딩시 접어놓기
		$("#comment").addClass("clamp");
		
		// 더보기 버튼 누르면
		$("#commentBtn").click( function(){
			
			var commentBtn = $(this).text();
			if(commentBtn != "더보기") {
				$("#comment").addClass("clamp");
				$(this).text("더보기");
				return;
			}
			else {
				$("#comment").removeClass("clamp");
				$(this).text("접기");
				return;
			}
		});
		
		
		$(".tablinks").click( function(){
			var book =$(this).attr("class");	
			if("tablinks book" != book) {
				$(this).removeClass("on");
			}
			
		});
		
		
		
		
		
	 	var startdayStr = "${startday}";
		var enddayStr = "${endday}";
		
		if(!((startdayStr == null) && (enddayStr == null))){
			var startdayArr = startdayStr.split("-");
			var year1 = startdayArr[0];
			var month1 = startdayArr[1]-1;
			var day1 = startdayArr[2];
			
			var enddayArr = enddayStr.split("-");
			var year2 = enddayArr[0];
			var month2 = enddayArr[1]-1;
			var day2 = enddayArr[2];
			
			var startday = new Date(year1, month1, day1);
			var endday = new Date(year2, month2, day2); 
		}
		else {
			var startday = new Date();
			var endday = new Date().fp_incr(1);
		}
		
		$("#datepicker").flatpickr({
			allowInput: true,
			wrap: true,
			mode: "range",
		    minDate: "today",
		    maxDate: new Date().fp_incr(60),
		    dateFormat: "Y-m-d",
		    defaultDate: [startday, endday], // 또는 검색된 페이지에서 넘어온값
		    locale: { rangeSeparator: ' ~ ' },
		    /* onClose: function(selectedDates, dateStr, instance) {
		          let daysInRange = document.getElementsByClassName('inRange');
		          let daysLengthTotal = daysInRange.length + 1;
		          daysLengthTotal = ":: "+ daysLengthTotal+"박";
		          console.log(daysLengthTotal);
		    } */
		    saveButton: true,
		    onChange: function (selectedDates, dateStr, instance) {
		    	if(selectedDates.length==2) {
		        	$('#roomDetailFrm').submit();
		    	}
		    }
		    
		});
		
		// 객실상세사진 슬라이더
		var picSlider={ dots: true,
						infinite: false,
						speed: 500,
						fade: true,
						cssEase: 'linear',
						prevArrow : '<button type="button" class="pic_prev" >&lt;</button>',
						nextArrow : '<button type="button" class="pic_next";">&gt;</button>'
		}
		// 객실사진 클릭하면		
		$(".pic_allview").hide(); // 처음엔 숨기고
		
		// 클릭한 이미지를 누르면 슬라이더 div 만들어주기
		$(".pic_view_img").click(function(){
			var index = $(".pic_view_img").index(this);
		  	console.log("index : " + index);
		  	$(".pic_allview").eq(index).show();
		    $(".pic_slider").eq(index).slick(picSlider);
		});
		// 클릭한 버튼를 누르면 슬라이더 div 숨기기
		$(".pic_close").click(function(){
			var index = $(".pic_close").index(this);
		  	console.log("index : " + index);
		  	$(".pic_allview").eq(index).hide();
		    $(".pic_slider").eq(index).slick('unslick');
		});
				
		// modal창   누른 버튼의 모달창 띄우기
		$(".infoBtn").click(function(){
			var index = $(".infoBtn").index(this);
		//  console.log("index : " + index);
		    $(".modal").eq(index).css("display","block"); 
		});
		
		$(".modal-close").click(function(){
		    $(".modal").css("display","none"); 
		});
	////////////////////////////////////// book //////////////////////////////////////////////////	
		
		/* var cnt = $("ul.dot_txt"). children(".dot_content").length;
		console.log(cnt);
		if(cnt=0) {
			$("ul.dot_txt").css('display', 'hidden');
		} */
		
	}); // end of $(document).ready()--------------------------------------
	
	
	
	
	
	

	
</script>


</body>
</html>


