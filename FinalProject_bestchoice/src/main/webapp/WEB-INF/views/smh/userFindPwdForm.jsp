<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%
 String ctxPath = request.getContextPath();
%> 




  




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
    font-size: 16px;   
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



.findPwdForm{
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
.fix_title {

 margin-bottom: 80px;
}




</style>
<script type="text/javascript">


$(document).ready(function(){
	 
	/*  $("#btnLOGIN").click(function() {
		 here_Login();
		 
	 }); */
	 
	 $("#email").keydown(function(event){
			
			if(event.keyCode == 13) { // 엔터를 했을 경우
				here_Login();
			}
	 }); // end of $("#email").keydown();-----------------------	
	 
}); // end of $(document).ready()---------------------------	 


function here_Login() {


	 var frm = document.loginFrm;
	 
	 frm.action = "<%=ctxPath%>/loginEnd.bc";
	 frm.method = "POST";
	 frm.submit();
	 
} // end of function func_Login(event)-----------------------------



</script>

</head>
<body>
<div class="layer_fix">
   <section> 
   <form name="loginFrm">
	<div class="fix_title">
                <strong class="logo"><a href="main.bc"><img id="main_Logo_img" src="<%= ctxPath%>/resources/images/minha_images/main_Logo.png"></a></strong>
    </div>

            <div class="inp_type_1 ico_email form-errors">
                <input type="email" id="email" name="email" placeholder="이메일 주소" required class="required" value=""
                       data-msg-required="이메일 주소를 입력해 주세요."/>
            </div>
            
            <button class="findPwdForm" id="btnLOGIN"><span>인증번호 받기 </span></button>
               
                </form>
               </section>
              </div>
      
</body>
</html>