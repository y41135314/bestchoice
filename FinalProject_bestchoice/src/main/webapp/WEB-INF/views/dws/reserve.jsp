<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
  
    
</head>


<!-- 뷰단   -->
<body>
    <div id="content">
        <div class="reserve">
            <div class="reserve-payment">
                <p class="tit">예약자 정보</p>
                <div class="input-wrap">
                    <label for="booker">예약자 이름</label>
                    <div class="input-element">
                        <input type="text" id="booker" placeholder="체크인시 필요한 정보입니다.">
                    </div>
                    <p class="txt-warning" style="visibility: hidden;">한글,영문,숫자만 입력이 가능합니다.</p><!-- 개발 -->
                </div>
                <div class="input-wrap">
                    <label for="phone">휴대폰 번호</label>
                    <p class="txt">개인 정보 보호를 위해 안심번호로 숙소에 전송됩니다.</p>
                    <div class="input-element add-btn">
                        <input type="text" id="phone" placeholder="체크인시 필요한 정보입니다.">
                        <button>인증번호 전송</button>
                    </div>
                    <p class="txt-warning" style="visibility: hidden;">휴대폰 번호를 확인해주세요.</p><!-- 개발 -->
                </div>
                <!-- s:개발, 인증번호 전송시 보여지는 영역 -->
                <!-- <div class="input-wrap">
                    <label for="certification"><b>인증번호</b></label>
                    <div class="input-element add-btn add-timer">
                        <input type="text" id="certification" placeholder="체크인시 필요한 정보입니다.">
                        <span class="timer">3:00</span>
                        <button>확인</button>
                    </div>
                </div> -->
                <!-- //e:개발, 인증번호 전송시 보여지는 영역 -->
                <!-- s:개발, 비회원시 보여지는 영역 -->
                <div class="benefits-guide">
                    <a href="#">
                        <p>로그인 후 예약하시면<br/>할인 쿠폰과 추가 혜택을 받을 수 있어요</p>
                        <span>로그인</span>
                    </a>
                </div>
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
                <select name="methodchoice">
                    <option value="">카드결제(신용, 체크)</option>
                    <option value="">-</option>
                    <option value="">-</option>
                    <option value="">-</option>
                </select>
                <div class="agree-wrap">
                    <div><label for="allAgree"><input type="checkbox" name="" id="allAgree"><span></span>전체 동의</label></div>
                    <div><label for="agree1"><input type="checkbox" name="" id="agree1"><span></span>숙소이용규칙 및 취소/환불규정 동의<span>(필수)</span></label></div>
                    <div><label for="agree2"><input type="checkbox" name="" id="agree2"><span></span>개인정보 수집 및 이용 동의<span>(필수)</span></label></div>
                    <div><label for="agree3"><input type="checkbox" name="" id="agree3"><span></span>개인정보 제 3자 제공 동의<span>(필수)</span></label></div>
                    <div><label for="agree4"><input type="checkbox" name="" id="agree4"><span></span>만 14세 이상 입니다.<span>(필수)</span></label></div>
                </div>
            </div>
            <div class="reserve-product">
                <div class="product-selection">
                    <p class="tit">숙소 이름</p>
                    <p class="txt">%숙소이름%</p>
                    <p class="tit">객실타입/기간</p>
                    <p class="txt">%객실타입% / %기간%</p>
                    <p class="tit">체크인</p>
                    <p class="txt">%체크인%</p>
                    <p class="tit">체크아웃</p>
                    <p class="txt">%체크아웃%</p>
                </div>
                <div class="total-payment">
                    <h3>총 결제 금액<span>(VAT 포함)</span></h3>
                    <p class="price">%총결제금액%원</p>
                    <ul>
                        <li>해당 객실가는 세금, 봉사료가 포함된 가격입니다.</li>
                        <li>결제완료 후 <span>예약자 이름</span>으로 바로 <span>체크인</span> 하시면 됩니다.</li>
                    </ul>
                </div>
                <button>결제하기</button>
            </div>
        </div>

    </div>

</body>
</html>
    