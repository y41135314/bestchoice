<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>  

<style>
.adminLoginInput{
	border: solid 1.5px black; 
	text-align: right; 
	height: 30px; 
	width: 200px;
}

#loginButton:hover{
	cursor: pointer;
	font-weight: bold;
}
</style>

<script type="text/javascript" src="<%=ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){

		$("#loginButton").click(function(){
			goLogin();
		});    
		
		$("#adminPwd").keydown(function(event){  // keydown : 키보드 눌렀을 때  <-> keyup : 누르고 뗄때
			                                     // event : key down 이벤트
			// 암호입력란에 엔터를 했을 경우, 로그인 시도한다.
			if(event.keyCode == 13) {  // key down 한 이벤트의 키가 1. ==> // 엔터 : keyCode 13 (대소문자 구분!)
				goLogin();
			}
			
		});		
		   
	});  // end of 4(document).ready()==========================
		
	function goLogin(){
		// alert("로그인 처리");
		
		var loginAdminId = $("#adminId").val().trim();
		var loginPwd = $("#adminPwd").val().trim();
		
		if(loginAdminId == "") {
			alert("아이디 항목은 필수 입력값입니다.");
			$("#adminId").val("").focus();
			return;
		}
		else if(loginPwd == "") {
			alert("패스워드 항목은 필수 입력값입니다.");
			$("#pwd").val("").focus();
			return;
		}
		
		var frm = document.adminLogin;
		frm.method = "post";
		frm.action ="<%= request.getContextPath() %>/loginAdminEnd.bc";
		frm.submit();
			
	}; // end of goLogin()=================	
		
</script>		



<p> <span style="padding: 10px; color: #F7323F; font-weight: bold;">여기는어때</span> 관리자 로그인 페이지</p>
<form name="adminLogin">
<table style="display: inline-block; padding: 10px;">
	<tr>
		<td style="font-weight: bold; font-size: 14pt;">ID&nbsp;&nbsp;</td>
		<td>
		    <input class="adminLoginInput" type="text" name="adminId" id="adminId" required />
		</td>
	</tr>
	<tr>
		<td style="font-weight: bold; font-size: 14pt;">PASSWORD&nbsp;&nbsp;</td>
		<td>
			<input class="adminLoginInput" type="password" name="adminPwd" id="adminPwd" required />
		</tr>
	<tr style="height: 15px;"></tr>	
	<tr align="right">
		<td colspan="2" >
			<a id="loginButton">로그인 <br/> <span style="font-size: 10pt;"> (여기는어때 메인페이지 이동)</span></a>
		</td>    
	</tr>		
</table>
</form>