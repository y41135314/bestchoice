<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>

#adminPage {
	clear: both;
	background-color: #F7323F;
	min-height: 110px;
	margin-top: 74px;
}   
			   
#header2{
	float: left;
	color: white;
	font-size: 30px;
	margin-top: 30px;   
	margin-left: 7%;
	width: 50%;   
}     

#adminInfo{
	font-size: 15px;
	color: white;  
	display: inline-block;
	position: relative;   
	left: 230px;
	top: 10px;
}  

#iconHeader {  
	float: right;
	width: 20%; 
	margin-right: 5%;
	display: inline-block;
}

</style>    

<div id="adminPage">    
	<p id="header2">  
			 매출 현황 
	</p> 
	
	<p id="adminInfo">
	안녕하세요<br/>
	관리자 <span style="font-weight: bold;"><%-- ${(sessionScope.loginadmin).name} --%></span> 님 
	</p>
		    
	<img id="iconHeader" style="height: 150px; width: 150px;" src="./resources/images/관리자헤더.png">

</div>