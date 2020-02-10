<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<%--  ===== #179. 스피너를 사용하기 위해  jquery-ui 사용하기 ===== --%>
  <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jquery-ui-1.11.4.custom/jquery-ui.css" />
  <script type="text/javascript" src="<%= request.getContextPath() %>/resources/jquery-ui-1.11.4.custom/jquery-ui.js"></script>

<style type="text/css">
    
  th {width: 30%;}
  
  /* 예약버튼 */
	.gra_left_right_red {
	    display: block;
	    width: 50%;
	    height: 40px;
	    border: none;
	    border-radius: 4px;
	    font-size: 16px;
	    font-weight: normal;
	    color: #fff;
	    text-align: center;
	    background: rgb(255,0,85);
	    margin: 0 auto;
	}
  
  	/* .score_wrap {
		display:inline-block;
	}
	.score_star {
		display:inline-block;
	}
  
  	.star{
	  display:inline-block;
	  width: 20px;height: 36px;
	  cursor: pointer;
	}
	.star_left{
	  background: url('/test_bestchoice/resources/images/star1.png') no-repeat 0 0; 
	  background-size: 36px; 
	  margin-right: -6px;
	}
	.star_right{
	  background: url('/test_bestchoice/resources/images/star1.png') no-repeat -18px 0; 
	  background-size: 36px; 
	  margin-right: -6px;
	}
	.star.on{
	  background-image: url('/test_bestchoice/resources/images/star2.png');
	  background-size: 36px; 
	}
	
	.score_wrap p{
		margin-top: 22px;
	    font-size: 18px;
	    display: block;
	} */
	
	label {
		width: 80px;
	}
</style>


	


<div id="container" style="width: 50%; margin: 0 auto; position: relative; padding-top: 20px;">
	
	 <%-- >>>> 파일첨부하기
	 	       enctype="multipart/form-data" 을 해주어야만 파일첨부가 된다. --%>
	<form name="addFrm" enctype="multipart/form-data" >
		<table id="table" class="table table-bordered" style="width: 100%; margin-top: 20px;">
			<tr>
				<th>제목</th>
				<td>
					<div style="width: 100%;">
						<input type="text" name="title" id="title" class="form-control" />
					</div>
				</td>
			</tr>
			<tr>
				<th>글내용</th>
				<td>
				    <div style="width: 100%;">
						<textarea name="content" id="content" rows="6" cols="100" placeholder="250자 이내로 작성해주세요."style="width: 100%; height: 150px;"></textarea>
						<span style="color:#aaa;" id="counter">(0 / 최대 250자)</span>
					</div>
				</td>
			</tr>
			
			<tr>
				<th rowspan="6">평점</th>
			</tr>
				<tr>	
				<td>
					<label for="grade0" style="width: 80px;" >접근성 : </label>
  		            <input class="grade" id="grade0" name="grade0" value="0" style="width: 30px; height: 20px;">
	            </td>
	            </tr>
	            <tr>
	            <td>
					<label for="grade1" >객실시설 : </label>
  		            <input class="grade" id="grade1" name="grade1" value="0" style="width: 30px; height: 20px;">
	            </td>
	            </tr>
	            <tr>
	            <td>
					<label for="grade2" >청결도 : </label>
  		            <input class="grade" id="grade2" name="grade2" value="0" style="width: 30px; height: 20px;">
	            </td>
	            </tr>
	            <tr>
	            <td>
					<label for="grade3" >서비스 : </label>
  		            <input class="grade" id="grade3" name="grade3" value="0" style="width: 30px; height: 20px;">
	            </td>
	            </tr>
	            <tr>
	            <td>
					<label for="grade4" >만족도 : </label>
  		            <input class="grade" id="grade4" name="grade4" value="0" style="width: 30px; height: 20px;">
	            </td>
				</tr>
			
         	
         	<%-- ==== 다중첨부파일 타입 추가하기 ===== --%>
         	<tr>
         		<th>사진첨부</th>
         		<td>
         		    <label for="spinnerOqty">파일갯수 : </label>
  		            <input id="spinnerOqty" value="0" style="width: 30px; height: 20px;">
         		    <div id="divFileattach"></div>
         		</td>
         	</tr>
		</table>
		
		<input id="seq" name="seq" type="text" value="${ReviewWriteMap.seq}"/>
		<button type="button" id="btnWrite" class="gra_left_right_red">리뷰등록</button> 
	
	</form>
</div>
<br/><br/><br/>


<script type="text/javascript">

	$(document).ready(function(){
	
		$(".grade").spinner({
			spin: function(event, ui) {
				if(ui.value > 10) {
					$(this).spinner("value", 10);
					return false;
				}
				else if(ui.value < 0) {
					$(this).spinner("value", 0);
					return false;
				}
			}
		});// end of $(".spinner").spinner({});-----------------
		
		$("#spinnerOqty").spinner({
  	      spin: function( event, ui ) {
  	        if( ui.value > 10 ) {
  	          $( this ).spinner( "value", 0 ); 
  	          return false;
  	        } 
  	        else if ( ui.value < 0 ) {
  	          $( this ).spinner( "value", 10 );
  	          return false;
  	        }
  	      }
  	    });
		
		
		$("#spinnerOqty").bind("spinstop", function(){
			// 스핀너는 이벤트가 "change" 가 아니라 "spinstop" 이다.
			var html = "";
			
			var spinnerOqtyVal = $("#spinnerOqty").val();
			
			if(spinnerOqtyVal == "0") {
				$("#divFileattach").empty();
				return;
			}
			else
			{
				for(var i=0; i<parseInt(spinnerOqtyVal); i++) {
					html += "<br/>";
					html += "<input type='file' name='attach' class='btn btn-default' />";
				}
				
				$("#divFileattach").empty();
				$("#divFileattach").append(html);	
			}
		});
		
		$('#content').keyup(function (e){
		    var content = $(this).val();
		    $('#counter').html("("+content.length+" / 최대 250자)");    //글자수 실시간 카운팅

		    if (content.length > 200){
		        alert("최대 250자까지 입력 가능합니다.");
		        $(this).val(content.substring(0, 200));
		        $('#counter').html("(250 / 최대 250자)");
		    }
		});
		
		
		//리뷰 등록 버튼
		$("#btnWrite").click(function(){
			
	        // 글제목 유효성 검사
			var titleval = $("#title").val().trim();
			if(titleval == "") {
				alert("글제목을 입력하세요!!");
				return;
			}
			
			// 글내용 유효성 검사 (일반적인 textarea 일때 유효성 검사)
			var contentval = $("#content").val().trim();
			if(contentval == "") {
				alert("글내용을 입력하세요!!");
				return;
			} 
			
			// 폼을 submit
			var frm = document.addFrm;
			frm.method = "POST"; // 파일을 첨부할 경우이라면 반드시 POST 이어야만 가능하다. GET이라면 파일첨부가 안되어진다.
			frm.action = "<%= ctxPath%>/reviewWriteEnd.bc";
			frm.submit();
		});
		
		 /*    $(".star").on('click',function(){
 	   var idx = $(this).index();
 	   $(".star").removeClass("on");
 	     for(var i=0; i<=idx; i++){
 	        $(".star").eq(i).addClass("on");
 	   }
  }); */
  
		/*   $('.starRev span').click(function(){
  	  $(this).parent().children('span').removeClass('on');
  	  $(this).addClass('on').prevAll('span').addClass('on');
  	  return false;
	}); */
			
			
	}); // end of $(document).ready()-----------------------------------

	</script>






   