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
#sellerDetail {
 /* 	border: solid 1px black; */
 	min-height: 500px;   
 	/* margin-top: 200px; */
 	margin-top: 10px;
 	margin-bottom: 30px;
 }
 #pSeller {
	background-color: #555555;
	color: #B7B7B7;
}
 #sellerListBtn{
 	color: #F7323F;
 }
 
 #tableSellerDetail {
 	border: solid 1px black;
 	border-collapse: collapse;  
 	width: 100%;
 	margin-top: 10px;
 }
 
 #tableSellerDetail tr, #tableSellerDetail th, #tableSellerDetail td  {
 	border: solid 1px black;
    padding: 5px;
 }
 
 #tableSellerDetail th {
 	text-align: center;
 }
 
</style>

<script>
	$(document).ready(function(){
		
		$("#divSeller").css("border-bottom", "solid 1px #555555");
		$("#divHotel").css("border", "none");
		$("#divSeller2").show();            
		$("#divHotel2").hide();
		
		$("#sellerListBtn").bind("mouseover", function(){	
			$("#sellerListBtn").css({"color":"white","background-color":"#F7323F"});
		})
		$("#sellerListBtn").bind("mouseout", function(){	
			$("#sellerListBtn").css({"color":"#F7323F","background-color":"rgba(225,225,225,0.0)"});
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
				url: "<%= request.getContextPath() %>/addSellerComment.bc",
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
		
		chart_Seller_MonthlyPrice();
		
	}) // end of document==================================
	
	function goView( adminBoard_idx,rno) {
		var frm = document.goViewFrm;
		frm.adminBoard_idx.value = adminBoard_idx ;
		frm.rno.value=rno;
		frm.method="GET";
		frm.action="adCommentDetail.bc";
		frm.submit();
	};
	
	function chart_Seller_MonthlyPrice(){
		$.ajax({
			url: "<%= request.getContextPath() %>/chart_SellerMonthlyPrice.bc",
			data: {"seller_idx" :${sellervo.seller_idx} },
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
				
				Highcharts.chart('chart_SellerMontlyPrice', {
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

    
<div id="sellerDetail">
	<label style="font-size: 16px;">◎ 판매자 상세 내역</label>
   <br/>
   <input type="button" value="판매자리스트페이지로" onclick="location.href='<%=request.getContextPath()%>/adminSeller_list.bc'" style="font-size: 8pt;"/> 
   &nbsp;&nbsp;|&nbsp;&nbsp;
   <input type="button" value="예약내역 보기" onclick="location.href='<%=request.getContextPath()%>/adminReservList.bc?searchType=seller_name&searchWord=${sellervo.seller_Name}&startDate=&endDate=&res_startday=&res_startdayEnd='" style="font-size: 8pt;"/> 
   &nbsp;&nbsp;|&nbsp;&nbsp;
   <label>보유 호텔 : 총&nbsp;</label>${seller_hotelCount}<span>개</span> &nbsp;
   <input type="button" value="리스트보기" onclick="location.href='<%=request.getContextPath()%>/adminHotel_list.bc?startDate=&endDate=&hotel_Grade=&hotel_Addr1=&searchType=seller_Name&searchWord=${sellervo.seller_Name}&orderType=hotel_registerday'" style="font-size: 8pt;"/> 
	&nbsp;&nbsp;|&nbsp;&nbsp;
	<input type="button" value="계정 상태 변경" onclick="location.href='<%=request.getContextPath()%>/updateSellerStatus.bc?seller_idx=${sellervo.seller_idx}&seller_realStatus=${sellervo.seller_realStatus}'" style="font-size: 8pt;"/>
   	 <span style="font-size: 8pt; color: orange;">**판매자가 보유한 모든 호텔에 반영됩니다.</span>    
    <table id="tableSellerDetail"  style="text-align: center;">
		<tr style="background-color: #FAFAFA;"> 
			<th>판매자번호</th>
			<th>ID</th>
			<th>판매자</th>
			<th>대표번호</th>
			<th>대표자명</th>
			<th>휴대폰번호</th>
			<th>사업자소재지</th>
			<th>우편번호</th>
			<th>가입일자</th>
			<th>누적판매액</th>
			<th>누적예약수</th>
			<th>계정상태</th>
		</tr> 
		<tr>   
			<td>${sellervo.seller_idx} </td>
			<td>${sellervo.seller_Id} </td>
			<td>${sellervo.seller_Name}</td>
			<td>${sellervo.seller_Phone} </td>
			<td>${sellervo.seller_RepName} </td>
			<c:set var = "string" value = "${sellervo.seller_Mobile}"/>
			<c:set var = "hp1" value = "${fn:substring(string, 0, 3)}" />
			<c:set var = "hp2" value = "${fn:substring(string, 3, 7)}" />
			<c:set var = "hp3" value = "${fn:substring(string, 7, 11)}" />
			<td>${hp1}-${hp2}-${hp3}</td>
			<td>${sellervo.seller_Addr} </td> 
			<td>${sellervo.seller_Post} </td>
			<td>${sellervo.seller_registerday} </td>
			<td><fmt:formatNumber value="${sellervo.totalPrice}" pattern="#,###"/></td>
			<td><fmt:formatNumber value="${sellervo.totalCount}" pattern="#,###"/></td>
			<c:if test="${sellervo.seller_realStatus == 1}"> 
			  <td>활성</td>
			</c:if>
			<c:if test="${sellervo.seller_realStatus == 0}"> 
			  <td>휴먼</td>
			</c:if>
		</tr>
	</table>	
	
	<br/><br/>  
	<div style="border: solid 1px black;" id="chart_SellerMontlyPrice">
		<label>▶ 월별 예약건수 및 판매액 추이(보유 호텔 총합)</label>
	</div>
	
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
		
		<form name="adminComment" style="margin-top: 15px;">
			<div>
				<input type="text" name="title" id="title" placeholder="제목" style="margin: 5px 0;" /><br/>
				<textarea name="content" id="content" style="width: 50%;"></textarea>
			</div>
			<div>
				<input type="text" name="fk_sellerName" value="${sellervo.seller_Name}" style="font-size: 8pt; width: 7%; margin-bottom: 5px;" class="short"  readonly  /> 
				<input type="text" name="name" value="${(sessionScope.loginadmin).name}" style="font-size: 8pt; width: 7%; margin-bottom: 5px;" class="short"  readonly  />  <%-- ${sessionScope.loginuser.name} --%>
				<input type="button" id="btnWrite" value="등록" style="font-size: 8pt; margin-left: 100;"/> 
			</div>
			<input type="hidden" value="${(sessionScope.loginadmin).adminId}" name="fk_adminId"/>
			<input type="hidden" value="" name="fk_hotelName"/>
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