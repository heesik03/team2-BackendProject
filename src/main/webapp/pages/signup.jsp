<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
	<!-- head (페이지 설정) 영역 -->
	<c:set var="pageTitle" value="회원가입" />
	<%@ include file="/components/pageHead.jsp" %>
	
	<style>
	    body { 
	        font-family: 'Playfair Display', 'Noto Serif KR', serif; 
	        background-color: #FFFFFF; /* 흰색 배경 */
	    }
	
	    /* 폼 컨테이너 및 카드 스타일 */
	    .signup-container {
	        max-width: 750px; /* 가로비 */
	        margin: 50px auto;
	        padding: 20px;
	    }
	
	    .signup-card { 
	        border: none;
	        border-radius: 20px; 
	        padding: 40px;
	        background-color: white; 
	        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1); 
	        border: 1px solid #cceeff; /* 테두리 */
	    }
	    
	    /* 제목 스타일 */
	    .signup-title {
	        font-family: 'Playfair Display', serif;
	        font-size: 45px; 
	        font-weight: 800; 
	        text-align: center;
	        margin-bottom: 40px;
	        color: #160E0E;
	    }
	    
	    /* 폼 요소 스타일 */
	    .form-label { 
	        font-weight: 700; 
	        margin-bottom: 8px; 
	        color: #333;
	    }
	    .form-control, .form-select { 
	        border-radius: 10px; 
	        padding: 12px 15px; 
	        border: 1px solid #aaddff; /* 연한 파란색 입력 필드 테두리 유지 */
	        transition: border-color 0.3s, box-shadow 0.3s;
	    }
	    /* 입력 필드 포커스 시 강조 */
	    .form-control:focus, .form-select:focus {
	        border-color: #88ccff; /* 포커스 시 연한 파란색 유지 */
	        box-shadow: 0 0 0 0.25rem rgba(136, 204, 255, 0.25); /* 포커스 시 그림자 유지 */
	    }
	    
	    /* 버튼 스타일 */
	    .btn-primary-custom {
	        background-color: #4dc3ff; /* 버튼 파란색 */
	        border-color: #4dc3ff; /* 버튼 파란색  */
	        font-size: 1.2rem;
	        font-weight: 700;
	        padding: 12px 25px; 
	        border-radius: 10px; 
	        box-shadow: 0 4px 10px rgba(77, 195, 255, 0.4); /* 버튼 그림자 */
	        transition: background-color 0.3s, border-color 0.3s, transform 0.2s;
	    }
	    .btn-primary-custom:hover {
	        background-color: #26a9e0; 
	        border-color: #26a9e0; 
	        transform: translateY(-2px); 
	        box-shadow: 0 6px 15px rgba(77, 195, 255, 0.6); 
	    }
	
	    /* 푸터 스타일 (기존 유지) */
	    footer { 
	        background: #160E0E; 
	        color: white; 
	        padding: 32px 0; 
	        margin-top: 50px; 
	    }
	    footer p, footer a { font-size: 16px; color: #ccc; text-decoration: none; line-height: 1.8; }
	</style>
	
</head>

<c:if test="${not empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>

<body>
	<%@ include file="/layout/header.jsp"  %>
	
    <main class="signup-container">
        <h2 class="signup-title">Visit Japan 회원가입</h2>
        
        <div class="signup-card">
            <form action="${pageContext.request.contextPath}/signup.do" method="post" id="signupForm">
                
                <!-- 닉네임 -->
                <div class="mb-3">
                    <label for="name-input" class="form-label">닉네임</label> 
                    <input type="text" name="name" id="name-input" 
                           class="form-control" placeholder="닉네임 입력 (최대 20자)" 
                           maxlength="20" required>
                </div>
            
            		<!-- 이메일 -->
                <div class="mb-3">
                    <label for="email-input" class="form-label">아이디 (이메일)</label> 
                    <input type="email" name="email" id="email-input" 
                           class="form-control" placeholder="이메일 입력" 
                           maxlength="50" required>
                           
					<span id="email-message"></span>
	        			<button type="button" id="check-email-btn">중복확인</button><br>
	        			
                </div>
                
                <!-- 암호 -->
                <div class="mb-3">
                    <label for="password-input" class="form-label">암호</label>
                    <input type="password" name="password" id="password-input" 
                           class="form-control" placeholder="암호 입력 (최대 30자)" 
                           maxlength="30" required>
					<span id="pw-message"></span><br>
                </div>
                
                <!-- 암호 확인 -->
                <div class="mb-3">
                    <label for="confirm_password-input" class="form-label">암호 확인</label>
                    <input type="password" name="confirm_password" id="confirm_password-input" 
                           class="form-control" placeholder="확인용 암호 입력" 
                           maxlength="30" required>
					<span id="confirm-message"></span><br>
                </div>	
                
                 <!-- 도시 선택 -->
                <div class="mb-4">
                		<%@ include file="/components/selectCity.jsp" %>
                </div>
                
                <button type="submit" class="btn btn-primary-custom w-100">
                    <i class="bi bi-person-fill-add"></i> 회원가입
                </button>
            </form>
            
            <c:if test="${not empty error}">
                <p style="color:red; margin-top: 15px; text-align: center; font-weight: 700;">${error}</p>
            </c:if>
        </div>
    </main>
    
    <%@ include file="/layout/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	
	<!-- 여기 JS 기능 전체 추가 -->
	<script src="${pageContext.request.contextPath}/resource/js/utils/checkPassword.js"></script>
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
