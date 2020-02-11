<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   

<%
   String ctxPath = request.getContextPath(); 
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon&display=swap" rel="stylesheet">
<style type="text/css">

body{
height: 2000px;;
}

.point_show {
    padding-bottom: 21px;
    border-bottom: 1px solid rgba(0,0,0,0.2);
    background: none;
    color: rgba(0,0,0,0.87);
    text-align: left;
}

.point_show strong {
    display: inline;
    font-size: 18px;
    color: rgb(230,28,81);
}
.list_none {
    background: none;
    padding-top: 125px;
    font-size: 20px;
    font-weight: bold;
}

ul{
   list-style:none;
   }
   
 .mhtitle{
	  	display: inline-block;
	    margin-right: 16px;
	    padding: 0;
	    font-size: 25px;
	    font-family: 'Do Hyeon', sans-serif;
   }
   

   .hotel_img {
   margin-top: 30px;
   margin-bottom: 15px;
   
   } 
   
	
   
   .mh_hotel_info_box{
    width: 500px;
   
  	width: 502px;

   }
   
  .mh_hotel_info > title{
    font-weight: 5;
    font-size: 25px;
    line-height: 1.1;
    color: #000;
    letter-spacing: -2px;
    word-spacing: 3px;

}

.list_none {
    background: none;
    padding-top: 125px;
    font-size: 20px;
    font-weight: bold;
    font-family: 'Do Hyeon', sans-serif;
}

    
</style>
<body>
	<div class="align_rt" style="display: inline-block;">
	        <input type="hidden" name="page" value="1">
	        <div>
	       		
	            <div class="point_show gra_red">
	                <span class="mhtitle">예약 내역</span>
	                <strong id="point-page-show"></strong>
	            </div>
			
	            <ul class="point_list"></ul>
	        </div>
			
			<div class="mh_hotel_info_box">
		      	<c:if test="${sessionScope.loginuser != null}">
					<c:forEach var="reservaList" items="${reservationList}">						 	      	 
				      	 <div class="mh_hotel_info img"><img class="hotel_img" style="width: 500px; height:240px;" src="<%= ctxPath%>/resources/images/kmt/hotelImage/${reservaList.hotelImage_wasFileName}" /></div>
								<strong class="mh_hotel_info title" style="font-size: 25px; padding-bottom: 10px; display: block;">${reservaList.hotel_Name}</strong>
								<span class="mh_hotel_info addr">${reservaList.hotel_Addr1}${reservaList.hotel_Addr2}${reservaList.hotel_Addr3}${reservaList.hotel_Post}</span>
				     </c:forEach>
				    </c:if>		 
			</div>  
		        <c:if test="${reservationList == null}">
		        <div class="list_none">예약된 내역이 없습니다.</div>
		        </c:if>
		        

	    </div>
	    
	    
	    
	    


</body>


</html>