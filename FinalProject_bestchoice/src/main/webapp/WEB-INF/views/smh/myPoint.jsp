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
.point_show span {
    display: inline-block;
    margin-right: 16px;
    padding: 0;
    font-size: 16px;
    font-weight: bold;
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
	    font-size: 20px;
	    font-weight: bold;
   }
   
</style>
<body>
	<div class="align_rt">
	        <input type="hidden" name="page" value="1">
	        <div>
	       		
	            <div class="point_show gra_red">
	                <span class="mhtitle ">사용 가능 포인트 </span>
	                <span style="float:right; color:#F7323F; font-weight: bolder; font-size: 18pt;">
	              	<%-- ${point} --%><fmt:formatNumber value="${point}" pattern="###,###"/>
	                </span>
	                <strong id="point-page-show"></strong>
	            </div>
			
	            <ul class="point_list"></ul>
	        </div>
	
	        <!-- 리스트 없을시 -->
	         <c:if test="${point == null}">
		        <div class="list_none">
		                        적립된 포인트가 없습니다<br/>
		        </div>
	        </c:if>
	    </div>


</body>
</html>