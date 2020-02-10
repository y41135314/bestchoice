<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

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

<!-- 슬라이더 -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/slick-1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/slick-1.8.1/slick/slick-theme.css"/>
<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/resources/slick-1.8.1/slick/slick.min.js"></script>
<!-- font -->
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">


<style type="text/css">
	
	#content { border: solid 0px red;
			   padding-top: 130px;
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
	
	
	/*************************************************************************************/
	
	#detail_info .collapsible {
	  background-color: rgb(255,255,255);
	  color: #000;
	  border-bottom: 1px solid rgba(0,0,0,.08);
	  border-width: 0 0 1px 0;
	  cursor: pointer;
	  padding: 18px;
	  width: 100%;
	  text-align: left;
	  outline: none;
	  font-size: 16px;
	}
	
	#detail_info .collapsible:hover { background-color: rgba(0,0,0,0.01);}
	
	#detail_info .collapsible:after {
	  content: '\25E3';
	  -webkit-transform: rotate(315deg);
	  color: rgba(0,0,0,0.3);
	  font-weight: bold;
	  float: right;
	  margin-left: 5px;
	}
	
	#detail_info .active:after {
	  content: "\25E3";
	  -webkit-transform: rotate(135deg);
	}
	
	#detail_info .content {
	  padding: 0 18px;
	  max-height: 0;
	  overflow: hidden;
	  transition: max-height 0.2s ease-out;
	  background-color: rgba(0,0,0,0.05);
	}
	
	.content_info{
		font-size: 15px;
    	line-height: 24px;
    	color: rgba(0,0,0,0.56);
	}
	
	.infoList {
		padding-left: 20px;
	}
	
	.infoList > span {
	    display: block;
	    margin: 30px 0 10px 0;
	    font-size: 15px;
	    font-weight: bold;
	    color: rgba(0,0,0,0.56);
	}
	
	.infoList ul {
	    font-size: 15px;
	    line-height: 24px;
	    color: rgba(0,0,0,0.56);
	}
	
	.infoList ul li {
		line-height: 28px;
	}
	
	
	
	
	.service {
    	list-style: none;
	}
	
	.service li {
	    display: block;
		padding-top: 30px;
		/* border: solid 1px red; */
	    float: left;
	    width: 91px;
	    margin-right: 12px;
	    background-position: 50% 0 !important;
	    background-size: 35px auto !important;
	    font-size: 13px;
	    color: rgba(0,0,0,0.56);
	    text-align: center;
	}
	
	.service span {
		display: block;
		margin: 10px 0 20px 0;
	}
	
	/*************************************************************************************/
	
</style>

</head>
<body>

<!-- Content  -->
<div id="content" class="detail"> 
	
	<input type="hidden" id="hotel_idx" value="${hotelInfoVO.hotel_idx}">
    <!-- Top -->
    <div class="top">
	
        <!-- Left -->
  		<div class="left">
			<div class="container" style="width : 500px; margin: 0; padding: 0; display: inline;">
				
				<div class="slider slider-for" id="slider-for">
					<c:forEach var="HotelTotalImageMap" items="${hotelTotalImageList}" begin="0" end="0" step="1">
					<div class="mainImg"><img src="<%= ctxPath%>/resources/images/${HotelTotalImageMap.hotelimage_filename}" style="width:100%"></div>
					</c:forEach>
					<c:forEach var="HotelTotalImageMap" items="${hotelTotalImageList}">
					<div class="mainImg"><img src="<%= ctxPath%>/resources/images/${HotelTotalImageMap.roomimage_filename}" style="width:100%"></div>
					</c:forEach>
				</div>
			    
			  	<br/>
				   
			    <div class="slider slider-nav" id="slider-nav" style="width:90%; margin: 0 auto;">
					<div id="slick-current">
						<c:forEach var="HotelTotalImageMap" items="${hotelTotalImageList}" begin="0" end="0" step="1">
						<img src="<%= ctxPath%>/resources/images/${HotelTotalImageMap.hotelimage_filename}" style="width:100%">
						</c:forEach>
					</div>
					<c:forEach var="HotelTotalImageMap" items="${hotelTotalImageList}">
					<div><img src="<%= ctxPath%>/resources/images/${HotelTotalImageMap.roomimage_filename}" style="width:100%"></div>
					</c:forEach>
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
        <button class="tablinks book" onClick="javascript:location.href='<%= ctxPath %>/roomDetail.bc?hotel_idx=${hotelInfoVO.hotel_idx}&startday=${startday}&endday=${endday}'"><span>객실안내/예약</span></button>
        <button class="tablinks detail_info on" onClick="javascript:location.href='<%= ctxPath %>/roomService.bc?hotel_idx=${hotelInfoVO.hotel_idx}&startday=${startday}&endday=${endday}'"><span>숙소정보</span></button>
        <button class="tablinks tab_review" onClick="javascript:location.href='<%= ctxPath %>/roomReview.bc?hotel_idx=${hotelInfoVO.hotel_idx}&startday=${startday}&endday=${endday}'"><span>리뷰</span></button>
    </div>
    
    <!-- tab_content -->
    <div class="tab_content">
     
		
		<div id="detail_info" class="tabcontent" style="display: block;">
		<!-- detail_info -->

			<button class="collapsible">기본정보</button>
			<div class="content content_info">
				<div class="infoList">
					<span class="infoSub">기본사항</span>
					<ul>
						<li>전 객실 금연</li>
						<li>개인금고</li>
						<li>무료 주차 (객실 당 등록된 차량 1대만 가능)</li>
						<li>Bath Amenity (치약, 칫솔 무료/ 면도기 별도 구매)</li>
						<li>환경 보호정책 일환으로 필요 요청 고객에 한해서 무료 제공이며, 프론트 직접 방문 픽업 시 제공</li>
					</ul>
				</div>
				
				<div class="infoList">
					<span class="infoSub">인원 추가 정보</span>
					<ul>
						<li>엑스트라베드 추가: 33,000원</li>
						<li>현장 결제 및 호텔 문의</li>
					</ul>
				</div>
				
				<div class="infoList">
					<span class="infoSub">투숙객 혜택</span>
					<ul>
						<li>피트니스 센터 무료 이용</li>
					</ul>
				</div>
				
				<div class="infoList">
					<span class="infoSub">취소 및 환불 규정</span>
					<ul>
						<li>체크인 기준 3일 전 17시까지 : 100% 환불</li>
						<li>체크인 기준 3일 전 17시이후~당일 및 No-show : 환불불가</li>
						<li>취소, 환불시 수수료가 발생할 수 있습니다</li>
					</ul>
				</div>
				<div class="infoList">
					<span class="infoSub">확인사항 및 기타</span>
					<ul>
						<li>최대인원 초과시 입실 불가합니다</li>
						<li>위의 정보는 호텔의 사정에 따라 변경될 수 있습니다</li>
						<li>해당 이미지는 실제와 상이 할 수 있습니다</li>
						<li><span style="color: red; font-weight: bold;">체크인 시 배정 또는 베드타입 미기재 상품은 특정객실과 베드타입을 보장하지 않습니다</span></li>
						<li>해당 객실가는 세금, 봉사료가 포함된 금액입니다</li>
						<li>미성년자는 보호자 동반없이 이용하실 수 없습니다</li>
					</ul>
				</div>
				<br/>
				<div id="room_map" style="width:90%; height:300px; margin: 0 auto;"></div>
				<br/>
			</div>
			<button class="collapsible">편의시설 서비스</button>
			<div class="content content_service">
				
				<ul class="service" id="service">
					
				</ul>
			</div>
			
		</div>
		<!-- detail_info -->
		
		
    </div>
    <!-- tab_content-->
    
    
</div>
<!-- Content  -->
<br/><br/><br/><br/><br/>



<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dfcf458ab32902b650b43be9c5e6ae43&libraries=services"></script>

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
			var detail_info =$(this).attr("class");	
			if("tablinks detail_info" != detail_info) {
				$(this).removeClass("on");
			}
		});
		
    	var coll = document.getElementsByClassName("collapsible");
		var i;
		
		for (i = 0; i < coll.length; i++) {
			  coll[i].addEventListener("click", function() {
			    this.classList.toggle("active");
			    var content = this.nextElementSibling;
			    if (content.style.maxHeight){
			      content.style.maxHeight = null;
			    } else {
			      content.style.maxHeight = content.scrollHeight + "px";
			    } 
			  });
			}
		
		// 지도 만들기
		var mapContainer = document.getElementById('room_map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch('${hotel_Addr}', function(result, status) {
		
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
		
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
		
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		        	content: "<div style='width:150px;text-align:center;padding:6px;font-size:15px;'>${hotelInfoVO.hotel_Name}</div>"
		        });
		        infowindow.open(map, marker);
		
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		}); // end of geocoder.addressSearch()--------------------------------
		
		$.ajax({
			url:"<%= ctxPath%>/roomServiceJSON.bc",
			type:"GET",
			data:{"hotel_idx":$("#hotel_idx").val()},
			dataType:"JSON",
			success:function(json){
				
				var html = "";
				$.each(json, function(index, item){
					if(item.status != "0"){
						html += "<li><img src='<%= ctxPath%>/resources/images/jyu/service/"+item.service+".png'/><span>"+item.str_service+"</span></li>";
					}
					
				});
		
				$("#service").html(html);
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
				
		}); // end of $.ajax-----------------------------------------
				
	}); // end of $(document).ready()--------------------------------------
	
	
	
	
	

	
</script>


</body>
</html>


