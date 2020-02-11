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
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon&display=swap" rel="stylesheet">
<style type="text/css">

.point_show {
    padding-bottom: 21px;
    border-bottom: 1px solid rgba(0,0,0,0.2);
    background: none;
    color: rgba(0,0,0,0.87);
    text-align: left;
    margin-bottom: 10px;

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
   

        
   }
	/* 보유쿠폰 글씨   */
   .mhtitle{
   font-family: 'Do Hyeon', sans-serif;
    display: inline-block;
    margin-right: 16px;
    padding: 0;
    font-size: 25px;
   }
   
   /* 쿠폰내역 제목들 */
   .cu_title{
   font-size: 16px;
   font-weight: bold;
    padding-bottom: 10px;
    margin-top: 30px;

    
   }
.cu_title a{
 font-size: 16px;
 font-weight: bold;
}

.cuList{


}


.cuList3{
width:230px;

}
.cuList2{
width: 180px;

}
.cuList1{
width: 280px;

}
</style>
<body>
	<div class="align_rt">
	        <input type="hidden" name="page" value="1">
	        <div>
	       		
	       		<c:if test="${(sessionScope.loginuser) != null}">
	       			
		            <div class="point_show gra_red">
		                <span class="mhtitle" style="font-family: 'Do Hyeon', sans-serif; font-size: 25px;">보유쿠폰 </span>
		                <strong id="point-page-show"></strong>
		            </div>
				</c:if>
	            <ul class="point_list"></ul>
	        </div>
	
	        <!-- 리스트 없을시 -->
	         <%-- <c:if test="${point == null}"> --%>
	         <c:if test="${CouponList == null}">	     
		        <div class="list_none">
		                        가지고 있는 쿠폰이 없습니다.<br/>
		        </div>
	      	 </c:if>
	      	 
	      	 <table>
		      	 <thead>
			      	 
			      	 
			      	 

				<br/><br/>
				<table style=" font-size: 13pt;">
			      <tr style="margin-left: 25px;">
					 		<td class="cuList1">쿠폰명</td>
					 		<td class="cuList2" >쿠폰 할인금액</td>
					 		<td class="cuList3">쿠폰 만료일</td>
				  </tr>
				 </table>
					 	<br/><br/>
			<c:if test="${CouponList != null}">
				 	<c:forEach var="coupoun" items="${CouponList}" >	
				
				 	
				 	
					<table style="font-size: 12pt;">
						
					 	<tr style="margin-left: 25px; margin-top:15px;">
					 		<td class="cuList1" style=" padding-top: 15px;">${coupoun.coupon_name}</td>
					 		<td class="cuList2" style="text-align: center;" ><fmt:formatNumber value="${coupoun.coupon_discountMon}" pattern="###,###" /></td>
					 		<td class="cuList3">${coupoun.coupon_endday}</td>
					 	</tr>
					</table>
			      	 </c:forEach>
			      </c:if>	 	
		      	 </thead>	
	      	 </table>
	    </div>


</body>
</html>