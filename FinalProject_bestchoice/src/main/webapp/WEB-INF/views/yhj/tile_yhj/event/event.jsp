<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 이벤트 | 여기는어때</title>

<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Jua&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>


<style type="text/css">

	@media ( max-width : 991px) {
		
		#event_container {
			width: 100%;
			margin:0 auto;
		}
	
		#event_sideinfo ul {
			display:none;
			list-style: none;
			padding: 30px 0;
		}
		
		#event_sideinfo ul li {
			margin-bottom: 20px;
			font-family: 'Jua', sans-serif;
			font-size: 16pt;
		}
		
		#event_sideinfo ul li a {
			text-decoration: none;
			color:  #bfbfbf;
			word-spacing: -2px;
		}
		
		#event_body {
			padding: 30px 0;
		}
		
		#event_body table {
			width: 90%;
		}
		
		#event_body table td {
			padding-left: 20px;
			padding-bottom: 20px;
			text-align: left;
			line-height: 1.7;
		}
		
		#event_body table td button {
			border: solid 2px black;
			background-color: white;
			padding: 5px 15px;
			font-weight:bold;
			
		}
		
		.event_title {
			font-weight: bold;
			font-size: 15pt;
		}
		
		.event_period {
			color: #999999;
		}
		
		.event_mainImg {
			width: 100%;
			cursor: pointer;
		}
		
		.event_mainImgEnd {
			width: 100%;
			opacity: 0.1;
		}
		
		.admin_buttons {
			border: solid 2px black;
		    color: black;
		    padding: 3px 10px;
		    background-color: white;
		    font-family: 'Nanum Gothic',sans-serif;
		}	
		
	}


	
	@media ( min-width : 992px) {

		#event_container {
			width: 80%;
			margin:0 auto;
		}
	
		#event_sideinfo ul {
			list-style: none;
			padding: 30px 0;
		}
		
		#event_sideinfo ul li {
			margin-bottom: 20px;
			font-family: 'Jua', sans-serif;
			font-size: 16pt;
		}
		
		#event_sideinfo ul li a {
			text-decoration: none;
			color:  #bfbfbf;
			word-spacing: -2px;
		}
		
		#event_body {
			width:70%;
			float:left; 
			padding: 30px 0;
		}
		
		#event_body table {
			width: 90%;
		}
		
		#event_body table td {
			padding-left: 20px;
			padding-bottom: 20px;
			text-align: left;
			line-height: 1.7;
		}
		
		#event_body table td button {
			border: solid 2px black;
			background-color: white;
			padding: 5px 15px;
			font-weight:bold;
			
		}
		
		.event_title {
			font-weight: bold;
			font-size: 15pt;
		}
		
		.event_period {
			color: #999999;
		}
		
		.event_mainImg {
			width: 100%;
			cursor: pointer;
		}
		
		.event_mainImgEnd {
			width: 100%;
			opacity: 0.1;
		}
		
		.admin_buttons {
			border: solid 2px black;
		    color: black;
		    padding: 3px 10px;
		    background-color: white;
		    font-family: 'Nanum Gothic',sans-serif;
		}	
			
	}



		
	
	
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
		
		
	});
	
	function goEventDetail(number){
		
		location.href= "<%= request.getContextPath()%>/event/detail.bc?no="+number;
	}
	
	
	
	
</script>

</head>
<body>

	<div id="event_container">
		
			<div id="event_sideinfo" style="width:20%;float:left;">
		    	
		        <ul>
		        	<li><a href="<%=request.getContextPath()%>/notice/main.bc">공지사항</a></li>
		        	<li><a href="<%=request.getContextPath()%>/event/main.bc" style="color: red;">이벤트</a></li>
		            <li><a href="<%=request.getContextPath()%>/question/main.bc">자주 묻는 질문</a></li>
		            <li><a href="<%=request.getContextPath()%>/faq/main.bc">1대1 문의</a></li>
		        </ul>
		        
		    </div>
		    
			<div id="event_body" >
				
				<table>
					<c:if test="${ eventList != null }">
						<c:forEach var="map" items="${ eventList }" > 
							<tr>
								<td>
									<div class="event_title">${ map.event_name }</div>
									
									<div class="event_period">기간: ${map.event_startday } ~ ${map.event_endday }</div>
									
									<c:if test="${ map.event_status == 1 }">
										<img class="event_mainImg" onclick="goEventDetail('${map.event_code}')" 
										src="<%= request.getContextPath()%>/resources/images/yhj/event/${ map.wasfilename }">
									</c:if>
									<c:if test="${ map.event_status == 2 }">
										<img class="event_mainImgEnd"  
										src="<%= request.getContextPath()%>/resources/images/yhj/event/${ map.wasfilename }">
									</c:if>
									
									
								</td>
							</tr>
						</c:forEach>
					</c:if> 
					
					<c:if test="${ eventList == null }">
						<tr>
							<td>
								작성된 이벤트가 없습니다.
							</td>
						</tr>
					</c:if>
				</table>
				<div id="event_write" style="text-align: right; padding:20px 0;">
					<c:if test="${ sessionScope.loginadmin != null }">
						<button class="admin_buttons" type="button" onclick="javascript:location.href='<%= request.getContextPath()%>/event/write.bc'">이벤트 작성하기</button>
					</c:if>
					
					
				</div>
				<div id="event_pageBar">
					
				</div>
				
			</div>
	</div>		
</body>	
</html>