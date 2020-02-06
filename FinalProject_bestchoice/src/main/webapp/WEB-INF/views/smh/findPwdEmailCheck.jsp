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

.Logo_img {vertical-align: middle;}

.here_login_btn{
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

body {
    text-align: center;
    font-family: "Apple SD Gothic Neo","맑은 고딕","맑은고딕","Malgun Gothic",sans-serif;
    font-size: 14pt;
}

#main_Logo_img{
	width: 150px;
	height: 50px;
	margin-bottom: 20px;
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
    outline: none;
}

.layer_fix section {
    width: 336px;
    margin: 100px auto 0 auto;
}
.ico_pw:after {
    display: inline-block;
    content: '';
    position: absolute;
    top: 15px;
    left: 11px;
    width: 18px;
    height: 20px;
    background: url(https://ifh.cc/g/hkRbs.png) 50% 0 no-repeat;
    background-size: 18px auto;
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
</style>
<script type="text/javascript">

$(document).ready(function(){
	 
	$("#btnLOGIN").click(function() {
		 here_Login();
		 
	 }); // end of $("#here_login_btn").click();-----------------------
	
	
	 $("#pwd").keydown(function(event){
			
			if(event.keyCode == 13) { // 엔터를 했을 경우
				here_Login();
			}
	 }); // end of $("#pwd").keydown();-----------------------	
	 
	 function here_Login() {


		 var frm = document.loginPwdUpdate;		 
		 frm.action = "<%=ctxPath%>/loginEnd.bc";
		 frm.method = "POST";
		 frm.submit();
		 
	}	 
	 
	
	/* 	
		var method = "${ requestScope.method }";
		var email = "${ requestScope.email }";
		var n = "${ requestScope.n }";
		
		if(method == 'POST' && n == 1) {
			$("#pwdFindEmail").val(email);
			$("#pwdFind-btn").hide();
		} else {
			$("#pwdFind-btn").show();
		} */

		// ------ 인증하기 ------ //
		/* $("#btnConfirm-input").click(function(){
			
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
			
			
		});  */
	 
	 
	 
});  // end of $(document).ready()---------------------------	 
</script>

</head>
<body>
<div class="layer_fix">
<section>
	<form name="loginPwdUpdate">
	<div class="fix_title">
                <strong class="logo"><a href="main.bc"><img id="main_Logo_img" src="<%= ctxPath%>/resources/images/minha_images/main_Logo.png"></a></strong>
    </div>

		<div class="inp_type_1 ico_email form-errors">
                <input type="email" name="email" placeholder="이메일 주소" required class="required" value=""
                       data-msg-required="이메일 주소를 입력해 주세요."/>
            </div>
            <div class="inp_type_1 ico_pw form-errors">
                <input type="password" name="pwd" placeholder="발급된 비밀번호를 입력해 주세요." required class="required"
                       data-msg-required="비밀번호를 입력해 주세요."/>
			</div>
		<button class="here_login_btn" id="btnLOGIN"><span>로그인</span></button>
</form>
</section>
</div> 
		
</body>
</html> 