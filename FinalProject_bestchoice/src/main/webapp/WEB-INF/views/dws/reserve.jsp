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
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	  <!-- iamport.payment.js -->
	  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	  
	<script>
	$("#tile_yhj_head_div").hide();
		$(document).ready(function(){
	
			payInit(); //결제 관련 초기화 
			
			$("#payBtn").on("click",function(){
				if(validation() == true){
					$("input[name=pay_method]").val($("#payMethod").select().val());
				  // IMP.request_pay(param, callback) 호출
					$("input[name=amount]").val($("#payAmt").text().replace(/,/g,""));
				  IMP.request_pay(
					  $("form[name=payForm]").serializeObject(), function (rsp) { // callback
					  if (rsp.success) {
						  
						  $("input[name=buyer_name]").val($("input[name=booker]").val());	
						  var resPoint = '0'// 적립금 사용내역 일단 0 으로 처리해 두었습니다. 
						  var resPayment = $("input[name=resPayment]").val();
						///원본  var resPayment = $("input[name=pay_method]").val();
						  var resPaymentStatus = '1'; // 결제 상태 (0:예약전 1: 결제 o 3:취소)
						  var resNumber = $("input[name=merchant_uid]").val();
						  var amount = $("input[name=amount]").val();
						  var mpointCash = $("input[name=mpointCash]").val();
						  if(resPayment =='card'){
							  resPayment = '0'
						  }else if(resPayment == 'kakaopay'){
							  resPayment = '1'
						  }else if( payMethod =='naverco'){
							  resPayment = '2'
						  }
						  
						  $("input[name=res_payment]").val(resPayment);
						  
						  var frm = document.payForm;
						  frm.method="POST";
						  frm.action="<%= request.getContextPath()%>/pay/reserveSuccess.bc";
						  frm.submit();
						  
				    } else {
				       alert(rsp.error_msg)
				    }
				  });
				}
			});
			
			$("#allAgree").on("click",function(){
				if($("#allAgree").is(":checked") == true ){
					$("#agree1").prop("checked", true);
					$("#agree2").prop("checked", true);
					$("#agree3").prop("checked", true);
					$("#agree4").prop("checked", true);
				}else{
					$("#agree1").prop("checked", false);
					$("#agree2").prop("checked", false);
					$("#agree3").prop("checked", false);
					$("#agree4").prop("checked", false); 
				}
				
			});
			
			$("#userPoint").on("click",function(){
				var meber_idx = $("input[name=member_idx]").val();
				if(meber_idx != null && meber_idx != '' && meber_idx != undefined){
					$.ajax({  
						url: "<%= request.getContextPath() %>/pay/mpointCash.bc" ,
						type: "POST",
						data:{ "meber_idx": meber_idx },
						dataType: "JSON",
						success: function(json){
							$("#point").val(numberWithCommas(json.mpointCash));
						},error: function(request, status, error){
						   	 alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						   } 
					});
				}else{
					alert('로그인후 이용부탁드립니다.')
				}
			});
			
			$("#mpointCashBtn").on("click",function(){
 				var mpointCash = parseInt($("#mpointCash").val().replace(/,/g,""));
 				var point = parseInt($("#point").val().replace(/,/g,""));
 				var amount = parseInt($("#payAmt").text().replace(/,/g,""));
				
 				console.log(mpointCash);
 				console.log(point);
 				console.log(amount);
 				
 				
 				if($("#point").val() == '' || $("#point").val() == null ){
 					alert("조회후 이용해주세요.");
 					return;
 				};
 				
 				if($("#mpointCash").val() == '' || $("#mpointCash").val() == null ){
 					alert("적립금을 입력해주세요.");
 					return;
 				};
 				
 				// 금액보다 적립금이 클경우 
 				if(amount < mpointCash){
 					alert("상품금액보다 적립금 사용금액이 더 큽니다.");
 					return;
 				};
 				
 				//사용가능한 포인트 보다 사용액이 더큽니다.
 				if( point < mpointCash ){
 					alert("사용가능한 포인트 보다 사용액이 더큽니다.");
 					return;
 				};
 				
 				
 				
 				
 				
 				$("input[name=mpointCash]").val(mpointCash)
				$("#payAmt").text(numberWithCommas(String(amount - mpointCash))) 				
 				$("#mpointCash").val($("input[name=mpointCash]").val().replace(/,/g,""))
			});
			
			
			
			
		}); // end of document ready ----------------------------------------------------------------
		
		
		function payInit(){
			 var IMP = window.IMP; // 생략해도 괜찮습니다.
			  IMP.init("imp81295048"); // "imp00000000" 대신 발급받은 "가맹점 식별코드"를 사용합니다.
		}
		
		function validation(){
			if($("#payMethod").select().val() == '' || $("#payMethod").select().val() == null ){
				alert("결제수단을 선택해주세요.")
				return false;	
			}
			
			if($("#agree1").is(":checked") != true ||
				$("#agree2").is(":checked") != true ||
				$("#agree3").is(":checked") != true ||
				$("#agree4").is(":checked") != true ){
				
				alert("필수 약관동의를 체크해주세요.");
				return false;
			}
			
			if($("#booker").val() == '' || $("#booker").val() == null ){
				alert("예약자 성함을 입력해주세요.")
				return false;	
			}
			
			 if($("#phone").val() == '' || $("#phone").val() == null  ){
				alert("휴대폰번호 확인해주세요.");
				return false;	
			}else if("인증체크 값" ){
				alert("휴대폰인증을 진행해주세요");
			} 
			
			
			 if($("input[name=member_idx]").val() =='' || $("input[name=member_idx]").val() == null){
					if(confirm("로그인후 결제 가능합니다 로그인 페이지로 이동하시겠습니까?")){
						location.href="/userLogin.bc"					
					}else{
						return false;	
					}
				}			
				
				return true;
			 
		}
			 
			//핸드폰인증
			function sendAuthCode(){

				var phone = $("#phone").val();

				sendSms(phone);

			}
			
	       //확인 (인증)
			function sendCode(){
				var  certification = $("#certification").val();
			     
				var numStr = "${ sessionScope.numStr}";
				

				if(numStr == certification ) {   //세션값이랑  인증번호값 확인
					alert("인증에 성공하였습니다.");
					
				} else {
					alert("인증에 실패하였습니다.");
				}
				
				
			}
			 
			
			
			/* SMS인증 FUNCTION:시작 */
			function sendSms(phone) { 
				$.ajax({ 
					url: "<%=request.getContextPath()%>/sendSms.bc", 
					data: { receiver: phone }, 
					type: "post", 
					success: function(result) {
						if (result != "fail") {
							$(".input-wrap").show();
							$("#authCodehidden").val(result);
						} 
						else { 
							alert("인증번호 전송에 실패했습니다."); 
						} 
					} 
				});
			} ///////////핸드폰 인증

			/* if($("#certification") == {numberStr}){
				alert("성공");
			}
			else{
				$(this).val()."";
				return  "";
			} */
			
		function numberWithCommas(str) {
		    return str.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		
		$.fn.serializeObject = function() {
			  var result = {}
			  var extend = function(i, element) {
			    var node = result[element.name]
			    if ("undefined" !== typeof node && node !== null) {
			      if ($.isArray(node)) {
			        node.push(element.value)
			      } else {
			        result[element.name] = [node, element.value]
			      }
			    } else {
			      result[element.name] = element.value
			    }
			  }

			  $.each(this.serializeArray(), extend)
			  return result
		}
		
	</script>
	
</head>
<!-- 뷰단   -->
<body>
    <div id="content">
        <div class="reserve">
        <form name="payForm">
 			<input type="hidden" name="pg" value="inicis">
			<input type="hidden" name="pay_method">
			<input type="hidden" name="buyer_email" value="${member.email}">
	        <input type="hidden" name="merchant_uid" value="${reservation.res_number}"><!-- 예약번호 --> 
	        <input type="hidden" name="name" value="여기는 어때"> <!--상품명-->
	        <input type="hidden" name="buyer_name" value="${member.name}"> <!-- 구매자 -->
	        <input type="hidden" name="buyer_tel" value="${member.hp1}-${member.hp2}-${member.hp3}"> <!--구매자 폰번호-->
	        <input type="hidden" name="amount" value="${reservation.res_totalprice}"><!--결제금액-->
		
			<input type="hidden" name="mpointCash" value="${reservation.mpointCash}">
			<input type="hidden" name="member_idx" value="${ sessionScope.loginuser.member_idx }">
            <div class="reserve-payment">
                <p class="tit">예약자 정보</p>
                <div class="input-wrap">
                    <label for="booker">예약자 이름</label>
                    <div class="input-element">
                        <input type="text" id="booker" name="booker" placeholder="체크인시 필요한 정보입니다.">
                    </div> 
                    <p class="txt-warning" style="visibility: hidden;">한글,영문,숫자만 입력이 가능합니다.</p><!-- 개발 -->
                </div>
                
                <div class="input-wrap">
                    <label for="phone">휴대폰 번호</label>
                    <p class="txt">개인 정보 보호를 위해 안심번호로 숙소에 전송됩니다.</p>
                    <div class="input-element add-btn">
                        <input type="text" id="phone" placeholder="체크인시 필요한 정보입니다.">
                      <button type="button" class="ui-button __square-small __black" id="authCodeSend" name="authCodeSend" onclick="sendAuthCode()">
									인증번호 전송
									</button>
                    </div>
                    <p class="txt-warning" style="visibility: hidden;" id="authCodehidden">휴대폰 번호를 확인해주세요.</p><!-- 개발 -->
                </div>
                <!-- s:개발, 인증번호 전송시 보여지는 영역 -->
                <div class="input-wrap">
                    <label for="certification"><b>인증번호</b></label>
                    <div class="input-element add-btn add-timer">
                        <input type="text" id="certification" placeholder="체크인시 필요한 정보입니다.">
                        <input style="width: 150px; padding: 0;" class="inputPwd" type="hidden" id="authCodehidden">
                        <!-- <span class="timer">3:00</span> -->
                       <button type="button" class="ui-button __square-small __black" id="authCodeSend" name="authCodeSend" onclick="sendCode()">
									확인</button>
                    </div>
                </div>
                <!-- //e:개발, 인증번호 전송시 보여지는 영역 -->
                
                <div class="input-wrap" style="float: left; width: 500px;">
                    <label for="phone">적립금 조회</label>
                    <div class="input-element add-btn">
                        <input type="text" id="point" readonly="readonly"/>
                        <button id="userPoint" type="button">조회</button>
                    </div>
                </div>
                <div class="input-wrap" style="float: right; width: 500px;">
                    <label for="phone">적립금 사용</label>
                    <div class="input-element add-btn">
	     				<input type="text" id="mpointCash" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" />
						<button id="mpointCashBtn" type="button">적립금사용</button>
                    </div> 
                </div>
                <!-- 적립금   -->
                
                
                <!--  이벤트 조회 그냥 만들기만 할것 -->
               <!--  <p>
                    <button id="couponBtn">사용 가능 쿠폰 0장</button>
                    <span class="val" id="couponVal"></span>
                </p>                  -->
                <!--이벤트  조회-->
                
                <!-- s:개발, 비회원시 보여지는 영역 -->
             <%--    <div class="benefits-guide">
                    <c:if test="${member eq null}">
                    <a href="/userLogin.bc">
                        <p>로그인 후 예약하시면<br/>할인 쿠폰과 추가 혜택을 받을 수 있어요</p>
                        <span>로그인</span>
                    </a>
                    </c:if>
                </div> --%>
                <!-- //e:개발, 비회원시 보여지는 영역 -->
                
                <!-- s:개발, 로그인시 보여지는 영역 -->
                <!-- <div class="member-payment">
                    <p class="tit">할인 수단 선택</p>
                    <table>
                        <tbody>
                            <tr>
                                <th>
                                    <p>구매총액</p>
                                </th>
                                <td>
                                    <p><strong>%구매총액% 원</strong></p>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <button>사용 가능 쿠폰 %0%장</button>
                                </th>
                                <td>
                                    <p><strong>-</strong></p>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div> -->
                <!-- //e:개발, 로그인시 보여지는 영역 -->
                <p class="tit tit-small">결제수단 선택</p>
                <select name="methodchoice" id="payMethod">
                	<option value="" selected="selected">결제수단 선택</option>
                    <option value="card">카드 결제</option>
                    <option value="kakaopay">카카오페이</option>
                    <option value="naverco">네이버페이</option>
                    
                </select>
                <div class="agree-wrap">
                    <div><label for="allAgree"><input type="checkbox" id="allAgree"><span></span>전체 동의</label></div>
                    <div><label for="agree1"><input type="checkbox" id="agree1"><span></span>숙소이용규칙 및 취소/환불규정 동의<span>(필수)</span></label></div>
                    <div><label for="agree2"><input type="checkbox" id="agree2"><span></span>개인정보 수집 및 이용 동의<span>(필수)</span></label></div>
                    <div><label for="agree3"><input type="checkbox" id="agree3"><span></span>개인정보 제 3자 제공 동의<span>(필수)</span></label></div>
                    <div><label for="agree4"><input type="checkbox" id="agree4"><span></span>만 14세 이상 입니다.<span>(필수)</span></label></div>
                </div>
            </div>
            <div class="reserve-product">
                <div class="product-selection">
                    <p class="tit">숙소 이름</p>
                    <p class="txt">${roomMap.hotel_name}</p>
                    <p class="tit">객실타입</p>
                    <p class="txt">${roomMap.room_name}</p>
                    <p class="tit">체크인</p>
                    <p class="txt">${startday}&nbsp ${roomMap.room_checkintime}:00</p>
                    <p class="tit">체크아웃</p>
                    <p class="txt">${endday}&nbsp ${roomMap.room_checkouttime}:00</p>
                </div>
                <div class="total-payment">
                    <h3>총 결제 금액<span>(VAT 포함)</span></h3>
                    <p class="price" id="payAmt"><fmt:formatNumber value="${roomMap.roomprice}" pattern="#,###"/></p>
                    	
                    <ul>
                        <li>해당 객실가는 세금, 봉사료가 포함된 가격입니다.</li>
                        <li>결제완료 후 <span>예약자 이름</span>으로 바로 <span>체크인</span> 하시면 됩니다.</li>
                    </ul>
                </div>
                <button id="payBtn" type="button">결제하기</button>
            </div>
            
            </form>
        </div>
	
    </div>

</body>
</html>