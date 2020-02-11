<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon&display=swap" rel="stylesheet"> 
<style>

#loginUserMyPage {
	clear: both;
	background-color: #F7323F;
	min-height: 110px;
	margin-top: 73px;  
}   
			   
#header2{
	float: left;
	color: white;
	font-size: 40px;
	margin-top: 35px;
	margin-left: 7%;
	width: 50%;   
}     

#adminInfo{
	float: left;
	font-size: 18px;
	color: white;  
	display: inline-block;
	position: relative;   
	left: 230px;
	top: 10px;
}  

#iconHeader {  
	float: right;
	width: 20%; 
	margin-right: 7%;
	display: inline-block;
	margin-top: 12px;
}

</style>    

<div id="loginUserMyPage">    
	<p id="header2"  style="font-family: 'Do Hyeon', sans-serif;">  
			 내정보
	</p> 
		  
	<p id="adminInfo" style="font-family: 'Do Hyeon', sans-serif;" >
	안녕하세요!  <span style="font-weight: bold;">${(sessionScope.loginuser).name}</span> 님 
	</p>
		    
		    
	<img id="iconHeader" style="height: 100px; width: 160px;" src="./resources/images/minha_images/userMyPagehder.png">

</div>