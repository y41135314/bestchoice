<center>
<script type = "text/javascript" src = "https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
 
<div id = "naver_id_login"></div>
 
<script type="text/javascript">
 
         var naver_id_login = new naver_id_login("R46jg0rrGm3pHMtVmrNi", "http://localhost:9090/bestchoice/callbackNaverLogin.bc");    // Client ID, CallBack URL 삽입
                                            // 단 'localhost'가 포함된 CallBack URL
         var state = naver_id_login.getUniqState();
        
         naver_id_login.setButton("white", 4, 40);
         naver_id_login.setDomain("http://localhost:9090/bestchoice/userNaverLogin.bc");    //  URL
         naver_id_login.setState(state);
         naver_id_login.setPopup();
         naver_id_login.init_naver_id_login();
 
</script>
</center>