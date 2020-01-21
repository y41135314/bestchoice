<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
#memberDetail {
 /* 	border: solid 1px black; */
 	min-height: 500px;   
 	/* margin-top: 200px; */
 	margin-top: 10px;
 	margin-bottom: 30px;
 }
 #adminMemberListBTN{
 	color: #F7323F;
 }
 #tableMemberDetail {
 	border: solid 1px black;
 	border-collapse: collapse;  
 	width: 100%;
 	margin-top: 10px;
 }
 
 #tableMemberDetail tr, #tableMemberDetail th, #tableMemberDetail td  {
 	border: solid 1px black;
 }
 
 #tableMemberDetail th {
 	text-align: center;
 }
 
</style>

<script>
	$(document).ready(function(){
		$("#adminMemberChartBTN").bind("mouseover", function(){	
			$("#adminMemberChartBTN").css({"color":"white","background-color":"#F7323F"});
		})
		$("#adminMemberChartBTN").bind("mouseout", function(){
			$("#adminMemberChartBTN").css({"color":"rgba(0,0,0,0.56)","background-color":"white"});
		}) 
		
		$("#adminMemberListBTN").bind("mouseover", function(){	
			$("#adminMemberListBTN").css({"color":"white","background-color":"#F7323F"});
		})
		$("#adminMemberListBTN").bind("mouseout", function(){	
			$("#adminMemberListBTN").css({"color":"#F7323F","background-color":"white"});
		})

	})
</script>

<div id="memberDetail">
	<label style="font-size: 16px;">◎ 회원 상세 내역</label>
   <!--  ID, 회원명,  휴대폰, 이메일, 가입일, 성별, 생년월일, 누적예약수, 누적 결제금액, 최근 결제한 날짜, 회원상태  -->
   <br/>
   <input type="button" value="회원리스트페이지로" onclick="location.href='<%=request.getContextPath()%>/adminMember_list.bc'" style="font-size: 8pt;"/> 
   &nbsp;&nbsp;|&nbsp;&nbsp;
   <input type="button" value="예약내역 보기" onclick="location.href='<%=request.getContextPath()%>/adminReservList.bc'" style="font-size: 8pt;"/> 

   <table id="tableMemberDetail">
		<tr>
			<th>ID</th>
			<th>이름</th>
			<th>이메일</th>
			<th>휴대폰번호</th>
			<th>가입일자</th>
			<th>성별</th>
			<th>나이</th>
			<th>생년월일</th>
			<th>누적결제액</th>
			<th>누적예약수</th>
			<th>최근결제일</th>
			<th>가입상태</th>
		</tr>
		<tr>   
			<td colspan="12">가입된 회원이 없습니다.</td>
		</tr>
	</table>	
	     
	<br/>  
	<label>▶회원 적립금 : </label> <input type="text" style="width: 100px;"value=""/>원 &nbsp;<input type="button" value="수정" style="font-size: 8pt;"/> 
	
</div>    