<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% String ctxPath = request.getContextPath(); %>

<script type="text/javascript">
	var loginuser = "${sessionScope.loginuser}";
	var gobackURL = "${requestScope.gobackURL}";
	
	if(loginuser != null && (gobackURL == null || gobackURL == "") ) {
		alert("업데이트 성공!!");
		location.href="<%= ctxPath%>/myPage.bc"; 
		/*로그인성공시 시작페이지로 가라.  */	
	}
	else if(loginuser != null && (gobackURL != null && gobackURL != "") ) { 
		alert("업데이트 성공!~");
		location.href="<%= ctxPath%>/myPage.bc"; 

	}
	
</script>  