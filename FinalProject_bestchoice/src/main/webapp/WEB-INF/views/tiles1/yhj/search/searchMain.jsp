<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  

<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4a2dc2dd247eb470ae70b4db429fb7ee&libraries=services,clusterer,drawing"></script>
<style>
	
	
	@media ( max-width : 991px) {
	
		
		#div_searchWord {
			
			padding: 95px 0 30px 0;
	    	text-align: center;
		}
		
		#div_searchWord > div {
			border-bottom: solid 2px black;
			width: 400px;
			margin: 0 auto;
			padding-bottom: 1px;
		}
		
		#searchWord {
			width: 265px;
			border: none;
			text-align: center;
			font-family: 'Nanum Gothic', sans-serif;
			font-size: 20pt;
			font-weight: bold;
			padding: 5px 0;
		}
		
		#searchWord:focus {
			outline: none;
		}
		
		#yhj_autoSearchDiv {
			position: absolute;
		    border: solid 1px black;
		    width: 400px;
		    padding: 10px;
		    background-color: white;
		    z-index: 2;
		    text-align: left;
		    margin-top: 3px;
		}
		
		
		#div_searchLeft {
			float:right;
			width: 100%;
			/* overflow-y: scroll; */
			overflow-x: hidden;
			min-height: 1300px;
		}
		
		#search_map {
			display:none;
			float:left;
			width: 40%;
			height: 650px;
			z-index: 0;
		}
		
		#startday, #endday {
			border: none;
			width: 110px;
		}
		
		/* 체크 박스 구현 */
		.yhj_checkbox {
			display: none;
		}
		.yhj_label1 {
			display: inline-block;
			width: 20px;
			height: 20px;
			border: 2px solid #bcbcbc;
			cursor: pointer;
			margin: 0;
			position: relative;
	    	top: 4.5px;
		}
		.yhj_label2 {
			color: #999999;
			cursor: pointer;
			font-size: 9pt;
	    	font-weight: 500;
		}
		.yhj_checkbox:checked + .yhj_label1 {
			background: url('<%=request.getContextPath()%>/resources/images/yhj/ico_chk.png') no-repeat center/18px 18px ; 
		}
		
		/* 폼 안의 테이블 조건 */
		form[name=searchForm] table {
			width: 99%;
			font-family: 'Nanum Gothic', 'sans serif';
			border: solid 3px black;
		}
		
		form[name=searchForm] table td:nth-child(1){
			width: 20%;
			padding-left: 20px;
			font-weight:bold;
		} 
		
		#detailSearch {
			display:inline-block;
			/* margin-left: 50px; */
			border:solid 2px #ff0066;
			border-radius: 5px;
			background-color: #ff0066;
			color: white;
			font-weight: bold;
			padding: 3px 10px;
		}
		
		
		form[name=searchForm] table td {
			border-top: solid 1px #d9d9d9;
			border-bottom: solid 1px #d9d9d9;
			padding: 7px 0;
		}
		
		form[name=searchForm] table ul {
			list-style: none;
			padding: 0;
			margin:0;
		}
		
		form[name=searchForm] table ul li {
			display: inline-block;
			width: 23%;
		}
		
		#yhj_searchBar span button {
			background-color: white;
		    border: none;
		    height: 10px;
		    font-size: 12px;
		    color: #b3b3b3;
		}
		
		.yhj_searchActive {
			border: solid 1px black;
		    border-radius: 4px;
		    padding: 1px 4px;
		    margin: 3px;
		    display: inline-block;
		    font-family: 'Noto Sans KR', sans-serif;
		    font-size: 9pt;
		}
		
		/* 적용, 초기화 버튼 */
		#searchApply_btn , #searchReset_btn {
			padding: 3px 20px;
			
			font-family: 'Nanum Gothic', 'sans serif';
			font-weight: bold;
		}
		
		#searchApply_btn {
			background-color: #ff0066;
			color: white;
			border: solid 2px #ff0066;
		} 
		
		#searchReset_btn {
			background-color: white;
			color: #ff0066;
			border: solid 2px #ff0066;
		}
		
		#slide_body {
			z-index: 1;
		}
		
		#div_searchContent {
			padding: 25px 5px;
		}
		
		/* 인원 증감 버튼  */
		
		#people_minus , #people_plus {
			font-weight: bold;
		    border: none;
		    background-color: white;
		}
		
		input[name=room_Person]{
			color: #ff0066;
			width: 25px;
			border: none; 
			text-align: center;
			font-weight: bold;
			font-size: 14pt;
		}
		
		input[name=orderBy] {
			display:none;
		}
		
		.orderByClass {
			font-weight: 500;
	   	 	margin: 0 15px;
			cursor: pointer;
			font-family: 'Noto Sans KR', sans-serif;
		}
		
		.orderByClass_active {
			font-weight: bold;
		    background-color: #ff0066;
		    color: white;
		    border: solid 1px #ff0066;
		    border-radius: 5px;
		    padding: 2px 5px;
		}
		
		/* 호텔 리스트 css */
		
		.hotel_div {
			font-family: 'Nanum Gothic', sans-serif;
		}
		
		.hotel_div a {
			text-decoration: none;
			color : black;
		}
		
		.hotel_div a:hover {
			color: black;
		}
		
		.hotel_img {
			/* position: relative;
		    top: 0;
		    left: 0; */
		    width: 100%;
		    height: 400px;
		}
		
		.hotel_info {
			margin-bottom: 40px;
		    list-style: none;
		    padding: 0;
		}
		
		.hotel_info li {
			display: inline-block;
		}
		
		.hotel_info li:nth-child(1){
			width: 70%;
			padding-left: 15px;
		}
		
		.hotel_name {
			
		}
		
		.hotel_name span:nth-child(1) {
			
		}
		
		.hotel_name span:nth-child(2) {
			font-weight: bold;
			font-size: 25pt;
		}
		
		.hotel_name span:nth-child(4) {
			color: gray;
		}
		
		.hotel_price span:nth-child(1) {
			color: #ff0000;
			font-size: 9pt;
		}
		
		.hotel_price span:nth-child(3) {
			font-weight: bold;
			font-size: 16pt;
		}
		
		.hotel_price span:nth-child(4) {
		
		}
		
		.map_marker {
			padding-left: 35px;
			font-family: 'Noto Sans KR', sans-serif;
			font-weight: bold;
		}
	}
	
	@media ( min-width : 992px) {
		
		
		#div_searchWord {
			
			padding: 95px 0 30px 0;
	    	text-align: center;
		}
		
		#div_searchWord > div {
			border-bottom: solid 2px black;
			width: 400px;
			margin: 0 auto;
			padding-bottom: 1px;
		}
		
		#searchWord {
			width: 265px;
			border: none;
			text-align: center;
			font-family: 'Nanum Gothic', sans-serif;
			font-size: 20pt;
			font-weight: bold;
			padding: 5px 0;
		}
		
		#searchWord:focus {
			outline: none;
		}
		
		#yhj_autoSearchDiv {
			position: absolute;
		    border: solid 1px black;
		    width: 400px;
		    padding: 10px;
		    background-color: white;
		    z-index: 2;
		    text-align: left;
		    margin-top: 3px;
		}
		
		
		#div_searchLeft {
			float:right;
			width: 59%;
			/* overflow-y: scroll; */
			overflow-x: hidden;
			min-height: 1300px;
		}
		
		#search_map {
			float:left;
			width: 40%;
			height: 650px;
			z-index: 0;
		}
		
		#startday, #endday {
			border: none;
			width: 110px;
		}
		
		/* 체크 박스 구현 */
		.yhj_checkbox {
			display: none;
		}
		.yhj_label1 {
			display: inline-block;
			width: 20px;
			height: 20px;
			border: 2px solid #bcbcbc;
			cursor: pointer;
			margin: 0;
			position: relative;
	    	top: 4.5px;
		}
		.yhj_label2 {
			color: #999999;
			cursor: pointer;
			font-size: 9pt;
	    	font-weight: 500;
		}
		.yhj_checkbox:checked + .yhj_label1 {
			background: url('<%=request.getContextPath()%>/resources/images/yhj/ico_chk.png') no-repeat center/18px 18px ; 
		}
		
		/* 폼 안의 테이블 조건 */
		form[name=searchForm] table {
			width: 99%;
			font-family: 'Nanum Gothic', 'sans serif';
			border: solid 3px black;
		}
		
		form[name=searchForm] table td:nth-child(1){
			width: 20%;
			padding-left: 20px;
			font-weight:bold;
		} 
		
		#detailSearch {
			display:inline-block;
			margin-left: 50px;
			border:solid 2px #ff0066;
			border-radius: 5px;
			background-color: #ff0066;
			color: white;
			font-weight: bold;
			padding: 3px 10px;
		}
		
		
		form[name=searchForm] table td {
			border-top: solid 1px #d9d9d9;
			border-bottom: solid 1px #d9d9d9;
			padding: 7px 0;
		}
		
		form[name=searchForm] table ul {
			list-style: none;
			padding: 0;
			margin:0;
		}
		
		form[name=searchForm] table ul li {
			display: inline-block;
			width: 23%;
		}
		
		#yhj_searchBar span button {
			background-color: white;
		    border: none;
		    height: 10px;
		    font-size: 12px;
		    color: #b3b3b3;
		}
		
		.yhj_searchActive {
			border: solid 1px black;
		    border-radius: 4px;
		    padding: 1px 4px;
		    margin: 3px;
		    display: inline-block;
		    font-family: 'Noto Sans KR', sans-serif;
		    font-size: 9pt;
		}
		
		/* 적용, 초기화 버튼 */
		#searchApply_btn , #searchReset_btn {
			padding: 3px 20px;
			
			font-family: 'Nanum Gothic', 'sans serif';
			font-weight: bold;
		}
		
		#searchApply_btn {
			background-color: #ff0066;
			color: white;
			border: solid 2px #ff0066;
		} 
		
		#searchReset_btn {
			background-color: white;
			color: #ff0066;
			border: solid 2px #ff0066;
		}
		
		#slide_body {
			z-index: 1;
		}
		
		#div_searchContent {
			padding: 25px 5px;
		}
		
		/* 인원 증감 버튼  */
		
		#people_minus , #people_plus {
			font-weight: bold;
		    border: none;
		    background-color: white;
		}
		
		input[name=room_Person]{
			color: #ff0066;
			width: 25px;
			border: none; 
			text-align: center;
			font-weight: bold;
			font-size: 14pt;
		}
		
		input[name=orderBy] {
			display:none;
		}
		
		.orderByClass {
			font-weight: 500;
	   	 	margin: 0 15px;
			cursor: pointer;
			font-family: 'Noto Sans KR', sans-serif;
		}
		
		.orderByClass_active {
			font-weight: bold;
		    background-color: #ff0066;
		    color: white;
		    border: solid 1px #ff0066;
		    border-radius: 5px;
		    padding: 2px 5px;
		}
		
		/* 호텔 리스트 css */
		
		.hotel_div {
			font-family: 'Nanum Gothic', sans-serif;
		}
		
		.hotel_div a {
			text-decoration: none;
			color : black;
		}
		
		.hotel_div a:hover {
			color: black;
		}
		
		.hotel_img {
			/* position: relative;
		    top: 0;
		    left: 0; */
		    width: 100%;
		    height: 400px;
		}
		
		.hotel_info {
			margin-bottom: 40px;
		    list-style: none;
		    padding: 0;
		}
		
		.hotel_info li {
			display: inline-block;
		}
		
		.hotel_info li:nth-child(1){
			width: 70%;
			padding-left: 15px;
		}
		
		.hotel_name {
			
		}
		
		.hotel_name span:nth-child(1) {
			
		}
		
		.hotel_name span:nth-child(2) {
			font-weight: bold;
			font-size: 25pt;
		}
		
		.hotel_name span:nth-child(4) {
			color: gray;
		}
		
		.hotel_price span:nth-child(1) {
			color: #ff0000;
			font-size: 9pt;
		}
		
		.hotel_price span:nth-child(3) {
			font-weight: bold;
			font-size: 16pt;
		}
		
		.hotel_price span:nth-child(4) {
		
		}
		
		.map_marker {
			padding-left: 35px;
			font-family: 'Noto Sans KR', sans-serif;
			font-weight: bold;
		}
	
	}
	
	
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 시작시에 넘어온 값 입력하기
		var searchWord = "${searchVO.searchWord}";
		
		if( searchWord != null && searchWord !=""){
			$("#searchWord").val(searchWord);
		}
		
		var orderBy = "${searchVO.orderBy}"; 
		
		if(orderBy ==null || orderBy ==""){
			
			$('input:radio[name=orderBy][value=1]').prop("checked", true);
			$(".orderByClass").eq((0)).addClass("orderByClass_active");
		}
		else {

			$('input:radio[name=orderBy][value="${searchVO.orderBy}"]').prop("checked", true);
			$(".orderByClass").eq(("${searchVO.orderBy}"-1)).addClass("orderByClass_active");
		}
		
		
		// 배열로 받아와서 반복문 돌릴 것
		$(".yhj_searchActive").css("display","none");
		 
		
		if(${ searchVO.strList != null } ){

			var strList = "${searchVO.strList}"; 
			
			var strListArr = strList.split(",");
			
			for(var i=0; i<strListArr.length; i++){
				
				var valName = strListArr[i];
				console.log(valName);
				
				$("#"+valName).prop("checked", true);
				$(".yhj_searchActive_"+valName).css("display","");
			} 
		}
		
		
		// 검색하기
		$("#yhj_searchBtn").click(function(){
			
			getHotelList();
		});
		
		
		
		// 날짜 선택하기
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		$( "#startday" ).datepicker({ 
			minDate: 0, maxDate: "+2M"  ,
			showMonthAfterYear: true ,
			yearSuffix: "년",
			dayNames: ['일','월','화','수','목','금','토'],
			dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], // 요일의 한글 형식.
			monthNames: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] ,// 월의 한글 형식.
			dateFormat: "mm월 dd일 (DD)", 
			onClose: function(){
				
				changeBak();
			}
		});
		
		// 날짜 받아온 것 출력하기
		if(${searchVO.startday == null || searchVO.startday == ''}){
			$('#startday').datepicker('setDate', 'today');
		}
		else {
			
			var startday = "${searchVO.startday}";
			var startdayArr = startday.split("-");
			 
			var startdayDate = new Date();
			startdayDate.setFullYear(startdayArr[0] , startdayArr[1]-1 , startdayArr[2]);
			
			$('#startday').datepicker('setDate', startdayDate);
		}
		
		
		$( "#endday" ).datepicker({ 
			minDate: 1, maxDate: "+2M"  ,
			showMonthAfterYear: true ,
			yearSuffix: "년",
			dayNames: ['일','월','화','수','목','금','토'],
			dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], // 요일의 한글 형식.
			monthNames: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] ,// 월의 한글 형식.
			dateFormat: "mm월 dd일 (DD)", 
			onClose: function(){
				
				changeBak();
			}
		});
		
		// 날짜 받아온 것 출력하기
		if(${searchVO.endday == null || searchVO.endday == ''}){
			$('#endday').datepicker('setDate', 'today'+1);
		}
		else {
			
			var endday = "${searchVO.endday}";
			var enddayArr = endday.split("-");
			 
			var enddayDate = new Date();
			enddayDate.setFullYear(enddayArr[0] , enddayArr[1]-1 , enddayArr[2]);
			
			$('#endday').datepicker('setDate', enddayDate);
		}
		
		changeBak();
		
		
		// orderBy 바뀔때마다 active 바뀌게 하기
		$("label.orderByClass").bind("click",function(){
			
			$("label.orderByClass").removeClass("orderByClass_active");
			$(this).addClass("orderByClass_active");
			
			// getHotelList();
		});
		
		
		
		
		
		// 인원 추가, 감소하기
		var peopleNumber = 0;
		if( ${searchVO.room_Person == null || searchVO.room_Person ==''} ){
			peopleNumber = 2 ;
		}
		else {
			peopleNumber = "${searchVO.room_Person}";
		}
		
		$("input[name=room_Person]").val(peopleNumber);
		$("#people_minus").click(function(){
			
			if(peopleNumber >2){
				peopleNumber--;
				$("input[name=room_Person]").val(peopleNumber);
			}
		}); 
		
		$("#people_plus").click(function(){
			
			if(peopleNumber < 10){
				peopleNumber++;
				$("input[name=room_Person]").val(peopleNumber);
			}
		});
		
		
		// 맨 위로 오는 버튼 구현하기
		$("#fixed_up").click(function(){
			
        	// $("#div_searchLeft").animate({over : 0}, 400);
        	 $('#div_searchLeft').scrollTop(0, 400);
        	 $( 'html' ).animate( { scrollTop : 0 }, 400 );
		});
		
		
		
		// 폼에 체크할 때마다 yhj_searchBar 에 내용 보였다 빼기.
		$("form[name=searchForm] input[type=checkbox]").bind("click", function(){
			
			var checked = $(this).is(":checked");
			
			if(checked == true){
				
				var text = $(this).next().next().text();
				$("#yhj_searchBar").find( "span:contains("+text+")" ).css("display","");
			}
			else {
				
				var text = $(this).next().next().text();
				$("#yhj_searchBar").find( "span:contains("+text+")" ).css("display","none");
			}
			
		}); // end of 체크시 내용 추가 빼기
		
		
		// 상세조건 검색 내리고 열기
		$("#slide_body").css("display","none");
		
		$("#detailSearch").click(function(){
			
			var sld = $("#slide_body").css("display");
		  	
		    if(sld == "none") {
		    	$("#detailSearch").text("");
		    	$("#detailSearch").text("상세조건 접기");
		    	$("#slide_body").css("display","");
		    }
		    else {
		    	$("#slide_body").css("display","none");
		    	$("#detailSearch").text("");
		    	$("#detailSearch").text("상세조건 보기");
		    }
			
		});
		
		
		// 폼 초기화
		$("#searchReset_btn").click(function(){
			
			location.href = "javascript:history.go()";
		});
		
		// 검색 폼 적용
		$("#searchApply_btn").click(function(){

			getHotelList();
		});
		
		
		// 자동검색어 구현하기
		$("#yhj_autoSearchDiv").css('display','none');
		
		$("#searchWord").keyup(function(){
			
			var searchWord = $("#searchWord").val().trim();
			
			if( searchWord =="" ){
				
				$("#yhj_autoSearchDiv").css('display','none');
			}
			else {
				
				$("#yhj_autoSearchList").html("");
				
				
				$.ajax({
					
					url: "<%= request.getContextPath()%>/search/autoComplete.bc",
					type: "GET",
					data: { 'searchWord': $("#searchWord").val()   } ,
					dataType: "json",
					success: function(json){
						
						if(json.length > 0){
							
							$("#yhj_autoSearchDiv").css('display','');
							
							var html = "";
							
							$.each(json, function(index, item){
								
								html+= "<div onclick='changeSearchWord(event)'>"
								html+= item.string ;
								html+= "</div>"
								
							});
							
							$("#yhj_autoSearchList").html(html);
							
						}
						else{
	
							$("#yhj_autoSearchDiv").css('display','none');
							
						}
						
					}, 
					error: function(request, status, error){
						
						alert("code: "+request.status+"\n"+"message: "+request.responseTest+"\n"+"error: "+error);
					}
					
				}); 
				
			}
			
		});
		
		
		// 지금 현재 위치 위,경도 알아오기
		
		var request_latitude = "${searchVO.latitude}";
		var request_longitude = "${searchVO.longitude}";
		
		if (navigator.geolocation) {
            //위치 정보를 얻기
            navigator.geolocation.getCurrentPosition (function(pos) {
               //  console.log("위도는 "+pos.coords.latitude  ) ;   
                var latitude = pos.coords.latitude ;		// 위도
                // console.log("경도는 "+pos.coords.longitude  ) ;  
                var longitude = pos.coords.longitude ;		// 경도
                
                if(request_latitude == null || request_latitude ==""){
                	$("input[name=latitude]").val(latitude);
                    $("input[name=longitude]").val(longitude);
                }
                else{
                	$("input[name=latitude]").val(request_latitude);
                    $("input[name=longitude]").val(request_longitude);
                    latitude = request_latitude;
                    longitude = request_longitude;
                }
                
             	// 지도 탭 구현하기
        		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
        		
        		var container = document.getElementById('search_map');
        		var options = {
        			// center 에는 시작 위경도 입력하면 됨.
        			center: new kakao.maps.LatLng(latitude, longitude),
        			level: 7
        		};
        		
        		var map = new kakao.maps.Map(container, options);	
        		
        		var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
				var imageSize = new kakao.maps.Size(24, 35); 
				 var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
				
        	    // 마커를 생성합니다
        	    var marker = new kakao.maps.Marker({
        	        map: map, 		// 마커를 표시할 지도
        	        position: new kakao.maps.LatLng(latitude, longitude), 	// 마커를 표시할 위치
        	        title : "현재 위치" , 		// 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        	        image : markerImage // 마커 이미지 
        	    });
        		
        		
        	    
        	    $("form[name=searchForm] input[name=searchWord]").val($("#searchWord").val());
        	    var date1 = new Date($("#startday").datepicker("getDate"));
        	    var date2 = new Date($("#endday").datepicker("getDate"));
        	    
        	   	var startday = date1.getFullYear()+"-"+(date1.getMonth()+1)+"-"+date1.getDate();
        	    var endday = date2.getFullYear()+"-"+(date2.getMonth()+1)+"-"+date2.getDate();
        		
        	    $("input[name=startday]").val(startday);
        	    $("input[name=endday]").val(endday);
        	    
        	    
        		var searchForm = $("form[name=searchForm]").serialize();
        		
        		// alert(searchForm);
        		
        		$.ajax({
        			
        			url: "<%= request.getContextPath()%>/search/mainJson.bc",
        			type: "GET",
        			data: searchForm  ,
        			dataType: "json",
        			success: function(json){
        				
        				// var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
        				// var imageSize = new kakao.maps.Size(24, 35); 
        				
        				// alert('성공');
        				$.each(json, function(index, item){
        					
        	        	    
        	        	    // 마커를 생성합니다
        	        	    var marker = new kakao.maps.Marker({
        	        	        map: map, 		// 마커를 표시할 지도
        	        	        position: new kakao.maps.LatLng(item.hotel_geo_x, item.hotel_geo_y), 	// 마커를 표시할 위치
        	        	       //  title : item.hotel_name , 		// 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        	        	       // image : markerImage // 마커 이미지 
        	        	    });
        	        		
        	        	 	// 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
        	        	     var iwContent= "<div class='map_marker'> ";
        	        	     iwContent += item.hotel_name+"</div>"; 
        	        	    
        	        	   //  var iwContent =  '<div class ="label"><span class="left"></span><span class="center">카카오!</span><span class="right"></span></div>';

        	        	    console.log(iwContent);
        	        	    
        	        	    // 인포윈도우를 생성합니다
        	        	    var infowindow = new kakao.maps.InfoWindow({
        	        	        content : iwContent ,
        	        	        position : new kakao.maps.LatLng(item.hotel_geo_x, item.hotel_geo_y)
        	        	    });

        	        	    // 마커에 마우스오버 이벤트를 등록합니다
        	        	    kakao.maps.event.addListener(marker, 'mouseover', function() {
        	        	      // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
        	        	        infowindow.open(map, marker);
        	        	    });

        	        	    // 마커에 마우스아웃 이벤트를 등록합니다
        	        	    kakao.maps.event.addListener(marker, 'mouseout', function() {
        	        	        // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
        	        	        infowindow.close();
        	        	    });
        	        		
        	        		
        	        		
        				});
        				
        			}, 
        			error: function(request, status, error){
        				
        				alert("code: "+request.status+"\n"+"message: "+request.responseTest+"\n"+"error: "+error);
        			}
        			
        		}); 
        		
        		
        		
        		
        		
        		
        		
        		
        		
        		
        		
                
                
            });
        } else {
            alert("이 브라우저에서는 Geolocation이 지원되지 않습니다.");
        }
			
		
		
		
		
		
		
		
		
		
		
	}); // end of document ready --------------------

	
	
	
	
	
	
	
	
	
	
	// 자동 완성 검색어 클릭하면 검색어 바뀌기
	function changeSearchWord(event){
		
		var searchWord = $(event.target).text();
		$("#searchWord").val("");
		$("#searchWord").val(searchWord);
		
		$("#yhj_autoSearchDiv").hide();
	}
	
	
	
	
	
	
	// 몇박인지 계산하기
	function changeBak(){
		
		var date1 = new Date($("#startday").datepicker("getDate"));
	    var date2 = new Date($("#endday").datepicker("getDate"));
		
	    var dayNum = date2-date1;
	    var currDay = 24 * 60 * 60 * 1000;// 시 * 분 * 초 * 밀리세컨
	    var result = parseInt(dayNum/currDay) ;
		
		$("#yhj_dateNum").text("총 "+result+"박");
	}
	
	
	// 검색어 옆에 x 누르면 checkbox 체크 해제하기
	function deleteSpan(event){
		
		var text = $(event.target).parent().text();
		
		var index = text.indexOf("X");
		text = text.substr(0, index);
		
		// alert(text);
		
		$("#yhj_searchBar").find( "span:contains("+text+")" ).css("display","none");
		
		$("form[name=searchForm]").find("label:contains("+text+")").prev().prev().attr("checked",false);
		
		
	} // end of deleteSpan ---------------------------------------
	
	
	
	// form 정보 넘기면서 hotelList 받아오기
	function getHotelList(){
		
		// 검색어 입력하기
		$("form[name=searchForm] input[name=searchWord]").val($("#searchWord").val());
		
		// 추천순, 거리순, 낮은가격순, 높은가격순
		var orderBy = $(".orderByClass_active").text();
		if(orderBy == "높은가격순"){
			$("input[name=orderBy]").val("4");
		}
		else if(orderBy == "낮은가격순"){
			$("input[name=orderBy]").val("3");
		}
		else if(orderBy == "거리순"){
			$("input[name=orderBy]").val("2");		
		}
		else {
			$("input[name=orderBy]").val("1");
		}
		
		
		// 입실일, 퇴실일 날짜 받기
		var date1 = new Date($("#startday").datepicker("getDate"));
	    var date2 = new Date($("#endday").datepicker("getDate"));
	    
	    if( (date2 - date1) <= 0){
	    	alert("날짜를 다시 선택해주세요.");
	    	return false;
	    }
	    
	    // var count = ((date2-date1)/ 1000 / 60 / 60 / 24 );
	    
	   //  $("input[name=searchdate]").val(count);
	    
	   	var startday = date1.getFullYear()+"-"+(date1.getMonth()+1)+"-"+date1.getDate();
	    var endday = date2.getFullYear()+"-"+(date2.getMonth()+1)+"-"+date2.getDate();
		
	    // console.log(startday);
	    
	    $("input[name=startday]").val(startday);
	    $("input[name=endday]").val(endday);
		
	    // 
	    
	    var frm = document.searchForm;
	    
	    frm.action="<%= request.getContextPath()%>/search/main.bc";
	    frm.method="GET";
	    frm.submit();
		
	}
	
	
	// 선택된옵션에 띄우기
	function showCheckedOption(){
		
		var checked = $(this).is(":checked");
		
		if(checked == true){
			
			var text = $(this).next().next().text();
			$("#yhj_searchBar").find( "span:contains("+text+")" ).css("display","");
		}
		else {
			
			var text = $(this).next().next().text();
			$("#yhj_searchBar").find( "span:contains("+text+")" ).css("display","none");
		}
		
	}
	
	
	// 자동완성창 숨기기
	function hideAutoSearch(){
		
		$("#yhj_autoSearchDiv").css("display","none");
	}
	
</script>




<title>${ searchVO.searchWord } | 여기는어때</title>

	<%-- 화면 상단 검색창 --%>
	<div id="div_searchWord">
		
		<div>
			<input id="searchWord" type="text" />
			<span id="yhj_searchBtn" class="glyphicon glyphicon-search" style="font-size:14pt;cursor:pointer;"></span>
			<div id="yhj_autoSearchDiv">
				<div id="yhj_autoSearchList">
				</div>
				<div style="text-align: right;">
					<button type="button" onclick="hideAutoSearch();">
						<span class="glyphicon glyphicon-chevron-up"></span>
					</button>
				</div>
			</div>
		</div>
	</div>
	
	
	<%-- 지도 나오는 구역 --%>
	<div id="search_map"></div>
	
	
	<%-- 검색결과 구역 --%>
	<div id="div_searchLeft">
		<div id="div_searchOption">
			<form name="searchForm">
				
				<%-- 상세검색이라는 인풋값 하나 넘길까 --%>
				<input type="hidden" name="searchWord"> 
				<input type="hidden" name="startday" > 
				<input type="hidden" name="endday" >
				<input type="hidden" name="latitude">
				<input type="hidden" name="longitude">
				
				<table>
					<thead>
						<tr>
							<td>날짜선택</td> 
							<td>
								<div style="width: 370px; border: solid 1px #999999; padding:5px 15px; display: inline-block;font-weight: bold;">
									<label for="startday">
										<span class="glyphicon glyphicon-calendar" ></span>
									</label>
									<input type="text" id="startday" readonly="readonly">
									&nbsp;~&nbsp;
									<label for="endday">
										<span class="glyphicon glyphicon-calendar" ></span>
									</label>
									<input type="text" id="endday" readonly="readonly">
									<span id="yhj_dateNum" style="font-weight:bold;"></span>
								</div>
								
								<button type="button" id="detailSearch">상세조건 보기</button>
							</td>
						</tr>
						
						<tr>
							<td></td>
							<td>
								
								<input type="radio" name="orderBy" id="orderByRecommendation" value="1"><label class="orderByClass" for="orderByRecommendation">평점순</label>
								<input type="radio" name="orderBy" id="orderByDistance" value="2"><label class="orderByClass"  for="orderByDistance">거리순</label>
								<input type="radio" name="orderBy" id="orderByLowPrice" value="3"><label class="orderByClass"  for="orderByLowPrice">낮은가격순</label>
								<input type="radio" name="orderBy" id="orderByHighPrice" value="4"><label class="orderByClass"  for="orderByHighPrice">높은가격순</label>
								
							</td>
						</tr>
						
						<tr>
							<td>인원</td>
							<td>
								<button type="button" id="people_minus">-</button>
								<input name="room_Person" type="text" readonly="readonly">
								<button type="button" id="people_plus">+</button>
							</td>
						</tr>
						
						<tr>
							<td>
								선택된 옵션
							</td> 
							<td>
								<div id="yhj_searchBar" style="line-height: 2;">
									<span style="border: solid 1px black; border-radius: 4px; padding: 1px 4px; margin: 3px; display: inline-block; font-size:9pt; font-family: 'Noto Sans KR', sans-serif;">호텔</span>
									<span class='yhj_searchActive yhj_searchActive_hotel_Category0'>일반<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_hotel_Category1'>특1급<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_hotel_Category2'>특급<button type='button' onclick='deleteSpan(event)'>X</button></span>
									
									<span class='yhj_searchActive yhj_searchActive_bed_single'>싱글<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_bed_double'>더블<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_bed_twin'>트윈<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_bed_ondol'>온돌<button type='button' onclick='deleteSpan(event)'>X</button></span>
									
									<span class='yhj_searchActive yhj_searchActive_service_spa'>스파<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_service_minibar'>미니바<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_service_wifi'>와이파이<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_service_towel'>욕실용품<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_service_tv'>TV<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_service_airconditioner'>에어컨<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_service_fridge'>냉장고<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_service_showerroom'>객실사워실<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_service_bathtub'>욕조<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_service_hairdryer'>드라이기<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_service_iron'>다리미<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_service_kitchen'>전기밥솥<button type='button' onclick='deleteSpan(event)'>X</button></span>
					
									<span class='yhj_searchActive yhj_searchActive_theme_mooin'>무인텔<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_theme_party'>파티룸<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_theme_mirror'>미러룸<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_theme_doubleFloor'>복층룸<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_theme_princess'>공주룸<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_theme_terras'>야외 테라스<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_theme_ocean'>오션뷰<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_theme_lake'>호수뷰<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_theme_sky'>스카이뷰<button type='button' onclick='deleteSpan(event)'>X</button></span>
									
									<span class='yhj_searchActive yhj_searchActive_spa_wpool'>월풀<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_spa_sauna'>사우나<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_spa_massage'>마사지베드<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_spa_hinokki'>히노끼탕<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_spa_openbath'>노천탕<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_spa_halfpool'>반신욕<button type='button' onclick='deleteSpan(event)'>X</button></span>
									<span class='yhj_searchActive yhj_searchActive_spa_tv'>욕실내 TV<button type='button' onclick='deleteSpan(event)'>X</button></span>
									
								</div>
							</td>
						</tr>
					</thead>	
						
					<tbody id="slide_body">	
						<tr>
							<td>호텔유형</td>
							<td>
								<ul>
								<li>
									<input type="checkbox" name="hotel_Category0" id="hotel_Category0" class="yhj_checkbox hotel_category" value="hotel_Category0">
									<label for="hotel_Category0" class="yhj_label1"></label> <label for="hotel_Category0" class="yhj_label2">일반</label>
								</li>
								<li>
									<input type="checkbox" name="hotel_Category1" id="hotel_Category1" class="yhj_checkbox hotel_category" value="hotel_Category1">
									<label for="hotel_Category1" class="yhj_label1"></label> <label for="hotel_Category1" class="yhj_label2">특1급</label>
								</li>
								<li>
									<input type="checkbox" name="hotel_Category2" id="hotel_Category2" class="yhj_checkbox hotel_category" value="hotel_Category2">
									<label for="hotel_Category2" class="yhj_label1"></label> <label for="hotel_Category2" class="yhj_label2">특급</label>
								</li>
								</ul>
							</td>
						</tr>
						
																	
						<tr>
							<td>베드타입</td>
							<td>
								<ul>
									<li>
										<input type="checkbox" name="bed_single" id="bed_single" class="yhj_checkbox" value="bed_single">
										<label for="bed_single" class="yhj_label1"></label> <label for="bed_single" class="yhj_label2">싱글</label>
									</li>
									<li>
										<input type="checkbox" name="bed_double" id="bed_double" class="yhj_checkbox" value="bed_double">
										<label for="bed_double" class="yhj_label1"></label> <label for="bed_double" class="yhj_label2">더블</label>
									</li>
									<li>
										<input type="checkbox" name="bed_twin" id="bed_twin" class="yhj_checkbox" value="bed_twin">
										<label for="bed_twin" class="yhj_label1"></label> <label for="bed_twin" class="yhj_label2">트윈</label>
									</li>
									<li>
										<input type="checkbox" name="bed_ondol" id="bed_ondol" class="yhj_checkbox" value="bed_ondol">
										<label for="bed_ondol" class="yhj_label1"></label> <label for="bed_ondol" class="yhj_label2">온돌</label>
									</li>
								</ul>
							</td>
						</tr>
						
						<tr>
							<td>내부객시설</td>
							<td>
								<ul>
									<li>
										<input type="checkbox" name="service_spa" id="service_spa" class="yhj_checkbox" value="service_spa">
										<label for="service_spa" class="yhj_label1"></label> <label for="service_spa" class="yhj_label2">스파</label>
									</li>
									<li>
										<input type="checkbox" name="service_minibar" id="service_minibar" class="yhj_checkbox" value="service_minibar">
										<label for="service_minibar" class="yhj_label1"></label> <label for="service_minibar" class="yhj_label2">미니바</label>
									</li>
									<li>
										<input type="checkbox" name="service_wifi" id="service_wifi" class="yhj_checkbox" value="service_wifi">
										<label for="service_wifi" class="yhj_label1"></label> <label for="service_wifi" class="yhj_label2">와이파이</label>
									</li>
									<li>
										<input type="checkbox" name="service_towel" id="service_towel" class="yhj_checkbox" value="service_towel">
										<label for="service_towel" class="yhj_label1"></label> <label for="service_towel" class="yhj_label2">욕실용품</label>
									</li>
									<li>
										<input type="checkbox" name="service_tv" id="service_tv" class="yhj_checkbox" value="service_tv">
										<label for="service_tv" class="yhj_label1"></label> <label for="service_tv" class="yhj_label2">TV</label>
									</li>
									<li>
										<input type="checkbox" name="service_airconditioner" id="service_airconditioner" class="yhj_checkbox" value="service_airconditioner">
										<label for="service_airconditioner" class="yhj_label1"></label> <label for="service_airconditioner" class="yhj_label2">에어컨</label>
									</li>
									<li>
										<input type="checkbox" name="service_fridge" id="service_fridge" class="yhj_checkbox" value="service_fridge">
										<label for="service_fridge" class="yhj_label1"></label> <label for="service_fridge" class="yhj_label2">냉장고</label>
									</li>
									<li>
										<input type="checkbox" name="service_showerroom" id="service_showerroom" class="yhj_checkbox" value="service_showerroom">
										<label for="service_showerroom" class="yhj_label1"></label> <label for="service_showerroom" class="yhj_label2">객실사워실</label>
									</li>
									<li>
										<input type="checkbox" name="service_bathtub" id="service_bathtub" class="yhj_checkbox" value="service_bathtub">
										<label for="service_bathtub" class="yhj_label1"></label> <label for="service_bathtub" class="yhj_label2">욕조</label>
									</li>
									<li>
										<input type="checkbox" name="service_hairdryer" id="service_hairdryer" class="yhj_checkbox" value="service_hairdryer">
										<label for="service_hairdryer" class="yhj_label1"></label> <label for="service_hairdryer" class="yhj_label2">드라이기</label>
									</li>
									<li>
										<input type="checkbox" name="service_iron" id="service_iron" class="yhj_checkbox" value="service_iron">
										<label for="service_iron" class="yhj_label1"></label> <label for="service_iron" class="yhj_label2">다리미</label>
									</li>
									<li>
										<input type="checkbox" name="service_kitchen" id="service_kitchen" class="yhj_checkbox" value="service_kitchen">
										<label for="service_kitchen" class="yhj_label1"></label> <label for="service_kitchen" class="yhj_label2">전기밥솥</label>
									</li>
									
								</ul>
							</td>
						</tr>
	
						<tr>
							<td>이색테마유형</td>
							<td>
								<ul>
									<li>
										<input type="checkbox" name="theme_mooin" id="theme_mooin" class="yhj_checkbox" value="theme_mooin">
										<label for="theme_mooin" class="yhj_label1"></label> <label for="theme_mooin" class="yhj_label2">무인텔</label>
									</li>
									<li>
										<input type="checkbox" name="theme_party" id="theme_party" class="yhj_checkbox" value="theme_party">
										<label for="theme_party" class="yhj_label1"></label> <label for="theme_party" class="yhj_label2">파티룸</label>
									</li>
									<li>
										<input type="checkbox" name="theme_mirror" id="theme_mirror" class="yhj_checkbox" value="theme_mirror">
										<label for="theme_mirror" class="yhj_label1"></label> <label for="theme_mirror" class="yhj_label2">미러룸</label>
									</li>
									<li>
										<input type="checkbox" name="theme_doubleFloor" id="theme_doubleFloor" class="yhj_checkbox" value="theme_doubleFloor">
										<label for="theme_doubleFloor" class="yhj_label1"></label> <label for="theme_doubleFloor" class="yhj_label2">복층룸</label>
									</li>
									<li>
										<input type="checkbox" name="theme_princess" id="theme_princess" class="yhj_checkbox" value="theme_princess">
										<label for="theme_princess" class="yhj_label1"></label> <label for="theme_princess" class="yhj_label2">공주룸</label>
									</li>
									<li>
										<input type="checkbox" name="theme_terras" id="theme_terras" class="yhj_checkbox" value="theme_terras">
										<label for="theme_terras" class="yhj_label1"></label> <label for="theme_terras" class="yhj_label2">야외 테라스</label>
									</li>
									<li>
										<input type="checkbox" name="theme_ocean" id="theme_ocean" class="yhj_checkbox" value="theme_ocean">
										<label for="theme_ocean" class="yhj_label1"></label> <label for="theme_ocean" class="yhj_label2">오션뷰</label>
									</li>
									<li>
										<input type="checkbox" name="theme_lake" id="theme_lake" class="yhj_checkbox" value="theme_lake">
										<label for="theme_lake" class="yhj_label1"></label> <label for="theme_lake" class="yhj_label2">호수뷰</label>
									</li>
									<li>
										<input type="checkbox" name="theme_sky" id="theme_sky" class="yhj_checkbox" value="theme_sky">
										<label for="theme_sky" class="yhj_label1"></label> <label for="theme_sky" class="yhj_label2">스카이뷰</label>
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<td>스파유형</td>
							<td>
								<ul>
									<li>
										<input type="checkbox" name="spa_wpool" id="spa_wpool" class="yhj_checkbox" value="spa_wpool">
										<label for="spa_wpool" class="yhj_label1"></label> <label for="spa_wpool" class="yhj_label2">월풀</label>
									</li>
									<li>
										<input type="checkbox" name="spa_sauna" id="spa_sauna" class="yhj_checkbox" value="spa_sauna">
										<label for="spa_sauna" class="yhj_label1"></label> <label for="spa_sauna" class="yhj_label2">사우나</label>
									</li>
									<li>
										<input type="checkbox" name="spa_massage" id="spa_massage" class="yhj_checkbox" value="spa_massage">
										<label for="spa_massage" class="yhj_label1"></label> <label for="spa_massage" class="yhj_label2">마사지베드</label>
									</li>
									<li>
										<input type="checkbox" name="spa_hinokki" id="spa_hinokki" class="yhj_checkbox" value="spa_hinokki">
										<label for="spa_hinokki" class="yhj_label1"></label> <label for="spa_hinokki" class="yhj_label2">히노끼탕</label>
									</li>
									<li>
										<input type="checkbox" name="spa_openbath" id="spa_openbath" class="yhj_checkbox" value="spa_openbath">
										<label for="spa_openbath" class="yhj_label1"></label> <label for="spa_openbath" class="yhj_label2">노천탕</label>
									</li>
									<li>
										<input type="checkbox" name="spa_halfpool" id="spa_halfpool" class="yhj_checkbox" value="spa_halfpool">
										<label for="spa_halfpool" class="yhj_label1"></label> <label for="spa_halfpool" class="yhj_label2">반신욕</label>
									</li>
									<li>
										<input type="checkbox" name="spa_tv" id="spa_tv" class="yhj_checkbox" value="spa_tv">
										<label for="spa_tv" class="yhj_label1"></label> <label for="spa_tv" class="yhj_label2">욕실내 TV</label>
									</li>
								</ul>
							</td>
						</tr>
						
						<tr>
							<td colspan="2" style="text-align: center;">
								<button type="button" id="searchReset_btn">초기화</button>
								<button type="button" id="searchApply_btn">적용</button>
							</td>
						</tr>
						
					</tbody>
				</table>
				
			</form>
			
			
		</div>
		
		<%-- ajax 로 검색해온 리스트 뿌려주는 곳 --%>
		<div id="div_searchContent">
		
			
			<c:if test="${not empty hotelList}">
				
				<c:forEach items="${hotelList }" var="hotelvo">
					<div class="hotel_div">
						<a href="<%= request.getContextPath() %>/roomDetail.bc?startday=${searchVO.startday}&endday=${searchVO.endday}&hotel_idx=${hotelvo.hotel_idx}">
							<img class="hotel_img" src="<%= request.getContextPath()%>/resources/images/kmt/hotelImage/${hotelvo.hotelImage_wasFileName}">
							<ul class="hotel_info">
								<li class="hotel_name">
									<span>${ hotelvo.hotel_Grade }</span>
									<span>${ hotelvo.hotel_name }</span><br>
									<span>${ hotelvo.hotel_addr1 }</span>
								</li>
								
								<li class="hotel_price">
									<span>${ hotelvo.gradePerHotel }</span><br>
									<span><fmt:formatNumber value="${ hotelvo.roomprice }" pattern="#,###.##"/></span>
									<span>원</span>
								</li>
							</ul>
						</a>
					</div>
				</c:forEach>
			
			</c:if>
			<c:if test="${ empty hotelList }">
				<div style="text-align: center; font-size: 16pt; font-weight: bold; font-family: 'Noto Sans KR', sans-serif;">조건에 맞는 호텔이 없습니다.</div>
			
			</c:if>
		
		</div>
		
	</div>
	
	

	<div id="fixed_up" style="position: fixed;bottom: 20px;right:20px;">
		<button type="button" class="glyphicon glyphicon-arrow-up" style="padding: 8px; background-color: white; border: solid 2px black;"></button>
	</div>
