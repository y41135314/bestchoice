<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>

<script type="text/javascript">
	var result = 1;
	var loginuser = "${sessionScope.loginuser}";
	var gobackURL = "${requestScope.gobackURL}";
	
	if(result == 1 && (gobackURL == null || gobackURL == "") ) {
		alert("회원탈퇴 되었습니다.");
		location.href="<%= ctxPath%>/main.bc"; 
		/*로그인성공시 시작페이지로 가라.  */	
	}
	else if(result == 1 && (gobackURL != null && gobackURL != "") ) { 
		alert("회원탈퇴 되었습니다.");
		location.href=gobackURL;
		/* 돌아갈 페이지로 가라 */
	}
	
</script>  