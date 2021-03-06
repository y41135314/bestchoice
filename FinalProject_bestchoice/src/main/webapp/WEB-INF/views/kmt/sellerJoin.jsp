<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   


<html>
<head>
<meta charset="UTF-8">
<title>판매자 회원 가입</title>
</head>
<%-- --------------------------------------- C S S 시작---------------------------------------------------------------- --%>
<style type="text/css">
	.header{
		width: 100%;
		height: 200px;
		background-color: red;
		padding-left: 10px;
	}
	
	.head_1{
		width: 15%;
		display: inline-block;
	}
	.head_2{
		width: 50%;
		display: inline-block;
	}
	.head_3{
		width: 33%;
		display: inline-block;
		font-weight: bold;
		color: white;
		font-size: 24pt;
	}
	
  .agreeTitle{
  		width: 1400px;
  	    margin: 0 auto;

  }
  
  .agreeTitle > h5{
 
  		margin: 0 auto;
  		width: 91%;
  }	
  .agree{
  		width: 1400px;
  	    margin: 0 auto;
  	    background-color: #f2f2f2;
  	    border: solid 1px gray;
  	    width: 91%;
  }
  
  .agree1{
  		border-bottom: solid 1px gray;
  }
  
  .agree1_1{
  		margin: 0 auto;
  		width: 98%;
  		font-size: 10pt;
  }
  
  .agree2{
  		margin: 0 auto;
  		width: 98%;
  		font-size: 10pt;
  		background-color: #f2f2f2;
  }  
  
  .agree3{
  		margin: 0 auto;
  		width: 98%;
  		font-size: 10pt;
  		background-color: ;
  }  
  
  .agree2 > .agree2_2{
  		border: solid 1px gray;
  		background-color: #ffffff;
  		width: 100%;
  		height: auto;
  		max-height: 150px;
  }
  
  .agree2 > .agree2_2 > .agree2_2_1{
  		width: 98%;
  		padding: 10px;
  		font-size: 8pt;
  		max-height: 130px;
  		overflow: auto;
  }
  .agree3 > .agree3_1 > .agree3_1_1{
  		font-size: 8pt;
  } 	

<%-- ------------------------------------------------------------------------------------- --%>
* {box-sizing: border-box}


body, html {
  height: 100%;
  margin: 0;
  font-family: Arial;
}

/* Style tab links */
.tablink {
  background-color: #555;
  color: white;
  float: left;
  border: none;
  outline: none;
  padding: 14px 16px;
  font-size: 17px;
  width: 25%;
}

/* Style the tab content (and add height:100% for full page content) */
.tabcontent {
  color: black;
  display: none;
  padding: 100px 20px;
  height: 100%;
}

#Home {background-color: white;}
#News {background-color: white;}
#Contact {background-color: white;}
#About {background-color: white;}
<%-- ------------------------------------------------------------------------------------- --%>
.tab {
  float: left;
  border: 1px solid #ccc;
  background-color: #f1f1f1;
  width: 30%;
  height: 300px;
}

.tab > button {
  display: block;
  background-color: inherit;
  color: black;
  padding: 22px 16px;
  width: 100%;
  border: none;
  outline: none;
  text-align: left;
  cursor: pointer;
  transition: 0.3s;
  font-size: 17px;
}	

tr > th{
  text-align: left; 
  border:silver solid 0.5px; 
  border-radius: 5px; 
  margin-bottom: 2px;
  width : 150px;
  font-size: 11pt;
  padding-left: 4px;
}
tr > td{
  text-align: left; 
  border:silver solid 0.5px; 
  border-radius: 5px; 
  margin-bottom: 2px;
  font-size: 11pt;
  padding-left: 4px;
}
tr > td > input {
	border: solid 0px gray;
}
  .btnx{
  		margin: 0auto;
  		width: 100%;
  		text-align: center;
  		align:center;
  		vertical-align: middle;  		
  }
<%-- ------------------------------------------------------------------------------------- --%>
.footer {
	background-color: #333333;
	text-align: left;
	line-height: 2;
	padding: 20px 5% 20px 5%;
	color: white;
	width: 100%;
	font-size: 13px;
}  
   
.footer a {
	color: #ccc;
	text-decoration: none;
}

.footer a:hover {
	cursor: pointer;
}

<%-- ------------------------------------------------------------------------------------- --%>

.nextbutton1{
	width: 160px;
	height: auto;
	border-radius: 10px;
	border: 0.5px solid silver;
	background-color: #ff8080;
	color: aqua;
}  

.nextbutton2{
	width: 160px;
	height: auto;
	border-radius: 10px;
	border: 0.5px solid silver;
	background-color: #ff8080;
	color: aqua;
}

.nextbutton3{
	width: 160px;
	height: auto;
	border-radius: 10px;
	border: 0.5px solid silver;
	background-color: #ff8080;
	color: aqua;
}

.nextbutton4{
	width: 320px;
	height: 50px;
	border-radius: 10px;
	border: 0.5px solid silver;
	background-color: #ff8080;
	color: aqua;
}

.idcheckbtn{
	width: 100px;
	height: auto;
	border-radius: 5px;
	border: 0.5px solid silver;
	background-color: #ff8080;
	color: aqua;
}

.addrcheckbtn{
	width: 100px;
	height: auto;
	border-radius: 5px;
	border: 0.5px solid silver;
	background-color: #ff8080;
	color: aqua;
}   


</style>
<%-- --------------------------------------- C S S 끝 ----------------------------------------------------------------- --%>
<%-- ---------------------------------------S C R I P T 시작----------------------------------------------------------- --%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4a2dc2dd247eb470ae70b4db429fb7ee&libraries=services,clusterer,drawing"></script>
<script type="text/javascript">

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

$(document).ready(function(){
	
	$(".tabcontent1").show();
	$(".tablink1").css("background-color","red");
	$(".nextbutton1").prop("disabled",true);
	$(".tabcontent2").hide();
	$(".tabcontent3").hide();
	$(".tabcontent4").hide();
	$(".complete2").hide();

//  약관동의 체크박스 전체해제 / 전체선택
//	1. 체크박스 (전체선택)
	$("input:checkbox[id=allcheck]").click(function(){

		var bool = $(this).prop("checked"); 
		
		$("input:checkbox[name=agree]").prop("checked", bool);
	});

//	2. 체크박스 (전체해제)	
	$("input:checkbox[name=agree]").click(function(){
	 
	 var flag = false;

	 $("input:checkbox[name=agree]").each(function() {
		 var bool = $(this).prop("checked");
		 if(!bool) {
			 $("input:checkbox[id=allcheck]").prop("checked", false);
			 flag = true;
			 return false;
		 }
	 });

	 if(!flag)
		 $("input:checkbox[id=allcheck]").prop("checked", true); 
	});
	
// 아이디 중복확인
	$("#Home > div:nth-child(4) > div > table > tbody > tr:nth-child(1) > td:nth-child(4) > button").click(function(){
		
		var seller_Id = $("form[name=hotelRegisForm] input[name=seller_Id]").val();
		var regExpId = /^[A-Za-z0-9]{5,15}$/;
		var boolId = regExpId.test($("#seller_Id").val());
//		1. 아이디 검사 (정규표현식)			

		if($("#seller_Id").val().trim() == ""){
			alert("아이디는 필수입니다~~꼭 입력해주세요. ID 중복검사도 필수입니다.");
			$(this).html("");
			return false;
		}
		// 정규표현
		if(!boolId){
			alert("아이디는 영문 대/소문자 및 숫자 사용만 가능하며 5-15자 입니다. ID 중복검사도 필수입니다.");
			$(this).html("");
			return false;
		}
		$.ajax({
			url: "<%= request.getContextPath() %>/seller/checkId.bc",
			type: "GET",
			data: {seller_Id: seller_Id},
			dataType: "json",
			success: function(json){

					 if(json.n == "0"){
						alert(json.msg);
						$(".nextbutton1").prop("disabled",false);
						return;
					}
					else{
						alert(json.msg);
						$("#Home > div:nth-child(4) > div > table > tbody > tr:nth-child(1) > td:nth-child(3) > input[type=text]").val("");
						$(".nextbutton1").prop("disabled",true);
						$(".nextbutton1").css("cursor","pointer");
						return;
					}			 
				}, 
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseTest+"\n"+"error: "+error);
			}
		}); 
	});
	
	// 사용자 주소 입력하기
	$("#Home > div:nth-child(4) > div > table > tbody > tr:nth-child(21) > td:nth-child(4) > button").click(function(){
		new daum.Postcode({
			oncomplete: function(data) {
			    $("input[name=seller_Addr]").val(data.address);    // 큰주소                        예> 서울특별시 종로구 인사로 17 
			    $("input[name=seller_Post]").val(data.zonecode);
			    $("input[name=seller_Addr]").focus();
			}
		}).open();
	});
	
	// 호텔 유형 바꾸기
	$(".hotel_Category").click(function(){
		
		$(".hotel_Category").prop("checked",false);
		$(this).prop("checked",true);
	});
	
	
	// 호텔 주소 입력하기
	$("#hotelAddrSearch").click(function(){

		new daum.Postcode({
		    oncomplete: function(data) {
		    	
		    	$("input[name=hotel_Post]").val(data.zonecode);
				$("input[name=hotel_Addr1]").val(data.sido);    // 큰주소                        예> 서울특별시 종로구 인사로 17 
			    $("input[name=hotel_Addr2]").val(data.sigungu+" "+data.query);
			    $("input[name=hotel_Addr3]").focus();
				
			    console.log($("input[name=hotel_Addr1]"));
			    console.log($("input[name=hotel_Addr2]"));
			    console.log($("input[name=hotel_Addr3]"));
			    
			    const geocoder = new daum.maps.services.Geocoder();
			    
		        Promise.resolve(data).then(o => {
		            const { address } = data;
		
		            return new Promise((resolve, reject) => {
		                const geocoder = new daum.maps.services.Geocoder();
		
		                geocoder.addressSearch(address, (result, status) =>{ 
		                    if(status === daum.maps.services.Status.OK){
		                        const { x, y } = result[0]; 
		
		                        $("input[name=hotel_GEO_X]").val(y);
		                        $("input[name=hotel_GEO_Y]").val(x);
		                        resolve({ lat: y, lon: x })
		                    }else{
		                        reject();
		                    }
		                });
		            });
		        }).then(result => { // 위, 경도 결과 값	        
		        });
		    }
		}).open();
	});

}); // end of $(document).ready(function()
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function nextStep1(){
// 	$(".tablink2").trigger("click");
	var flag = false;
	var seller_Id = $("form[name=hotelRegisForm] input[name=seller_Id]").val();
	var regExpId = /^[A-Za-z0-9]{5,15}$/;
	var boolId = regExpId.test($("#seller_Id").val());
	var regExpPassword = /^.*(?=^.{5,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g;
	var boolPassword = regExpPassword.test($("#seller_Pwd").val());
	var regExpName = /^[가-힣a-zA-Z0-9]{3,15}$/;
	var boolName = regExpName.test($("#seller_Name").val());
	var regExpRepName = /^[가-힣a-zA-Z0-9]{3,15}$/;
	var boolRepName = regExpRepName.test($("#seller_Name").val());
	var regExpNo = /^[A-Za-z0-9]{9,11}$/;
	var boolNo = regExpId.test($("#seller_No").val());
	var regExpMobile = /^[0-9]{8,20}$/;
	var boolMobile = regExpMobile.test($("#seller_Mobile").val());  
	var regExpPhone = /^[0-9]{8,20}$/;
	var boolPhone = regExpMobile.test($("#seller_Phone").val());
	

//	2. 비밀번호 검사 (정규표현식)
	// 공백
	if($("#seller_Pwd").val().trim() == ""){
		alert("비밀번호는 필수입니다~~꼭 입력해주세요");
		flag = false;
		$(this).html("");
		return;
	}		
	else if(!boolPassword){
		alert("비밀번호는 영문(대/소문자)+숫자+특수기호 의 조합이여야 하며 8-16자 입니다.");
		flag = false;
		$(this).html("");
		return;
	} else {flag = true;}
	
//	3. 비밀번호 확인 검사
	// 공백
	if($("#seller_PwdCheck").val().trim() == ""){
		alert("비밀번호 확인은 필수입니다~~");
		flag = false;
		$(this).html("");
		return;
	}				
	else if( $("#seller_Pwd").val() != $("#seller_PwdCheck").val() ){
		alert("비밀번호가 서로 다르네요~~다시 입력해주세요");
		flag = false;
		$(this).html("");
		return;
	} else {flag = true;}
	
//	4. 사업자명 검사			
	// 공백
	if( $("#seller_Name").val().trim() == ""){
		alert("사업자명은 필수입니다~(공백X) 꼭 입력해주세요.");
		flag = false;
		$(this).value("");
		return; 
	}
	else if(!boolName){
		alert("사업자명은 영대/소문자/한글/숫자 로 3자 이상 15자 이하입니다~~~");
		flag = false;
		$(this).value("");
		return;
	}else {flag = true;}

//	5. 대표자명 검사			
	// 공백
	if( $("#seller_RepName").val().trim() == ""){
		alert("대표자명은 필수입니다~(공백X) 꼭 입력해주세요.");
		flag = false;
		$(this).value("");
		return;
	}	else if(!boolRepName){
		alert("대표자명은 영대/소문자/한글/숫자 로 3자 이상 15자 이하입니다~~~");
		flag = false;
		$(this).value("");
		return;
	}else {flag = true;}
	
//	6. 사업자번호 검사		
	// 공백
	if( $("#seller_No").val().trim() == ""){
		alert("사업자번호는 필수입니다~(공백X) 꼭 입력해주세요.");
		flag = false;
		$(this).value("");
		return;
	}	else if(!boolNo){
		alert("사업자번호는 숫자만 가능하며 9자 이상 11자 이하입니다~~~");
		flag = false;
		$(this).value("");
		return;
	}else {flag = true;}
	
//	7. 대표휴대전화 검사		
	// 공백
	if( $("#seller_Mobile").val().trim() == ""){
		alert("휴대전화번호는 필수입니다~(공백X) 꼭 입력해주세요.");
		flag = false;
		$(this).value("");
		return;
	}	else if(!boolMobile){
		alert("휴대전화번호는 숫자만 가능하며 8자 이상 20자 이하입니다~~~");
		flag = false;
		$(this).value("");
		return;
	}else {flag = true;}

//	8. 대표전화번호 검사			
	// 공백
	if( $("#seller_Phone").val().trim() == ""){
		alert("대표전화번호는 필수입니다~(공백X) 꼭 입력해주세요.");
		flag = false;
		$(this).value("");
		return;
	}	else if(!boolPhone){
		alert("대전화번호는 숫자만 가능하며 8자 이상 20자 이하입니다~~~");
		flag = false;
		$(this).value("");
		return;
	}else {flag = true;}

//	9. 주소 검사	
	//공백
	if( $("#seller_Addr").val().trim() == ""){
		alert("주소는 필수입니다~~");
		flag = false;
		$(this).html("");
		return;
	} else {flag = true;}

//	12. 다음단계 넘어가기	
	if(flag == true){
		$(".tabcontent1").hide();
		$(".tablink2").css("background-color","red");
		$(".tabcontent2").show();

	}
	else{
		alert("혹시 ID 중복검사는 하셨나요?");
	}
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function nextStep2(){
	var flag = false;
	var regExpName = /^[가-힣a-zA-Z0-9]{3,15}$/;
	var boolName = regExpName.test($("#hotel_Name").val());
	var regExpRepName = /^[가-힣a-zA-Z0-9]{3,15}$/;
	var boolRepName = regExpRepName.test($("#hotel_RepName").val());
	// 체크박스는 생략 밑에서 바로
	// 주소도 밑에서 바로 
	var regExpPhone = /^[0-9]{8,20}$/;
	var boolPhone = regExpPhone.test($("#hotel_Phone").val());
	var regExpFax = /^[0-9]{8,20}$/;
	var boolFax = regExpFax.test($("#hotel_Fax").val());
	var regExpEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/
	var boolEmail = regExpEmail.test($("#hotel_Email").val());
	var regExpHomepage = /^(((http(s?))\:\/\/)?)([0-9a-zA-Z\-]+\.)+[a-zA-Z]{2,6}(\:[0-9]+)?(\/\S*)?$/
	var boolHomepage = regExpHomepage.test($("#hotel_Homepage").val());
	var checkbox = $("")
	
	
//  1. 호텔명 (정규표현)
	if( $("#hotel_Name").val().trim() == ""){
		alert("호텔명은 필수입니다~(공백X) 꼭 입력해주세요. 3-15자");
		flag = false;
		$(this).value("");
		return;
	}	else if(!boolName){
		alert("호텔명은 영대소문자/한글/숫자 가능하며 3자 이상 15자 이하입니다~~~");
		flag = false;
		$(this).value("");
		return;
	}else {flag = true;}
	
//  2. 호텔대표자명 (정규표현)
	if( $("#hotel_RepName").val().trim() == ""){
		alert("호텔대표자명은 필수입니다~(공백X) 꼭 입력해주세요. 3-15자");
		flag = false;
		$(this).value("");
		return;
	}	else if(!boolRepName){
		alert("호텔대표자명은 영대소문자/한글/숫자 가능하며 3자 이상 15자 이하입니다~~~");
		flag = false;
		$(this).value("");
		return;
	}else {flag = true;}
	
//  3. 호텔유형 (검사)
	if($("input:checkbox[id=hotel_Category1]").is(":checked") && $("input:checkbox[id=hotel_Category1]").val()=="0" ){
		flag = true;
	}else if($("input:checkbox[id=hotel_Category2]").is(":checked") && $("input:checkbox[id=hotel_Category1]").val()=="1" ){
		flag = true;
	}else if($("input:checkbox[id=hotel_Category3]").is(":checked") && $("input:checkbox[id=hotel_Category1]").val()=="2" ){
		flag = true;
	}
	else{
		alert("호텔유형을 선택해주세요.");
		flag = false;
		return;
	}

//  4. 호텔주소 (검사)
	if( $("#hotel_Addr1").val().trim() == ""){
		alert("주소검색을 통해 주소를 꼭 입력해주세요")
		flag = false;
		return;
	}else{flag = true;}
	
//  5. 호텔홈페이지 (정규표현)  
	if( $("#hotel_Homepage").val().trim() == ""){
		return;
	}else if(!boolHomepage){
		alert("홈페이지 형식에 맞지 않습니다. 예)www.abc.co.kr");
		flag = false;
		$(this).value("");
		return;
	}else {flag = true;}

//  6. 호텔전화번호 (정규표현)	
	if( $("#hotel_Phone").val().trim() == ""){
		alert("호텔전화번호는 필수입니다~(공백X) 꼭 입력해주세요.");
		flag = false;
		$(this).value("");
		return;
	}	else if(!boolPhone){
		alert("휴대전화번호는 숫자만 가능하며 8자 이상 20자 이하입니다~~~");
		flag = false;
		$(this).value("");
		return;
	}else {flag = true;}

//  7. 호텔팩스 (정규표현)
	if( $("#hotel_Fax").val().trim() == ""){
		alert("팩스번호는 필수입니다~(공백X) 꼭 입력해주세요.");
		flag = false;
		$(this).value("");
		return;
	}	else if(!boolFax){
		alert("팩스번호는 숫자만 가능하며 8자 이상 20자 이하입니다~~~");
		flag = false;
		$(this).value("");
		return;
	}else {flag = true;}

//  8. 호텔이메일 (정규표현)
	if( $("#hotel_Email").val().trim() == ""){
		alert("호텔이메일은 필수입니다~(공백X) 꼭 입력해주세요.");
		flag = false;
		$(this).value("");
		return;
	}	else if(!boolEmail){
		alert("이메일형식에 맞지 않습니다~다시 입력해주세요.");
		flag = false;
		$(this).value("");
		return;
	}else {flag = true;}
		
//	9. 다음단계 넘어가기	
	if(flag == true){
		$(".tabcontent2").hide();
		$(".tablink1").css("background-color","red");
		$(".tablink2").css("background-color","red");
		$(".tablink3").css("background-color","red");
		$(".tabcontent3").show();
	}
	else{
		alert("입력이 잘되었나요?? 다시 확인해주세요.")
		return;
	}

}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function nextStep3(){
	
	 if($("input:checkbox[id=allcheck]").prop("checked")){
			$(".tabcontent3").hide();
			$(".tablink1").css("background-color","red");
			$(".tablink2").css("background-color","red");
			$(".tablink3").css("background-color","red");
			$(".tablink4").css("background-color","red");
			$(".tabcontent4").show();
		}
		else{
			alert("약관에 동의 하셨나요?? 다시 확인해주세요.")
			return;
		}

	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function registerGo(){
	
	var frm = document.hotelRegisForm;
	frm.action = "<%= request.getContextPath()%>/seller/registerSeller.bc";
	frm.method="POST";
	frm.submit();
	
	$(".complete1").hide();
	$(".complete2").show();

	}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	다음 주소 검색		 
function openDaumPOST() {
	new daum.Postcode({
		oncomplete: function(data) {
		    $("#postnum").val(data.postcode1 + "-" +data.postcode2);
		    $("#address1").val(data.address);       // 큰주소                        예> 서울특별시 종로구 인사로 17 
		    $("#address2").focus();
		}
	}).open();
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

</script>
<%-- ---------------------------------------S C R I P T 끝------------------------------------------------------------- --%>
 
<body>

<div class="header" id="header">

	<div class="head_1">
		<img style="position: relative; top: 10px;" src = "./resources/images/ico_판매자.png">
	</div>
	<div class="head_2">
		<img src = "./resources/images/로고2.png">
	</div>
	<div class="head_3">
		판매자 회원가입
	</div>

</div>
<div style="width: 100%;">
	<div style="width: 25%; display: inline-block;" class="tablink tablink1">판매자 정보<span style="float: right;">>>></span></div>
	<div style="width: 25%; display: inline-block;" class="tablink tablink2">호텔 정보<span style="float: right;">>>></span></div>
	<div style="width: 25%; display: inline-block;" class="tablink tablink3">약관 동의<span style="float: right;">>>></span></div>
	<div style="width: 25%; display: inline-block;" class="tablink tablink4">가입 완료</div>
</div>
<%-- -------------------------------------------------------------------------------------------------------------- --%>
<%-- 판매자 정보 가입 --------------------------------------------------------------------------------------------------- --%>

<form name="hotelRegisForm" enctype="multipart/form-data" >

<div id="Home" class="tabcontent tabcontent1">
  
  <div style="width: 100%; height: 20px;">
	  	<div style="width: 15%; display: inline-block;">
	  	</div>
	  	<div style="width: 70%; display: inline-block; text-align: left; font-size: 18pt; font-weight: bold;">
	  	사업자 회원가입
	 	</div>
		<div style="width: 13%; display: inline-block;">
	  	</div>
  </div>
  <div style="width:100%; height: 25px;"></div>
  <div style="width: 15%; display: inline-block;">
  </div>
  
  <div style="width: 40%; display: inline-block;">
  	
	  	
	  	<div>
	  		<table>
	  			<tr>
	  				<th>사업자 ID</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" type="text" id="seller_Id" name="seller_Id" placeholder="영문 대/소 및 숫자포함 5자 이상 15자 이하 " /></td>
	  				<td style="border: none;"><button class="idcheckbtn" id="idcheckbtn" type="button" onclick="">ID check</button> </td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th>비밀번호</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" type="password" id="seller_Pwd" name="seller_Pwd" placeholder="영문 대/소 및 숫자포함 5자 이상 15자 이하 " /></td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th>비밀번호확인</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" type="password" id="seller_PwdCheck" /></td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th>사업자명</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" type="text" id="seller_Name" name="seller_Name" placeholder="영대소문/한글/숫자 포함 3자 이상 15자 이하 " /></td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th>대표자명</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" type="text" id="seller_RepName" name="seller_RepName" placeholder="영문 대/소 및 숫자포함 3자 이상 15자 이하 " /></td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th>사업자번호</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" type="tel" id="seller_No" name="seller_No" placeholder="숫자 9자 이상 11자 이하 " /></td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th>사업자신고일</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" type="date" name="seller_Regday" /></td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th>대표휴대전화</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" maxlength="14" id="seller_Mobile" name="seller_Mobile" placeholder="숫자 8자 이상 20자 이하" value="" type="text" autocomplete="off" /></td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th>대표전화번호</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" type="text" id="seller_Phone" name="seller_Phone" placeholder="숫자 8자 이상 20자 이하" /></td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th>대표 홈페이지</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" type="text" id="seller_homepage" name="seller_homepage"  placeholder="예)www.abc.co.kr" /></td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th>사업자소재지</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" type="text" id="seller_Addr" name="seller_Addr" /></td>
	  				<td style="border: none;"><button type="button" class="addrcheckbtn" >주소 검색</button> </td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th>우편번호</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" type="text" readonly="readonly" id="seller_Post" name="seller_Post" /></td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th>취급품목</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td style="border: 0px;">
	  					<input type="checkbox" value="1" name="seller_Item" checked="checked"> 호텔
	  					<input type="checkbox" value="2" name="seller_Item" disabled="disabled"> 모텔
	  					<input type="checkbox" value="3" name="seller_Item" disabled="disabled"> 리조트
	  					<input type="checkbox" value="4" name="seller_Item" disabled="disabled"> 펜션
	  					<input type="checkbox" value="5" name="seller_Item" disabled="disabled"> 캠핑
	  				</td>
	  			</tr>
	  			<tr style="height: 30px;"></tr>
	  		</table>
	  		<div style="height: 30px; width: 100%;"></div>
			<button type="button" class="nextbutton1" id="nextbutton1" style="border: none; float: right; " onclick="nextStep1();">다음 단계</button>
			<div style="height: 30px; width: 100%;"></div>
	  	</div>

  </div>
  
  <div style="width: 13%; display: inline-block;">
  </div>
  
  <div style="width: 15%; display: inline-block;">
  	<img src = "./resources/images/Logo세로.png">
  </div> 
 
  <div style="width: 15%; display: inline-block;">
  </div>	

  
</div>


<%-- -------------------------------------------------------------------------------------------------------------- --%>
<%-- 호텔 정보 가입 --------------------------------------------------------------------------------------------------- --%>


<div id="News" class="tabcontent tabcontent2">
 <div style="width: 100%; height: 20px;">
	  	<div style="width: 15%; display: inline-block;">
	  	</div>
	  	<div style="width: 70%; display: inline-block; text-align: left; font-size: 18pt; font-weight: bold;">
	  	호텔 정보 입력
	 	</div>
		<div style="width: 13%; display: inline-block;">
	  	</div>
  </div>
  <div style="width: 15%; display: inline-block;">
  </div>
  
  <div style="width: 40%; display: inline-block;">
 		
  	
	  	<div>
	  		<table>
	  			<tr>
	  				<th>호텔 명</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" type="text" id="hotel_Name" name="hotel_Name" /></td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th>호텔 대표자명</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" type="text" id="hotel_RepName" name="hotel_RepName" /></td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th>호텔 유형</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td style="border: 0px;">
	  					<input type="checkbox" value="0" name="hotel_Category" id="hotel_Category1" class="hotel_Category" /> 일반
	  					<input type="checkbox" value="1" name="hotel_Category" id="hotel_Category2" class="hotel_Category" disabled="disabled" /> 특급
	  					<input type="checkbox" value="2" name="hotel_Category" id="hotel_Category3" class="hotel_Category" disabled="disabled" /> 특1급
	  				</td>
	  			</tr>

	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th><span style="float: left;">호텔 주소</span> <span style="font-size: 6pt; float: right; text-align: bottom;">(시/도)</span></th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" type="text" readonly="readonly" id="hotel_Addr1" name="hotel_Addr1" /></td>
	  				<td style="border: none;"><button style="height:80%;" type="button" id="hotelAddrSearch" onclick="">주소 찾기</button> </td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th><span style="float: left; color: #f1f1f1;">호텔 주소</span> <span style="font-size: 6pt; float: right;">(시/구/군/면/동)</span></th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" type="text" readonly="readonly" id="hotel_Addr2" name="hotel_Addr2" /></td>
	  				
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th><span style="float: left; display: none; color: #f1f1f1;">호텔 주소</span> <span style="font-size: 6pt; float: right;">(상세주소)</span></th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" type="text" id="hotel_Addr3" name="hotel_Addr3" /></td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th>우편번호</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" readonly="readonly" type="text" id="hotel_Post" name="hotel_Post" /></td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th>호텔 홈페이지</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" type="text" id="hotel_Homepage" name="hotel_Homepage" /></td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th>호텔 전화번호</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" maxlength="14" id="hotel_Phone" name="hotel_Phone" placeholder="예) 01012345678" value="" type="tel" autocomplete="off" /></td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th>호텔 팩스번호</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" type="tel" id="hotel_Fax" name="hotel_Fax" /></td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th>호텔 이메일</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%;" type="text" id="hotel_Email" name="hotel_Email" /></td>
	  			</tr>
	  			<tr style="height: 7px;"></tr>
	  			<tr>
	  				<th>호텔 이미지</th>
	  				<td style="width: 30px; border: none;"></td>
	  				<td><input style="width:100%; border: 0.5px solid silver; border-radius: 5px; " type="file" id="hotelImage_FileName" name="hotelImage_FileName" /></td>
	  			</tr>
	  			<tr style="display:none;">
	  				<th>호텔 GEO X</th>
	  				<td><input type="text" readonly="readonly" id="hotel_GEO_X" name="hotel_GEO_X" /> </td>
	  				<th>호텔 GEO Y</th>
	  				<td><input type="text" readonly="readonly" id="hotel_GEO_Y" name="hotel_GEO_Y" /> </td>
	  				<td style="width: 30px; border: none;"></td>
	  				<td style="border: 0px;"></td>
	  			</tr>
	  			<tr style="height: 30px;"></tr>
	  		</table>
	  		<div style="height: 30px; width: 100%;"></div>
			<button type="button" class="nextbutton2" id="nextbutton1" style="border: none; float: right; " onclick="nextStep2();">다음 단계</button>
			<div style="height: 30px; width: 100%;"></div>
	  	</div>
	  	
	  	<div>
	  		
	  	</div>
  	  	
  </div>
  
  <div style="width: 13%; display: inline-block;">
  </div>
  
  <div style="width: 15%; display: inline-block;">
  	<img src = "./resources/images/Logo세로.png">
  </div> 
 
  <div style="width: 15%; display: inline-block;">
  </div>

  
</div>

</form>


<%-- -------------------------------------------------------------------------------------------------------------- --%>
<%-- 약관 동의           --------------------------------------------------------------------------------------------------- --%>

<div id="Contact" class="tabcontent tabcontent3" style="height: 860px;	">
	<div style="width: 100%; height: 20px;">
	  	<div style="width: 15%; display: inline-block;">
	  	</div>
	  	<div style="width: 70%; display: inline-block; text-align: left; font-size: 18pt; font-weight: bold;">
	  	약관 동의
	 	</div>
		<div style="width: 13%; display: inline-block;">
	  	</div>
	</div>
  <div style="width:100%; height: 25px;"></div>

  <div style="width: 15%; display: inline-block;">
  </div>
  
  <div style="width: 70%; display: inline-block; border: solid 0.5px silver; border-radius: 10px;">
  	<br/>
	  		<div class="agreeTitle">
				<h5>전체 동의</h5>
			</div>
		
			<div class="agree">
				<div class="agree1">
					<div class="agree1_1">
						<p>
							<span>
								<input style="display: inline-block; width:15px; height:15px; vertical-align: middle;" class="inputTypeText" name="allcheck" id="allcheck" type="checkbox" />
								<label>이용약관 및 개인정보수집 및 이용, 쇼핑정보 수신(선택)에 모두 동의합니다.</label>
							</span>
						</p>
					</div>
				</div>
				<div class="agree2">
					<div class="agree2_1">
						<h5>[필수] 이용약관 동의</h5>
					</div>
					<div class="agree2_2 content">
	            		<div class="agree2_2_1" >
	            			<p>제1조(목적)<br>이 약관은 OO 회사(전자상거래 사업자)가 운영하는 OO 사이버 몰(이하 “몰”이라 한다)에서 제공하는 인터넷 관련 서비스(이하 “서비스”라 한다)를 이용함에 있어 사이버 몰과 이용자의 권리․의무 및 책임사항을 규정함을 목적으로 합니다.<br>※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다.」</p><p>제2조(정의)<br>① “몰”이란 OO 회사가 재화 또는 용역(이하 “재화 등”이라 함)을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다.<br>② “이용자”란 “몰”에 접속하여 이 약관에 따라 “몰”이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.<br>③ ‘회원’이라 함은 “몰”에 (삭제) 회원등록을 한 자로서, 계속적으로 “몰”이 제공하는 서비스를 이용할 수 있는 자를 말합니다.<br>④ ‘비회원’이라 함은 회원에 가입하지 않고 “몰”이 제공하는 서비스를 이용하는 자를 말합니다.</p><p>제3조 (약관 등의 명시와 설명 및 개정) <br>① “몰”은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호․모사전송번호․전자우편주소, 사업자등록번호, 통신판매업 신고번호, 개인정보관리책임자등을 이용자가 쉽게 알 수 있도록 00 사이버몰의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.<br>② “몰은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회․배송책임․환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.<br>③ “몰”은 「전자상거래 등에서의 소비자보호에 관한 법률」, 「약관의 규제에 관한 법률」, 「전자문서 및 전자거래기본법」, 「전자금융거래법」, 「전자서명법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 「방문판매 등에 관한 법률」, 「소비자기본법」 등 관련 법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.<br>④ “몰”이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 "몰“은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다. <br>⑤ “몰”이 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정 전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간 내에 “몰”에 송신하여 “몰”의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.<br>⑥ 이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 전자상거래 등에서의 소비자 보호지침 및 관계법령 또는 상관례에 따릅니다.</p><p>제4조(서비스의 제공 및 변경) <br>① “몰”은 다음과 같은 업무를 수행합니다.<br>&nbsp; 1. 재화 또는 용역에 대한 정보 제공 및 구매계약의 체결<br>&nbsp; 2. 구매계약이 체결된 재화 또는 용역의 배송<br>&nbsp; 3. 기타 “몰”이 정하는 업무<br>② “몰”은 재화 또는 용역의 품절 또는 기술적 사양의 변경 등의 경우에는 장차 체결되는 계약에 의해 제공할 재화 또는 용역의 내용을 변경할 수 있습니다. 이 경우에는 변경된 재화 또는 용역의 내용 및 제공일자를 명시하여 현재의 재화 또는 용역의 내용을 게시한 곳에 즉시 공지합니다.<br>③ “몰”이 제공하기로 이용자와 계약을 체결한 서비스의 내용을 재화등의 품절 또는 기술적 사양의 변경 등의 사유로 변경할 경우에는 그 사유를 이용자에게 통지 가능한 주소로 즉시 통지합니다.<br>④ 전항의 경우 “몰”은 이로 인하여 이용자가 입은 손해를 배상합니다. 다만, “몰”이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.</p><p>제5조(서비스의 중단) <br>① “몰”은 컴퓨터 등 정보통신설비의 보수점검․교체 및 고장, 통신의 두절 등의 사유가 발생한 경우에는 서비스의 제공을 일시적으로 중단할 수 있습니다.<br>② “몰”은 제1항의 사유로 서비스의 제공이 일시적으로 중단됨으로 인하여 이용자 또는 제3자가 입은 손해에 대하여 배상합니다. 단, “몰”이 고의 또는 과실이 없음을 입증하는 경우에는 그러하지 아니합니다.<br>③ 사업종목의 전환, 사업의 포기, 업체 간의 통합 등의 이유로 서비스를 제공할 수 없게 되는 경우에는 “몰”은 제8조에 정한 방법으로 이용자에게 통지하고 당초 “몰”에서 제시한 조건에 따라 소비자에게 보상합니다. 다만, “몰”이 보상기준 등을 고지하지 아니한 경우에는 이용자들의 마일리지 또는 적립금 등을 “몰”에서 통용되는 통화가치에 상응하는 현물 또는 현금으로 이용자에게 지급합니다.</p><p>제6조(회원가입) <br>① 이용자는 “몰”이 정한 가입 양식에 따라 회원정보를 기입한 후 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.<br>② “몰”은 제1항과 같이 회원으로 가입할 것을 신청한 이용자 중 다음 각 호에 해당하지 않는 한 회원으로 등록합니다.<br>&nbsp; 1. 가입신청자가 이 약관 제7조제3항에 의하여 이전에 회원자격을 상실한 적이 있는 경우, 다만 제7조제3항에 의한 회원자격 상실 후 3년이 경과한 자로서 “몰”의 회원재가입 승낙을 얻은 경우에는 예외로 한다.<br>&nbsp; 2. 등록 내용에 허위, 기재누락, 오기가 있는 경우<br>&nbsp; 3. 기타 회원으로 등록하는 것이 “몰”의 기술상 현저히 지장이 있다고 판단되는 경우<br>③ 회원가입계약의 성립 시기는 “몰”의 승낙이 회원에게 도달한 시점으로 합니다.<br>④ 회원은 회원가입 시 등록한 사항에 변경이 있는 경우, 상당한 기간 이내에 “몰”에 대하여 회원정보 수정 등의 방법으로 그 변경사항을 알려야 합니다.</p><p>제7조(회원 탈퇴 및 자격 상실 등) <br>① 회원은 “몰”에 언제든지 탈퇴를 요청할 수 있으며 “몰”은 즉시 회원탈퇴를 처리합니다.<br>② 회원이 다음 각 호의 사유에 해당하는 경우, “몰”은 회원자격을 제한 및 정지시킬 수 있습니다.<br>&nbsp; 1. 가입 신청 시에 허위 내용을 등록한 경우<br>&nbsp; 2. “몰”을 이용하여 구입한 재화 등의 대금, 기타 “몰”이용에 관련하여 회원이 부담하는 채무를 기일에 지급하지 않는 경우<br>&nbsp; 3. 다른 사람의 “몰” 이용을 방해하거나 그 정보를 도용하는 등 전자상거래 질서를 위협하는 경우<br>&nbsp; 4. “몰”을 이용하여 법령 또는 이 약관이 금지하거나 공서양속에 반하는 행위를 하는 경우<br>③ “몰”이 회원 자격을 제한․정지 시킨 후, 동일한 행위가 2회 이상 반복되거나 30일 이내에 그 사유가 시정되지 아니하는 경우 “몰”은 회원자격을 상실시킬 수 있습니다.<br>④ “몰”이 회원자격을 상실시키는 경우에는 회원등록을 말소합니다. 이 경우 회원에게 이를 통지하고, 회원등록 말소 전에 최소한 30일 이상의 기간을 정하여 소명할 기회를 부여합니다.</p><p>제8조(회원에 대한 통지)<br>① “몰”이 회원에 대한 통지를 하는 경우, 회원이 “몰”과 미리 약정하여 지정한 전자우편 주소로 할 수 있습니다.<br>② “몰”은 불특정다수 회원에 대한 통지의 경우 1주일이상 “몰” 게시판에 게시함으로서 개별 통지에 갈음할 수 있습니다. 다만, 회원 본인의 거래와 관련하여 중대한 영향을 미치는 사항에 대하여는 개별통지를 합니다.</p><p>제9조(구매신청) <br>① “몰”이용자는 “몰”상에서 다음 또는 이와 유사한 방법에 의하여 구매를 신청하며, “몰”은 이용자가 구매신청을 함에 있어서 다음의 각 내용을 알기 쉽게 제공하여야 합니다. (삭제)<br>&nbsp; 1. 재화 등의 검색 및 선택<br>&nbsp; 2. 받는 사람의 성명, 주소, 전화번호, 전자우편주소(또는 이동전화번호) 등의 입력<br>&nbsp; 3. 약관내용, 청약철회권이 제한되는 서비스, 배송료․설치비 등의 비용부담과 관련한 내용에 대한 확인<br>&nbsp; 4. 이 약관에 동의하고 위 3.호의 사항을 확인하거나 거부하는 표시(예, 마우스 클릭)<br>&nbsp; 5. 재화등의 구매신청 및 이에 관한 확인 또는 “몰”의 확인에 대한 동의<br>&nbsp; 6. 결제방법의 선택<br>② “몰”이 제3자에게 구매자 개인정보를 제공•위탁할 필요가 있는 경우 실제 구매신청 시 구매자의 동의를 받아야 하며, 회원가입 시 미리 포괄적으로 동의를 받지 않습니다. 이 때 “몰”은 제공되는 개인정보 항목, 제공받는 자, 제공받는 자의 개인정보 이용 목적 및 보유‧이용 기간 등을 구매자에게 명시하여야 합니다. 다만 「정보통신망이용촉진 및 정보보호 등에 관한 법률」 제25조 제1항에 의한 개인정보 취급위탁의 경우 등 관련 법령에 달리 정함이 있는 경우에는 그에 따릅니다.</p><p>제10조 (계약의 성립)<br>① “몰”은 제9조와 같은 구매신청에 대하여 다음 각 호에 해당하면 승낙하지 않을 수 있습니다. 다만, 미성년자와 계약을 체결하는 경우에는 법정대리인의 동의를 얻지 못하면 미성년자 본인 또는 법정대리인이 계약을 취소할 수 있다는 내용을 고지하여야 합니다.<br>&nbsp; 1. 신청 내용에 허위, 기재누락, 오기가 있는 경우<br>&nbsp; 2. 미성년자가 담배, 주류 등 청소년보호법에서 금지하는 재화 및 용역을 구매하는 경우<br>&nbsp; 3. 기타 구매신청에 승낙하는 것이 “몰” 기술상 현저히 지장이 있다고 판단하는 경우<br>② “몰”의 승낙이 제12조제1항의 수신확인통지형태로 이용자에게 도달한 시점에 계약이 성립한 것으로 봅니다.<br>③ “몰”의 승낙의 의사표시에는 이용자의 구매 신청에 대한 확인 및 판매가능 여부, 구매신청의 정정 취소 등에 관한 정보 등을 포함하여야 합니다.</p><p>제11조(지급방법)<br>“몰”에서 구매한 재화 또는 용역에 대한 대금지급방법은 다음 각 호의 방법중 가용한 방법으로 할 수 있습니다. 단, “몰”은 이용자의 지급방법에 대하여 재화 등의 대금에 어떠한 명목의 수수료도 추가하여 징수할 수 없습니다.<br>1. 폰뱅킹, 인터넷뱅킹, 메일 뱅킹 등의 각종 계좌이체 <br>2. 선불카드, 직불카드, 신용카드 등의 각종 카드 결제<br>3. 온라인무통장입금<br>4. 전자화폐에 의한 결제<br>5. 수령 시 대금지급<br>6. 마일리지 등 “몰”이 지급한 포인트에 의한 결제<br>7. “몰”과 계약을 맺었거나 “몰”이 인정한 상품권에 의한 결제 <br>8. 기타 전자적 지급 방법에 의한 대금 지급 등</p><p>제12조(수신확인통지․구매신청 변경 및 취소)<br>① “몰”은 이용자의 구매신청이 있는 경우 이용자에게 수신확인통지를 합니다.<br>② 수신확인통지를 받은 이용자는 의사표시의 불일치 등이 있는 경우에는 수신확인통지를 받은 후 즉시 구매신청 변경 및 취소를 요청할 수 있고 “몰”은 배송 전에 이용자의 요청이 있는 경우에는 지체 없이 그 요청에 따라 처리하여야 합니다. 다만 이미 대금을 지불한 경우에는 제15조의 청약철회 등에 관한 규정에 따릅니다.</p><p>제13조(재화 등의 공급)<br>① “몰”은 이용자와 재화 등의 공급시기에 관하여 별도의 약정이 없는 이상, 이용자가 청약을 한 날부터 7일 이내에 재화 등을 배송할 수 있도록 주문제작, 포장 등 기타의 필요한 조치를 취합니다. 다만, “몰”이 이미 재화 등의 대금의 전부 또는 일부를 받은 경우에는 대금의 전부 또는 일부를 받은 날부터 3영업일 이내에 조치를 취합니다. 이때 “몰”은 이용자가 재화 등의 공급 절차 및 진행 사항을 확인할 수 있도록 적절한 조치를 합니다.<br>② “몰”은 이용자가 구매한 재화에 대해 배송수단, 수단별 배송비용 부담자, 수단별 배송기간 등을 명시합니다. 만약 “몰”이 약정 배송기간을 초과한 경우에는 그로 인한 이용자의 손해를 배상하여야 합니다. 다만 “몰”이 고의․과실이 없음을 입증한 경우에는 그러하지 아니합니다.</p><p>제14조(환급)<br>“몰”은 이용자가 구매신청한 재화 등이 품절 등의 사유로 인도 또는 제공을 할 수 없을 때에는 지체 없이 그 사유를 이용자에게 통지하고 사전에 재화 등의 대금을 받은 경우에는 대금을 받은 날부터 3영업일 이내에 환급하거나 환급에 필요한 조치를 취합니다.</p><p>제15조(청약철회 등)<br>① “몰”과 재화등의 구매에 관한 계약을 체결한 이용자는 「전자상거래 등에서의 소비자보호에 관한 법률」 제13조 제2항에 따른 계약내용에 관한 서면을 받은 날(그 서면을 받은 때보다 재화 등의 공급이 늦게 이루어진 경우에는 재화 등을 공급받거나 재화 등의 공급이 시작된 날을 말합니다)부터 7일 이내에는 청약의 철회를 할 수 있습니다. 다만, 청약철회에 관하여 「전자상거래 등에서의 소비자보호에 관한 법률」에 달리 정함이 있는 경우에는 동 법 규정에 따릅니다. <br>② 이용자는 재화 등을 배송 받은 경우 다음 각 호의 1에 해당하는 경우에는 반품 및 교환을 할 수 없습니다.<br>&nbsp; 1. 이용자에게 책임 있는 사유로 재화 등이 멸실 또는 훼손된 경우(다만, 재화 등의 내용을 확인하기 위하여 포장 등을 훼손한 경우에는 청약철회를 할 수 있습니다)<br>&nbsp; 2. 이용자의 사용 또는 일부 소비에 의하여 재화 등의 가치가 현저히 감소한 경우<br>&nbsp; 3. 시간의 경과에 의하여 재판매가 곤란할 정도로 재화등의 가치가 현저히 감소한 경우<br>&nbsp; 4. 같은 성능을 지닌 재화 등으로 복제가 가능한 경우 그 원본인 재화 등의 포장을 훼손한 경우<br>③ 제2항제2호 내지 제4호의 경우에 “몰”이 사전에 청약철회 등이 제한되는 사실을 소비자가 쉽게 알 수 있는 곳에 명기하거나 시용상품을 제공하는 등의 조치를 하지 않았다면 이용자의 청약철회 등이 제한되지 않습니다.<br>④ 이용자는 제1항 및 제2항의 규정에 불구하고 재화 등의 내용이 표시•광고 내용과 다르거나 계약내용과 다르게 이행된 때에는 당해 재화 등을 공급받은 날부터 3월 이내, 그 사실을 안 날 또는 알 수 있었던 날부터 30일 이내에 청약철회 등을 할 수 있습니다.</p><p>제16조(청약철회 등의 효과)<br>① “몰”은 이용자로부터 재화 등을 반환받은 경우 3영업일 이내에 이미 지급받은 재화 등의 대금을 환급합니다. 이 경우 “몰”이 이용자에게 재화등의 환급을 지연한때에는 그 지연기간에 대하여 「전자상거래 등에서의 소비자보호에 관한 법률 시행령」제21조의2에서 정하는 지연이자율(괄호 부분 삭제)을 곱하여 산정한 지연이자를 지급합니다.<br>② “몰”은 위 대금을 환급함에 있어서 이용자가 신용카드 또는 전자화폐 등의 결제수단으로 재화 등의 대금을 지급한 때에는 지체 없이 당해 결제수단을 제공한 사업자로 하여금 재화 등의 대금의 청구를 정지 또는 취소하도록 요청합니다.<br>③ 청약철회 등의 경우 공급받은 재화 등의 반환에 필요한 비용은 이용자가 부담합니다. “몰”은 이용자에게 청약철회 등을 이유로 위약금 또는 손해배상을 청구하지 않습니다. 다만 재화 등의 내용이 표시•광고 내용과 다르거나 계약내용과 다르게 이행되어 청약철회 등을 하는 경우 재화 등의 반환에 필요한 비용은 “몰”이 부담합니다.<br>④ 이용자가 재화 등을 제공받을 때 발송비를 부담한 경우에 “몰”은 청약철회 시 그 비용을 누가 부담하는지를 이용자가 알기 쉽도록 명확하게 표시합니다.</p><p>제17조(개인정보보호)<br>① “몰”은 이용자의 개인정보 수집시 서비스제공을 위하여 필요한 범위에서 최소한의 개인정보를 수집합니다. <br>② “몰”은 회원가입시 구매계약이행에 필요한 정보를 미리 수집하지 않습니다. 다만, 관련 법령상 의무이행을 위하여 구매계약 이전에 본인확인이 필요한 경우로서 최소한의 특정 개인정보를 수집하는 경우에는 그러하지 아니합니다.<br>③ “몰”은 이용자의 개인정보를 수집•이용하는 때에는 당해 이용자에게 그 목적을 고지하고 동의를 받습니다. <br>④ “몰”은 수집된 개인정보를 목적외의 용도로 이용할 수 없으며, 새로운 이용목적이 발생한 경우 또는 제3자에게 제공하는 경우에는 이용•제공단계에서 당해 이용자에게 그 목적을 고지하고 동의를 받습니다. 다만, 관련 법령에 달리 정함이 있는 경우에는 예외로 합니다.<br>⑤ “몰”이 제2항과 제3항에 의해 이용자의 동의를 받아야 하는 경우에는 개인정보관리 책임자의 신원(소속, 성명 및 전화번호, 기타 연락처), 정보의 수집목적 및 이용목적, 제3자에 대한 정보제공 관련사항(제공받은자, 제공목적 및 제공할 정보의 내용) 등 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」 제22조제2항이 규정한 사항을 미리 명시하거나 고지해야 하며 이용자는 언제든지 이 동의를 철회할 수 있습니다.<br>⑥ 이용자는 언제든지 “몰”이 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며 “몰”은 이에 대해 지체 없이 필요한 조치를 취할 의무를 집니다. 이용자가 오류의 정정을 요구한 경우에는 “몰”은 그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다.<br>⑦ “몰”은 개인정보 보호를 위하여 이용자의 개인정보를 취급하는 자를 최소한으로 제한하여야 하며 신용카드, 은행계좌 등을 포함한 이용자의 개인정보의 분실, 도난, 유출, 동의 없는 제3자 제공, 변조 등으로 인한 이용자의 손해에 대하여 모든 책임을 집니다.<br>⑧ “몰” 또는 그로부터 개인정보를 제공받은 제3자는 개인정보의 수집목적 또는 제공받은 목적을 달성한 때에는 당해 개인정보를 지체 없이 파기합니다.<br>⑨ “몰”은 개인정보의 수집•이용•제공에 관한 동의란을 미리 선택한 것으로 설정해두지 않습니다. 또한 개인정보의 수집•이용•제공에 관한 이용자의 동의거절시 제한되는 서비스를 구체적으로 명시하고, 필수수집항목이 아닌 개인정보의 수집•이용•제공에 관한 이용자의 동의 거절을 이유로 회원가입 등 서비스 제공을 제한하거나 거절하지 않습니다.</p><p>제18조(“몰“의 의무)<br>① “몰”은 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 재화․용역을 제공하는데 최선을 다하여야 합니다.<br>② “몰”은 이용자가 안전하게 인터넷 서비스를 이용할 수 있도록 이용자의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어야 합니다.<br>③ “몰”이 상품이나 용역에 대하여 「표시․광고의 공정화에 관한 법률」 제3조 소정의 부당한 표시․광고행위를 함으로써 이용자가 손해를 입은 때에는 이를 배상할 책임을 집니다.<br>④ “몰”은 이용자가 원하지 않는 영리목적의 광고성 전자우편을 발송하지 않습니다.</p><p>제19조(회원의 ID 및 비밀번호에 대한 의무)<br>① 제17조의 경우를 제외한 ID와 비밀번호에 관한 관리책임은 회원에게 있습니다.<br>② 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.<br>③ 회원이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 “몰”에 통보하고 “몰”의 안내가 있는 경우에는 그에 따라야 합니다.</p><p>제20조(이용자의 의무)<br>이용자는 다음 행위를 하여서는 안 됩니다.<br>1. 신청 또는 변경시 허위 내용의 등록<br>2. 타인의 정보 도용<br>3. “몰”에 게시된 정보의 변경<br>4. “몰”이 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시<br>5. “몰” 기타 제3자의 저작권 등 지적재산권에 대한 침해<br>6. “몰” 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위<br>7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 몰에 공개 또는 게시하는 행위</p><p>제21조(연결“몰”과 피연결“몰” 간의 관계)<br>① 상위 “몰”과 하위 “몰”이 하이퍼링크(예: 하이퍼링크의 대상에는 문자, 그림 및 동화상 등이 포함됨)방식 등으로 연결된 경우, 전자를 연결 “몰”(웹 사이트)이라고 하고 후자를 피연결 “몰”(웹사이트)이라고 합니다.<br>② 연결“몰”은 피연결“몰”이 독자적으로 제공하는 재화 등에 의하여 이용자와 행하는 거래에 대해서 보증 책임을 지지 않는다는 뜻을 연결“몰”의 초기화면 또는 연결되는 시점의 팝업화면으로 명시한 경우에는 그 거래에 대한 보증 책임을 지지 않습니다.</p><p>제22조(저작권의 귀속 및 이용제한)<br>① “몰“이 작성한 저작물에 대한 저작권 기타 지적재산권은 ”몰“에 귀속합니다.<br>② 이용자는 “몰”을 이용함으로써 얻은 정보 중 “몰”에게 지적재산권이 귀속된 정보를 “몰”의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.<br>③ “몰”은 약정에 따라 이용자에게 귀속된 저작권을 사용하는 경우 당해 이용자에게 통보하여야 합니다.</p><p>제23조(분쟁해결)<br>① “몰”은 이용자가 제기하는 정당한 의견이나 불만을 반영하고 그 피해를 보상처리하기 위하여 피해보상처리기구를 설치․운영합니다.<br>② “몰”은 이용자로부터 제출되는 불만사항 및 의견은 우선적으로 그 사항을 처리합니다. 다만, 신속한 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 즉시 통보해 드립니다.<br>③ “몰”과 이용자 간에 발생한 전자상거래 분쟁과 관련하여 이용자의 피해구제신청이 있는 경우에는 공정거래위원회 또는 시•도지사가 의뢰하는 분쟁조정기관의 조정에 따를 수 있습니다.</p><p>제24조(재판권 및 준거법)<br>① “몰”과 이용자 간에 발생한 전자상거래 분쟁에 관한 소송은 제소 당시의 이용자의 주소에 의하고, 주소가 없는 경우에는 거소를 관할하는 지방법원의 전속관할로 합니다. 다만, 제소 당시 이용자의 주소 또는 거소가 분명하지 않거나 외국 거주자의 경우에는 민사소송법상의 관할법원에 제기합니다.<br>② “몰”과 이용자 간에 제기된 전자상거래 소송에는 한국법을 적용합니다.<br></p>
							부 칙(시행일) 이 약관은 년 월 일부터 시행합니다.
						</div>        
					</div>
					<div class="agree2_3">
							
					</div>
				</div>
				
				<div class="agree3">
					<div class="agree3_1">
						<p class="agree3_1_1">
							<span>이용약관에 동의하십니까?</span>
							<input id="agree1" name="agree" value="" type="checkbox" style="display:inline-block; vertical-align: middle;" />동의함
						</p>
					</div>
				</div>
				<hr>
				<div class="agree2">
					<div class="agree2_1">
						<h5>[필수] 이용약관 동의</h5>
					</div>
					<div class="agree2_2 content">
	            		<div class="agree2_2_1" >
	            	    	<p>&nbsp;** 본 양식은 쇼핑몰 운영에 도움을 드리고자 샘플로 제공되는 서식으로 쇼핑몰 운영형태에 따른 수정이 필요합니다. 쇼핑몰에 적용하시기 전, 쇼핑몰 운영 사항 등을 확인하시고 적절한 내용을 반영하여 사용하시기 바랍니다. **</p><p>1. 개인정보 수집목적 및 이용목적</p><p>가. 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산</p><p>콘텐츠 제공 , 구매 및 요금 결제 , 물품배송 또는 청구지 등 발송 , 금융거래 본인 인증 및 금융 서비스</p><p>나. 회원 관리</p><p>회원제 서비스 이용에 따른 본인확인 , 개인 식별 , 불량회원의 부정 이용 방지와 비인가 사용 방지 , 가입 의사 확인 , 연령확인 , 만14세 미만 아동 개인정보 수집 시 법정 대리인 동의여부 확인, 불만처리 등 민원처리 , 고지사항 전달</p><p>2. 수집하는 개인정보 항목 : 이름 , 생년월일 , 성별 , 로그인ID , 비밀번호 , 자택 전화번호 , 휴대전화번호 , 이메일 , 14세미만 가입자의 경우 법정대리인의 정보</p><p>3. 개인정보의 보유기간 및 이용기간</p><p>원칙적으로, 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.</p><p>가. 회사 내부 방침에 의한 정보 보유 사유</p><p>o 부정거래 방지 및 쇼핑몰 운영방침에 따른 보관 : OO년</p><p>나. 관련 법령에 의한 정보보유 사유</p><p>o 계약 또는 청약철회 등에 관한 기록</p><p>-보존이유 : 전자상거래등에서의소비자보호에관한법률</p><p>-보존기간 : 5년</p><p>o 대금 결제 및 재화 등의 공급에 관한 기록</p><p>-보존이유: 전자상거래등에서의소비자보호에관한법률</p><p>-보존기간 : 5년&nbsp;</p><p>o 소비자 불만 또는 분쟁처리에 관한 기록</p><p>-보존이유 : 전자상거래등에서의소비자보호에관한법률</p><p>-보존기간 : 3년&nbsp;</p><p>o 로그 기록&nbsp;</p><p>-보존이유: 통신비밀보호법</p><p>-보존기간 : 3개월</p><p>※ 동의를 거부할 수 있으나 거부시 회원 가입이 불가능합니다.</p>
						</div>        
					</div>
					<div class="agree2_3">
							
					</div>
				</div>
		
				<div class="agree3">
					<div class="agree3_1">
						<p class="agree3_1_1">
							<span>개인정보 수집 및 이용에 동의하십니까?</span>
							<input id="agree2" name="agree" value="" type="checkbox" style="display:inline-block; vertical-align: middle;" />동의함
						</p>
					</div>
				</div>
			<br/>
	 		</div>
	 		<div style="height: 30px;">
	 		</div>
	 		<div style="height: 30px; width: 100%;"></div>
			<button type="button" class="nextbutton3" id="nextbutton3" style="border: none; float: right; " onclick="nextStep3();">다음 단계</button>
			<div style="height: 30px; width: 100%;"></div>
	 		
  </div>
  
    	
  
  <div style="width: 13%; display: inline-block;">
  
  </div>

  <div style="width: 100%; height: 70px;">
  </div>

</div>
<%-- --------------------------------------------------------------------------------------------------- --%>
<%-- 최종 가입 --------------------------------------------------------------------------------------------------- --%>
<div id="About" class="tabcontent tabcontent4">
  <div style="width: 100%; height: 20px;">
	  	<div style="width: 10%; display: inline-block;">
	  	</div>
	  	
	  	<div class="complete1" style="width: 79%; display: inline-block; text-align: left; font-size: 18pt; font-weight: bold;">
	  		<div style="width:30%; display: inline-block;"></div>
	  		<div style="width:15%; display: inline-block;">
				<button type="button" class="nextbutton4" id="nextbutton4" style="border: none; float:none; ; "  onclick="registerGo();">가입 하기</button>
			</div>
			<div style="width:42%; display: inline-block;"></div>
	 	</div>
	 	
	 	<div class="complete2" style="width: 79%; text-align:center; display: inline-block; text-align: left; font-size: 18pt; font-weight: bold;">

	  		<p style="text-align: center;">감사합니다.^^</p> 
	  		<p style="text-align: center;">승인후 가입이 최종 완료됩니다.</p>
	  		<p style="text-align: center;">승인이 되려면 객실등록은 필수입니다</p>

	 	</div>
	 	
		<div style="width: 9%; display: inline-block;">
	  	</div>
  </div>
   
</div>
<%-- --------------------------------------------------------------------------------------------------- --%>

<div class="footer">

	<a>회사소개</a> | <a>이용약관</a> | <a>개인정보처리방침</a> | <a>사업자 정보확인</a> | <a>콘텐츠산업진흥에의한 표시</a> 
    
    <br/> <br/>
	 고객행복센터 1670-6250 &nbsp;&nbsp; 오전 9시 - 새벽 3시, 점심시간: 오후 12시 - 오후 1시 <br/>
	<br/>
	(주) 위드이노베이션<br/>
	주소 : 서울특별시 강남구 봉은사로 479, 479타워 11층<br/>
	대표이사 : 최문석 | 사업자등록번호: 742-86-00224<br/>
	통신판매번호 : 2017-서울강남-01779 | 관광사업자 등록번호: 제1026-24호<br/>
	전화번호 : 1670-6250<br/>
	전자우편주소 : help@goodchoice.kr<br/>
	Copyright WITHINNOVATION Corp. All rights reserved.<br/>
</div>

</body>
</html>