<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
    <!-- =에러 처리 페이지 -->
    
    <%-- isErrorPage="true" 주는 것에 유의 --%>
    
<%
	response.setStatus(200);//IE
%>
<script>
	alert('<%=exception.getMessage()%>');
	history.back();
</script>