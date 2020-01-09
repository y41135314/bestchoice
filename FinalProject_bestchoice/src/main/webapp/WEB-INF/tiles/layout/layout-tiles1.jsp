<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === #24. tiles 를 사용하는 레이아웃1 페이지 만들기 === --%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	
	<style type="text/css">
		
		#tile1_container {
			
			/* border: solid 1px black; */
			
		}
		
		#tile1_header {
			/* border: solid 1px red; */
		}
		
		#tile1_content {
			/* border: solid 1px blue; */
			margin: 0 auto;
			width: 80%;
		}
		
		
		#tile1_footer {
			/* border: solid 1px green; */
			clear: both;
		}
			
	</style>
  
</head>
<body>
	<div id="tile1_container">
		<div id="tile1_header">
			 <tiles:insertAttribute name="header" /> 
		</div>
		
		<div id="tile1_content">
			 <tiles:insertAttribute name="content" /> 
		</div>
		
		<div id="tile1_footer">
			 <tiles:insertAttribute name="footer" /> 
		</div>
	</div>
</body>
</html>



