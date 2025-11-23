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
	
	<script src="${pageContext.request.contextPath}/resource/js/checkPassword.js"></script>
	<script>
		document.getElementById("change-pwd-btn").addEventListener("click", function (e) { 
			
		    if (!validatePassword()) {
		        alert("비밀번호 조건을 만족해야 합니다.");
		        e.preventDefault();
		        return false;
		    }
			
		    if (!validateConfirmPassword()) {
		    		alert("비밀번호 확인이 일치해야 합니다.");
		        e.preventDefault();
		        return false;
		    }
			
			
		    if (!confirm("정말 비밀번호를 변경하시겠습니까? (변경 후 로그아웃 됨)")) {
		        e.preventDefault(); // 취소 시 submit 중단
		    }
		    
		});
		
		document.getElementById("change-name-btn").addEventListener("click", function () {
		    if (!confirm("정말 닉네임을 변경 하시겠습니까?")) return;

		    const name = document.getElementById("name-input").value; // 보낼 새로운 이름

		    fetch(`${pageContext.request.contextPath}/mypage/change.do`, {
		        method: "PUT",
		        headers: { "Content-Type": "application/json" },
		        body: JSON.stringify({ name })
		    })
		    .then(res => {
		        if (res.status === 204) {
		            alert("닉네임 변경 성공!");
		            window.location.href = `${pageContext.request.contextPath}/mypage.do`;
		        } else {
		            alert("닉네임 변경 중 오류 발생");
		            res.text().then(text => console.error("변경 실패:", text));
		        }
		    })
		    .catch(err => console.error(err));
		});
	</script>
	
</body>
</html>