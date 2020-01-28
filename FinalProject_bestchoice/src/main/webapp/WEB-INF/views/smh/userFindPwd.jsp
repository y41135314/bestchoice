<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
 String ctxPath = request.getContextPath();
%> 

<jsp:include page="/WEB-INF/views/psb/header.jsp"/>







<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">
body {
text-align: center;
font-family: "Apple SD Gothic Neo","맑은 고딕","맑은고딕","Malgun Gothic",sans-serif;
font-size: 14pt;
}
.layer_fix section {
    width: 336px;
    margin: 100px auto 0 auto;
}
#main_Logo_img{
	width: 150px;
	height: 50px;
	margin-bottom: 20px;
}
.layer_fix .btn_start {
    display: block;
    position: relative;
    margin-bottom: 8px;
    border-radius: 4px;
    text-align: center;
    width: 336px;
    height: 56px;
    font-size: 18px;   
}

.space_or span {
    display: inline-block;
    position: absolute;
    top: 0;
    left: 50%;
    z-index: 10;
    width: 50px;
    height: 40px;
    margin: 0 0 0 -25px;
    background: #fff;
    font-size: 14px;
    line-height: 40px;
    color: rgba(0,0,0,0.38);
    text-align: center;
}
.space_or:after {
    content: '';
    position: absolute;
    top: 50%;
    left: 0;
    width: 100%;
    height: 1px;
    background: rgba(0,0,0,0.08);
}
.inp_type_1 {
    position: relative;
    margin-bottom: 8px;
    border: 1px solid rgba(0,0,0,0.26);
    border-radius: 4px;
    box-sizing: border-box;
    height: 48px;
    padding: 0 16px 0 46px;    
}
.inp_type_1 input {
    position: relative;
    top: 11px;
    width: 100%;
    height: 24px;
    font-size: 18px;
    border: none;
    outline:none;
}
span i {
top: 1px;
    padding-right: 7px;
    font-size: 26px;
   
}
.Logo_img {vertical-align: middle;}

.pwdFind-btn{
    height: 56px;
    font-size: 18px;
    background: #f7323f;    
    display: block;
    width: 100%;
    margin-top: 16px;
    border-radius: 6px;
    color: #fff;
    text-align: center;
    border: none;
	
}
	.Logo_img2{
	vertical-align: middle;
	float: left;
	display: inline-block;
}
 .link_half div {
    display: inline-block;
    float: left;
    width: 50%;
    height: 40px;
    text-align: center;
}
.link_half div a {
	font-size: 14px;
    line-height: 40px;
    color: rgba(0,0,0,0.87);
    text-decoration: none;
    
}
.ico_email:after {
    display: inline-block;
    content: '';
    position: absolute;
    top: 12px;
    left: 11px;
    width: 18px;
    height: 18px;
    background: url(https://ifh.cc/g/XT757.png) 0 0 no-repeat;
    background-size: 18px auto;
}
.layer_fix .sub_title {

    margin: 30px 0 10px 0;
    font-size: 18px;
}

.layer_fix .sub_title {
    display: block;
    text-align: center;
}

.txt_top {
    margin: 12px 0 18px 0;
    color: rgba(0,0,0,0.56);
    text-align: center;
    font-size: 12pt;
}

</style>
<script type="text/javascript">
$(document).ready(function(){
	 

	 $("#pwdFind-btn").keydown(function(event){
			
			if(event.keyCode == 13) { // 엔터를 했을 경우
				
			}
	 }); // end of $("#pwd").keydown();-----------------------	
	 
	 
	// ------------------------ 비밀번호찾기 ---------------------------- //
		
		//  찾기
		<%-- $("#pwdFind-btn").click(function(){
			
			var emailVal = $('#pwdFindEmail').val().trim();
			
			if(emailVal != "") {
				var frm = document.pwdFindFrm;
				frm.method = "POST";
				frm.action = "<%=ctxPath%>/findPwd.bc";
				frm.submit();
			
			}
			else {
				alert("이메일을 입력하세요");
				
			}
			
			
		});
		
		var method = "${ requestScope.method }";
		var email = "${ requestScope.email }";
		var n = "${ requestScope.n }";
		
		if(method == 'POST' && n == 1) {
			$("#pwdFindEmail").val(email);
			$("#pwdFind-btn").hide();
		} else {
			$("#pwdFind-btn").show();
		}

		// ------ 인증하기 ------ //
		$("#btnConfirm-input").click(function(){
			
			var frm = document.verifyCertificationFrm;
			frm.userCertificationCode.value = $("#input_confirmCode").val();
			frm.email.value = $("#pwdFindEmail").val();
			
			frm.action = "verifyCertification.bc"
			frm.method = "POST";
			frm.submit();
			
			var verifiedResult = "${ requestScope.verifiedResult }";
			var method = "${ requestScope.method }";
			
			if(verifiedResult == 1 ) {
				alert("인증에 성공하였습니다.");
				openPwdUpdateNav();
			} else {
				alert("인증에 실패하였습니다.");
			}
			
			
		}); --%>
	 
	 
	 
}); // end of $(document).ready()---------------------------	 
</script>

</head>
<body>
<div class="layer_fix">
   <section>

  

	<div class="fix_title">
                <strong class="logo"><a href="main.bc"><img id="main_Logo_img" src="<%= ctxPath%>/resources/images/minha_images/main_Logo.png"></a></strong>
    </div>
   			<strong class="sub_title">비밀번호 재설정</strong>
   			<p class="txt_top">
               	 회원가입 시 등록한 이메일 주소를 입력하시면<br>비밀번호 재설정 할 수 있는 인증번호를 전송해드립니다.
            </p>
            
            <%-- PasswordFind form --%>
            <form name="pwdFindFrm" style="margin-top:30px">
	            <div class="inp_type_1 ico_email form-errors">
	                <input type="email" name="email" placeholder="이메일 주소" id="pwdFindEmail" />
	            </div>
          
            <button class="pwdFind-input btn-default pwdFind-btn"  id="pwdFind-btn"><span>인증번호 받기</span></button>
     </form>
     
 <%--    
			<div id="div_findResult" align="center">
			 	<c:if test="${ requestScope.n == 1 }">
					<div style="margin: 50px 0; font-size: 11px;">
						<span>인증코드가 ${ requestScope.email } 로 발송되었습니다.</span><br/>
						<span>인증코드를 입력해주세요</span>
					</div>
					
					<c:if test="${ requestScope.n == 0 }">
						<span style="color:red; font-size: 11px;">사용자 정보가 없습니다.</span>
				 	</c:if>
					
				 	<c:if test="${ requestScope.n == -1 }">
						<span style="color:red; font-size: 11px;">메일 발송에 실패했습니다.</span>
				 	</c:if>
					<input type="text" class="pwdFind-input" name="input-confirmCode" id="input_confirmCode" required />
					<button type="button" class="pwdFind-input btn-default pwdFind-btn" id="btnConfirm-input" style="color:white; margin-top:30px; padding:0;">인증하기</button>
			 	</c:if>
			 	
			 	<form name="verifyCertificationFrm">
					<input type="text" name="email" />
					<input type="text" name="userCertificationCode" />
				</form>
			 	
			</div>
     </section>
     </div>
 --%>
</body>
</html> 