<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<!-- head (페이지 설정) 영역 -->
<c:set var="pageTitle" value="회원가입" />
<%@ include file="/components/pageHead.jsp" %>

<!-- 로그아웃 상태라면 홈 화면으로 로 이동 -->
<c:if test="${not empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>

<body>	
	<jsp:include page="/layout/header.jsp" />
	
	<main>
		<form action="${pageContext.request.contextPath}/signup.do" method="post">
			<label for="name-input">닉네임 : </label> 
			<input type="text" name="name" 
				id="name-input" placeholder="닉네임입력 (최대 20자)" maxlength=20 required><br>
		
			<label for="email-input">아이디 : </label> 
			<input type="email" name="email" 
				id="email-input" placeholder="이메일 입력" maxlength=50 required><br>
			
			<label for="password-input">암호 : </label>
			<input type="password" name="password" 
				id="password-input" placeholder="암호 입력 (최대 30자)" maxlength=30 required><br>
			
			<label for="password-input">암호 확인 : </label>
			<input type="password" name="confirm_password" 
				id="confirm_password-input" placeholder="확인용 암호 입력" maxlength=30 required><br>
			
		    <label for="choose-city" style="display: block;">도시 선택</label>
			<select id="choose-city" name="city" required>
			    <option value="" disabled selected>도시 선택</option>
			    <option value="도쿄">도쿄</option>
			    <option value="오사카">오사카</option>
			    <option value="교토">교토</option>
			    <option value="후쿠오카">후쿠오카</option>
			</select>
		    
			<button type="submit">
				회원가입
			</button>	
		</form>
		
		<!-- 만약 회원가입 시 문제가 발생했을 시 -->
		<c:if test="${not empty error}">
		    <p style="color:red;">${error}</p>
		</c:if>
	</main>
	
	<%@ include file="/layout/footer.jsp" %>
</body>
</html>