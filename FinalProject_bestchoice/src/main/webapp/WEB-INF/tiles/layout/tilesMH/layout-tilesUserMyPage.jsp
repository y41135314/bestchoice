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

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	
<style type="text/css">
html, body {
    
    font-family: "Apple SD Gothic Neo","맑은 고딕","Malgun Gothic",sans-serif;
    font-size: 14px;
    line-height: 1;
    color: rgba(0,0,0,0.87);
    margin: 0 auto;
}


#mysideinfo {
margin-left: 30px;
float: left;



}

#mycontent {
 padding-top: 137px;
 width: 724px;
 float: right;
 height: 1000px;


}
#myheader2 {
width: 100%;

}
</style>
  
  
</head>
<body>
	<div id="mycontainer">
		<div id="myheader">
			<tiles:insertAttribute name="header" />
		</div>
		
		<div id="myheader2">
			<tiles:insertAttribute name="header2" />
		</div>
		
		<div id="mycontent" >
			<tiles:insertAttribute name="content" />
		</div>
		
		<div id="mysideinfo">
			<tiles:insertAttribute name="sideinfo" />
		</div>
		
		<div id="myfooter" style="margin-top:1000px;">
			<tiles:insertAttribute name="footer" />
		</div>
	</div>
</body>
</html>



