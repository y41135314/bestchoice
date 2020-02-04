<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 관리 페이지</title>
<script type="text/javascript">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	$('#inputStartDate').change(function (){
		var startDate = $("#startDate").val();
		$("#inputStartDate").val()=startDate;
	});
	
	
	
	
	// page4 날짜 설정하기
	var today = new Date();
	$("#page4_date_span").text( today.getFullYear() +" 년 "+(today.getMonth()+1)+" 월 "+today.getDate()+" 일 ");
	
	// page4 요금 조정의 날짜 변환하기
	$("#page4_date_prev").click(function(){
		
		var date_text = $("#page4_date_span").text().replace( /(\s*)/g, "");
		
		var year_index = date_text.indexOf("년");
		var month_index = date_text.indexOf("월");
		var day_index = date_text.indexOf("일");
			
		var now_year = date_text.substring(0,year_index);
		var now_month = date_text.substring(year_index+1,month_index);
		var now_day = date_text.substring(month_index+1,day_index);
		
		var prev_date = new Date(now_year,now_month-1,now_day);
		prev_date.setDate(prev_date.getDate()-1);
		
		$("#page4_date_span").text( prev_date.getFullYear() +" 년 "+(prev_date.getMonth()+1)+" 월 "+prev_date.getDate()+" 일 ");
		
		getRoomPriceQuant();
		
	});
	
	$("#page4_date_next").click(function(){
		
		var date_text = $("#page4_date_span").text().replace( /(\s*)/g, "");
		
		var year_index = date_text.indexOf("년");
		var month_index = date_text.indexOf("월");
		var day_index = date_text.indexOf("일");
			
		var now_year = date_text.substring(0,year_index);
		var now_month = date_text.substring(year_index+1,month_index);
		var now_day = date_text.substring(month_index+1,day_index);
		
		var next_date = new Date(now_year,now_month-1,now_day);
		next_date.setDate(next_date.getDate()+1);
		
		$("#page4_date_span").text( next_date.getFullYear() +" 년 "+(next_date.getMonth()+1)+" 월 "+next_date.getDate()+" 일 ");
		
		getRoomPriceQuant();
		
	});
	
	
	var count = 1;
	$(".insertRoom2").hide();
	$(".insertRoom3").hide();
	$(".insertRoom4").hide();
	$(".insertRoom5").hide();
	$(".insertRoom6").hide();
	$(".insertRoom7").hide();

	// page6 의 추가하기 버튼
	$("#roomInsertBtn").click(function(){
		
		count++;
		if(count == 8){
			alert("더이상 추가할 수 없습니다.	");
			return;
		}
		$(".insertRoom"+count).show();
		
	});
	
	
});	// end of document ready 
////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////
function openPage(pageName,elmnt,color) {
	  var i, tabcontent, tablinks;
	  tabcontent = document.getElementsByClassName("tabcontent");
	  for (i = 0; i < tabcontent.length; i++) {
	    tabcontent[i].style.display = "none";
	  }
	  tablinks = document.getElementsByClassName("tablink");
	  for (i = 0; i < tablinks.length; i++) {
	    tablinks[i].style.backgroundColor = "";
	  }
	  document.getElementById(pageName).style.display = "block";
	  elmnt.style.backgroundColor = color;
	}

	// Get the element with id="defaultOpen" and click on it
	// document.getElementById("defaultOpen").click();
	
function goRoomModify(){
	var frm = document.roomPriceEditForm;
	
	frm.action
}		



//특정날짜 방가격 가져오기	
function getRoomPriceQuant(){
	
	
	var date_text = $("#page4_date_span").text().replace( /(\s*)/g, "");
	
	var year_index = date_text.indexOf("년");
	var month_index = date_text.indexOf("월");
	var day_index = date_text.indexOf("일");
		
	var now_year = date_text.substring(0,year_index);
	var now_month = date_text.substring(year_index+1,month_index);
	var now_day = date_text.substring(month_index+1,day_index);
	
	var str_date = now_year +"-"+now_month+"-"+now_day;
	
	$.ajax({
		
		url: "<%= request.getContextPath()%>/seller/getPriceQuant.bc",
		type: "GET",
		data: { 'logdate': str_date, 'fk_hotel_idx': $("form[name=roomPriceEditForm] select[name=fk_hotel_idx]").val()   } ,
		dataType: "json",
		success: function(json){
			
			// alert('성공');
			 $.each(json, function(index, item){
				
				 $("form[name=roomPriceEditForm] input[name=roomprice_seqno"+index+"]").val(item.roomprice_seqno);
				 $("form[name=roomPriceEditForm] input[name=roomprice"+index+"]").val(item.roomprice);
				 $("form[name=roomPriceEditForm] input[name=roomprice_quantity"+index+"]").val(item.roomprice_quantity);
				 
				 
			});
			
		}, 
		error: function(request, status, error){
			
			alert("code: "+request.status+"\n"+"message: "+request.responseTest+"\n"+"error: "+error);
		}
		
	}); 
	
	
	
	
	
	
}	
	
// ajax 로 객실요금조정정하기	
function reviseRoomPriceQuant(){
	
	var date_text = $("#page4_date_span").text().replace( /(\s*)/g, "");
	
	var year_index = date_text.indexOf("년");
	var month_index = date_text.indexOf("월");
	var day_index = date_text.indexOf("일");
		
	var now_year = date_text.substring(0,year_index);
	var now_month = date_text.substring(year_index+1,month_index);
	var now_day = date_text.substring(month_index+1,day_index);
	
	var str_date = now_year +"-"+now_month+"-"+now_day;
	// alert(str_date);
	$("form[name=roomPriceEditForm] input[name=logdate]").val(str_date);
	
	var frmData = $("form[name=roomPriceEditForm]").serialize();
	
	$.ajax({
		
		url: "<%= request.getContextPath()%>/seller/adjustPrice.bc",
		type: "POST",
		data: frmData ,
		dataType: "json",
		success: function(json){
			
			var msg = json.msg ;
			
			if(msg == "success"){
				
				alert("가격 변경에 성공했습니다.");
			}
			else {
				alert("가격 수정에 실패했습니다.");
			}
			
		}, 
		error: function(request, status, error){
			
			alert("code: "+request.status+"\n"+"message: "+request.responseTest+"\n"+"error: "+error);
		}
		
	}); 
	
}



// 객실 등록하기
function goSubmitRoom(){
	
	var frm = document.roomInsertForm;
	frm.action = "<%= request.getContextPath()%>/seller/roomRegister.bc";
	frm.method = "POST";
	frm.submit();
	
}
	

</script>
<%-- ------------------------------------------------------------------------------------- --%>	
<%-- ------------------------------------------------------------------------------------- --%>	
<style type="text/css">
	.header{
		width: 100%;
		height: 190px;
		background-color: red;
		padding-left: 10px;
	}
	
	.head_1{
		width: 15%;
		display: inline-block;
	}
	.head_2{
		width: 33%;
		display: inline-block;
		font-weight: bold;
		color: white;
		font-size: 24pt;
		text-align: left;
	}
	.head_3{
		width: 50%;
		display: inline-block;
	}
<%-- ------------------------------------------------------------------------------------- --%>	
body, html {
  height: 100%;
  margin: 0;
  font-family: Arial;
}

/* Style tab links */
.tablink {
  background-color: #3333ff;
  color: white;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  font-size: 14px;
  width: 100%;
}

.tablink:hover {
  background-color: #d9b3ff;
}

/* Style the tab content (and add height:100% for full page content) */
.tabcontent {
  color: black;
  display: none;
  padding: 20px 20px;
  min-height: 300px;
}

.main{
	display: block;
	width: 100%;
}

#page1 {background-color: white;}
#page2 {background-color: white;}
#page3 {background-color: white;}
#page4 {background-color: white;}
#page5 {background-color: white;}
#page6 {background-color: white;}
#page7 {background-color: white;}

.tab {
  float: left;
  border: 1px solid #ccc;
  background-color: #f1f1f1;
  width: 100%;

}

.tab > button {
  display: block;
  background-color: inherit;
  color: black;
  padding: 22px 16px;
  width: 100%;
  border: none;
  height: 12.5%;
  outline: none;
  text-align: left;
  cursor: pointer;
  transition: 0.3s;
  font-size: 17px;
}
<%-- ------------------------------------------------------------------------------------- --%>
.footer {
	background-color: #333333;
	text-align: left;
	padding: 20px 5% 20px 5%;
	color: white;
	width: 100%;
	font-size: 13px;
	display: block;
}   
   
.footer a {
	color: #ccc;
	text-decoration: none;
}

.footer a:hover {
	cursor: pointer;
}
.bothside{
	display: inline-block;
	width: 1%;
}

.mainside{
	display: inline-block;
	width: 96%;
}



<%-- ------------------------------------------------------------------------------------- --%>




</style>
</head>
<body>

<div class="header" id="header">
	<div class="head_1">
		<div>
		<img style="position:absolute; top:50px; left:40px; width:80px; height: 80px;" src = "./resources/images/ico_판매자.png">
		</div>
		<div>abc님 안녕하세요</div>
	</div>
	<div class="head_2"> 
		판매자 관리 페이지 
	</div>
	<div class="head_3">
		<div style="position: relative; left: 400px;"><img  src = "./resources/images/로고2.png"></div>
		<div> 
		<span style="position: relative; bottom: 2px;"><button type="button" onclick="logout();">호텔추가하기</button></span>
		<span style="position: relative; bottom: 1px;"><button type="button" onclick="logout();">Logout</button></span>
		</div>
	</div>
</div>


<div style="width: 13%; display: inlin-block;">
		<div><button class="tablink" style="cursor:none;">A B C Hotel</button></div>
		<div><button class="tablink" onclick="openPage('page1', this, 'red')" id="defaultOpen" >HOME</button></div>
		<div><button class="tablink" onclick="openPage('page2', this, 'red')">예약 목록</button></div>
		<div><button class="tablink" onclick="openPage('page3', this, 'red')">객실 달력</button></div>
		<div><button class="tablink" onclick="openPage('page4', this, 'red')">객실요금조정</button></div>
		<div><button class="tablink" onclick="openPage('page5', this, 'red')">매출 현황</button></div>
		<div><button class="tablink" onclick="openPage('page6', this, 'red')">객실 등록</button></div>
		<div><button class="tablink" onclick="openPage('page7', this, 'red')">객실 등록현황</button></div>
	
</div>

<div class="main" style="width: 85%; min-height:600px; display: inline-block;">
<%-- HOME ------------------------------------------------------------------------------------- --%>

<div id="page1" class="tabcontent page1">
	<div class="bothside">
	옆공간
	</div>	
	
	<div class="mainside">
		<div style="width: 100%; height: 10px;"></div>
		
		<div style="width: 100%;">
			<div style="display: inline-block; width:24%;">
			&nbsp;&nbsp;Today
			</div>
			
			<div style="display: inline-block; width: 50%; text-align: center;">
				<span style="display: inline-block; width: 9%">&lt;</span>
				<span style="display: inline-block; width: 80%">날짜</span>
				<span style="display: inline-block; width: 9%">&gt;</span> 
			</div>
			
			<div style="display: inline-block; width:24%;">
			
			</div>
		</div>
	
		<div style="width: 100%; height: 10px;"></div>
	
		<div style="width:100%; height: 120px; background-color: aqua;">
			<div style="width:100%; height:60px; border-bottom: solid 0.5px gray;">
				<div style="width:16.2%; height:100%; display: inline-block; vertical-align: middle;">
				객실 미배정
				</div>
				<div style="width:16.2%; height:100%; display: inline-block;">
				체크인
				</div>
				<div style="width:16.2%; height:100%; display: inline-block;">
				체크아웃
				</div>
				<div style="width:16.2%; height:100%; display: inline-block;">
				재실중
				</div>
				<div style="width:16.2%; height:100%; display: inline-block;">
				들어온 예약
				</div>
				<div style="width:16.2%; height:100%; display: inline-block;">
				취소된 예약
				</div>
				
			</div>
			
			<div style="width:100%; height:60px;">
				<div style="width:16.2%; height:100%; display: inline-block; vertical-align: middle;">
				12
				</div>
				<div style="width:16.2%; height:100%; display: inline-block;">
				12
				</div>
				<div style="width:16.2%; height:100%; display: inline-block;">
				12
				</div>
				<div style="width:16.2%; height:100%; display: inline-block;">
				12
				</div>
				<div style="width:16.2%; height:100%; display: inline-block;">
				12
				</div>
				<div style="width:16.2%; height:100%; display: inline-block;">
				12
				</div>
			</div>
			
		</div>
		
		<div style="width: 100%; height: 40px;"></div>
		
		<div style="width: 100%; height: 150px;">
			<div style="width: 33%; height: 100%; display: inline-block; background-color: blue;">
			
			</div>	
		
			<div style="width: 3%; height: 100%; display: inline-block; background-color: white;"></div>
		
			<div style="width: 35%; height: 100%; display: inline-block; background-color: green;">
			
			</div>
			
			<div style="width: 27%; height: 100%; display: inline-block; background-color: red;">
			 
			</div>
		
		</div>
		
	</div>
	
	<div class="bothside">
	옆공간
	</div>
			
</div>
<%-- 예약 목록 ------------------------------------------------------------------------------------- --%>	
<div id="page2" class="tabcontent page2">

	<div class="bothside">
	옆빈공간
	</div>
	
	<div class="mainside">
	
		<div style="width: 100%; height: 10px;">예약 목록</div>
		
		<div style="width: 100%; height: 20px;"></div>
		
		<div style="width:100%;">
			<div style="width: 10%; height: 30px; display: inline-block;">지점선택</div>
			
			<div style="width: 10%; height: 30px; display: inline-block;">
				<select>
					<option>Hotel</option>
					<option>Hotel2</option>
				</select>
			</div>
			
			<div style="width: 10%; height: 30px; display: inline-block;">조회기간</div>
								
			<div style="width: 10%; height: 30px; display: inline-block;">
				<input type="date" />
			</div>
			
			<div style="width: 2%; height: 30px; display: inline-block;">~</div>
			
			<div style="width: 10%; height: 30px; display: inline-block;">
				<input type="date" />
			</div>
		</div>
		
		<div style="width: 100%; height: 20px;"></div>
		
		<div style="width: 100%; height: 10px;">조회기간 : 2020-02-17 ~ 2020-02-19</div>
		
		<div style="width: 100%; height: 20px;"></div>
		
		<table style="width: 100%; border: 0.5px solid gray;">
			<tr style="width: 100%; background-color: gray;">
				<th style="width:9.8%">호텔</th>
				<td style="width:9.8%">방번호</td>
				<td style="width:9.8%">입실일</td>
				<td style="width:9.8%">퇴실일</td>
				<td style="width:9.8%">예약일</td>
				<td style="width:9.8%">방가격</td>
				<td style="width:9.8%">총할인금액</td>
				<td style="width:9.8%">총결제금액</td>
				<td style="width:9.8%">이용상태</td>
				<td style="width:9.8%">결제상태</td>
			</tr>
			
			<tr style="width: 100%;">
				<th style="width:9.8%">ABC호텔</th>
				<td style="width:9.8%">201</td>
				<td style="width:9.8%">2020-02-19</td>
				<td style="width:9.8%">2020-02-21</td>
				<td style="width:9.8%">2020-02-06</td>
				<td style="width:9.8%">50,000</td>
				<td style="width:9.8%">10,000</td>
				<td style="width:9.8%">90,000</td>
				<td style="width:9.8%">예약중</td>
				<td style="width:9.8%">결제완료</td>
			</tr>
			
			<tr style="width: 100%;">
				<th style="width:9.8%">ABC호텔</th>
				<td style="width:9.8%">202</td>
				<td style="width:9.8%">2020-02-17</td>
				<td style="width:9.8%">2020-02-18</td>
				<td style="width:9.8%">2020-01-06</td>
				<td style="width:9.8%">45,000</td>
				<td style="width:9.8%">0</td>
				<td style="width:9.8%">45,000</td>
				<td style="width:9.8%">이용완료</td>
				<td style="width:9.8%">결제완료</td>
			</tr>
			
			<tr style="width: 100%;">
				<th style="width:9.8%">ABC호텔</th>
				<td style="width:9.8%">203</td>
				<td style="width:9.8%">2020-02-17</td>
				<td style="width:9.8%">2020-02-18</td>
				<td style="width:9.8%">2020-01-06</td>
				<td style="width:9.8%">80,000</td>
				<td style="width:9.8%">20,000</td>
				<td style="width:9.8%">60,000</td>
				<td style="width:9.8%">사용중</td>
				<td style="width:9.8%">결제완료</td>
			</tr>
			
		</table>
	</div>
	
	
	<div class="bothside">
	옆빈공간
	</div>

</div>
<%-- 객실 달력 ------------------------------------------------------------------------------------- --%>	
<div id="page3" class="tabcontent page3">

	<div class="bothside"></div>
	
	<div class="mainside">
		<div style="width: 100%;">
			<div style="display: inline-block; width:24%;">
			</div>
			<div style="display: inline-block; width: 50%; text-align: center;">
				<span style="display: inline-block; width: 9%">&lt;</span>
				<span style="display: inline-block; width: 80%">날짜</span>
				<span style="display: inline-block; width: 9%">&gt;</span> 
			</div>
			<div style="display: inline-block; width:24%;">
			</div>
		</div>
		<div style="width: 100%; height: 10px;"></div>
		
		<div style="width: 100%;">
			<table>
				<tr style="width: 100%;">
					<th style="width: 12.3%;"></th>
					<td>일</td>
					<td>월</td>
					<td>화</td>
					<td>수</td>
					<td>목</td>
					<td>금</td>
					<td>토</td>
				</tr>
				
				<tr>
					<th>Deluxe1</th>
					<td>일</td>
					<td>월</td>
					<td>화</td>
					<td>수</td>
					<td>목</td>
					<td>금</td>
					<td>토</td>
				</tr>
			</table>
		</div>
		
		
		
		
		
		
		
	</div>
	
	
	<div class="bothside"></div>

</div>
<%-- 요금조정 ------------------------------------------------------------------------------------- --%>	
<div id="page4" class="tabcontent page4">

	<div class="bothside">

	</div>
	
	<div class="mainside">
		
		<div style="width: 100%;">
			<div style="width: 79%; height: 30px; display: inline-block;">요금 조정</div>
			<div style="width: 19%; height: 30px; display: inline-block; float: right;"> 
				<c:if test="${ not empty roomPriceList }">
					<button type="button" onclick="reviseRoomPriceQuant();">수정 완료</button>  
				</c:if>
			</div>
		</div>
		
		<div style="width: 100%; height: 10px;"></div>
		
		<div style="width: 100%;">
			
			<div style="display: inline-block; width:24%;"></div>
			
			<div style="display: inline-block; width: 50%; text-align: center;">
				<button style="display: inline-block; width: 9%" id="page4_date_prev">&lt;</button>
				<span style="display: inline-block; width: 80%" id="page4_date_span"></span>
				<button style="display: inline-block; width: 9%" id="page4_date_next">&gt;</button> 
			</div>
			
			<div style="display: inline-block; width:24%;"></div>
			
		</div>
		
		<div style="width: 100%; height: 20px;"></div>
		
		<div style="width: 100%; height: 10px;">객실</div>
		
		<div style="width: 100%; height: 10px;"></div>
		
		<div style="width: 100%; height: 30px; border-bottom: 1px solid gray;">
			<div style="width: 79%; display: inline-block;">
			Standard , (Deluxe  (하나씩만 설정가능하게 할 예정))
			</div>
			
			<div style="width: 19%; display: inline-block;  float: right;">
				<button type="button" onclick="roomSearch()">방 검색</button>
			</div>
		</div>	
		
		<div style="width: 100%; height: 10px;"></div>
		
		<div>
			<form name="roomPriceEditForm">
				<input type="hidden" name="logdate">
				<div>
					<select name="fk_hotel_idx">
						<c:if test="${ not empty sellerHotelList }">
							<c:forEach items="${sellerHotelList }" var="map">
								<option value="${ map.hotel_idx }">${ map.hotel_name }</option>
							</c:forEach>
						</c:if>
					</select>
				</div>
				<table>
					<thead>
						<tr>
							<th>객실유형</th>
							<th>가격</th>
							<th>수량</th>
						</tr>
					</thead>
					
					<tbody>
						<c:if test="${ not empty roomPriceList }">
							<c:forEach items="${ roomPriceList }" var="map" varStatus="status">
								<tr>
									<td>
										<span>${map.room_name}</span>
										<input type="hidden" name="room_idx${status.index }" value="${map.room_idx }">
										<input type="hidden" name="roomprice_seqno${status.index }" value="${map.roomprice_seqno }">
										<input type="hidden" name="roomprice_date${ status.index}" value="${ map.roomprice_date}">
									</td>
									<td>
										<input type="text" name="roomprice${ status.index}" value="${map.roomprice}"> 원
									</td>
									<td>
										<input type="text" name="roomprice_quantity${ status.index}" value="${map.roomprice_quantity}"> 개
										<c:if test="${ status.last }">
											<input type="hidden" name="roomPriceListCount" value="${status.index }">
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</c:if>	
						<c:if test="${ empty roomPriceList }">
							<tr>
								<td colspan="3">객실 등록 먼저 부탁드립니다.</td>
							</tr>
						</c:if>
						
					</tbody>
				</table>
			</form>
		</div>

	</div>
	
	
	<div class="bothside">

	</div>

</div>
<%-- 매출 현황 ------------------------------------------------------------------------------------- --%>	
<div id="page5" class="tabcontent page5">

	<div class="bothside">
	옆공간
	</div>
	
	<div class="mainside">
	</div>
	
	
	<div class="bothside">
	옆공간
	</div>

</div>
<%-- 객실 등록 ------------------------------------------------------------------------------------- --%>	
<div id="page6" class="tabcontent page6">

	<div class="bothside">
	</div>
	
	<div class="mainside">
	
		<div style="width: 100%; border-bottom: solid 1px gray;">
			<div style="width: 19%; height: 30px; display: inline-block; font-weight: bold;">객실 등록</div>
			<div style="width: 50%; height: 30px; display: inline-block;"></div>
			<div style="width: 9.5%; height: 30px; display: inline-block;"> <button type="button" id="roomInsertBtn">추가 하기</button></div>
			<div style="width: 10%; height: 30px; display: inline-block;"></div>
			<div style="width: 9.5%; height: 30px; display: inline-block;"> <button type="button" onclick="goSubmitRoom();">저장 하기</button></div>
		</div>
		<div style="width: 100%; height: 10px;"></div>
		
		<div style="width: 100%;">
			<form name="roomInsertForm">
				<div style="width: 100%; border-bottom: solid 1px gray;">
					<div style="width: 11.5%; display: inline-block; border-right: solid 0.5px gray; font-size: 11pt; text-align: center;">호텔</div>
					<div style="width: 11.5%; display: inline-block; border-right: solid 0.5px gray; font-size: 11pt; text-align: center;">객실 유형명</div>
					<div style="width: 11.5%; display: inline-block; border-right: solid 0.5px gray; font-size: 11pt; text-align: center;">체크인</div>
					<div style="width: 11.5%; display: inline-block; border-right: solid 0.5px gray; font-size: 11pt; text-align: center;">체크아웃</div>
					<div style="width: 11.5%; display: inline-block; border-right: solid 0.5px gray; font-size: 11pt; text-align: center;">기본인원</div>
					<div style="width: 11.5%; display: inline-block; border-right: solid 0.5px gray; font-size: 11pt; text-align: center;">최대인원</div>
					<div style="width: 11.5%; display: inline-block; border-right: solid 0.5px gray; font-size: 11pt; text-align: center;">인당추가금</div>
					<div style="width: 100%; height: 10px;"></div>
				</div>
				
				<div style="width: 100%; height: 10px;"></div>
				<%-- 1번째 --%>
				<div style="width: 100%; border-bottom: solid 1px gray;" class="insertRoom1">
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<select name="fk_hotel_idx1">
							<c:if test="${ not empty sellerHotelList }">
								<c:forEach items="${sellerHotelList }" var="map">
									<option value="${ map.hotel_idx }">${ map.hotel_name }</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="text" name="room_name1" style="width:70%;" />
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="00" max="23" id="ROOM_CHECKINTIME" name="ROOM_CHECKINTIME1" style="width:25%;" />시
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="00" max="23" id="ROOM_CHECKOUTTIME" name="ROOM_CHECKOUTTIME1" style="width:25%;" />시
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="1" max="10" id="ROOM_PERSON" name="ROOM_PERSON1" style="width:25%;" />명
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="1" max="10" id="ROOM_ADDPERSON" name="ROOM_ADDPERSON1" style="width:25%;" />명
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="text" style="width:50%;" id="ROOM_ADDPERCHARGE" name="ROOM_ADDPERCHARGE1" />원
					</div>
					
					<div style="width: 100%; height: 30px;"></div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							침대유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_SINGLE" name="BED_SINGLE1" value="1" />싱글
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_DOUBLE" name="BED_DOUBLE1" value="1" />더블
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_TWIN" name="BED_TWIN1" value="1" />트윈
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_ONDOL" name="BED_ONDOL1" value="1" />온돌
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							스파유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_WPOOL" name="SPA_WPOOL1" value="1" />월풀
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_SAUNA" name="SPA_SAUNA1" value="1" />사우나
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_MASSAGE" name="SPA_MASSAGE1" value="1" />마사지베드
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_HINOKKI" name="SPA_HINOKKI1" value="1" />히노끼탕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_OPENBATH" name="SPA_OPENBATH1" value="1" />노천탕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_HALFPOOL" name="SPA_HALFPOOL1" value="1" />반신욕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_TV" name="SPA_TV1" value="1" />욕실내TV
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							테마유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_MOOIN" name="THEME_MOOIN1" value="1" />무인텔
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_PARTY" name="THEME_PARTY1" value="1" />파티룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_MIRROR" name="THEME_MIRROR1" value="1" />미러룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_DOUBLEFLOOR" name="THEME_DOUBLEFLOOR1" value="1" />복층룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_PRINCESS" name="THEME_PRINCESS1" value="1" />공주룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_TERRAS" name="THEME_TERRAS1" value="1" />야외테라스
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_OCEAN" name="THEME_OCEAN1" value="1" />오션뷰
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_LAKE" name="THEME_LAKE1" value="1" />호수뷰
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_SKY" name="THEME_SKY1" value="1" />스카이뷰
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							내부객시설
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_SPA" name="SERVICE_SPA1" value="1" />스파
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_MINIBAR" name="SERVICE_MINIBAR1" value="1" />미니바
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_WIFI" name="SERVICE_WIFI1" value="1" />와이파이
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_TOWEL" name="SERVICE_TOWEL1" value="1" />욕실용품
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_TV" name="SERVICE_TV1" value="1" />TV
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_AIRCONDITIONER" name="SERVICE_AIRCONDITIONER1" value="1" />에어컨
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_FRIDGE" name="SERVICE_FRIDGE1" value="1" />냉장고
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_IRON" name="SERVICE_IRON1" value="1" />다리미
						</div>
						<div style="width: 100%; height: 10px;"></div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_BATHTUB" name="SERVICE_BATHTUB1" value="1" />욕조
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_HAIRDRYER" name="SERVICE_HAIRDRYER1" value="1" />드라이기
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_KITCHEN" name="SERVICE_KITCHEN1" value="1" />전기밥솥
						</div>		
						<div style="width: 9.9%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_SHOWERROOM" name="SERVICE_SHOWERROOM1" value="1" />객실내샤워실
						</div>			
						<div style="width: 100%; height: 10px;"></div>
					</div>				
								
					<div style="width: 100%; height: 20px;"></div>
				</div>
				
				<div style="width: 100%; height: 10px;"></div>
				
				
				<%-- 2번째 --%>
				<div style="width: 100%; border-bottom: solid 1px gray;" class="insertRoom2">
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<select name="fk_hotel_idx2">
							<c:if test="${ not empty sellerHotelList }">
								<c:forEach items="${sellerHotelList }" var="map">
									<option value="${ map.hotel_idx }">${ map.hotel_name }</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="text" name="room_name2" style="width:70%;" />
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="00" max="23" id="ROOM_CHECKINTIME" name="ROOM_CHECKINTIME2" style="width:25%;" />시
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="00" max="23" id="ROOM_CHECKOUTTIME" name="ROOM_CHECKOUTTIME2" style="width:25%;" />시
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="1" max="10" id="ROOM_PERSON" name="ROOM_PERSON2" style="width:25%;" />명
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="1" max="10" id="ROOM_ADDPERSON" name="ROOM_ADDPERSON2" style="width:25%;" />명
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="text" style="width:50%;" id="ROOM_ADDPERCHARGE" name="ROOM_ADDPERCHARGE2" />원
					</div>
					
					<div style="width: 100%; height: 30px;"></div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							침대유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_SINGLE" name="BED_SINGLE2" value="1" />싱글
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_DOUBLE" name="BED_DOUBLE2" value="1" />더블
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_TWIN" name="BED_TWIN2" value="1" />트윈
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_ONDOL" name="BED_ONDOL2" value="1" />온돌
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							스파유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_WPOOL" name="SPA_WPOOL2" value="1" />월풀
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_SAUNA" name="SPA_SAUNA2" value="1" />사우나
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_MASSAGE" name="SPA_MASSAGE2" value="1" />마사지베드
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_HINOKKI" name="SPA_HINOKKI2" value="1" />히노끼탕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_OPENBATH" name="SPA_OPENBATH2" value="1" />노천탕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_HALFPOOL" name="SPA_HALFPOOL2" value="1" />반신욕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_TV" name="SPA_TV2" value="1" />욕실내TV
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							테마유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_MOOIN" name="THEME_MOOIN2" value="1" />무인텔
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_PARTY" name="THEME_PARTY2" value="1" />파티룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_MIRROR" name="THEME_MIRROR2" value="1" />미러룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_DOUBLEFLOOR" name="THEME_DOUBLEFLOOR2" value="1" />복층룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_PRINCESS" name="THEME_PRINCESS2" value="1" />공주룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_TERRAS" name="THEME_TERRAS2" value="1" />야외테라스
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_OCEAN" name="THEME_OCEAN2" value="1" />오션뷰
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_LAKE" name="THEME_LAKE2" value="1" />호수뷰
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_SKY" name="THEME_SKY2" value="1" />스카이뷰
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							내부객시설
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_SPA" name="SERVICE_SPA2" value="1" />스파
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_MINIBAR" name="SERVICE_MINIBAR2" value="1" />미니바
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_WIFI" name="SERVICE_WIFI2" value="1" />와이파이
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_TOWEL" name="SERVICE_TOWEL2" value="1" />욕실용품
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_TV" name="SERVICE_TV2" value="1" />TV
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_AIRCONDITIONER" name="SERVICE_AIRCONDITIONER2" value="1" />에어컨
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_FRIDGE" name="SERVICE_FRIDGE2" value="1" />냉장고
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_IRON" name="SERVICE_IRON2" value="1" />다리미
						</div>
						<div style="width: 100%; height: 10px;"></div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_BATHTUB" name="SERVICE_BATHTUB2" value="1" />욕조
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_HAIRDRYER" name="SERVICE_HAIRDRYER2" value="1" />드라이기
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_KITCHEN" name="SERVICE_KITCHEN2" value="1" />전기밥솥
						</div>		
						<div style="width: 9.9%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_SHOWERROOM" name="SERVICE_SHOWERROOM2" value="1" />객실내샤워실
						</div>			
						<div style="width: 100%; height: 10px;"></div>
					</div>				
								
					<div style="width: 100%; height: 20px;"></div>
				</div>
				
				<div style="width: 100%; height: 10px;"></div>
				
				<%-- 3번째 --%>
				<div style="width: 100%; border-bottom: solid 1px gray;" class="insertRoom3">
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<select name="fk_hotel_idx3">
							<c:if test="${ not empty sellerHotelList }">
								<c:forEach items="${sellerHotelList }" var="map">
									<option value="${ map.hotel_idx }">${ map.hotel_name }</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="text" name="room_name3" style="width:70%;" />
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="00" max="23" id="ROOM_CHECKINTIME" name="ROOM_CHECKINTIME3" style="width:25%;" />시
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="00" max="23" id="ROOM_CHECKOUTTIME" name="ROOM_CHECKOUTTIME3" style="width:25%;" />시
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="1" max="10" id="ROOM_PERSON" name="ROOM_PERSON3" style="width:25%;" />명
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="1" max="10" id="ROOM_ADDPERSON" name="ROOM_ADDPERSON3" style="width:25%;" />명
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="text" style="width:50%;" id="ROOM_ADDPERCHARGE" name="ROOM_ADDPERCHARGE3" />원
					</div>
					
					<div style="width: 100%; height: 30px;"></div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							침대유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_SINGLE" name="BED_SINGLE3"  value="1"/>싱글
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_DOUBLE" name="BED_DOUBLE3"  value="1"/>더블
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_TWIN" name="BED_TWIN3"  value="1"/>트윈
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_ONDOL" name="BED_ONDOL3"  value="1"/>온돌
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							스파유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_WPOOL" name="SPA_WPOOL3" value="1" />월풀
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_SAUNA" name="SPA_SAUNA3" value="1" />사우나
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_MASSAGE" name="SPA_MASSAGE3" value="1" />마사지베드
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_HINOKKI" name="SPA_HINOKKI3" value="1" />히노끼탕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_OPENBATH" name="SPA_OPENBATH3" value="1" />노천탕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_HALFPOOL" name="SPA_HALFPOOL3" value="1" />반신욕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_TV" name="SPA_TV3" value="1" />욕실내TV
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							테마유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_MOOIN" name="THEME_MOOIN3" value="1" />무인텔
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_PARTY" name="THEME_PARTY3" value="1" />파티룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_MIRROR" name="THEME_MIRROR3" value="1" />미러룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_DOUBLEFLOOR" name="THEME_DOUBLEFLOOR3" value="1" />복층룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_PRINCESS" name="THEME_PRINCESS3" value="1" />공주룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_TERRAS" name="THEME_TERRAS3" value="1" />야외테라스
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_OCEAN" name="THEME_OCEAN3" value="1" />오션뷰
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_LAKE" name="THEME_LAKE3" value="1" />호수뷰
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_SKY" name="THEME_SKY3" value="1" />스카이뷰
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							내부객시설
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_SPA" name="SERVICE_SPA3" value="1" />스파
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_MINIBAR" name="SERVICE_MINIBAR3" value="1" />미니바
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_WIFI" name="SERVICE_WIFI3" value="1" />와이파이
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_TOWEL" name="SERVICE_TOWEL3" value="1" />욕실용품
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_TV" name="SERVICE_TV3" value="1" />TV
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_AIRCONDITIONER" name="SERVICE_AIRCONDITIONER3" value="1" />에어컨
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_FRIDGE" name="SERVICE_FRIDGE3" value="1" />냉장고
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_IRON" name="SERVICE_IRON3" value="1" />다리미
						</div>
						<div style="width: 100%; height: 10px;"></div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_BATHTUB" name="SERVICE_BATHTUB3" value="1" />욕조
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_HAIRDRYER" name="SERVICE_HAIRDRYER3" value="1" />드라이기
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_KITCHEN" name="SERVICE_KITCHEN3" value="1" />전기밥솥
						</div>		
						<div style="width: 9.9%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_SHOWERROOM" name="SERVICE_SHOWERROOM3" value="1" />객실내샤워실
						</div>			
						<div style="width: 100%; height: 10px;"></div>
					</div>				
								
					<div style="width: 100%; height: 20px;"></div>
				</div>
				
				<div style="width: 100%; height: 10px;"></div>
				<%-- 4번째 --%>
				<div style="width: 100%; border-bottom: solid 1px gray;" class="insertRoom4">
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<select name="fk_hotel_idx4">
							<c:if test="${ not empty sellerHotelList }">
								<c:forEach items="${sellerHotelList }" var="map">
									<option value="${ map.hotel_idx }">${ map.hotel_name }</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="text" name="room_name4" style="width:70%;" />
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="00" max="23" id="ROOM_CHECKINTIME" name="ROOM_CHECKINTIME4" style="width:25%;" />시
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="00" max="23" id="ROOM_CHECKOUTTIME" name="ROOM_CHECKOUTTIME4" style="width:25%;" />시
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="1" max="10" id="ROOM_PERSON" name="ROOM_PERSON4" style="width:25%;" />명
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="1" max="10" id="ROOM_ADDPERSON" name="ROOM_ADDPERSON4" style="width:25%;" />명
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="text" style="width:50%;" id="ROOM_ADDPERCHARGE" name="ROOM_ADDPERCHARGE4" />원
					</div>
					
					<div style="width: 100%; height: 30px;"></div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							침대유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_SINGLE" name="BED_SINGLE4"  value="1"/>싱글
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_DOUBLE" name="BED_DOUBLE4"  value="1"/>더블
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_TWIN" name="BED_TWIN4"  value="1"/>트윈
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_ONDOL" name="BED_ONDOL4" value="1" />온돌
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							스파유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_WPOOL" name="SPA_WPOOL4" value="1" />월풀
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_SAUNA" name="SPA_SAUNA4" value="1" />사우나
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_MASSAGE" name="SPA_MASSAGE4" value="1" />마사지베드
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_HINOKKI" name="SPA_HINOKKI4" value="1" />히노끼탕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_OPENBATH" name="SPA_OPENBATH4" value="1" />노천탕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_HALFPOOL" name="SPA_HALFPOOL4" value="1" />반신욕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_TV" name="SPA_TV4" value="1" />욕실내TV
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							테마유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_MOOIN" name="THEME_MOOIN4" value="1" />무인텔
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_PARTY" name="THEME_PARTY4" value="1" />파티룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_MIRROR" name="THEME_MIRROR4" value="1" />미러룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_DOUBLEFLOOR" name="THEME_DOUBLEFLOOR4" value="1" />복층룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_PRINCESS" name="THEME_PRINCESS4" value="1" />공주룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_TERRAS" name="THEME_TERRAS4" value="1" />야외테라스
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_OCEAN" name="THEME_OCEAN4" value="1" />오션뷰
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_LAKE" name="THEME_LAKE4" value="1" />호수뷰
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_SKY" name="THEME_SKY4" value="1" />스카이뷰
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							내부객시설
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_SPA" name="SERVICE_SPA4" value="1" />스파
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_MINIBAR" name="SERVICE_MINIBAR4" value="1" />미니바
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_WIFI" name="SERVICE_WIFI4" value="1" />와이파이
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_TOWEL" name="SERVICE_TOWEL4" value="1" />욕실용품
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_TV" name="SERVICE_TV4" value="1" />TV
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_AIRCONDITIONER" name="SERVICE_AIRCONDITIONER4" value="1" />에어컨
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_FRIDGE" name="SERVICE_FRIDGE4" value="1" />냉장고
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_IRON" name="SERVICE_IRON4" value="1" />다리미
						</div>
						<div style="width: 100%; height: 10px;"></div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_BATHTUB" name="SERVICE_BATHTUB4" value="1" />욕조
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_HAIRDRYER" name="SERVICE_HAIRDRYER4" value="1" />드라이기
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_KITCHEN" name="SERVICE_KITCHEN4" value="1" />전기밥솥
						</div>		
						<div style="width: 9.9%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_SHOWERROOM" name="SERVICE_SHOWERROOM4" value="1" />객실내샤워실
						</div>			
						<div style="width: 100%; height: 10px;"></div>
					</div>				
								
					<div style="width: 100%; height: 20px;"></div>
				</div>
				
				<div style="width: 100%; height: 10px;"></div>
				<%-- 5번째 --%>
				<div style="width: 100%; border-bottom: solid 1px gray;" class="insertRoom5">
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<select name="fk_hotel_idx5">
							<c:if test="${ not empty sellerHotelList }">
								<c:forEach items="${sellerHotelList }" var="map">
									<option value="${ map.hotel_idx }">${ map.hotel_name }</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="text" name="room_name5" style="width:70%;" />
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="00" max="23" id="ROOM_CHECKINTIME" name="ROOM_CHECKINTIME5" style="width:25%;" />시
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="00" max="23" id="ROOM_CHECKOUTTIME" name="ROOM_CHECKOUTTIME5" style="width:25%;" />시
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="1" max="10" id="ROOM_PERSON" name="ROOM_PERSON5" style="width:25%;" />명
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="1" max="10" id="ROOM_ADDPERSON" name="ROOM_ADDPERSON5" style="width:25%;" />명
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="text" style="width:50%;" id="ROOM_ADDPERCHARGE" name="ROOM_ADDPERCHARGE5" />원
					</div>
					
					<div style="width: 100%; height: 30px;"></div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							침대유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_SINGLE" name="BED_SINGLE5"  value="1"/>싱글
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_DOUBLE" name="BED_DOUBLE5" value="1" />더블
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_TWIN" name="BED_TWIN5" value="1" />트윈
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_ONDOL" name="BED_ONDOL5" value="1" />온돌
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							스파유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_WPOOL" name="SPA_WPOOL5" value="1" />월풀
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_SAUNA" name="SPA_SAUNA5" value="1" />사우나
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_MASSAGE" name="SPA_MASSAGE5" value="1" />마사지베드
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_HINOKKI" name="SPA_HINOKKI5" value="1" />히노끼탕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_OPENBATH" name="SPA_OPENBATH5" value="1" />노천탕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_HALFPOOL" name="SPA_HALFPOOL5" value="1" />반신욕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_TV" name="SPA_TV5" value="1" />욕실내TV
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							테마유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_MOOIN" name="THEME_MOOIN5" value="1" />무인텔
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_PARTY" name="THEME_PARTY5" value="1" />파티룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_MIRROR" name="THEME_MIRROR5" value="1" />미러룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_DOUBLEFLOOR" name="THEME_DOUBLEFLOOR5" value="1" />복층룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_PRINCESS" name="THEME_PRINCESS5" value="1" />공주룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_TERRAS" name="THEME_TERRAS5" value="1" />야외테라스
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_OCEAN" name="THEME_OCEAN5" value="1" />오션뷰
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_LAKE" name="THEME_LAKE5" value="1" />호수뷰
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_SKY" name="THEME_SKY5" value="1" />스카이뷰
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							내부객시설
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_SPA" name="SERVICE_SPA5" value="1" />스파
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_MINIBAR" name="SERVICE_MINIBAR5" value="1" />미니바
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_WIFI" name="SERVICE_WIFI5" value="1" />와이파이
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_TOWEL" name="SERVICE_TOWEL5" value="1" />욕실용품
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_TV" name="SERVICE_TV5" value="1" />TV
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_AIRCONDITIONER" name="SERVICE_AIRCONDITIONER5" value="1" />에어컨
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_FRIDGE" name="SERVICE_FRIDGE5" value="1" />냉장고
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_IRON" name="SERVICE_IRON5" value="1" />다리미
						</div>
						<div style="width: 100%; height: 10px;"></div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_BATHTUB" name="SERVICE_BATHTUB5" value="1" />욕조
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_HAIRDRYER" name="SERVICE_HAIRDRYER5" value="1" />드라이기
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_KITCHEN" name="SERVICE_KITCHEN5" value="1" />전기밥솥
						</div>		
						<div style="width: 9.9%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_SHOWERROOM" name="SERVICE_SHOWERROOM5" value="1" />객실내샤워실
						</div>			
						<div style="width: 100%; height: 10px;"></div>
					</div>				
								
					<div style="width: 100%; height: 20px;"></div>
				</div>
				
				<div style="width: 100%; height: 10px;"></div>
				<%-- 6번째 --%>
				<div style="width: 100%; border-bottom: solid 1px gray;" class="insertRoom6">
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<select name="fk_hotel_idx6">
							<c:if test="${ not empty sellerHotelList }">
								<c:forEach items="${sellerHotelList }" var="map">
									<option value="${ map.hotel_idx }">${ map.hotel_name }</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="text" name="room_name6" style="width:70%;" />
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="00" max="23" id="ROOM_CHECKINTIME" name="ROOM_CHECKINTIME6" style="width:25%;" />시
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="00" max="23" id="ROOM_CHECKOUTTIME" name="ROOM_CHECKOUTTIME6" style="width:25%;" />시
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="1" max="10" id="ROOM_PERSON" name="ROOM_PERSON6" style="width:25%;" />명
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="1" max="10" id="ROOM_ADDPERSON" name="ROOM_ADDPERSON6" style="width:25%;" />명
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="text" style="width:50%;" id="ROOM_ADDPERCHARGE" name="ROOM_ADDPERCHARGE6" />원
					</div>
					
					<div style="width: 100%; height: 30px;"></div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							침대유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_SINGLE" name="BED_SINGLE6" value="1" />싱글
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_DOUBLE" name="BED_DOUBLE6" value="1" />더블
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_TWIN" name="BED_TWIN6" value="1" />트윈
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_ONDOL" name="BED_ONDOL6" value="1" />온돌
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							스파유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_WPOOL" name="SPA_WPOOL6" value="1" />월풀
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_SAUNA" name="SPA_SAUNA6" value="1" />사우나
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_MASSAGE" name="SPA_MASSAGE6" value="1" />마사지베드
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_HINOKKI" name="SPA_HINOKKI6" value="1" />히노끼탕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_OPENBATH" name="SPA_OPENBATH6" value="1" />노천탕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_HALFPOOL" name="SPA_HALFPOOL6" value="1" />반신욕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_TV" name="SPA_TV6" value="1" />욕실내TV
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							테마유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_MOOIN" name="THEME_MOOIN6" value="1" />무인텔
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_PARTY" name="THEME_PARTY6" value="1" />파티룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_MIRROR" name="THEME_MIRROR6" value="1" />미러룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_DOUBLEFLOOR" name="THEME_DOUBLEFLOOR6" value="1" />복층룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_PRINCESS" name="THEME_PRINCESS6" value="1" />공주룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_TERRAS" name="THEME_TERRAS6" value="1" />야외테라스
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_OCEAN" name="THEME_OCEAN6" value="1" />오션뷰
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_LAKE" name="THEME_LAKE6" value="1" />호수뷰
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_SKY" name="THEME_SKY6" value="1" />스카이뷰
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							내부객시설
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_SPA" name="SERVICE_SPA6" value="1" />스파
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_MINIBAR" name="SERVICE_MINIBAR6" value="1" />미니바
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_WIFI" name="SERVICE_WIFI6" value="1" />와이파이
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_TOWEL" name="SERVICE_TOWEL6" value="1" />욕실용품
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_TV" name="SERVICE_TV6" value="1" />TV
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_AIRCONDITIONER" name="SERVICE_AIRCONDITIONER6" value="1" />에어컨
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_FRIDGE" name="SERVICE_FRIDGE6" value="1" />냉장고
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_IRON" name="SERVICE_IRON6" value="1" />다리미
						</div>
						<div style="width: 100%; height: 10px;"></div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_BATHTUB" name="SERVICE_BATHTUB6" value="1" />욕조
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_HAIRDRYER" name="SERVICE_HAIRDRYER6" value="1" />드라이기
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_KITCHEN" name="SERVICE_KITCHEN6" value="1" />전기밥솥
						</div>		
						<div style="width: 9.9%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_SHOWERROOM" name="SERVICE_SHOWERROOM6" value="1" />객실내샤워실
						</div>			
						<div style="width: 100%; height: 10px;"></div>
					</div>				
								
					<div style="width: 100%; height: 20px;"></div>
				</div>
				
				<div style="width: 100%; height: 10px;"></div>
				<%-- 7번째 --%>
				<div style="width: 100%; border-bottom: solid 1px gray;" class="insertRoom7">
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<select name="fk_hotel_idx7">
							<c:if test="${ not empty sellerHotelList }">
								<c:forEach items="${sellerHotelList }" var="map">
									<option value="${ map.hotel_idx }">${ map.hotel_name }</option>
								</c:forEach>
							</c:if>
						</select>
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="text" name="room_name7" style="width:70%;" />
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="00" max="23" id="ROOM_CHECKINTIME" name="ROOM_CHECKINTIME7" style="width:25%;" />시
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="00" max="23" id="ROOM_CHECKOUTTIME" name="ROOM_CHECKOUTTIME7" style="width:25%;" />시
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="1" max="10" id="ROOM_PERSON" name="ROOM_PERSON7" style="width:25%;" />명
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="number" min="1" max="10" id="ROOM_ADDPERSON" name="ROOM_ADDPERSON7" style="width:25%;" />명
					</div>
					<div style="width: 11.5%; display: inline-block; font-size: 11pt; text-align: center;">
						<input type="text" style="width:50%;" id="ROOM_ADDPERCHARGE" name="ROOM_ADDPERCHARGE7" />원
					</div>
					
					<div style="width: 100%; height: 30px;"></div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							침대유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_SINGLE" name="BED_SINGLE7" value="1" />싱글
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_DOUBLE" name="BED_DOUBLE7" value="1" />더블
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_TWIN" name="BED_TWIN7" value="1" />트윈
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="BED_ONDOL" name="BED_ONDOL7" value="1" />온돌
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							스파유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_WPOOL" name="SPA_WPOOL7" value="1" />월풀
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_SAUNA" name="SPA_SAUNA7" value="1" />사우나
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_MASSAGE" name="SPA_MASSAGE7" value="1" />마사지베드
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_HINOKKI" name="SPA_HINOKKI7" value="1" />히노끼탕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_OPENBATH" name="SPA_OPENBATH7" value="1" />노천탕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_HALFPOOL" name="SPA_HALFPOOL7" value="1" />반신욕
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" class="TBL_HERE_SPA" id="SPA_TV" name="SPA_TV7" value="1" />욕실내TV
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							테마유형
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_MOOIN" name="THEME_MOOIN7" value="1" />무인텔
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_PARTY" name="THEME_PARTY7" value="1" />파티룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_MIRROR" name="THEME_MIRROR7" value="1" />미러룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_DOUBLEFLOOR" name="THEME_DOUBLEFLOOR7" value="1" />복층룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_PRINCESS" name="THEME_PRINCESS7" value="1" />공주룸
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_TERRAS" name="THEME_TERRAS7" value="1" />야외테라스
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_OCEAN" name="THEME_OCEAN7" value="1" />오션뷰
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_LAKE" name="THEME_LAKE7" value="1" />호수뷰
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="THEME_SKY" name="THEME_SKY7" value="1" />스카이뷰
						</div>
						<div style="width: 100%; height: 10px;"></div>
					</div>
					
					<div style="width: 100%;">
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
							내부객시설
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_SPA" name="SERVICE_SPA7" value="1" />스파
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_MINIBAR" name="SERVICE_MINIBAR7" value="1" />미니바
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_WIFI" name="SERVICE_WIFI7" value="1" />와이파이
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_TOWEL" name="SERVICE_TOWEL7" value="1" />욕실용품
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_TV" name="SERVICE_TV7" value="1" />TV
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_AIRCONDITIONER" name="SERVICE_AIRCONDITIONER7" value="1" />에어컨
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_FRIDGE" name="SERVICE_FRIDGE7" value="1" />냉장고
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_IRON" name="SERVICE_IRON7" value="1" />다리미
						</div>
						<div style="width: 100%; height: 10px;"></div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: center; border-right: solid 0.5px gray;">
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_BATHTUB" name="SERVICE_BATHTUB7" value="1" />욕조
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_HAIRDRYER" name="SERVICE_HAIRDRYER7" value="1" />드라이기
						</div>
						<div style="width: 9.3%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_KITCHEN" name="SERVICE_KITCHEN7" value="1" />전기밥솥
						</div>		
						<div style="width: 9.9%; display: inline-block; font-size: 9pt; text-align: left;">
							<input type="checkbox" id="SERVICE_SHOWERROOM" name="SERVICE_SHOWERROOM7" value="1" />객실내샤워실
						</div>			
						<div style="width: 100%; height: 10px;"></div>
					</div>				
								
					<div style="width: 100%; height: 20px;"></div>
				</div>
				
				<div style="width: 100%; height: 10px;"></div>
					
			</form>
		</div>
	
	</div>
	
	
	<div class="bothside">
	</div>

</div>
<%-- 객실 등록현황 ------------------------------------------------------------------------------------- --%>	
<div id="page7" class="tabcontent page7">

	<div class="bothside">
	옆공간
	</div>
	
	<div class="mainside">
	</div>
	
	
	<div class="bothside">
	옆공간
	</div>

</div>
<%-- ------------------------------------------------------------------------------------- --%>
</div>


<%-- ------------------------------------------------------------------------------------- --%>
<footer>
<div class="footer" style="width: 100%; display: block;">

	<a>회사소개</a> | <a>이용약관</a> | <a>개인정보처리방침</a> | <a>사업자 정보확인</a> | <a>콘텐츠산업진흥에의한 표시</a> 
    
    <br/> <br/>
	 고객행복센터 1670-6250 &nbsp;&nbsp; 오전 9시 - 새벽 3시, 점심시간: 오후 12시 - 오후 1시 <br/>
	<br/>
	(주) 위드이노베이션<br/>
	주소 : 서울특별시 강남구 봉은사로 479, 479타워 11층<br/>
	대표이사 : 최문석 | 사업자등록번호: 742-86-00224<br/>
	통신판매번호 : 2017-서울강남-01779 | 관광사업자 등록번호: 제1026-24호<br/>
	전화번호 : 1670-6250<br/>
	전자우편주소 : help@goodchoice.kr<br/>
	Copyright WITHINNOVATION Corp. All rights reserved.<br/>
</div>
</footer>
</body>
</html>