<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<script type="text/javascript">
// test_bestchoice
	if(${n==1}) {
		alert("글수정 성공!!!");
		location.href="<%= ctxPath%>/roomReview.bc";
	}
	else {
		alert("글수정 실패ㅠㅠ");
		location.href="javascript:history.back();";
	} 
	
</script>