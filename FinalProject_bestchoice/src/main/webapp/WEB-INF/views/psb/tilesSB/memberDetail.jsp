<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
 	padding: 5px;
 }
 
 #tableMemberDetail th {
 	text-align: center;
 }
 
</style>

<script type="text/javascript">
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

		// 적립금 - 천단위 콤마
		var memberPoint = $("#memberPoint").val();
		memberPoint = comma(memberPoint);
		$("#memberPoint").val(memberPoint);
		
		// 적립금 변경 
		$("#pointUpdateBtn").click(function(){
			var frm = document.memberPointFrm;
			frm.method="POST";
			frm.action="memberPointUpdate.bc?member_idx=${membervo.member_idx}";
			frm.submit();
		})
		
	})
	
	// 천 단위 콤마 함수 
	function comma(obj) {
        var regx = new RegExp(/(-?\d+)(\d{3})/);
        var bExists = obj.indexOf(".", 0);//0번째부터 .을 찾는다.
        var strArr = obj.split('.');
        while (regx.test(strArr[0])) {//문자열에 정규식 특수문자가 포함되어 있는지 체크
            //정수 부분에만 콤마 달기 
            strArr[0] = strArr[0].replace(regx, "$1,$2");//콤마추가하기
        }
        if (bExists > -1) {
            //. 소수점 문자열이 발견되지 않을 경우 -1 반환
            obj = strArr[0] + "." + strArr[1];
        } else { //정수만 있을경우 //소수점 문자열 존재하면 양수 반환 
            obj = strArr[0];
        }
        return obj;//문자열 반환
    }

</script>

<div id="memberDetail">
	<label style="font-size: 16px;">◎ 회원 상세 내역</label>
   <!--  ID, 회원명,  휴대폰, 이메일, 가입일, 성별, 생년월일, 누적예약수, 누적 결제금액, 최근 결제한 날짜, 회원상태  -->
   <br/>
   <input type="button" value="회원리스트페이지로" onclick="location.href='<%=request.getContextPath()%>/adminMember_list.bc'" style="font-size: 8pt;"/> 
   &nbsp;&nbsp;|&nbsp;&nbsp;
   <input type="button" value="예약내역 보기" onclick="location.href='<%=request.getContextPath()%>/adminReservList.bc?searchType=fk_member_idx&searchWord=${membervo.member_idx}&startDate=&endDate=&res_startday=&res_startdayEnd='" style="font-size: 8pt;"/> 

   <table id="tableMemberDetail" style="text-align: center;">
		<tr style="background-color: #FAFAFA;">
			<th>회원번호</th>
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
			<td>${membervo.member_idx}</td>
			<td>${membervo.name}</td>
			<td>${membervo.email}</td>
			<td>${membervo.hp1}-${membervo.hp2}-${membervo.hp3}</td>
			<td>${membervo.registerday}</td>
			<td>
				<c:if test="${membervo.gender == 1}">
				남
				</c:if>	
				<c:if test="${membervo.gender == 2}">
				여
				</c:if>	
			</td>
			<td>${membervo.age}</td>
			<td>${membervo.birthday}</td>
			<td><fmt:formatNumber value="${membervo.totalPrice}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${membervo.totalCount}" pattern="#,###"/></td>   
			<td>${lastDate}</td>
			<td>${membervo.mstatus}</td>
		</tr>
	</table>	
	     
	<br/>      
	<label>▶회원 적립금 : </label>   
	<form name="memberPointFrm" style="display: inline-block;">
	    <input type="text" name="memberPoint" id="memberPoint" style="width: 100px; text-align: right;" value="${memberPoint}" />원 &nbsp;
	    <input type="button" value="수정" id="pointUpdateBtn" style="font-size: 8pt;"/> 
 	</form>
</div>    