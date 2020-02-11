<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style type="text/css">
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
 		font-family: "Apple SD Gothic Neo","맑은 고딕","Malgun Gothic",sans-serif;
	  	display: inline-block;
	    margin-right: 16px;
	    padding: 0;
	    font-size: 16px;
	    font-weight: bolder;
   }
   
   .mh_hotel_info addr {
    display: inline-block;
   }
   
   .mh_hotel_info title {
    display: inline-block;
    
   }
</style>
<body>
	<div class="align_rt">
	        <input type="hidden" name="page" value="1">
	        <div>
	       		
	            <div class="point_show gra_red">
	                <span class="mhtitle" style="font-family: 'Jua', sans-serif, 돋움;">예약 내역</span>
	                <strong id="point-page-show"></strong>
	            </div>
			
	            <ul class="point_list"></ul>
	        </div>
	
	      	<c:if test="${sessionScope.loginuser != null}">
				<c:forEach var="reservaList" items="${reservationList}">						 	      	 
			      	 <div class="mh_hotel_info img" style=" border: solid 1px red; width: 500px; height:250px;">${reservaList.hotelImage_FileName}</div>
							<div class="mh_hotel_info title" style="font-size: 25px; padding-bottom: 10px;">${reservaList.hotel_Name}</div>
							<div class="mh_hotel_info addr">${reservaList.hotel_Addr1}${reservaList.hotel_Addr2}${reservaList.hotel_Addr3}${reservaList.hotel_Post}</div>
			     </c:forEach>
			    </c:if>
		        <div class="list_none">
		                       <br/>
		        </div>
		        
		        

	    </div>


</body>
</html>