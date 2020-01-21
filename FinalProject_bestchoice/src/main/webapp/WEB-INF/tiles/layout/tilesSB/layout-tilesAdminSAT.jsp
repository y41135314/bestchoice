<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === #25. tiles 를 사용하는 레이아웃2 페이지 만들기 === --%>
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
	
		#tile2_container {
			
		}
		
		#tile2_header {
			
		}
		
		#tile2_content {
			width: 100%;
			/* border: solid 1px red; */
			 display:inline-block;
		}
		
		#tile2_footer {
			clear: both;
		}	
		
/* ////////////////////////////////////////// */

</style>
  
  
</head>
<body>
	<div id="tile2_container">
		<div id="tile2_header">
			<tiles:insertAttribute name="header" />
		</div>

		<div id="title3_header"> 
			<tiles:insertAttribute name="header2" />
    	</div>	
    	
		<div style="padding: 30px 5%; margin: 0 auto;">
			
			<div id="tile2_content">
				<tiles:insertAttribute name="content" />
			</div>
		</div>
		
		<div id="tile2_footer">
			<tiles:insertAttribute name="footer" />
		</div>
	</div>
</body>
</html>



