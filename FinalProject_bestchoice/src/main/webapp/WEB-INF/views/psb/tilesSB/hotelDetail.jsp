<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
    
<style>
 #hotelDetail {
 	/* border: solid 1px black; */
 	min-height: 500px;   
 	/* margin-top: 200px; */
 	margin-top: 10px;
 	margin-bottom: 30px;
 }
 
  #pHotel {
	background-color: #555555;
	color: #B7B7B7;
}

 #hotelListBtn{
 	color: #F7323F;
 }
 
 #tableHotelDetail {
 	border: solid 1px black;
 	border-collapse: collapse;  
 	width: 100%;
 	margin-top: 10px;
 }
 
 #tableHotelDetail tr, #tableHotelDetail th, #tableHotelDetail td  {
 	border: solid 1px black;
 	padding: 5px;
 }
 
 #tableHotelDetail th {
 	text-align: center;
 }
 
 #sellerNameBtn{
 	color: #ff6666;
 }
 
 #sellerNameBtn:hover{
 	color: #ffb3b3;
 	cursor: pointer;
 }
 
</style>
<script>
	$(document).ready(function(){
		
		$("#divHotel").css("border-bottom", "solid 1px #555555");
		$("#divSeller").css("border", "none");
		$("#divHotel2").show();  
		$("#divSeller2").hide();  
		
		$("#hotelListBtn").bind("mouseover", function(){	
			$("#hotelListBtn").css({"color":"white","background-color":"#F7323F"});
		})
		$("#hotelListBtn").bind("mouseout", function(){	
			$("#hotelListBtn").css({"color":"#F7323F","background-color":"rgba(225,225,225,0.0)"});
		})
		         
		$(".title").css({"color": "#ff6666"});
			
		$(".title").bind("mouseover",function(event){
			var $target = $(event.target); 
			$target.css({"font-weight":"bold", "cursor":"pointer", "color":"#ffb3b3"});
		});
		
		$(".title").bind("mouseout",function(event){
			$(".title").css({"font-weight":"normal", "color": "#ff6666"});
		});  
		  
		$("#btnWrite").click(function(){
			// 글제목 유효성 검사
			var title = $("#title").val().trim();
			if(title == "") {
				alert("제목을 입력하세요!!");
				return;
			}
			
			var contentval = $("#content").val();
	        if(contentval == "" || contentval == "<p>&nbsp;</p>") { 
	        	alert("글내용을 입력하세요!!");
	        	return;
	        }
	       
			var form_data = $("form[name=adminComment]").serialize(); // 폼에 있는 name 값이 키워드가 되어 데이터가 된다.
				
			$.ajax({
				url: "<%= request.getContextPath() %>/addHotelComment.bc",
				data: form_data,
				type: "POST",
				dataType: "JSON",
				success: function(json){
					location.reload();
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			})
		});
		
		chart_Hotel_MonthlyPrice();
		
	}); // end of document====================================
	
	function goView( adminBoard_idx,rno) {
		var frm = document.goViewFrm;
		frm.adminBoard_idx.value = adminBoard_idx ;
		frm.rno.value=rno;
		frm.method="GET";
		frm.action="adCommentDetail.bc";
		frm.submit();
	};
	
	function chart_Hotel_MonthlyPrice(){
		$.ajax({
			url: "<%= request.getContextPath() %>/chart_HotelMonthlyPrice.bc",
			data: {"hotel_idx" : ${hotelvo.hotel_idx} },
			dataType: "JSON",
			success:function(json){
				
				var resultArrPrice = [] ; 
				var resultArrCount = []; 
				
				var Day = "";
				for (var i = 0; i < json.length; i++) {		
					Day += json[i].MONTH;
				}	
				
			    var bool = Day.includes('2019-03');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {    
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2019-03' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2019-04');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2019-04' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2019-05');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2019-05' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2019-06');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2019-06' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2019-07');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2019-07' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2019-08');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2019-08' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2019-09');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2019-09' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2019-10');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2019-10' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2019-11');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2019-11' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2019-12');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2019-12' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2020-01');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2020-01' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
					
				}
			    var bool = Day.includes('2020-02');
				if ( ! bool ){
					resultArrPrice.push(0);
					resultArrCount.push(0);
				}else {
					for (var i = 0; i < json.length; i++) {
						if( json[i].MONTH == '2020-02' ){
							resultArrPrice.push(json[i].totalPrice);
							resultArrCount.push(json[i].totalCount);
		        	 	}
					}
				}
				
				Highcharts.setOptions({

					lang: {

						thousandsSep: ','

					}

				});
				
				Highcharts.chart('chart_HotelMontlyPrice', {
				    chart: {
				        zoomType: 'xy'
				    },
				    title: {
				        text: ''
				    },
				    subtitle: {
				        text: ''
				    },
				    xAxis: [{
				        categories: ['2019-03','2019-04','2019-05','2019-06','2019-07',
		        	          '2019-08','2019-09','2019-10','2019-11','2019-12','2020-01','2020-02'],
				        crosshair: true
				    }],
				    yAxis: [{ // Primary yAxis
				        labels: {
				            format: '{value:,.0f}원',
				            style: {
				                color: '#cc3300'
				            }
				        },
				        title: {
				            text: '매출액',
				            style: {
				                color: '#cc3300'
				            }
				        }
				    }, { // Secondary yAxis
				        title: {
				            text: '예약건수',
				            style: {
				                color: 'gray'
				            }
				        },
				        labels: {
				            format: '{value} 건',
				            style: {
				                color: 'gray'    
				            }
				        },
				        opposite: true
				    }],
				    tooltip: {
				        shared: true
				    },
				    legend: {
				        layout: 'vertical',
				        align: 'left',
				        x: 120,
				        verticalAlign: 'top',
				        y: 100,
				        floating: true,
				        backgroundColor:
				            Highcharts.defaultOptions.legend.backgroundColor || // theme
				            'rgba(255,255,255,0.25)'
				    },
				    series: [{
				        name: '예약건수',
				        type: 'column',
				        yAxis: 1,
				        data: resultArrCount,
				        tooltip: {
				            valueSuffix: ' 건'
				        },
			            color: '#d1d1e0' 

				    }, {
				        name: '매출액',
				        type: 'spline',
				        data: resultArrPrice,  
				        tooltip: {
				            valueSuffix: '원'
				        },
				        color: '#F7323F'
				    }]
				});
				
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		})
	};
	
</script>

<div id="hotelDetail">
	<label style="font-size: 16px;">◎ 호텔 상세 내역</label>
	<br/>
   <input type="button" value="호텔리스트페이지로" onclick="location.href='<%=request.getContextPath()%>/adminHotel_list.bc'" style="font-size: 8pt;"/> 
   &nbsp;&nbsp;|&nbsp;&nbsp;
   <input type="button" value="예약내역 보기" onclick="location.href='<%=request.getContextPath()%>/adminReservList.bc?searchType=hotel_name&searchWord=${hotelvo.hotel_Name}&startDate=&endDate=&res_startday=&res_startdayEnd='" style="font-size: 8pt;"/> 
   &nbsp;&nbsp;|&nbsp;&nbsp;
   <input type="button" value="상태변경" onclick="location.href='<%=request.getContextPath()%>/updateHotelStatus.bc?hotel_idx=${hotelvo.hotel_idx}&hotel_Status=${hotelvo.hotel_Status}'" style="font-size: 8pt;"/>&nbsp;&nbsp;|&nbsp;&nbsp;
   <input type="button" value="판매페이지 가기" style="font-size: 8pt;"/> 
   	    
    <table id="tableHotelDetail" style="text-align: center;">
		<tr style="background-color: #FAFAFA;"> 
			<th>호텔번호</th>
			<th>호텔명</th>
			<th>호텔등급</th> 
			<th>판매자</th>  
			<th>대표자명</th>
			<th>주소</th>
			<th>전화번호</th>
			<th>등록일자</th>
			<th>누적판매액</th>
			<th>누적예약수</th>
			<th>영업상태</th>
		</tr>
		<tr>   
			<td>${hotelvo.hotel_idx} </td>
			<td>${hotelvo.hotel_Name} </td>
			<c:if test="${hotelvo.hotel_Category ==0 }"><td> 일반</td></c:if>
			<c:if test="${hotelvo.hotel_Category ==1 }"><td> 특급</td></c:if>
			<c:if test="${hotelvo.hotel_Category ==2 }"><td> 특1급</td></c:if>
			<td> <span id="sellerNameBtn" onclick="location.href='<%=request.getContextPath()%>/goSellerPage.bc?hotel_idx=${hotelvo.hotel_idx}'">${hotelvo.seller_Name}</span> </td>
			<td>${hotelvo.hotel_RepName} </td>
			<td>${hotelvo.hotel_Addr1} / ${hotelvo.hotel_Addr2} / ${hotelvo.hotel_Addr3} </td>
			<td>${hotelvo.hotel_Phone} </td>
			<td>${hotelvo.hotel_registerday} </td>
			<td><fmt:formatNumber value="${hotelvo.totalPrice}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${hotelvo.totalCount}" pattern="#,###"/></td>
			<c:if test="${hotelvo.hotel_Status == 1}"> 
			  <td>영업가능</td>
			</c:if>
			<c:if test="${hotelvo.hotel_Status == 0}"> 
			  <td>영업중단</td>
			</c:if>
		</tr>
	</table>	
	
	<br/><br/>
	<div style="border: solid 1px black;"  id="chart_HotelMontlyPrice">
		<label>▶ 월별 예약건수 및 판매액 추이</label>
	</div>
	
	<!-- 
	<br/><br/>
	<div style="border: solid 1px black;">
		<label>▶보유한 방 리스트</label>
		<table></table>
	</div>
	 -->
	<br/><br/>
	<div>
		<label>▶ 관리자 코멘트 (최근 10건)</label>
		<div style="border: solid 1px #ccc; font-size: 9pt; width: 70%; padding: 10px; line-height: 2;" id="commentDisplay">  
			<c:if test="${empty boardList}">
				등록된 글이 없습니다.	
			</c:if>    
			
			<c:if test="${!empty boardList}">
				<c:forEach var="boardvo" items="${boardList}" varStatus="stauts">
						제목 : 
						<c:if test="${boardvo.depthno == 0}">
				   	   		 <c:if test="${boardvo.commentCount > 0}">	 
						    	<c:if test="${boardvo.fileName == null }">	 
						   	    	<span class="title" onclick="goView('${boardvo.adminBoard_idx}','${boardvo.rno}');">
						   	    	  ${boardvo.title}&nbsp;
						   	      	  <span style="font-size: 9pt;">[${boardvo.commentCount}]</span>
						   	    	  </span>
						    	</c:if>
						    	<c:if test="${boardvo.fileName != null }">	 
						   	    	 <span class="title" onclick="goView('${boardvo.adminBoard_idx}','${boardvo.rno}');">
						   	    	 ${boardvo.title} <img src="<%= request.getContextPath()%>/resources/images/disk.gif" />
						   	    	 &nbsp;<span style="font-size: 9pt;">[${boardvo.commentCount}]</span>
						    		  </span>
						    	</c:if>
						     </c:if>
						    
						    <c:if test="${boardvo.commentCount == 0}">
						   	   <c:if test="${boardvo.fileName == null }">	 
						   	    	<span class="title" onclick="goView('${boardvo.adminBoard_idx}','${boardvo.rno}');"> ${boardvo.title}&nbsp;</span>
						    	</c:if>
						    	<c:if test="${boardvo.fileName != null }">	 
						   	    	 <span class="title" onclick="goView('${boardvo.adminBoard_idx}','${boardvo.rno}');"> ${boardvo.title}&nbsp;</span>
						    		 <img src="<%= request.getContextPath()%>/resources/images/disk.gif" />
						    	</c:if>
						    </c:if>
						    
				   		 </c:if>
				     
					      <%-- === 답변글인 경우 ===  --%>
					     <c:if test="${boardvo.depthno > 0}">
					   	     <c:if test="${boardvo.commentCount > 0}">	 <%-- 댓글쓰기게시판 ==> 댓글유무 --%>
						   	    <c:if test="${boardvo.fileName == null }">	 
						   	    	<span  style="color:#F7323F; font-style: italic; padding-left: ${boardvo.depthno * 10 }px;">└
							   	    	<c:forEach begin="1" end="${boardvo.depthno}" >
							   	    	RE: <%-- └RE${boardvo.depthno} --%>
							   	    	</c:forEach>
						   	    	</span>
							   	    <span class="title" onclick="goView('${boardvo.adminBoard_idx}','${boardvo.rno}');" >	 
							   	    	&nbsp;${boardvo.title}&nbsp;
							   	    	<span style=" font-size: 9pt;">[${boardvo.commentCount}]</span>
						    		</span>
						    	</c:if>
						    	<c:if test="${boardvo.fileName != null }">
					    			<span  style="color:red; font-style: italic; padding-left: ${boardvo.depthno * 10 }px;">└
							   	    	<c:forEach begin="1" end="${boardvo.depthno}">
							   	    	RE: <%-- └RE${boardvo.depthno} --%>
							   	    	</c:forEach>
						   	    	</span>
						   	    	<span  class="title"  onclick="goView('${boardvo.adminBoard_idx}','${boardvo.rno}');" >	 
							   	    	 &nbsp;${boardvo.title}
							   	    	<img src="<%= request.getContextPath()%>/resources/images/disk.gif" />
							   	    	&nbsp;<span style="font-size: 9pt;">[${boardvo.commentCount}]</span>
						    		</span>
						    	</c:if>
						     </c:if>
						     
						     <c:if test="${boardvo.commentCount == 0}">
						     	  <c:if test="${boardvo.fileName == null }">	 
					     	  		<span  style="color:red; font-style: italic; padding-left: ${boardvo.depthno * 10 }px;">└
							   	    	<c:forEach begin="1" end="${boardvo.depthno}" >
							   	    	RE: <%-- └RE${boardvo.depthno} --%>
							   	    	</c:forEach>
						   	    	</span> 
							   	    <span class="title" onclick="goView('${boardvo.adminBoard_idx}','${boardvo.rno}');">
						   	   			&nbsp;&nbsp;${boardvo.title}&nbsp;
						    		</span>
						     	  </c:if>
						     	  <c:if test="${boardvo.fileName != null }">	
						     	  		<span style="color:red; font-style: italic; padding-left: ${boardvo.depthno * 10 }px;">└
						   	   				<c:forEach begin="1" end="${boardvo.depthno}" >
								   	    	RE: <%-- └RE${boardvo.depthno} --%>
								   	    	</c:forEach>
								   	    <span class="title" onclick="goView('${boardvo.adminBoard_idx}','${boardvo.rno}');">
						   	   				&nbsp;&nbsp;${boardvo.title}&nbsp;
						   	   			</span>
						    			 <img src="<%= request.getContextPath()%>/resources/images/disk.gif" />
						    		</span> 
						     	  </c:if>
						    </c:if>
					     </c:if>
					       
					     &nbsp;&nbsp;||&nbsp; 작성자 : ${boardvo.name} &nbsp;&nbsp; ||&nbsp; ${boardvo.registerday}
					     <hr>
				</c:forEach>        
			</c:if>
		</div>
		<form name="adminComment"  style="margin-top: 15px;">
			<div>
				<input type="text" name="title" id="title" type="text" placeholder="제목" style="margin: 5px 0;" /><br/>
				<textarea  name="content" id="content"  style="width: 50%;"></textarea>
			</div>
			<div> 
				<input type="text"  name="fk_sellerName" value="${hotelvo.seller_Name}" style="font-size: 8pt; width: 7%; margin-bottom: 5px;" class="short"  readonly  /> 
				<input type="text" name="fk_hotelName" value="${hotelvo.hotel_Name}" style="font-size: 8pt; width: 7%; margin-bottom: 5px;" class="short"  readonly  /> 
				<input type="text" name="name" value="${(sessionScope.loginadmin).name}" style="font-size: 8pt; width: 7%; margin-bottom: 5px;" class="short"  readonly  />  <%-- ${sessionScope.loginuser.name} --%>
				<input type="button" id="btnWrite"  value="등록" style="font-size: 8pt; margin-left: 100;"/> 
			</div>
			<input type="hidden" value="${(sessionScope.loginadmin).adminId}" name="fk_adminId"/>
			<input type="hidden" value="${fk_seq}" name="fk_seq"/> 
			<input type="hidden" value="${groupno}" name="groupno"/>
			<input type="hidden" value="${depthno}" name="depthno"/>
		</form>
	      
	</div>
	
	<form name="goViewFrm"> 
		<input type="hidden" name="adminBoard_idx"  />
		<input type="hidden" name="rno"  />
		<input type="hidden" name="gobackURL" value="${gobackURL}" /> 
	</form>
</div>