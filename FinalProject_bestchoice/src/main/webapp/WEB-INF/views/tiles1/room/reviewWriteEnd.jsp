<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<script type="text/javascript">
// test_bestchoice
	
	if(${n==1}) {
		alert("글쓰기 성공!!!");
		location.href="<%= ctxPath%>/reviewWriteList.bc?member_idx=${sessionScope.loginuser.member_idx}";
	}
	else {
		alert("글쓰기 실패ㅠㅠ");
		location.href="javascript:history.back();";
	} 
	
</script>