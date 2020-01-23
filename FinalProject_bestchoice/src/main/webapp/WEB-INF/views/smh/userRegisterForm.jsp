<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<%
 String ctxPath = request.getContextPath();

%>   
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="#">


<meta charset="UTF-8">
<style type="text/css">

body {
	font-family: "Apple SD Gothic Neo","맑은 고딕","맑은고딕","Malgun Gothic",sans-serif;
	font-size: 14pt;
}

.layer_fix section {
    width: 336px;
    margin: 100px auto 0 auto;
}

.sub_title {
    display: block;
    margin-bottom: 10px;
    font-size: 16px;
    text-align: center;
  
}

form {
    display: block;
    margin-top: 0em;
    
}

#main_Logo_img{
	width: 150px;
	height: 50px;
	padding-bottom: 20px;
	display: block;
	margin: 0 auto;
}

.inp_type_2 {
	
    position: relative;
    height: 48px;
    margin-bottom: 38px;
    padding: 0 16px;
    border: 1px solid rgba(0,0,0,0.08);
    border-radius: 6px;
    box-sizing: border-box;
   
}

.inp_type_2 input {
    position: relative;
	top: 13px;
    height: 20px;
    padding: 0;
    border: none;
    font-size: 15px;
    vertical-align: top;
    outline: none;
}
span i {

top: 1px;
    padding-right: 7px;
    font-size: 26px;
   
}
.Logo_img {vertical-align: middle;}



.smh_login_btn{
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
.register_title {
    display: inline-block;
    margin-bottom: 9px;
    font-size: 16px;
    font-weight: bold;
    color: rgba(0,0,0,0.56);
}

.input_hp {

width: 75px;
padding: 3px;
outline: none;
}

.female_select{
	vertical-align: middle;
 	position: relative;
    height: 48px;
    margin-bottom: 38px;
    padding: 0 16px;
    border: 1px solid rgba(0,0,0,0.08);
    border-radius: 6px;
    box-sizing: border-box;
    padding-top: 13px;
}
.smh_error{
	display: inline-block;
	font-size: 9pt;
	color:red;

}

</style>
<script type="text/javascript" src="<%=ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>

<script type="text/javascript">

$(document).ready(function(){
	
	$("#goRegister").click(function() {
        joinRegister();
 	});
	
	$(".smh_error").hide();

	// 이메일 정규식검사 
	$("#email").blur(function(){
		
		var email = $(this).val();
		
		var regExp_EMAIL = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;  
		
		var bool = regExp_EMAIL.test(email);
		
		if(!bool) {
			$("#error_email").show();
			$(this).focus();
		}
		else {
			$("#error_email").hide();
		}
	
	});// end of $("#email").blur()--------------
	
	


	// 비밀번호 유효성검사 
	$("#pwd").blur(function(){
		
		var pwd = $(this).val();
	
		var regExp_PW = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
		// 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규식 객체 생성
		
		var bool = regExp_PW.test(pwd);
		
		if(!bool) {
			$("#error_pwd").show();
			$(this).focus();
		}
		else {
			$("#error_passwd").hide();
			$("#pwd_check").focus();
		} 
	}); // end of $("#pwd").blur()---------------
	

	$("#pwd_check").blur(function(){
		var pwd = $("#pwd").val();
		var pwdcheck = $(this).val();
		
		if(pwd != pwdcheck) {
			$("#error_pwdCheck").show();
			$(this).focus();
		}
		else {
			$("#error_pwdCheck").hide();
			$("#hp2").focus();
		}
		
	});//end of  $("#pwd").blur(function()--------------
			
			
	$("#hp2").blur(function(){
		var hp2 = $(this).val();
		
		var bool1 = false;
		var regExp_HP2a = /^[1-9][0-9][0-9]$/g;
		// 3글자가 숫자이라면 들어오도록 검사해주는 정규표현식
		var bool1 = regExp_HP2a.test(hp2);
		
		var bool2 = false;
		var regExp_HP2b = /^[0-9][0-9][0-9][0-9]$/g;
		// 숫자 4자리만 들어오도록 검사해주는 정규표현식
		var bool2 = regExp_HP2b.test(hp2);
		
		if( !(bool1 || bool2) ) {
			$("#error_hp").show();
			$(this).focus();
		}
		else {
			$("#error_hp").hide();
			$("#hp3").focus();
		}
		
	});// end of $("#hp2").blur()-------------
	
	
	$("#hp3").blur(function(){
		var hp3 = $(this).val();
		
		var regExp_HP3 = /^\d{4}$/g;
		// 숫자 4자리만 들어오도록 검사해주는 정규표현식
		
		var bool = regExp_HP3.test(hp3);
		
		if(!bool) {
			$("#error_hp").show();
			$(this).focus();
		}
		else {
			$("#error_hp").hide();
			$("#birthday").focus();
		}			
	});// end of $("#hp3").blur()-------------

	
	
	
});	

//회원가입 정보 보내기 
function joinRegister() {

	var frm = document.regiesterForm;
   	  frm.method = "POST";  
   	  frm.action = "<%= ctxPath %>/userRegisterForm.bc"; 
   	  frm.submit();
}

</script>

</head>
<body>
<div class="layer_fix">
<section>
    <form name="regiesterForm">	
		<div class="fix_title">
                <strong class="logo"><a href="main.bc"><img id="main_Logo_img" src="<%= ctxPath%>/resources/images/minha_images/main_Logo.png"></a></strong>
    </div>         
        <div class="joinUser">
            <strong class="sub_title">회원가입</strong>
            
           <b class="register_title">이름</b>
            <div class="inp_type_2 form-errors">
                <input  class="regeisterInfo" type="text" name="name"  required class="required"
                       value=""
                       data-rule-validemail="true"
                       data-msg-required="이름을 입력해주세요."/>                
            </div>
            
            <b class="register_title">닉네임</b>
            <div class="inp_type_2 form-errors">
                <input  class="regeisterInfo" type="text" name="nickname" />
            </div>
           
            <b class="register_title">이메일 아이디
            	 <b class=smh_error id="error_email">* 이메일 주소를 확인해 주세요.</b>
            	 <b class=smh_error id="emailcheck"></b>
            </b>
            <div class="inp_type_2 form-errors">
                <input  class="regeisterInfo" type="email" name="email" id="email" placeholder="이메일 주소를 입력해주세요." required class="required"
                       value=""
                       data-rule-validemail="true"
                       data-msg-required="이메일 주소를 확인해 주세요."/>
                      
            </div>
            
            <b class="register_title">비밀번호
            	<b class=smh_error id="error_pwd">* 영문자,숫자,특수기호가 혼합된 8~15 글자로만 입력가능합니다.</b>
            </b> 
            <div class="inp_type_2 form-errors form-password-rule">
                <input class="regeisterInfo" type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력해주세요." required class="required"
                      data-rule-passwdspace="[8,15]"
                       data-rule-passwdspace="true"
                       data-msg-required="8~15자 영문, 숫자, 특수문자를 입력해 주세요."/>
            </div>

            <b class="register_title">비밀번호 확인
            	<b class=smh_error id="error_pwdCheck">* 암호가 일치하지 않습니다.</b>
            </b>
            <div class="inp_type_2 form-errors">
                <input  class="regeisterInfo" type="password" name="pwd_check" id="pwd_check" placeholder="비밀번호를 입력해주세요." required class="required"
                       data-rule-equalTo="input[id=pwd]"
                       data-msg-required="비밀번호를 한번 더 입력해 주세요."
                       data-msg-equalTo="비밀번호가 일치하지 않습니다."/>
            </div>
                    
			<b class="register_title">연락처
			<b class=smh_error id="error_hp">* 연락처형식이 아닙니다.</b>
			</b>
			<div class="inp_type_2 form-errors" style="vertical-align: middle; ">
	
			    <select name="hp1" id="hp1" class="input_hp" style="margin-top: 13px; border-style: none;">
					<option value="010"  selected>010</option>
				</select>&nbsp;-&nbsp;
			    <input type="text" name="hp2" class="input_hp" id="hp2" size="6" maxlength="4" autocomplete="off" required class="required"  style="width:75px; vertical-align: top;"/>&nbsp;-&nbsp;
			    <input type="text" name="hp3" class="input_hp" id="hp3" size="6" maxlength="4" autocomplete="off"  required class="required" style="width:75px;  vertical-align: top;" />
	   
        	</div>
        	
        	
        	<b class="register_title">생년월일</b>
            <div class="inp_type_2 form-errors"><!-- focus / err -->
                <input type="text" name="birthday" id="birthday" placeholder="ex)19940715" required class="required"
                       value=""
                       data-rule-textsecuritylevel="6"
                       data-rule-textspace="true"
                       data-msg-required="생년월일을 다시한번 체크해주세요."/>
            </div>
            
            	<b class="register_title">성별</b>
				<div class="female_select" style="display: inline-block;">
				   <input type="radio" id="female" name="gender" value="1" />
				   <label class="register-label" for="female">여성</label>
				   
				   <input type="radio" id="male" name="gender" value="2"  />
				   <label class="register-label" for="male" >남성</label>
				</div>
			</div>
            
            <button class="smh_login_btn" id="goRegister"><span>동의하고 로그인</span></button>           
             </form>
        </section>
 </div>      

      
</body>
</html>