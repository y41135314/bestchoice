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
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon&display=swap" rel="stylesheet">
<style>


.main{

	width: 724px;
	height: 850px;
	padding-left: 54px;
	float: left;
}

.my_wrap {
    padding-top: 54px;
}


a, input, button, div, li, textarea, form, label, select {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
}

/* 메뉴이동 */
 .sub_wrap nav {
    display: block;
    float: left;   
}
.sub_wrap nav li {
	list-style: none;
	padding-top: 
}



.login_info p {
    padding-bottom: 42px;
    font-size: 15px;
}
/* 내정보이미지크기  */
.smhMypage_ico{
	width: 125px;
	height: 125px;
	margin-top: 50px;
	
}


.sub_title{
    font-size: 13pt;
    font-weight: normal;
    padding-bottom: 15px;
    width: 120px;


}

.mypage .pw_input__title .title__uinfo {
    color: rgba(0,0,0,0.56);
    padding-right: 240px;
    display: inline-block;
    font-size: 13pt;
}
.pw_input__title{
	margin-top: 15px;
	margin-bottom: 15px;
	color: rgba(0,0,0,0.87);
	font-weight: normal;
	
}
/* 버튼  */
.mypage .input_btns .input__btns_wrap {
    display: block;
    overflow: hidden;
    margin-bottom: 50px;
    padding-right: 110px;
    margin-top: 15px;
}

.mypage .input__btns_wrap .btn {
  
    margin-right: 5%;
    width:192px;
    height: 42px;
    border-radius: 4px;
    font-size: 15px;
    color: rgba(0,0,0,0.87);
    text-align: center;
    box-sizing: border-box;
    vertical-align: top;
    background-color: #fff;
    border: solid 1px #ccc;
    margin-bottom: 5%;
    
}

button {
    padding: 0;
    cursor: pointer;
}


#nick_name_edit, #name_edit {
 display: block;

}



.text_input{
    position: relative;
    border: 1px solid rgba(0,0,0,0.08);
    height: 44px;
    padding: 0 40px 0 10px;
    border-radius: 4px;
    width: 410px;
    margin-bottom: 25px;
    margin-top: 15px;
}


/* 회원탈퇴버튼 */
.bot_btn {
    height: 56px;
    margin-top: 48px;
    border-top: 1px solid rgba(0,0,0,0.08);
    background: none;
    text-align: left;
    display: block;
}
/* 회원탈퇴 글씨  */
.bot_btn p {
    display: inline-block;
    padding-top: 40px;
    font-size: 16px;
    color: rgba(0,0,0,0.56);
}
.pw_input__{
	display: inline-block;
}
.userName{
 display: inline-block;
}
.myInfoTitle{
	font-size: 18px;
	padding: 0 0 43px 0;
}
.pw_input__title b {
    width: 120px;
}

.btn_confirm {
   
    top: 0;
    right: 0;
    width: 100px;
    height: 42px;
    border: none;
    border-radius: 4px;
    background: #ccc;
    font-size: 14px;
    font-weight: normal;
    color: #fff;
    right: auto;
    left: 384px;
    margin-right: 300px;
}
/*===== 모달 설정 =====  */

/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 336px;
  height: 480px;
  color: rgba(0,0,0,0.87);
  
}

/* The Close Button */
.close {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}
.fix_title{
padding-bottom: 20px;

}
.fix_title strong {
    font-size: 24px;
    margin-bottom: 15px;
   
}
.cont b {
padding-top: 0;
    font-size: 18px;
    line-height: 30px;
    margin-bottom: 20px;
}
.btn_red_fill button{

color: #FFF;

margin-top: 16px;


}
.btn_red_fill {
    display: inline-block;
    border: none;
    border-radius: 4px;
    font-size: 16px;
    color: #fff;
    text-align: center;
    box-sizing: border-box;
    vertical-align: top;
    background: #ff0055;
    width: 296px;
	height: 56px;
	margin: 0 auto;
	position: relative;
}

.text_input1 {
    position: relative;
    border: 1px solid rgba(0,0,0,0.08);
    height: 42px;
    border-radius: 4px;
    width: 410px;
    margin-bottom: 25px;
    margin-top: 15px;
}

.login_info p {
	padding-top: 42px;
    padding-bottom: 42px;
    font-size: 15px;
}
.bot_btn p {
    display: inline-block;
    padding-top: 23px;
    font-size: 16px;
    color: rgba(0,0,0,0.56);
    width: 200px;
}
.userOut{
 border: none;

}
.dot_txt{
 list-style:none;
 float: left;
 line-height: 30px;

}

</style>
</head>
	
<script type="text/javascript" src="<%=ctxPath%>/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
		$("#nickname").hide();
		$("#name").hide();
		
		$(".submit_btn").hide();
		$(".cancel_btn").hide();
		$(".submit_btn2").hide();
		$(".cancel_btn2").hide();
		
		// 닉네임 수정 
		 $("#nick_name_edit").click(function() {

			 $("#nick_name_edit").hide(); //수정버튼 클릭시 버튼숨기기 
			 $("#nickname").show();	  // input 박스 보이기 
			 $(".submit_btn").show();
			 $(".cancel_btn").show();

			});
		
		// 이름 수정 
		 $("#name_edit").click(function() {

			 $("#name_edit").hide(); //수정버튼 클릭시 버튼숨기기 
			 $("#name").show();
			 $(".submit_btn2").show();
			 $(".cancel_btn2").show();
		
			});

		
		 // 닉네임수정버튼  업데이트 
		 $(".submit_btn").click(function() {
			 nicknameUpdate();
		 });
		// 이름수정완료 클릭시 
		 $(".submit_btn2").click(function() {
			 nameUpdate();
		 });
		 
		// 핸드폰번호수정완료  클릭시 
		$(".submit_btn3").click(function() {
			HpUpdate();
		});
	
		/*  //인증번호 확인 클릭시 
		$(".btn_confirmOK").click(function() {
			
			allHP_confirmOK();
		});
		  */
		 //회원탈퇴수정  버튼 클릭시 
		$(".btn_red_fill").click(function() {
			
			userDelete();
		});
		 
		
		 
		// 모달창 띄우기 (회원탈퇴 ) ////	  
		// Get the modal
		var modal = document.getElementById("myModal");

		// Get the button that opens the modal
		var btn = document.getElementById("myBtn");

		// Get the <span> element that closes the modal
		var span = document.getElementsByClassName("close")[0];

		// When the user clicks the button, open the modal 
		btn.onclick = function() {
		  modal.style.display = "block";
		}

		// When the user clicks on <span> (x), close the modal
		span.onclick = function() {
		  modal.style.display = "none";
		}

		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
		  if (event.target == modal) {
		    modal.style.display = "none";
		  }
		}
		
		var form3 = $("form[name=form3]").serialize();
		 // 핸드폰으로 인증문자 보내기 
		$(".hp_send_btn").click(function() {
			
		$.ajax({ 
			url : "<%= ctxPath %>/sendSMS.bc", 	
			type : "POST",
			data : form3,  
			dataType : "JSON",  
			success: function(json) { 
				  alert("인증번호가 발송되었습니다.")
			}, // end of success: function(data) ---------------------
			
			error: function(request, status, error){
		        alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		    } // end of error: function(request,status,error)
			
		}); // end of $.ajax --------------------
		
		
	}); // end of $(".hp_send_btn").click(function()	
			
	// 입력한 인증번호 확인하기  
	$(".btn_confirmOK").click(function() {
		
	$.ajax({ 
		url : "<%= ctxPath %>/checkSMS.bc", 	
		type : "POST",
		data : {"checkSMS":$("#numStr").val() },  
		dataType : "JSON",  
		success: function(json) { 
			//{"result":1}  ==> "result" controller에서 넘어가는 키값을 적어줘야 한다. 
			 if(json.result == 1){
				 alert("인증에 성공하였습니다.") 
			 }
			 else{
				 alert("인증실패 다시 인증해 주세요.")
			 }
			 
		}, // end of success: function(data) ---------------------
		
		error: function(request, status, error){
	        alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	    } // end of error: function(request,status,error)
		
	}); // end of $.ajax --------------------
		
 }); //$(".btn_confirmOK").click()-------	
 
		
});// end of $(document).ready(function() ---
		  
	// 닉네임 업데이트 정보보내기 
	function nicknameUpdate() {
		var frm = document.form1;
	   	  frm.method = "POST";  
	   	  frm.action = "<%= ctxPath %>/userInfoUpdate.bc"; 
	   	  frm.submit();
	}	  
  
	// 이름 업데이트 정보보내기 
	function nameUpdate() {
		var frm = document.form2;
	   	  frm.method = "POST";  
	   	  frm.action = "<%= ctxPath %>/userInfoUpdate.bc"; 
	   	  frm.submit();
	}	
	
	
	// 핸드폰번호 업데이트 
	function HpUpdate() {
		var frm = document.form3;
	   	  frm.method = "POST";  
	   	  frm.action = "<%= ctxPath %>/userInfoUpdate.bc"; 
	   	  frm.submit();
	}	
	

	// 회원탈퇴 
	function userDelete() {
	 var frm = document.memberDelete;
	 frm.method = "POST";  
  	 frm.action = "<%= ctxPath %>/DeleteEnd.bc"; 
  	 frm.submit();
	}

</script>
<body>



<div class="main align_rt">
        <div class="mypage">			 						
                    <strong class="myInfoTitle" style="font-size: 20pt; font-family: 'Do Hyeon', sans-serif; font-weight: normal; ">내 정보 수정</strong>
                    
			<form name="memberDelete">
                   <div class="login_info">
                        <div><img class="smhMypage_ico" src="<%= ctxPath%>/resources/images/minha_images/smhMyPage_ico.png" alt=""></div>
                        <p><input readonly="readonly" type="text" name="email" value="${(sessionScope.loginuser).email}" style="border: none; outline:none;"></p>
						   <input type="hidden"  name="member_idx" value="13"/>
						   <input type="hidden"  name="mstatus" value="1"/>
                    </div> 
		
			<form class="form1" name="form1">			
                    <div class="pw_input">
                        <div class="pw_input__title">
							<b class="sub_title">닉네임</b>
							<span class="title__uinfo">${(sessionScope.loginuser).nickname}</span>
						</div>
                        <section class="modifying-section">                     
	                         <div class="input__btns_wrap" id="nick_name_btns">
								<button class="edit_btn btn" type="button" id="nick_name_edit">수정</button>
								<input type="text" id="nickname"  name="nickname" class="text_input" style="display: block;"/>
								<button class="submit_btn btn" type="submit">수정완료</button>
								<button class="cancel_btn btn" type="button">수정취소</button>						
							 </div>						
					    </section>
					 </div>
			</form>	<!-- 닉네임전송 -->	  
						
			<form class="form2" name="form2">
                    <div class="pw_input">
                        <div class="pw_input__title">
							<b class="sub_title">예약자 이름 </b>
							<span class="title__uinfo">${(sessionScope.loginuser).name}</span>
						</div>
                        <section class="modifying-section">
                        
                         <div class="input__btns_wrap" id="name_btns">
							<button class="edit_btn btn" type="button" id="name_edit">수정</button>
							<input type="text" id="name" name="name"class="text_input" placeholder="체크인 시 필요한 이름입니다." style="display: block;"/>
						
							<button class="submit_btn2 btn" type="submit">수정완료</button>
							<button class="cancel_btn2 btn" type="button">수정취소</button>						
						</div>				
					    </section>
					 </div>
			</form>
			
			<form class="form3" name="form3">
               <div class="pw_input">
                        <div class="pw_input__title">
							<b class="sub_title">연락처</b>
							<span class="title__uinfo">${(sessionScope.loginuser).hp1}${(sessionScope.loginuser).hp2}${(sessionScope.loginuser).hp3}</span>
						</div>
						
						</div>	
						
                        <section class="modifying-section">                       
	                         <div class="input__btns_wrap" id="HP_btns">
								
							    <select name="hp1" id="hp1"  class="input_hp" style="margin-top: 13px; border-style: none;">
									<option value="010"  selected>010</option>
								</select><b class="-">&nbsp;-&nbsp;</b>
							    <input type="text"  name="hp2" class="input_hp text_input1" id="hp2" maxlength="4" style="width:75px; vertical-align:middle;"/><b class="-">&nbsp;-&nbsp;</b>
							    <input type="text"  name="hp3" class="input_hp text_input1" id="hp3" maxlength="4" style="width:75px;  vertical-align:middle;" />
								
								<button type="button" class="hp_send_btn btn_confirm">인증번호 전송</button>
								
								<!-- 인증문자 보내기   -->
								<div id="verificationCode">
								<b class="sub_title confirmOK_title">인증번호</b>
								<section>
									
										<input type="text" id="numStr" name="numStr" class="text_input1 confirmOK" min="6" maxlength="6" style="width: 225px;"> 
										<span class="timer">&nbsp;</span>
								
									<button type="button" class="btn_confirmOK btn_confirm" >확인</button>
								</section>
								</div>
								
								<button class="submit_btn3 btn" type="submit">수정완료</button>
								<button class="cancel_btn3 btn" type="button">수정취소</button>													
							</div>					
					    </section>
			</form>
			
			
			
       <section>       	
				<div id="root bot_btn"> 
					<p>여기어때를 이용하고 싶지 않으신가요? <button class="userOut" id="myBtn"  >회원탈퇴</button></p>  		    		
				</div>
 		
		   			<!-- The Modal -->
			<div id="myModal" class="modal">
			
			  <!-- Modal content -->
			  <div class="modal-content">
			    
			    <div class="fix_title">
			     	<strong style="text-align: center;">회원탈퇴</strong>	
			     	<span class="close">&times;</span>
			    </div>	   
			       
			    <div class="cont" >
		            <b style="margin-bottom: 20px;">주의사항</b>
		        
		            <strong style="display: block; padding-bottom: 20px;">회원탈퇴 전 반드시 확인해주세요.</strong>
		            <ul class="dot_txt">
		                <li>회원탈퇴 시 계정 정보는 복구가 불가하며 1일 이후 재가입 가능합니다.</li>
		                <li>현재 보유 중인 포인트, 마일리지, 쿠폰은 모두 소멸되며 복구할 수 없습니다.</li>
		                <li>탈퇴 후, 기존 가입 휴대기기로 재가입 시 첫 혜택을 받을 수 없습니다. (신규 회원 쿠폰, 첫 리뷰 작성 1000포인트 등)</li>
		            </ul>
		            <div class="fix_wrap">
		                <p><input type="checkbox" class="inp_chk_03" id="residue_night">
		                    <label for="residue_night">주의사항 모두 동의합니다.</label></p>
		                    <button class="btn_red_fill" type="submit">회원탈퇴</button>
				 	</div>
			     </div>			
			   </div>
			 </div>	
	
		</section>
	</form>	
</div>
</div>		   		
		   		

</body>
</html> 