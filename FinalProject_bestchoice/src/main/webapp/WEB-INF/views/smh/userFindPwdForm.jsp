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
div {
margin: auto;

}

#main_Logo_img{
	width: 150px;
	height: 50px;
	margin-bottom: 20px;
	margin: auto;
}


/* 이메일입력칸 겉 border */
.inp_type_1 {
    position: relative;
    margin-bottom: 8px;
    border: 1px solid rgba(0,0,0,0.26);
    border-radius: 4px;
    box-sizing: border-box;
    height: 48px;
    padding: 0 16px 0 46px;   
    width:336px; 
    margin: auto;
   
}
span i {	
	top: 1px;
    padding-right: 7px;
    font-size: 26px;	   
}

.Logo_img {vertical-align: middle;
	 
	}

.findPwdForm {
    height: 56px;
    font-size: 18px;
    background: #f7323f;    
    display: block;
    width:336px;
    margin-top: 16px !important;
    border-radius: 6px;
    color: #fff;
    text-align: center;
    border: none;
    margin: auto;	
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

/*form 전체크기  */
.userFindPwdForm {

height: 320px;
width: 336px;
margin: auto;
margin-top: 100px;
}

/* 비밀번호설정 박스  */
.inp_type_1 {
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
.sub_title {
	display: block;
    margin: 30px 0 10px 0;
    font-size: 18px;
    height: 26px;
}
.txt_top {
    margin: 12px 0 18px 0;
    color: rgba(0,0,0,0.56);
    text-align: center;
    font-size: 15px;
}

</style>

<script type="text/javascript" src="<%=ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	$("#btnPwdFind").click(function() {
		goFindPw();
	});	
});	// end of $(document).ready()---------------------------	 
	
	function goFindPw(){

		// 인증번호 받기 클릭시 
	 	var emailVal = $("#pwdFind_btn").val().trim();
		
		if(emailVal == ""){
			alert("이메일을 입력하세요");
			$("#myPwdFindNav").css('display', '');
			$("#myPwdFindNav").css('width', '30%');
			return;
		}
		
		var frm = document.userPwdFind;
		frm.method = "POST";
		frm.action = "<%= ctxPath %>/findPwdEmailCheck.bc";
		frm.submit(); 
	
		$("#myPwdFindNav").css('display', '');
		$("#myPwdFindNav").css('width', '30%');

		$("#myPwdFindNav").css('display', '');
		$("#myPwdFindNav").css('width', '30%');
	};

</script>

</head>
<body>
<div id="myPwdFindNav" class="sidenav layer_fix">
   <section> 
   <form name="userPwdFind" class="userFindPwdForm">
   
		<div class="fix_title">
	     	<strong class="logo"><a href="main.bc"><img id="main_Logo_img" src="<%= ctxPath%>/resources/images/minha_images/main_Logo.png"></a></strong>
	    </div>
		<strong class="sub_title">비밀번호 재설정</strong>
	    <p class="txt_top">
	            회원가입 시 등록한 이메일 주소를 입력하시면<br/>임시 비밀번호를 전송해 드립니다.
	    </p>

	    <div class="pop_login_errors">
		    <ul>
		    </ul>
	     </div>
	     <div class="inp_type_1 ico_email form-errors">
	         <input type="email" id="pwdFind_btn" name="email" class="inputPwdFind" placeholder="이메일 주소를 입력해주세요." />
	     </div>
	            
	     <button class="findPwdForm" id="btnPwdFind" name="pwd"><span>임시비밀번호 받기</span></button>               
    </form>
    
    
	    
    
   </section>
</div>
      
</body>
</html>