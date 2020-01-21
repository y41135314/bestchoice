<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
 #adminHotelList {
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
 
 #tableHotelList {
 	border: solid 1px black;
 	border-collapse: collapse;  
 	width: 100%;
 	margin-top: 10px;
 }
 
 #tableHotelList tr, #tableHotelList th, #tableHotelList td  {
 	border: solid 1px black;
 }
 #tableHotelList th {
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

<div id="adminHotelList">
<div>
		<label style="font-size: 16px;">◎ 호텔 리스트 (총 : <span></span>개)</label>
		<br/>
		<form>
		<input type="button" value="검색" style="margin: 15px;"/> 
		<label>영업상태 :</label> 
			영업중&nbsp;<input type="checkbox"/>
			영업중지&nbsp;<input type="checkbox"/>
		&nbsp;&nbsp;|&nbsp;&nbsp;
		<label>기간선택 : </label>     
		<input type="date" style="width: 130px;"/> ~ <input type="date" style="width: 130px;"/>
		&nbsp;&nbsp;|&nbsp;&nbsp;	
		<label>호텔등급 : </label>
		<select name="" id="" style="height: 20px;">
			<option value="">전체</option>
			<option value="">5성</option>
			<option value="">4성</option>
			<option value="">3성</option>
			<option value="">2성미만</option>
		</select>  
		&nbsp;&nbsp;|&nbsp;&nbsp;	
		<label>위치 : </label>
		<select name="" id="" style="height: 20px;">
			<option value="">전국</option>
			<option value="">서울</option>  
			<option value="">경기/인천</option>
			<option value="">강원</option>
			<option value="">대전/충남/충북</option>
			<option value="">경남/경북</option>
			<option value="">전남/전북</option>
			<option value="">제주/울릉</option>
		</select>  
		<br/>
		<select name="" id="" style="height: 20px; margin-left: 80px;">
			<option value="">ID</option>
			<option value="">호텔명</option>
			<option value="">사업자명</option>  
		</select>   
		<input type="text" style="height: 20px;"/>
		&nbsp;&nbsp;|&nbsp;&nbsp;	
		<label>조회순서 : </label>
		<select name="" id="" style="height: 20px;">
			<option value="">등록일자</option>
			<option value="">누적결재액</option>
			<option value="">누적예약건수</option>
			<option value="">평점</option>
		</select>  
		&nbsp;&nbsp;|&nbsp;&nbsp;
		<label>검색된 호텔 :  </label>&nbsp;총&nbsp;<span></span>개 
		
		 <input type="button" value="엑셀다운" style="float:right; font-size: 8pt; z-index: 1;" /> 
		</form>
		
		<table id="tableHotelList">
			<tr>
				<th>번호</th>
				<th>ID</th>
				<th>호텔명</th>
				<th>호텔등급</th>
				<th>사업자명</th>   
				<th>등록일자</th>
				<th>누적판매액</th>
				<th>누적예약수</th>
				<th>영업상태</th>
			</tr>
			<tr>   
				<td colspan="9">등록된 호텔이 없습니다.</td>
			</tr>
		</table>
		
		<input type="button" value="상세내역GO" onclick="location.href='<%=request.getContextPath()%>/hotelDetail.bc'"  style="position: relative; left: 25%; font-size: 8pt; " /> 
</div>
</div>   