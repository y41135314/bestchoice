<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
#sellerDetail {
 /* 	border: solid 1px black; */
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
 
 #tableSellerDetail {
 	border: solid 1px black;
 	border-collapse: collapse;  
 	width: 100%;
 	margin-top: 10px;
 }
 
 #tableSellerDetail tr, #tableSellerDetail th, #tableSellerDetail td  {
 	border: solid 1px black;
 }
 
 #tableSellerDetail th {
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

    
<div id="sellerDetail">
	<label style="font-size: 16px;">◎ 판매자 상세 내역</label>
   <br/>
   <input type="button" value="판매자리스트페이지로" onclick="location.href='<%=request.getContextPath()%>/adminSeller_list.bc'" style="font-size: 8pt;"/> 
   &nbsp;&nbsp;|&nbsp;&nbsp;
   <input type="button" value="예약내역 보기" onclick="location.href='<%=request.getContextPath()%>/adminReservList.bc'" style="font-size: 8pt;"/> 
   &nbsp;&nbsp;|&nbsp;&nbsp;
   <label>보유 호텔 : 총&nbsp;</label><span>개</span> &nbsp;<input type="button" value="리스트보기" onclick="location.href='<%=request.getContextPath()%>/adminHotel_list.bc'" style="font-size: 8pt;"/> 
	&nbsp;&nbsp;|&nbsp;&nbsp;
	<input type="button" value="영업중지해제" style="font-size: 8pt;"/> 
    <input type="button" value="영업중지" style="font-size: 8pt;"/> 
   	    
    <table id="tableSellerDetail">
		<tr> 
			<th>ID</th>
			<th>사업자명</th>
			<th>대표휴대폰</th>
			<th>대표전화번호</th>
			<th>사업자소재지</th>
			<th>우편번호</th>
			<th>사업자소재지</th>
			<th>가입일자</th>
			<th>누적판매액</th>
			<th>누적예약수</th>
			<th>영업상태</th>
		</tr>
		<tr>   
			<td colspan="11">가입한 판매자가 없습니다.</td>
		</tr>
	</table>	
	
	<br/><br/>  
	<div style="border: solid 1px black;">
		<label>▶ 예약건수 및 판매액 추이(주 평균/보유 호텔 총합)</label>
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
				<input type="text" value="관리자이름" style="font-size: 8pt; width: 7%; margin-bottom: 5px;" class="short"  readonly  />  <%-- ${sessionScope.loginuser.name} --%>
				<input type="button" value="등록" style="font-size: 8pt; margin-left: 100;"/> 
			</div>
		<%-- <input type="hidden" name="pnum" value="${pvo.pnum}" />
		<input type="hidden" name="goBackURL" value="${goBackURL}" />  --%>
		</form>
	      
	</div>
	
</div>     