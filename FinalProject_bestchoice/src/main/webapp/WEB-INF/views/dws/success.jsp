<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
	String ctxPath = request.getContextPath();
%>
    <!--  확인용 -->
<!DOCTYPE HTML>
<html>
<head>
	<title>여긴어때</title>

	<!-- css -->
  
    <link href="<%= ctxPath %>/resources/css/reset.css" rel="stylesheet">
    <link href="<%= ctxPath %>/resources/css/reserve.css" rel="stylesheet">
      <!-- jQuery -->
	  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
	  <!-- iamport.payment.js -->
	  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	  
	<script>
		
	</script>
	
	
</head>
<!-- 뷰단   -->


<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
th, td {
  padding: 5px;
  text-align: left;    
}
</style>


<body>
    <div id="content">
        <div class="reserve">
		  
		  
     <h1>결제 완료</h1>
	<p>결제 내역 확인.</p>
	
	<table style="width:100%">
	  <tr>
	    <th>숙소이름:</th>
	    <td>  <p class="txt">${roomMap.hotel_name}</p></td>
	  </tr>
	  <tr>
	    <th rowspan="2">객실타입</th>
	    <td> <p class="txt">${roomMap.room_name}</p></td>
	  </tr>
	  <tr>
	    <td>1박</td>
	  </tr>
	    <tr>
	    <th>결제금액:</th>
	    <td> <p class="txt">${roomMap.room_name}</p></td>
	  </tr>
	</table>
		 <button><a href="<%=request.getContextPath()%>/main.bc" style="color: red;">홈으로</a></button>
       
       </div>
        </div>
        
        

</body>
</html>
