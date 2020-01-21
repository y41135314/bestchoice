<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<script type="text/javascript">
	if( ${n==1} ) {
		alert("글 작성이 완료됐습니다.");
		location.href="<%= ctxPath %>/adminCommentBoard.bc";
	}
	else {
		alert("글 작성에 실패했습니다.");
		location.href="<%= ctxPath %>/adminCommentBoard.bc"
	}
</script>