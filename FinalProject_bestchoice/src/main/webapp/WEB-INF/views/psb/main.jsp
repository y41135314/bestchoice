<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
    
    
<%
   String ctxPath = request.getContextPath();
 
%>
    
<jsp:include page="header.jsp" />

<link rel="stylesheet" href="<%= ctxPath%>/resources/css/main.css">

<!DOCTYPE html>
<html>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400,500|Roboto&display=swap" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css"> <!--캘린더 css  -->

<meta name="viewport" content="width=device-width, initial-scale=1">


<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script> <!--캘린더 -->



<body>



<!-- Slide Show -->
<section>

   <div class="main_envent_seach">
	  <div class="main_envent_text_block" >	 <!-- 메인 검색창 상자  -->
	     <div class="main_input_keword" style="display: inline-block;">	 
		     <div class="keword">검색></div> 
		     <img src="<%= ctxPath%>/resources/images/minha_images/input_keword.jpg"/>		      
			 <input class="input_keword" type="text" placeholder="도시, 호텔, 공항명 입력" value="" autocomplete="off"/>
	      </div>
	      
	      <div class="schedule_calendar" >
	      	  <div class="flatpickr">  
					<div id="set_night" >
					    <select class="set_night_select" id="sel_date" name="sel_date" title="투숙 박수" tabindex="-1">
					        <option value="1">1박</option>
					        <option value="2">2박</option>
					        <option value="3">3박</option>
					        <option value="4">4박</option>
					        <option value="5">5박</option>
					        <option value="6">6박</option>
					        <option value="7">7박</option>
		    		    </select>
					</div>
					  
				    <div class="calendar_text" style="color: #909090;">
				    	<img src="<%= ctxPath%>/resources/images/minha_images/main_calendar.png" alt="" />날짜선택</div>
				    <input class="input_calendar"type="text" placeholder="체크인 - 체크아웃" data-input style="width: 250px;"> <!-- input is mandatory -->
	
				    <a class="input-button" title="toggle" data-toggle>
				        <i class="icon-calendar"></i>
				    </a>	
				    <a class="input-button" title="clear" data-clear>
				        <i class="icon-close"></i>							        
				    </a>				       
			   </div> <!-- flatpickr -->			   			   					   					   
  		   </div> <!-- schedule_calendar -->
  		   
  		   
  		   <div id="main_room_passen" class="set_room_person">
				<button type="button" class="roomPerson_btn_open" id="modal_btn">
					<input type="hidden" id="RoomPassen" name="RoomPassen" value="" />
					<span style="font-size:12pt;">객실수 <strong class="room_select" id="srp_room">1</strong></span>
					<span style="font-size:12pt;">성인 <strong class="room_select" id="srp_adult">2</strong></span>
					<span style="font-size:12pt;">아동 <strong class="room_select" id="srp_child">0</strong></span>
				</button>
			</div>

			<div class="set_room_person_layer" id="Modal_set_room_person">
				<div class="setRoomPerson_box">
				 <span class="close">&times;</span> <!--모달 닫기버튼   -->
					
					<div class="person person_select"  style="display: inline-block;">
					<h2 class="srp_title">
						<strong>객실<span class="srp_boxNum"></span></strong>
					</h2>					
						<select title="성인 인원" class="srp_selectAdult">
							<option value="1">성인 1 명</option>
							<option value="2" selected="">성인 2 명</option>
							<option value="3">성인 3 명</option>
							<option value="4">성인 4 명</option>
							<option value="5">성인 5 명</option>
							<option value="6">성인 6 명</option>
							<option value="7">성인 7 명</option>
							<option value="8">성인 8 명</option>
							<option value="9">성인 9 명</option>
						</select>
						
						<select title="아동 인원" class="srp_selectChild">
							<option value="0" selected="">아동 0 명</option>
							<option value="1">아동 1 명</option>
							<option value="2">아동 2 명</option>
							<option value="3">아동 3 명</option>
							<option value="4">아동 4 명</option>
							<option value="5">아동 5 명</option>
							<option value="6">아동 6 명</option>
						</select>
  

				<div class="styled-select sel_left oversea" style="display: inline-block;">
					<select name="selRoomCnt" id="selRoomCnt_ov" class="srp_selectRoom"  title="객실 수">						
						<option value="1">객실 1개</option>						
						<option value="2">객실 2개</option>					
						<option value="3">객실 3개</option>						
						<option value="4">객실 4개</option>						
						<option value="5">객실 5개</option>					
					</select>
				</div>
			</div> <!-- person_select  -->
	  	 </div> <!-- setRoomPerson_box -->
	</div> <!-- // Modal_set_room_person -->
						 
	      <button type="button" class="keword_search" id="keword_search_btn"><span>검색</span></button>   	 
</div> <!-- 메인 검색창  -->
	    
	  <!-- 메인슬라이더 이미지  -->
	  <a href="<%= ctxPath%>/event/main.bc">
	  	<img class="mySlides" src="<%= ctxPath%>/resources/images/minha_images/main_event_４.jpg">
	  </a>
	  <a href="<%= ctxPath%>/event/main.bc">
	  	 <img class="mySlides" src="<%= ctxPath%>/resources/images/minha_images/main_event_6.jpg">
	  </a>
  </div> <!-- 메인이미지슬라이더 -->
 </section>  
 
 
	<h2 class="event_title">
		<span class="txt_thin">여기는 어때 에서만 만날 수 있는 특별한 이벤트</span> 
	</h2>

<div class="event_container">
 <div class="slideshow-container1" > 
		<div style="text-align:center">
		  <span class="dot1" onclick="currentSlide(1)"></span> 
		  <span class="dot1" onclick="currentSlide(2)"></span> 
		  <span class="dot1" onclick="currentSlide(3)"></span> 
		</div> 
		  <!-- 두번째 이벤트 슬라이드1  -->
		  <div class ="slides_box">
		  <div class="mySlides_1 fade">
			  <div class="numbertext">1 / 3</div>
			  <a href="<%= ctxPath%>/event/main.bc">
			  	<img id="second_evetn_img" src="<%= ctxPath%>/resources/images/minha_images/main_scond_event5.png">
			  </a>
			  <div class="slider_event_title">
				<strong>음악의 바이브가 필요한 여기는 어때 회원 누구나  </strong>
				<span> VIBE 1개월 이용권 </span>
			</div>
		 </div>				 
						
		 <div class="mySlides_1 fade">
			  <div class="numbertext">2 / 3</div>
			  <a href="<%= ctxPath%>/event/main.bc">
			  <img id="second_evetn_img" src="<%= ctxPath%>/resources/images/minha_images/main_scond_event6.png">
			  </a>
			  <div class="slider_event_title">
				<strong>우리카드 포인트로 숙박부터 액티비티까지</strong>
				<span>보유포인트 전액 사용</span>
			 </div>
		</div>
		
		<div class="mySlides_1 fade">
		  <div class="numbertext">3 / 3</div>
		  <a href="<%= ctxPath%>/event/main.bc">
		  <img id="second_evetn_img" src="<%= ctxPath%>/resources/images/minha_images/main_scond_event7.png">
		  </a>
		  <div class="slider_event_title">
				<strong>50% cupon 을 돌려주는 페이백 </strong>
				<span> 예약후 쿠폰을 돌려받아 보세요 </span>
		  </div>
		</div>
		
		<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
		<a class="next" onclick="plusSlides(1)">&#10095;</a>
 	</div>
 </div>
 
 <div class="slideshow-container2">  
		  <!-- 두번째 이벤트 슬라이드2  -->
  <div class ="slides_box_2" > 
		  <div style="text-align:center">
		  <span class="dot2" onclick="currentSlide2(1)"></span> 
		  <span class="dot2" onclick="currentSlide2(2)"></span> 
		  <span class="dot2" onclick="currentSlide2(3)"></span> 
		</div>
		
		 <div class="mySlides_2 fade">
			  <div class="numbertext">1 / 3</div>
			  <a href="<%= ctxPath%>/event/main.bc">
			  	<img id="second_evetn_img" src="<%= ctxPath%>/resources/images/minha_images/main_scond_event3.jpg">
			  </a>
			  <div class="slider_event_title">
				<strong>제주에서 가장 HOT한 호텔  </strong>
				<span> 인피니트 풀에서 즐기는 제주여행  </span>
			</div>
		 </div>
		  	
		
		 <div class="mySlides_2 fade">
			  <div class="numbertext">2 / 3</div>
			  <a href="<%= ctxPath%>/event/main.bc">
			  <img id="second_evetn_img" src="<%= ctxPath%>/resources/images/minha_images/main_scond_event2.jpg">
			  </a>
			  <div class="slider_event_title">
				<strong> 강원도로 떠나는 여행   </strong>
				<span> 준비됐지 바다로 고고고! </span>
			</div>
		</div>
		
		<div class="mySlides_2 fade">
		  <div class="numbertext">3 / 3</div>
		  <a href="<%= ctxPath%>/event/main.bc">
		  	<img id="second_evetn_img" src="<%= ctxPath%>/resources/images/minha_images/main_scond_event1.jpg">
		  </a>	
		  <div class="slider_event_title">
				<strong>국내 럭셔리 브랜드 호텔 </strong>
				<span> 특별한날 우리 함께해요 </span>
			</div>
	      
		</div>
		
		<a class="prev" onclick="plusSlides2(-1)">&#10094;</a>
		<a class="next" onclick="plusSlides2(1)">&#10095;</a>		
	</div>	
 </div>
</div>  <!-- event_container -->


	<!-- 메인 지역선택   -->
	<div class="main_location">	
	<h2 class="event_title">
		<span class="txt_thin">원하는 지역을 찾아보세요 </span>
	</h2>

		<div class="main_content">				
		   <div class="city_image" style="display: block; width: 1080px; height: 220px; margin: 0 auto; margin-bottom: 20px;">			
			 <a href="<%=ctxPath%>/search/main.bc" onclick="">
				<strong class="city_" style="text-align: center; padding-left: 300px;" >지역별 BEST</strong>
				<img src="<%= ctxPath%>/resources/images/minha_images/main_local_best.jpg" alt="" />
			 </a>
			</div>	
			
			
				<div class="" style="display: inline-block;" >
				<div class="city_image " style=" width: 255px; height: 305px;">			
				  <a href="<%=ctxPath%>/search/main.bc" onclick="">
					<strong class="city_" style="text-align: center;" >강원</strong>
					<img src="<%= ctxPath%>/resources/images/minha_images/main_gangwon_do1.jpg" alt="" />
				 </a>				
				 </div>
				 
				<div class="city_image" style=" width: 255px; height: 305px;">			
				  <a href="<%=ctxPath%>/search/main.bc" onclick="">
					<strong class="city_" style="text-align: center;" >경기</strong>
					<img src="<%= ctxPath%>/resources/images/minha_images/main_gyeonggi_do1.jpg" alt="" />
				 </a>
				 </div>
				 </div>
				 
			
				 <div class="city_image" style=" width: 522px; height: 625px; display: inline-block;">			
				  <a href="<%=ctxPath%>/search/main.bc" onclick="">
					<strong class="city_" style="text-align: center; padding-left: 130px;" >서울</strong>
					<img src="<%= ctxPath%>/resources/images/minha_images/main_seoul_1.jpg" alt="" />
				 </a>
				</div>
	 
				<div class="" style="display: inline-block;">
	 				<div class="city_image" style=" width: 255px; height: 305px;">
						 <a href="<%=ctxPath%>/search/main.bc" onclick="">
							<strong class="city_" style="text-align: center;" >제주</strong>
							<img src="<%= ctxPath%>/resources/images/minha_images/main_jeju1.jpg" alt="" />
						 </a>
					 </div>
	
					<div class="city_image" style=" width: 255px; height: 305px;  ">			
						  <a href="<%=ctxPath%>/search/main.bc" onclick="">
							<strong class="city_" style="text-align: center;" >부산</strong>
							<img src="<%= ctxPath%>/resources/images/minha_images/main_busan1.jpg" alt="" />
						 </a>
					</div>	
				</div>
			
	  </div>
		</div>
		
<script type="text/javascript">
//메인 이벤트 슬라이더(3초)

		// 메인 광고이미지 3초 슬라이드 
		var myIndex = 0;
		carousel();
		
		function carousel() {
		  var i;
		  var x = document.getElementsByClassName("mySlides");
		  for (i = 0; i < x.length; i++) {
		     x[i].style.display = "none";
		  }
		  myIndex++;
		  if (myIndex > x.length) {myIndex = 1}
		  x[myIndex-1].style.display = "block";
		  setTimeout(carousel, 3000);
		}

		$(document).ready(function(){
			// 캘린더 
			$(".input_calendar").flatpickr({
			    mode: "range",
			    dateFormat: "y-m-d",
			    defaultDate: [new Date(), new Date().fp_incr(1)],
				locale: { rangeSeparator: ' ~ ' }
			}); 
		});
		
		
		// 모달 내용 
		var modal = document.getElementById("Modal_set_room_person");

		// 모달 버튼 
		var modal_btn = document.getElementById("modal_btn");
		
	
		// modal 닫기 버튼 
		var modal_close = document.getElementsByClassName("close")[0];

		
		modal_btn.onclick = function() {
		  modal.style.display = "block";
		}
		modal_close.onclick = function() {
		  modal.style.display = "none";
		}
		
		// 두번째 이벤트 슬라이드 1
		var slideIndex = 1;
		showSlides(slideIndex);
		
		function plusSlides(n) {
		  showSlides(slideIndex += n);
		}
		
		function currentSlide(n) {
		  showSlides(slideIndex = n);
		}
		
		// 두번째 이벤트 슬라이드 1 
		function showSlides(n) {
		  var i;
		  var slides = document.getElementsByClassName("mySlides_1");
		  var dots = document.getElementsByClassName("dot1");
		  if (n > slides.length) {slideIndex = 1}    
		  if (n < 1) {slideIndex = slides.length}
		  for (i = 0; i < slides.length; i++) {
		      slides[i].style.display = "none";  
		  }
		  for (i = 0; i < dots.length; i++) {
		      dots[i].className = dots[i].className.replace(" active", "");
		  }
		  slides[slideIndex-1].style.display = "block";  
		  dots[slideIndex-1].className += " active";
		} 
		
//////////////////////////////////////////////////////////////////////////////	

			// 두번째 이벤트 슬라이드 2
			var slideIndex2 = 1;
			showSlides2(slideIndex2);
			
			function plusSlides2(m) {
			  showSlides2(slideIndex2 += m);
			}
			
			function currentSlide2(m) {
			  showSlides2(slideIndex2 = m);
			}
			
			 function showSlides2(m) {
			  var p;
			  var slides = document.getElementsByClassName("mySlides_2");
			  var dots = document.getElementsByClassName("dot2");
			  if (m > slides.length) {slideIndex2 = 1}    
			  if (m < 1) {slideIndex2 = slides.length}
			  for (p = 0; p < slides.length; p++) {
			      slides[p].style.display = "none";  
			  }
			  for (i = 0; p < dots.length; p++) {
			      dots[p].className = dots[p].className.replace(" active", "");
			  }
			  slides[slideIndex2-1].style.display = "block";  
			  dots[slideIndex2-1].className += " active";
			} 
		// 두번째 이벤트 끝 

</script>

</body>
</html>	
<div style="margin-bottom: 100px;"></div>


<jsp:include page="footer.jsp" />