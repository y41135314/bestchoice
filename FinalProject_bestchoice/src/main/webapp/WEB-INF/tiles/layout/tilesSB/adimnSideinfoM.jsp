<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>      
<style>
.sidenav {
	margin-top: 15px;
	font-family: Arial, Helvetica, sans-serif, 돋움;
	font-size: 20px;  
}
.sidenav a {
	display: block;
	text-decoration: none;
/* 	background-color: white; */
/* 	color: #F7323F; */
	color: rgba(0,0,0,0.56);
	width: 150px;
	height: 30px;
	font-weight: bold;
	text-align: center;
	margin-bottom: 20px;
	font-size: 18px;
	vertical-align: middle !important;
	padding: 5px 0;
}  

</style>
    
<script>

</script>
    
<div class="sidenav">
	<a id="adminMemberListBTN" href="<%=ctxPath%>/adminMember_list.bc">회원 리스트</a>
	<a id="adminMemberChartBTN" href="<%=ctxPath%>/adminMember_chart.bc">회원 통계</a>
	
	<!-- 
	<p class="sideDropdown">Dropdown 
	  <i class="fa fa-caret-down"></i>
	</p>
	<div class="sideDropdown-container">
	  <a href="#">Link 1</a>
	  <a href="#">Link 2</a>
	  <a href="#">Link 3</a>
	</div>
	
	<a href="#contact">Search</a>
	 -->
</div>