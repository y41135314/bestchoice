<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
    
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

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script type="text/javascript" src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/resources/slick-1.8.1/slick/slick.min.js"></script>
<!-- font -->
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<style type="text/css">
	
	#content { border: solid 0px red;
			   padding-top: 130px;
			   width: 1500px;
			   height: 100%;
			   clear: both;
			   /* margin: 0 auto; */ /*inline 속성 태그에서는 적용 안된다.*/
    }
	
	* {box-sizing: border-box;}
	
	div {outline: none;}   
	
	.top { width : 1024px;
		   margin-left: 120px;
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
	    margin-left: 120px;
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

	.tab_content {display: inline-block; width: 90%;}
	
	
	/* Style the tab content */
	.tabcontent {
	  display: none;
	  width: 1024px;
/* 	  padding: 6px 12px;
	  border: 1px solid #ccc; */
	  border-top: none;
	}

	
	#tab_review .total_review_info .review {
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
	
	
	/*************************************************************************************/
	.total_review_info {
		width: 100%;
		display: inline-block;
	    padding: 31px 0;
	    text-align: center;
	    border-bottom: 1px solid rgba(0,0,0,.08);
	    margin-left: 120px;
	}
	.score_wrap {
		display:inline-block;
	}
	.score_star {
		display:inline-block;
	}
	.score_num {
		display: inline-block;
	    position: relative;
	    top: -7px;
	    padding-left: 12px;
	    font-size: 32px;
	    line-height: 1;
	}
	/* .star{
	  display:inline-block;
	  width: 20px;height: 60px;
	  cursor: pointer;
	}
	.star_left{
	  background: url('/test_bestchoice/resources/images/star1.png') no-repeat 0 0; 
	  background-size: 36px; 
	  margin-right: -6px;
	}
	.star_right{
	  background: url('/test_bestchoice/resources/images/star1.png') no-repeat -18px 0; 
	  background-size: 36px; 
	  margin-right: -6px;
	}
	.star.on{
	  background-image: url('/test_bestchoice/resources/images/star2.png');
	  background-size: 36px; 
	}
	*/
	
.star-rating { width:205px; text-align: left;}
.star-rating,.star-rating span { display:inline-block; height:39px; overflow:hidden; background:url('/test_bestchoice/resources/images/star.png')no-repeat; }
.star-rating span{ background-position:left bottom; line-height:0; vertical-align:top; }

.mini-star-rating { width:123px; text-align: left;}
.mini-star-rating,.mini-star-rating span { display:inline-block; height:24px; overflow:hidden; background:url('/test_bestchoice/resources/images/mini_star.png')no-repeat; }
.mini-star-rating span{ background-position:left bottom; line-height:0; vertical-align:top; }


	.score_wrap p{
		margin-top: 22px;
	    font-size: 18px;
	    display: block;
	}

	/* 리뷰버튼 */
	.total_review_info button {
	    display: inline-block;
	    margin: 0 auto;
	    width: 300px;
	    height: 40px;
	    border: none;
	    border-radius: 4px;
	    font-size: 16px;
	    font-weight: normal;
	    color: #fff;
	    text-align: center;
	}
	
	.review_update {
		display: inline-block;
	    margin-left: 750px;
	}
	
	.review_update button {
	    margin: 10px;
	    width: 70px;
	    height: 40px;
	    border: none;
	    border-radius: 4px;
	    font-size: 16px;
	    font-weight: normal;
	    color: #fff;
	    text-align: center;
	}
	
	.review_update button:hover {
	    background-color: #AAA;
	}
	
	.gra_left_right_red {background: rgb(255,0,85);}
	
	.review {
		width: 1124px;
	}
	
	#gradeChart {
	    display: inline-block;
		/* border: solid 1px red; */
		width: 25%;
		vertical-align: top;
		position: sticky; 
		top: 100px;
		margin: 0;
		padding-top: 50px;
	}
	
	.review ul {
		display: inline-block;
	 	list-style: none;
	 	width: 74%;
	}
	
	.review ul li {
	    position: relative;
	    padding: 47px 0 28px 0;
	    border-bottom: 1px solid rgba(0,0,0,0.08);
	}
	
	
	.myscore_star {
		display: inline-block;
	}
	
	.mynum {
		display: inline-block;
		font-size: 16px;
		padding-left: 5px;
		position: relative;
		top:-5px;
	}
	
	.guest .icon {
	    display: inline-block;
	    overflow: hidden;
	    position: absolute;
	    top: 47px;
	    left: 16px;
	    width: 56px;
	    height: 56px;
	    border-radius: 100%;
	}
	.guest .icon img {
	    width: 56px;
	    height: 56px;
	}
	
	.guest .title {
	    display: block;
	    padding: 0 16px 2px 96px;
	    font-size: 16px;
	    line-height: normal;
	}
	
	.score_wrap_sm {
		display: inline-block;
		padding-left: 96px;
	}
	
	.guest .name {
	    display: block;
	    padding: 0 16px 2px 96px;
	    font-size: 16px;
	    line-height: normal;
	}
	
	.guest .content {
	    display: block;
	    padding: 0 16px 2px 96px;
	    font-size: 16px;
	    line-height: normal;
	}
	
	.review_img {
		display: inline-block;
		width: 100%;
		height: 300px;
		padding: 25px;
	}
    
    .review_slider img {
    display: inline-block;
    	width: auto; margin-right: 16px;
    }
    
    .guest .registerday {
	    display: block;
	    padding: 0 16px 2px 96px;
	    font-size: 16px;
	    line-height: normal;
	}
	
	.pagination a {
		 text-decoration: none;
		 color: black;
		 transition: background-color .3s;
		 width: 20px;
		 display: inline-block;
	}
	
	.pagination span {
		width: 20px;
		display: inline-block;
	}



/*   ㅁㅁㅁㅁㅁㅁㅁ 차트 만들기 ㅁㅁㅁㅁㅁㅁㅁㅁ */

	.highcharts-data-table table {
	
		font-family: Verdana, sans-serif;
		border-collapse: collapse;
		border: 1px solid #EBEBEB;
		margin: 10px auto;
		text-align: center;
		width: 100%;
		max-width: 500px;
	}
	
	.highcharts-data-table caption {
	    padding: 1em 0;
	    font-size: 1.2em;
	    color: #555;
	}
	
	.highcharts-data-table th {
		font-weight: 600;
	    padding: 0.5em;
	}
	
	.highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
	    padding: 0.5em;
	}
	
	.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
	    background: #f8f8f8;
	}
	
	.highcharts-data-table tr:hover {
	    background: #f1f7ff;
	} 


</style>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		
		var allReviewNum = $("#allReviewNum").text();
		console.log(allReviewNum);
		
		if(allReviewNum != 0) {
			gradeChart();
		}
		
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
			var tab_review =$(this).attr("class");	
			if("tablinks tab_review" != tab_review) {
				$(this).removeClass("on");
			}
		});
		
		//////////////////////////////////////review //////////////////////////////////////////////////
		
		
		
		
		// 전체 별점
		var allGrade = $("#allGrade").val();
		var str_allGrade = (allGrade*10)+"%";
		$(".star-rating-width").css("width",str_allGrade); 
		
		// 각각 별점 채워주기
		$(".miniallGrade").each( function(){
			var index = $(".miniallGrade").index(this);
			var miniallGrade = $(this).val();
			var str_miniallGrade = (miniallGrade*10)+"%";
			$(".mini-star-rating-width").eq(index).css("width",str_miniallGrade); 
		});
		
		// 랜덤이미지
		showImage();
 		
		
		// 리뷰이미지가 있다면 보여주고 없다면 안보여주기
		var flag = false;
		
		<c:forEach var="reviewMap" items="${reviewMapList}" varStatus="status">
			   
			var html = "<div class='review_img'>"; 
		    html += "<div class='review_slider'>"; 
		   		   
		   	<c:forEach var="reviewImageMap" items="${reviewImageMapList}">
			   <c:if test="${reviewImageMap.fk_review_no == reviewMap.review_no}">
			      html += "<img class='map_review_img' src='<%= ctxPath%>/resources/images/${reviewImageMap.orgImgname}'>"; 
			      flag = true;
			   </c:if>
		    </c:forEach>
		
		     html += "</div>"; 
			 html += "</div>"; 
			
			 if(flag == true) 
				$(".imageInsert${status.index}").append(html);
			 else
				$(".imageInsert${status.index}").html(""); 
			
			flag = false;
			
		</c:forEach> 
		
		
		
		// 리뷰사진 슬라이더
		$('.review_slider').slick({
			  slidesToShow: 2,
			  slidesToScroll: 1,
			  dots: false,
			  arrows: true,
			  //centerMode: true,
			  focusOnSelect: true,
			  infinite: false
			});
		
	}); // end of $(document).ready()--------------------------------------
	
	// 리뷰 쓰기 버튼 누르고 목록가기
	function goReviewList(member_idx) {
		var frm = document.goReviewListFrm;
		frm.member_idx.value = member_idx;
		frm.method = "GET";
		frm.action = "<%= ctxPath%>/reviewWriteList.bc";
		frm.submit();
	}
	
	// 랜덤이미지
	function showImage(){
		
		var imgArray = new Array();
		imgArray[0] = "<%= ctxPath%>/resources/images/jyu/icon/ico_11.png";
		imgArray[1] = "<%= ctxPath%>/resources/images/jyu/icon/ico_12.png";
		imgArray[2] = "<%= ctxPath%>/resources/images/jyu/icon/ico_13.png";
		imgArray[3] = "<%= ctxPath%>/resources/images/jyu/icon/ico_14.png";
		imgArray[4] = "<%= ctxPath%>/resources/images/jyu/icon/ico_15.png";
		
		var icon_img = document.getElementsByClassName("icon_img");
		
		for(var i=0; i<icon_img.length; i++) {
			var imgNum = Math.round(Math.random()*4);
			icon_img[i].src = imgArray[imgNum];
		}
		
	};
	
	function gradeChart() {
		$.ajax({
			url:"<%= ctxPath%>/gradeChartJSON.bc",
			type:"GET",
			data:{"hotel_idx":$("#hotel_idx").val()},
			dataType:"JSON",
			success:function(json){
				
				$.each(json, function(index, item){
					
					Highcharts.createElement('link', {
					    href: 'https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap',
					    rel: 'stylesheet',
					    type: 'text/css'
					}, null, document.getElementsByTagName('head')[0]);
					Highcharts.theme = {
						    colors: ['#f45b5b', '#8085e9', '#8d4654', '#7798BF', '#aaeeee',
						        '#ff0066', '#eeaaee', '#55BF3B', '#DF5353', '#7798BF', '#aaeeee'],
					        /* chart: {
					            backgroundColor: 'rgba(0,0,0,0.08)'
					        } */
					};
					
					Highcharts.setOptions(Highcharts.theme);
					
					Highcharts.chart('gradeChart', {

						credits: {
							enabled: false
						}, // 워터마크 없애기
						 chart: {
						        polar: true,
						        type: 'area'
						 },

					     title: {
					        text: item.hotel_Name+' 평점',
					        x: 0,	// 제목 위치
					        margin: 0,
					    },

					    pane: {
					        size: '50%' // 그래프 크기
					    },

					    xAxis: {
					        categories: ['객실시설', '접근성', '청결도', '서비스', '만족도'],
					        tickmarkPlacement: 'on',
					        lineWidth: 0
					    },

					    yAxis: {
					        gridLineInterpolation: 'polygon',
					        lineWidth: 0,
					        min: 0,
					        max: 10,
					        tickInterval: 5
					    },

					    legend: {
					    	enabled: false,
					        align: 'right',
					        verticalAlign: 'middle',
					        layout: 'vertical'
					    },

					    series: [{
					        name: item.hotel_Name,
					        data: [item.grade1, item.grade0, item.grade2, item.grade3, item.grade4],
					        pointPlacement: 'on'
					    }],
					    exporting: {
					    	enabled: false
					  	}, // 메뉴 없애기
					    responsive: {
					        rules: [{
					            condition: {
					                maxWidth: 500
					            },
					            chartOptions: {
					                legend: {
					                    align: 'center',
					                    verticalAlign: 'bottom',
					                    layout: 'horizontal'
					                },
					                pane: {
					                    size: '70%'  // 그래프 크기
					                }
					            }
					        }]
					    }
					});
				}); // end of each--------------------------
				
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}	
</script>

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
        <button class="tablinks detail_info" onClick="javascript:location.href='<%= ctxPath %>/roomService.bc?hotel_idx=${hotelInfoVO.hotel_idx}&startday=${startday}&endday=${endday}'"><span>숙소정보</span></button>
        <button class="tablinks tab_review on" onClick="javascript:location.href='<%= ctxPath %>/roomReview.bc?hotel_idx=${hotelInfoVO.hotel_idx}&startday=${startday}&endday=${endday}'"><span>리뷰</span></button>
    </div>
    
    <!-- tab_content -->
    <div class="tab_content">
		
		<div id="tab_review" class="tabcontent" style="display: block;">
		
		<!-- tab_review -->
		  	<div id="total_review_info" class="total_review_info">
	  			<div class="score_top"><h3>${gradeMap.str_allGrade}</h3></div>
		  		<div class="score_wrap">
		  			<div class="score_star">
						<span class="star-rating">
						<span class="star-rating-width"><input id="allGrade" type="hidden" value="${gradeMap.allGrade}" /></span>
						</span>
		  			</div>
		  			<div class="score_num">${gradeMap.allGrade}</div>
		  			<p>전체리뷰<b>&nbsp;</b><span id="allReviewNum">${gradeMap.allReviewNum}</span></p>
	  			</div>
		  	</div>
		  	
		  	<c:if test="${sessionScope.loginuser != null}">
			  	<div class="total_review_info">
			  		<%-- <button type="button" class="gra_left_right_red" onClick="javascript:location.href='<%= ctxPath%>/reviewWriteList.bc?member_idx=${sessionScope.loginuser.member_idx}'"> 리뷰 작성하기 </button> --%>
			  		<button type="button" class="gra_left_right_red" onClick="goReviewList('${sessionScope.loginuser.member_idx}')"> 리뷰 작성하기 </button>
			  		
			  		<form name="goReviewListFrm">
				   		<input type="hidden" name="member_idx" />
					</form>
			  	</div>
		  	</c:if>
		  	
		
		  	<c:if test="${gradeMap.allReviewNum != 0}">
		  	<div class = "review">
			  	<div id="gradeChart" ></div>
			  	<c:if test="${reviewMapList != null}">
			  	<ul>
			  		<c:forEach var="reviewMap" items="${reviewMapList}" varStatus="status">
			  		<li>
			  		<%-- <input class="review_no" type="text" value="${reviewMap.review_no}"/> --%>
					<div class="guest">
					    <p class="icon">
					    	<img class="icon_img"/>
					    </p>
					    <strong class="title">${reviewMap.title}</strong>
					    <div class="score_wrap_sm">
					        <div class="myscore_star">
					        	<span class="mini-star-rating">
									<span class="mini-star-rating-width"><input class="miniallGrade" type="hidden" value="${reviewMap.allGrade}"/></span>
								</span>
					        </div>
					        <div class="mynum">${reviewMap.allGrade}</div>
					        
					    </div>
					    <div class="name">
					        <b>${reviewMap.name} · </b>${reviewMap.room_name}
					    </div>
					    <div class="content">
					    	<span>${reviewMap.content}</span>
	
	                    <div class="imageInsert${status.index}"></div> 
								
					    </div>
					    <span class="registerday" >${reviewMap.registerday}</span>
					</div>
			  		</li>
			  		</c:forEach>
			  		
			  	</ul>
	            </c:if>
		    </div>
		  	</c:if>       
	
		<c:if test="${gradeMap.allReviewNum == 0}">
			<div style="margin: 0 auto; margin-left: 200px; display: inline-block;"> 
       			<br/><br/>
       			<span style= "font-size: 40px; font-weight: bold; padding-top: 100px; margin-left: 100px; line-height: 500%;">작성된 리뷰가 없습니다.</span>
       			<img style= "width:30%; float: right;" src="<%= ctxPath%>/resources/images/리뷰.jpg"/>
       			<br/><br/>
     		</div>
		</c:if>   
		</div>
		<!-- tab_review -->
		
    </div>
    <!-- tab_content-->
    
    
    
    <%-- 페이지바 보여주기 === --%>
	<div class="pagination" align="center" style="padding: 40px; margin-left:600px; position:relative;">
		${pagebar}
	</div> 
</div>
<!-- Content  -->
<br/><br/><br/>









</body>
</html>


