<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
 #adminSellerList {
 	/* border: solid 1px black; */
 	min-height: 500px;   
 	/* margin-top: 200px; */
 	margin-top: 10px;
 	margin-bottom: 30px;
 }
 
 #pSeller {
	background-color: #555555;
	color: #B7B7B7;
}

 #sellerListBtn{
 	color: #F7323F;
 }
 
 #tableSellerList {
 	border: solid 1px black;
 	border-collapse: collapse;  
 	width: 100%;
 	margin-top: 10px;
 }
 
 #tableSellerList tr, #tableSellerList th, #tableSellerList td  {
 	border: solid 1px black;
 }
  #tableSellerList th {
 	text-align: center;
 }
</style>

<script>
	$(document).ready(function(){
		
		$("#divSeller").css("border-bottom", "solid 1px #555555");
		$("#divHotel").css("border", "none");
		$("#divSeller2").show();            
		$("#divHotel2").hide();
		
		$("#sellerListBtn").bind("mouseover", function(){	
			$("#sellerListBtn").css({"color":"white","background-color":"#F7323F"});
		})
		$("#sellerListBtn").bind("mouseout", function(){	
			$("#sellerListBtn").css({"color":"#F7323F","background-color":"rgba(225,225,225,0.0)"});
		})

	})
</script>

<div id="adminSellerList">
<div>
		<label style="font-size: 16px;">◎ 판매자 리스트 (총 : <span></span>명)</label>
		<br/>
		<form>
		<input type="button" value="검색" style="margin: 15px;"/> 
		<label>영업상태 :</label> 
			영업중&nbsp;<input type="checkbox"/>
			영업중지&nbsp;<input type="checkbox"/>
		&nbsp;&nbsp;|&nbsp;&nbsp;
		<label>기간선택 : </label>     
		<input type="date" style="width: 130px;"/> ~ <input type="date" style="width: 130px;"/>
		<br/>
		<select name="" id="" style="height: 20px; margin-left: 80px;">
			<option value="">ID</option>
			<option value="">판매자명</option>
		</select>   
		<input type="text" style="height: 20px;"/>
		&nbsp;&nbsp;|&nbsp;&nbsp;	
		<label>조회순서 : </label>
		<select name="" id="" style="height: 20px;">
			<option value="">가입일자</option>
			<option value="">누적결재액</option>
			<option value="">누적예약건수</option>
		</select>  
		&nbsp;&nbsp;|&nbsp;&nbsp;
		<label>가입상태 : </label>    
			가입&nbsp;<input type="checkbox"/>      
			탈퇴&nbsp;<input type="checkbox"/>
		&nbsp;&nbsp;|&nbsp;&nbsp;	    	    
		<label>검색된 판매자 : </label>&nbsp;총&nbsp;<span></span>명
		
		<input type="button" value="엑셀다운" style="float:right; font-size: 8pt; z-index: 1;" />  
		</form>
		
		<table id="tableSellerList">
			<tr>
				<th>번호</th>
				<th>ID</th>
				<th>판매자명</th>
				<th>휴대폰번호</th>
				<th>이메일</th>
				<th>가입일자</th>
				<th>누적판매액</th>
				<th>누적예약수</th>
				<th>영업상태</th>
			</tr>
			<tr>   
				<td colspan="9">가입한 판매자가 없습니다.</td>
			</tr>
		</table>
		<input type="button" value="상세내역GO" onclick="location.href='<%=request.getContextPath()%>/sellerDetail.bc'"  style="position: relative; left: 25%; font-size: 8pt; " /> 
</div>
</div>   