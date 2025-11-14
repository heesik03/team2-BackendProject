<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 로그인 상태라면 home.do 로 이동 -->
<c:if test="${not empty sessionScope.name}">
    <c:redirect url="home.do" />
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
</head>
<body>
	<jsp:include page="/layout/header.jsp" />
	
	<main>
		<h3>로그인 페이지</h3>
		
		<form action="${pageContext.request.contextPath}/login.do" method="post">
			<label for="email-input">아이디 : </label> 
			<input type="email" name="email" 
				id="email-input" placeholder="이메일 입력" required><br>
			
			<label for="password-input">암호 : </label>
			<input type="password" name="password" 
				id="password-input" placeholder="암호 입력" required><br>
			
			<button type="submit">
				로그인
			</button>
		</form>
		
		<!-- 만약 아이디나 비밀번호가 틀렸을 시 -->
		<c:if test="${not empty message}">
		    <p style="color:red;">${message}</p>
		</c:if>

	</main>
	
	 <%@ include file="/layout/footer.jsp" %>
</body>
</html>