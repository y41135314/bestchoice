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
    height: 73px;
    font-size: 20px;   
}

.layer_fix .btn_naver {
    background: rgb(40,209,17);
    color: #fff;
    text-decoration: none;
}

.btn_naver > span  {
	width: 336px;
	line-height: 56px;
	
}

 .btn_kakao {
    background: rgb(252,229,30);
    color: rgb(59,29,20);
    border: none;
}


.space_or {
    position: relative;
    height: 40px;
    margin-bottom: 8px;
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

.naveerLogo{ padding-bottom: 10px;}

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


.ico_pw:after {
    display: inline-block;
    content: '';
    position: absolute;
    top: 15px;
    left: 11px;
    width: 18px;
    height: 20px;
    background: url(https://ifh.cc/g/hkRbs.png)  50% 0 no-repeat;
    background-size: 18px auto;
}

.link_half:after {
    display: inline-block;
    content: '';
    position: absolute;
    left: 50%;
    width: 2px;
    height: 11px;
    background: rgba(0,0,0,0.08);
    margin-top: 13px;
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
            <button type="button" id="kakao_login_btn" class="btn_start btn_kakao" data-device-type="W">
            	<a href="${kakao_url}" style="text-decoration: none;"><span><i class="icon-ic_login_kakaotalk"><img  class="Logo_img" src="<%= ctxPath%>/resources/images/minha_images/kakao_ico.png"/></i>카카오톡으로 로그인</span></a>
            </button>
                   
            	<%@ page import="java.net.URLEncoder" %>
				<%@ page import="java.security.SecureRandom" %>
				<%@ page import="java.math.BigInteger" %>
			<%
			  String clientId = "R46jg0rrGm3pHMtVmrNi";
			  String redirectURI = URLEncoder.encode("http://localhost:9090/bestchoice/callbackNaverLogin.bc", "UTF-8");
			  SecureRandom random = new SecureRandom();
			  String state = new BigInteger(130, random).toString();
			  String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
			  apiURL += "&client_id=" + clientId;
			  apiURL += "&redirect_uri=" + redirectURI;
			  apiURL += "&state=" + state;
			  session.setAttribute("state", state);
			%>
			
              <%--   <a  id="naver_id_login" class='btn_start btn_naver' href="<%=ctxPath %>/userNaverLogin.bc"  >
            	<span><i class="icon-ic_login_naver"></i>
            		   <img class="Logo_img naveerLogo" src="<%= ctxPath%>/resources/images/minha_images/naver_ico.png" />네이버로 로그인
        	    </span>
            </a>
            --%>
		 
		<script type = "text/javascript" src = "https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
		 
		<div id = "naver_id_login"></div>
		     
		<script type="text/javascript">  
		      
		         var naver_id_login = new naver_id_login("R46jg0rrGm3pHMtVmrNi", "http://localhost:9090/bestchoice/callbackNaverLogin.bc");    // Client ID, CallBack URL 삽입
		                                            // 단 'localhost'가 포함된 CallBack URL
		         var state = naver_id_login.getUniqState();
		            
		         naver_id_login.setButton("green", 3, 73);
		         naver_id_login.setDomain("http://localhost:9090/bestchoice/userLogin.bc");    //  URL
		         naver_id_login.setState(state);
		         naver_id_login.setPopup();
		         naver_id_login.init_naver_id_login();
		</script>
		
            
            <p class="space_or"><span>또는</span></p>
            <div class="inp_type_1 ico_email form-errors">
                <input type="email" name="email" placeholder="이메일 주소" required class="required" value=""
                       data-msg-required="이메일 주소를 입력해 주세요."/>
            </div>
            <div class="inp_type_1 ico_pw form-errors">
                <input type="password" name="pwd" placeholder="비밀번호" required class="required"
                       data-msg-required="비밀번호를 입력해 주세요."/>
            </div> 
            <button class="here_login_btn" id="btnLOGIN"><span>로그인</span></button>
             <button class="here_login_btn" onclick="location.href='<%=ctxPath%>/seller/login.bc'" style="background-color: "><span>판매자 로그인</span></button>
               <div class="link_half">
                    <div><span ><a id="findPwd" href="<%=ctxPath%>/userFindPwdForm.bc">비밀번호 재설정</a></span></div>
                    <div><span><a href="<%=ctxPath%>/sellerJoin.bc">판매자 회원가입</a></span></div>
               </div>
               
                </form>
               </section>
              </div>

      
</body>
</html>