<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String ctxPath = request.getContextPath();
%>
    
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
<body>
    <div id="content">
    	
        <div class="reserve">
        	결제 성공 
        </div>

    </div>

</body>
</html>
    