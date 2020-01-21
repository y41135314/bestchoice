<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
 #hotelDetail {
 	/* border: solid 1px black; */
 	min-height: 500px;   
 	/* margin-top: 200px; */
 	margin-top: 10px;
 	margin-bottom: 30px;
 }
 
  #pHotel {
	background-color: #555555;
	color: #B7B7B7;
}

 #hotelListBtn{
 	color: #F7323F;
 }
 
 #tableHotelDetail {
 	border: solid 1px black;
 	border-collapse: collapse;  
 	width: 100%;
 	margin-top: 10px;
 }
 
 #tableHotelDetail tr, #tableHotelDetail th, #tableHotelDetail td  {
 	border: solid 1px black;
 }
 
 #tableHotelDetail th {
 	text-align: center;
 }
 
</style>
<script>
	$(document).ready(function(){
		
		$("#divHotel").css("border-bottom", "solid 1px #555555");
		$("#divSeller").css("border", "none");
		$("#divHotel2").show();  
		$("#divSeller2").hide();  
		
		$("#hotelListBtn").bind("mouseover", function(){	
			$("#hotelListBtn").css({"color":"white","background-color":"#F7323F"});
		})
		$("#hotelListBtn").bind("mouseout", function(){	
			$("#hotelListBtn").css({"color":"#F7323F","background-color":"rgba(225,225,225,0.0)"});
		})

	})
</script>

<div id="hotelDetail">
	<label style="font-size: 16px;">◎ 호텔 상세 내역</label>
	<br/>
   <input type="button" value="호텔리스트페이지로" onclick="location.href='<%=request.getContextPath()%>/adminSeller_list.bc'" style="font-size: 8pt;"/> 
   &nbsp;&nbsp;|&nbsp;&nbsp;
   <input type="button" value="예약내역 보기" onclick="location.href='<%=request.getContextPath()%>/adminReservList.bc'" style="font-size: 8pt;"/> 
    &nbsp;&nbsp;|&nbsp;&nbsp;
   <label>보유한 방 : 총&nbsp;</label><span>개</span>
   &nbsp;&nbsp;|&nbsp;&nbsp;
   <input type="button" value="영업중지해제" style="font-size: 8pt;"/> 
   <input type="button" value="영업중지" style="font-size: 8pt;"/> 
   	    
    <table id="tableHotelDetail">
		<tr> 
			<th>ID</th>
			<th>호텔명</th>
			<th>호텔등급</th>
			<th>사업자명</th>
			<th>호텔주소</th>
			<th>우편번호</th>
			<th>전화번호</th>
			<th>이메일</th>
			<th>등록일자</th>
			<th>누적판매액</th>
			<th>누적예약수</th>
			<th>영업상태</th>
		</tr>
		<tr>   
			<td colspan="12">등록된 호텔이 없습니다.</td>
		</tr>
	</table>	
	
	<br/><br/>
	<div style="border: solid 1px black;">
		<label>▶ 예약건수 및 판매액 추이(주 평균 총합)</label>
	</div>
	
	<br/><br/>
	
	<div style="border: solid 1px black;">
		<label>▶보유한 방 리스트</label>
		<table></table>
	</div>
	
	<br/><br/>
	<div>
		<label>▶ 관리자 코멘트</label>
		<form name="adminComment">
			<div>
				<input type="text" placeholder="제목" style="margin: 5px 0;" /><br/>
				<textarea name="adminCommentCon" id="adminCommentCon" style="width: 50%;"></textarea>
			</div>
			<div>
				<input type="text" value="사업자명" style="font-size: 8pt; width: 7%; margin-bottom: 5px;" class="short"  readonly  /> 
				<input type="text" value="호텔명" style="font-size: 8pt; width: 7%; margin-bottom: 5px;" class="short"  readonly  /> 
				<input type="text" value="관리자이름" style="font-size: 8pt; width: 7%; margin-bottom: 5px;" class="short"  readonly  />  <%-- ${sessionScope.loginuser.name} --%>
				<input type="button" value="등록" style="font-size: 8pt; margin-left: 100;"/> 
			</div>
		<%-- <input type="hidden" name="pnum" value="${pvo.pnum}" />
		<input type="hidden" name="goBackURL" value="${goBackURL}" />  --%>
		</form>
	      
	</div>
</div>