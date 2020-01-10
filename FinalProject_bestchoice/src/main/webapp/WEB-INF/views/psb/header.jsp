<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">  
<title>Spring 에서 Transaction(트랜잭션)처리 테스트</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  
<style type="text/css">
body {
	font-family: Arial, Helvetica, sans-serif, 돋움;
}  

.navbar { 
	overflow: hidden;
	background-color: white;
	/* border: solid 1px black; */
	position: fixed;   
	top: 0;
	height: 80px;
	padding: 20px 5% ;   
}

#logo {  
	height: 35px;    
	width: 150px;
}   
/*   
#headertbl, td {
	border: solid 1px black;
}
*/
#headertbl {
    border-collapse: collapse;
    width: 100%;   
    text-align: center;
 }
    
#headertbl td > a {     
	font-size: 16px;
	color: #404040;
	text-align: center;        
	text-decoration: none;
	font-weight: bold; 
}    

#headertbl td > a:hover {     
	font-weight: bold;          
}   
 
.dropdown {
  overflow: hidden;
  font-weight: bold; 
}   

.dropdown:hover{
  font-weight: bold;
}

.dropdown .dropbtn {
  border: none;  
  outline: none;
  color: #404040;
  background-color: inherit;
  font-family: inherit;             
  margin: 0;
  font-size: 16px !important;
}


.dropdown-content {
  display: none;
 /* position: absolute; */
  position: fixed;
  background-color: white;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown-content a {
  float: none;
  color: #404040;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  text-align: left;  
}

.dropdown-content a:hover {
  background-color: white;
  color: #ffb3b3;
}

.dropdown:hover .dropdown-content {
  display: block;
}
   
.loginIcon {
	height: 30px;
	width: 30px;
}   
/* ////////////////////////////////////////// */
.footer {
	background-color: #333333;
	text-align: left;
	line-height: 2;
	padding: 20px 5% 20px 5%;
	color: white;
	width: 100%;
	font-size: 13px;
}  
   
.footer a {
	color: #ccc;
	text-decoration: none;
}

.footer a:hover {
	cursor: pointer;
}


/* ////////////////////////////////////////// */
</style>      
    
<script type="text/javascript" src="<%=ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>

<script type="text/javascript">
	
	/* $(document).ready(function(){
	
	}); // end of $(document).ready(function(){})=============================
	 */
</script>

</head>

<body>                  
   
<div class="navbar" id="navbar">
 <table id="headertbl">
      <tr>
		<td><a href="main.bc"><img id="logo" src="./resources/images/로고.PNG"></a></td>
		
	  	<td width="70%"></td>
	     
		<td width="6%"><a href="#">내주변</a></td>
		<td width="6%"><a href="#">예약내역&nbsp;</a></td>
		
		<td width="6%">        
		 	<div class="dropdown">
	            <button class="dropbtn">더보기
	               <i class="fa fa-caret-down"></i>
	            </button>  
			    <div class="dropdown-content">
			      <a href="#">공지사항</a>
			      <a href="#">이벤트</a>
			      <a href="#">자주 묻는 질문</a>
			      <a href="#">1:1문의</a>
			      <a href="#">약관 및 정책</a>
			    </div>
			</div>
		</td>
		
		<c:if test="${sessionScope.loginuser == null}">  
			<td width="5%"><a href="#">로그인</a></td>
			<td width="6%"><a href="#">회원가입</a></td>
		</c:if>
		
		<c:if test="${sessionScope.loginuser != null }">  
			<td width="5%">
				<div class="dropdown">
	            <button class="dropbtn"><img class="loginIcon" src="./resources/images/ico_사용자.png">
	               <i class="fa fa-caret-down"></i>
	            </button>  
			    <div class="dropdown-content">
			      <a href="#">내정보</a>
			      <a href="#">포인트</a>
			      <a href="#">쿠폰함</a>
			      <a href="#">예약내역</a>
			      <a href="#">최근 본 숙소</a>
			    </div>
			</div>
			</td>
			
			<td width="6%"><a href="<%=ctxPath%>/logout.bc">로그아웃</a></td>
		</c:if>
		
		<%-- <c:if test="${sessionScope.loginuser.userid == 'admin'}">  
			<td width="5%">
				<div class="dropdown">
	            <button class="dropbtn"><img class="loginIcon" src="./resources/images/ico_관리자.png">
	               <i class="fa fa-caret-down"></i>
	            </button>  
			    <div class="dropdown-content">
			      <a href="#">회원 관리</a>
			      <a href="#">판매자/상품 관리</a>
			    </div>
			</div>
			</td>
			
			<td width="6%"><a href="#">로그아웃</a></td>
		</c:if>
         --%>
	  </tr>
   </table> 
</div>   

<div style="margin-top: 80px; height: 1000px; padding: 0 5%;">