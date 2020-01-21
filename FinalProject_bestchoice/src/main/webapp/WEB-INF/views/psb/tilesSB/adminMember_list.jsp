<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
 #adminMemberList {
 /* 	border: solid 1px black; */
 	min-height: 500px;   
 	/* margin-top: 200px; */
 	margin-top: 10px;
 	margin-bottom: 30px;
 }
 
 #adminMemberListBTN{
 	color: #F7323F;
 }
 
 #tableMemberList {
 	border: solid 1px black;
 	border-collapse: collapse;  
 	width: 100%;
 	margin-top: 10px;
 }
 
 #tableMemberList tr, #tableMemberList th, #tableMemberList td  {
 	border: solid 1px black;
 }
 
 #tableMemberList th {
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

<div id="adminMemberList">
	<div>
		<label style="font-size: 16px;">◎ 회원 리스트 (총 : <span></span>명)</label>
		<br/>
		<form >
		<input type="button" value="검색" style="margin: 15px;"/> 
		<label>성별 :</label> 
			남&nbsp;<input type="checkbox"/>
			여&nbsp;<input type="checkbox"/>
		&nbsp;&nbsp;|&nbsp;&nbsp;
		<label>나이 : </label> 
			10대미만&nbsp;<input type="checkbox"/>
			20대&nbsp;<input type="checkbox"/>
			30대&nbsp;<input type="checkbox"/>
			40대&nbsp;<input type="checkbox"/>
			50대&nbsp;<input type="checkbox"/>
			60대&nbsp;<input type="checkbox"/>
			70대이상&nbsp;<input type="checkbox"/>
		&nbsp;&nbsp;|&nbsp;&nbsp;
		<label>기간선택 : </label>     
		<input type="date" style="width: 130px;"/> ~ <input type="date" style="width: 130px;"/>
		<br/>  
		<select name="" id="" style="height: 20px; margin-left: 80px;">
			<option value="">ID</option>
			<option value="">이름</option>
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
		<label>검색된 회원 : </label>&nbsp;총&nbsp;<span></span>명
		  
        <input type="button" value="엑셀다운" style="float:right; font-size: 8pt; z-index: 1;" /> 
		</form>
		
		<table id="tableMemberList">
			<tr>
				<th>ID</th>
				<th>이름</th>
				<th>이메일</th>
				<th>휴대폰번호</th>
				<th>가입일자</th>
				<th>성별</th>
				<th>나이</th>
				<th>누적결제액</th>
				<th>누적예약수</th>
			</tr>
			<tr>   
				<td colspan="9">가입된 회원이 없습니다.</td>
			</tr>
		</table>
		
	</div>
	
		<input type="button" value="상세내역GO" onclick="location.href='<%=request.getContextPath()%>/memberDetail.bc'"  style="position: relative; left: 25%; font-size: 8pt; " /> 
	
</div>   