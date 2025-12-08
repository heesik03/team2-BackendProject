<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- JSTL Core 라이브러리(c:)를 사용하기 위해 선언 --%>

<!DOCTYPE html>
<html lang="ko">

<head>
	<c:set var="pageTitle" value="Visit Japan - Sign Up" />
	<%@ include file="/components/pageHead.jsp" %>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/signup.css">
	<style>
		.btn-check-email {
			margin-top : 8px;
		    padding: 5px 12px; /* 상세 보기 스타일 우선 */
		    font-size: 13px;
		    border-radius: 4px;
		    text-decoration: none;
		    display: inline-block;
		    cursor: pointer;
		    transition: all 0.2s;
		    border: 1px solid #6c757d;
		    color: #6c757d;
		    background: white;
		    margin-right: 5px;
		}
	</style>
</head>

<c:if test="${not empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>

<body>
	<%-- 레이아웃 헤더(상단 네비게이션) 포함 --%>
	<jsp:include page="/layout/header.jsp" />
	
	
    <main class="signup-container">
        <h2 class="signup-title">Visit Japan 회원가입</h2>
        
        <div class="signup-card">
            <%-- 회원가입 폼: 데이터를 /signup.do로 POST 방식으로 전송 --%>
            <form action="${pageContext.request.contextPath}/signup.do" method="post" id="signupForm">
                
                <%-- 닉네임 입력 필드 --%>
                <div class="mb-3">
                    <label for="name-input" class="form-label">닉네임</label> 
                    <input type="text" name="name" id="name-input" 
                           class="form-control" placeholder="닉네임 입력 (최대 20자)" 
                           maxlength="20" required>
                </div>
            
            		<%-- 이메일 입력 필드 --%>
            		<div class="mb-3">
                    <label for="email-input" class="form-label">아이디 (이메일)</label> 
                    <input type="email" name="email" id="email-input" 
                           class="form-control" placeholder="이메일 입력" 
                           maxlength="50" required>
                           
					<span id="email-message"></span> <%-- 이메일 중복 확인 결과 메시지 출력 --%>
	        			<button type="button" 
	        				id="check-email-btn" 
	        				class="btn-check-email">
	        				중복확인
	        			</button><br>
	        			
                </div>
                
                <%-- 암호 입력 필드 --%>
                <div class="mb-3">
                    <label for="password-input" class="form-label">암호</label>
                    <input type="password" name="password" id="password-input" 
                           class="form-control" placeholder="암호 입력 (최대 30자)" 
                           maxlength="30" required>
					<span id="pw-message"></span><br> <%-- 비밀번호 유효성 검사 메시지 출력 --%>
                </div>
                
                <%-- 암호 확인 입력 필드 --%>
                <div class="mb-3">
                    <label for="confirm_password-input" class="form-label">암호 확인</label>
                    <input type="password" name="confirm_password" id="confirm_password-input" 
                           class="form-control" placeholder="확인용 암호 입력" 
                           maxlength="30" required>
					<span id="confirm-message"></span><br> <%-- 비밀번호 일치 여부 메시지 출력 --%>
                </div>	
                
                 <%-- 도시 선택 드롭다운 (별도 JSP 파일 포함) --%>
                 <div class="mb-4">
                		<%@ include file="/components/selectCity.jsp" %>
                </div>
                
                <%-- 최종 회원가입 제출 버튼 --%>
                <button type="submit" class="btn btn-primary-custom w-100">
                    <i class="bi bi-person-fill-add"></i> 회원가입
                </button>
            </form>
            
            <%-- 서버에서 전달된 에러 메시지 표시 --%>
            <c:if test="${not empty error}">
                <p style="color:red; margin-top: 15px; text-align: center; font-weight: 700;">${error}</p>
            </c:if>
        </div>
    </main>
    
    <%@ include file="/layout/footer.jsp" %>
	
	<%-- **JavaScript 유효성 검사 로직** --%>
	
	<%-- 비밀번호 유효성 검사 로직이 담긴 외부 JS 파일 로드 --%>
	<script src="${pageContext.request.contextPath}/resource/js/utils/checkPassword.js"></script>
	<script>
		let emailValid = false; // 이메일 중복 체크 성공 여부를 저장하는 플래그
	
		// 이메일 중복 체크 버튼 클릭 이벤트 처리
		document.getElementById("check-email-btn").addEventListener("click", function() {
	
		    const email = document.getElementById("email-input").value;
		    const msg = document.getElementById("email-message");
	
		    
		    if (email.trim() === "") {
		        msg.innerHTML = "<span style='color:red;'>이메일을 입력하세요.</span>";
		        emailValid = false;
		        return;
		    }
	
		    // 서버에 이메일 중복 체크 요청 (GET 방식)
		    fetch("${pageContext.request.contextPath}/signup.do?email=" + email)
		        .then(res => res.json())
		        .then(data => {
		            if (data.result === "exists") {
		                // 이메일이 이미 존재하는 경우
		                msg.innerHTML = "<span style='color:red;'>이미 사용 중인 이메일입니다.</span>";
		                emailValid = false;
		            } else {
		                // 이메일 사용 가능한 경우
		                msg.innerHTML = "<span style='color:green;'>사용 가능한 이메일입니다.</span>";
		                emailValid = true;
		            }
		        })
		        .catch(err => {
		            // 오류 발생 시
		            msg.innerHTML = "<span style='color:red;'>중복 체크 중 오류가 발생했습니다.</span>";
		            emailValid = false;
		        });
		});
	
		// 회원가입 버튼 눌렀을 시 이벤트 처리
		document.getElementById("signupForm").addEventListener("submit", function(event) {
	
		    // 이메일 중복 체크 
		    if (!emailValid) {
		        alert("이메일 중복 체크를 먼저 완료해주세요.");
		        event.preventDefault(); // 폼 제출 방지
		        return false;
		    }
	
		    // 비밀번호 유효성 검사 (checkPassword.js 파일의 함수 사용)
		    if (!validatePassword()) {
		        alert("비밀번호 조건을 만족해야 합니다.");
		        event.preventDefault(); 
		        return false;
		    }
	
		    // 비밀번호 확인 일치 검사 (checkPassword.js 파일의 함수 사용)
		    if (!validateConfirmPassword()) {
		        alert("비밀번호 확인이 일치해야 합니다.");
		        event.preventDefault(); 
		        return false;
		    }
            	
		});
	</script>
</body>
</html>