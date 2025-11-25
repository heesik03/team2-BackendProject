<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<!-- head (페이지 설정) 영역 -->
<c:set var="pageTitle" value="정보 변경" />
<%@ include file="/components/pageHead.jsp" %>

<!-- 로그아웃 상태라면 홈 화면으로 이동 -->
<c:if test="${empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>

<body>
	<jsp:include page="/layout/header.jsp" />
	
		<main>	
			<h3>정보 수정</h3>	<br>
			
			<h4>닉네임 변경</h4>
			<form>
				<label for="name-input">새 닉네임 : </label> 
				<input type="text" name="name" 
					id="name-input" placeholder="닉네임입력 (최대 20자)" maxlength=20 required><br>
				
				<button id="change-name-btn" type="button">
					닉네임 변경
				</button>
			</form>
			
			<br> <h4>선호 도시 변경</h4>
			<form>
				<!-- 도시 선택 -->
				<%@ include file="/components/selectCity.jsp" %>
				
				<br> <button id="change-city-btn" type="button">
					선호 도시 변경
				</button>
			</form>

			<br> <h4>비밀번호 변경</h4>
			<form action="${pageContext.request.contextPath}/mypage/change.do" method="post">
				<label for="current-password-input">암호 : </label>
				<input type="password" name="currentPassword" 
					id="current-password-input" placeholder="기존 암호 입력" maxlength=30 required><br>
			
				<label for="password-input">새 암호 : </label>
				<input type="password" name="newPassword" 
					id="password-input" placeholder="새 암호 입력 (최대 30자)" maxlength=30 required><br>
				<span id="pw-message"></span><br>

				<label for="confirm_password-input">새 암호 확인 : </label>
				<input type="password" name="confirmPassword" 
					id="confirm_password-input" placeholder="확인용 암호 입력" maxlength=30 required><br>
				<span id="confirm-message"></span><br>
				
				<button id="change-pwd-btn" type="submit">
					비밀번호 변경
				</button>
				
				<!-- 만약 비밀번호 변경 중 문제가 발생 했을 시 -->
				<c:if test="${not empty pwdError}">
				    <p style="color:red;">${pwdError}</p>
				</c:if>
			</form>
			
			
		</main>
		
	<%@ include file="/layout/footer.jsp" %>
	
	<script>
		const context = "${pageContext.request.contextPath}"; // 현재 경로 js에 전달
	</script>
	<script src="${pageContext.request.contextPath}/resource/js/utils/checkPassword.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/page/changeInfo.js"></script>
	
</body>
</html>