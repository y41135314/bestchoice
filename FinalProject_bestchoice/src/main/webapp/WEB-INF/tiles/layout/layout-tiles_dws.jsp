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
		
		#tile_dws_container {
			
		}
		
		#tile_dws_header {
			/* border: solid 1px red; */
			height: 80px;
		}
		
		tile_dws_head_div {
			
		}
		
		#tile_dws_content {
			/* border: solid 1px blue; */
			width: 80%;
			margin:0 auto;
		}
		
		
		#tile_dws_footer {
			/* border: solid 1px green; */
			clear: both;
			margin-top: 100px;
		}
			
	</style>
  
</head>
<body>
	<div id="tile_dws_container">
		<div id="tile_dws_header">
			 <tiles:insertAttribute name="header" /> 
		</div>
		
		<div id="tile_dws_head_div">
			 <tiles:insertAttribute name="head_div" /> 
		</div>
		
		<div id="tile_dws_content">
			 <tiles:insertAttribute name="content" /> 
		</div>
		
		<div id="tile_dws_footer">
			 <tiles:insertAttribute name="footer" /> 
		</div>
	</div>
</body>
</html>



