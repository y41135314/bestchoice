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
<title>여기는어때</title>


<style type="text/css">
body {
	font-family: Arial, Helvetica, sans-serif, 돋움;
}  

.navbar {   
	overflow: hidden;
	background-color: #F7323F;
	/* border: solid 1px black; */   
	position: fixed;   
	top: 0;
	height: 80px;
	padding: 20px 5% 0 5% ;   
}

#logo {  
	height: 45px;    
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
	color: white;
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
  color: white;
  background-color: inherit;
  font-family: inherit;             
  margin: 0;
  font-size: 16px !important;
}


.dropdown-content {
  display: none;
  position: absolute; 
  position: fixed;
  background-color: white;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 2; 
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


.navbar_active {
	background-color: white;
	color: black !important;
}

</style>


       
<script type="text/javascript">
	
	$(document).ready(function(){
		
		var navbarTop = $("#navbar").offset().top;		// navbar와 화면 상단 간의 위치값 알아온다.
		//	var navbarLeft = $("#navbar").offset().left;
			
			var scrollTop = 0;
			$(window).scroll(function(event){
				scrollTop = $(this).scrollTop();			// scroll bar 의 상단 값
			//  alert("scrollTop : "+scrollTop);
			//  alert("navbarTop : "+navbarTop);
				
			    if(scrollTop > navbarTop) {
			    //	alert("스크롤의 위치가 네비게이션위치 및 그이하로 떨어졌네요.");
					$("#navbar").addClass("navbar_active");
					// $("#navbar").css("border-bottom","solid 1px gray");
					$("#headertbl td > a").addClass("navbar_active");
					$(".dropbtn").addClass("navbar_active");
					$("#logo").attr("src", "<%=request.getContextPath()%>/resources/images/로고4.png");
				
				}
				else {
					$("#navbar").removeClass("navbar_active");
					$("#headertbl td > a").removeClass("navbar_active");
					$(".dropbtn").removeClass("navbar_active");
					$("#navbar").css("border-bottom","none");
					$("#logo").attr("src", "<%=request.getContextPath()%>/resources/images/로고3.png");
				}
			});
		
	}); // end of $(document).ready(function(){})=============================
	
</script> 


</head>

<body>                    
   
<div class="navbar" id="navbar">
 <table id="headertbl">
      <tr>
		<td><a href="main.bc"><img id="logo" src="<%=request.getContextPath()%>/resources/images/로고3.png"></a></td>
		
	  	<td width="70%"></td>
	     
		<td width="6%"><a href="#">내주변</a></td>
		
		<c:if test="${sessionScope.loginuser != null or (sessionScope.loginuser == null && sessionScope.loginseller == null && sessionScope.loginadmin == null) }">
			<td width="6%"><a href="#">예약내역&nbsp;</a></td>
		</c:if>
		
		<c:if test="${sessionScope.loginseller != null}">
			<td width="6%"><a href="#">예약현황&nbsp;</a></td>
		</c:if>
		
		<c:if test="${sessionScope.loginadmin != null}">
			<td width="6%"><a href="<%=ctxPath%>/salesStatistic.bc">매출현황&nbsp;</a></td>
		</c:if>
		
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
		
		<c:if test="${sessionScope.loginuser == null && sessionScope.loginseller == null && sessionScope.loginadmin == null}">  
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
			
			<td width="6%"><a class="logout" href="<%=ctxPath%>/main_logout.bc">로그아웃</a></td>
		</c:if>
		
		<c:if test="${sessionScope.loginseller != null }">  
			<td width="5%">
				<div class="dropdown">
	            <button class="dropbtn"><img class="loginIcon" src="./resources/images/ico_판매자.png">
	               <i class="fa fa-caret-down"></i>
	            </button>  
			    <div class="dropdown-content">
			      <a href="#">내정보</a>
			      <a href="#">예약현황</a>
			      <a href="#">숙소등록</a>
			    </div>
			</div>
			</td>
			
			<td width="6%"><a  class="logout" href="<%=ctxPath%>/main_logout.bc">로그아웃</a></td>
		</c:if>
		
		<c:if test="${sessionScope.loginadmin != null }">  
			<td width="5%">
				<div class="dropdown">
	            <button class="dropbtn"><img class="loginIcon" src="./resources/images/ico_관리자.png">
	               <i class="fa fa-caret-down"></i>
	            </button>  
			    <div class="dropdown-content">
			      <a href="<%=ctxPath%>/adminMember_list.bc">회원 관리</a>
			      <a href="<%=ctxPath%>/adminSeller_list.bc">판매자/상품 관리</a>
		          <a href="<%=ctxPath%>/adminCommentBoard.bc">관리자 게시판</a>
			    </div>
			</div>
			</td>
			
			<td width="6%"><a  class="logout" href="<%=ctxPath%>/main_logout.bc">로그아웃</a></td>
		</c:if>
         
	  </tr>
   </table> 
 
</div>   

