<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
 String ctxPath = request.getContextPath();
%> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon&display=swap" rel="stylesheet">
<style type="text/css">

.sidenav {
 display: inline-block;
}
.my_wrap {
    padding-top: 54px;
}
.sidenav nav {
  padding-top: 15px;
  height: 100%;
  width: 238px;
  z-index: 1;
  overflow-x: hidden;
  padding-left: 0;
   float: left;
   text-decoration: none;
}

.sidenav a {
  display: block;
  font-size: 25px;
  color: rgba(0,0,0,0.56);
  text-decoration: none;
  height: 18px;
  margin: 15px;
 font-weight: bolder;
 font-family: 'Do Hyeon', sans-serif;
}


.sidenav a:hover {
  color: #f7323f;
}

 .sidenav {
 
  font-size: 25px;
  position: relative;
  padding: 100px 0px 50px;
  width: 238px;
  height: 1000px;

  
  
} 
</style>
</head>
<script type="text/javascript">


</script>
<body>

<div class="sidenav sub_wrap my_wrap">
  <nav>
        <ul>
            <li><a href="<%=ctxPath%>/myPoint.bc">포인트</a></li>
            <li><a class="" href="<%=ctxPath%>/myCoupon.bc">쿠폰함</a></li>
            <li><a class="" href="<%=ctxPath%>/myReservation.bc">예약 내역</a></li>
            <li><a class="active" href="<%=ctxPath%>/myPage.bc">내 정보 관리</a></li>
            <!-- <li><a class="active" href="/my/mypage">내 정보 관리</a></li> -->
        </ul>
    </nav>
</div>
</body>
</html>