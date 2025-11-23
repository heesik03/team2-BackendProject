<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<c:set var="pageTitle" value="회원가입" />
<%@ include file="/components/pageHead.jsp" %>

<c:if test="${not empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>

<body>
	<jsp:include page="/layout/header.jsp" />
	
	<main>
	    <form id="signupForm" action="${pageContext.request.contextPath}/signup.do" method="post">
	
	        <!-- 닉네임 -->
	        <label for="name-input">닉네임 : </label>
	        <input type="text" name="name" id="name-input"
	               placeholder="닉네임입력 (최대 20자)" maxlength="20" required><br>
	
	        <!-- 이메일 -->
	        <label for="email-input">아이디 : </label>
	        <input type="email" name="email" id="email-input"
	               placeholder="이메일 입력" maxlength="50" required>
	        <span id="email-message"></span>
	        <button type="button" id="check-email-btn">중복확인</button><br>
	
	        <!-- 비밀번호 -->
	        <label for="password-input">암호 : </label>
	        <input type="password" name="password" id="password-input"
	               placeholder="암호 입력 (문자+숫자+특수문자 8~20자)" maxlength="30" required>
	        <span id="pw-message"></span><br>
	
	        <!-- 비밀번호 확인 -->
	        <label for="confirm_password-input">암호 확인 : </label>
	        <input type="password" name="confirm_password" id="confirm_password-input"
	               placeholder="확인용 암호 입력" maxlength="30" required>
	        <span id="confirm-message"></span><br>
	
	        <!-- 도시 선택 -->
	        <label for="choose-city" style="display:block;">도시 선택</label>
	        <select id="choose-city" name="city" required>
	            <option value="" disabled selected>도시 선택</option>
	            <option value="도쿄">도쿄</option>
	            <option value="오사카">오사카</option>
	            <option value="교토">교토</option>
	            <option value="후쿠오카">후쿠오카</option>
	        </select>
	
	        <button type="submit" id="signupBtn">회원가입</button>
	    </form>
	
	    <c:if test="${not empty error}">
	        <p style="color:red;">${error}</p>
	    </c:if>
	
	</main>
	
	<%@ include file="/layout/footer.jsp" %>
	
	<!-- 여기 JS 기능 전체 추가 -->
	<script src="${pageContext.request.contextPath}/resource/js/checkPassword.js"></script>
	<script>
		let emailValid = false; // 이메일 중복 체크 성공 여부
	
		// 이메일 중복 체크 버튼 클릭
		document.getElementById("check-email-btn").addEventListener("click", function() {
	
		    const email = document.getElementById("email-input").value;
		    const msg = document.getElementById("email-message");
	
		    if (email.trim() === "") {
		        msg.innerHTML = "<span style='color:red;'>이메일을 입력하세요.</span>";
		        emailValid = false;
		        return;
		    }
	
		    fetch("${pageContext.request.contextPath}/signup.do?email=" + email)
		        .then(res => res.json())
		        .then(data => {
		            if (data.result === "exists") {
		                msg.innerHTML = "<span style='color:red;'>이미 사용 중인 이메일입니다.</span>";
		                emailValid = false;
		            } else {
		                msg.innerHTML = "<span style='color:green;'>사용 가능한 이메일입니다.</span>";
		                emailValid = true;
		            }
		        })
		        .catch(err => {
		            msg.innerHTML = "<span style='color:red;'>중복 체크 중 오류가 발생했습니다.</span>";
		            emailValid = false;
		        });
		});
	
		// submit 시 모든 조건 검사
		document.getElementById("signupForm").addEventListener("submit", function(event) {
	
		    if (!emailValid) {
		        alert("이메일 중복 체크를 먼저 완료해주세요.");
		        event.preventDefault();
		        return false;
		    }
	
		    if (!validatePassword()) {
		        alert("비밀번호 조건을 만족해야 합니다.");
		        event.preventDefault();
		        return false;
		    }
	
		    if (!validateConfirmPassword()) {
		        alert("비밀번호 확인이 일치해야 합니다.");
		        event.preventDefault();
		        return false;
		    }
	
		});
	</script>
</body>
</html>
