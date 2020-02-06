<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<html>
  <head>
    <title>네이버로그인</title>
  </head>
  <body>
  
  </body>
  <script type="text/javascript">
        var naver_id_login = new naver_id_login("R46jg0rrGm3pHMtVmrNi", "http://localhost:9090/bestchoice/callbackNaverLogin.bc"); // 역시 마찬가지로 'localhost'가 포함된 CallBack URL
        
        // 접근 토큰 값 출력
        // alert(naver_id_login.oauthParams.access_token);
        
        // 네이버 사용자 프로필 조회
        naver_id_login.get_naver_userprofile("naverSignInCallback()");
        
        // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
        function naverSignInCallback() {
        /*  alert(naver_id_login.getProfileData('email'));
            alert(naver_id_login.getProfileData('nickname'));
            alert(naver_id_login.getProfileData('name'));
            alert(naver_id_login.getProfileData('gender')); */
            
            var email =  naver_id_login.getProfileData('email');
            var name = naver_id_login.getProfileData('name');
            var nickname = naver_id_login.getProfileData('nickname');
            var gender = naver_id_login.getProfileData('gender')
            
            var age = naver_id_login.getProfileData('age');
            
            var birthday = naver_id_login.getProfileData('birthday');
            
           // alert(naver_id_login.getProfileData('age'));  // 20-29
            // alert(naver_id_login.getProfileData('birthday'));  // 06-04
            
            $.ajax({
				url: "<%= request.getContextPath() %>/naverInsert.bc",
				data: {"email" : email, "name" :name, "nickname" :nickname , "gender" : gender, "age":age, "birthday":birthday },
				dataType: "JSON",
				success:function(json){
			        alert("로그인에 성공했습니다. SNS로그인은 회원 이벤트에 제한 받을 수 있습니다.");

			        window.opener.location.href="<%= request.getContextPath()%>/main.bc";	
					self.close(); 
					
				},error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
				
            });
			
            
        }
    </script>

</html>