<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<jsp:include page="/components/loading.jsp" />

<html lang="ko">
<head>
	<c:set var="pageTitle" value="Visit Japan - Log in" />
	<%@ include file="/components/pageHead.jsp" %>

	<style>
	    /*기본 설정 및 폰트 */
	    body {
	        /* CSS 폰트 대체 설정 완료 */
	        font-family: 'Playfair Display', 'Noto Serif KR', serif; 
	        background: #F7F7F7;
	        margin: 0;
	        padding: 0;
	    }
	
	    /* 로그인 박스 스타일 (로그인 폼을 감싸는 컨테이너) */
	    .login-box {
	        border: 3px solid #6E98E5; /* 강조된 테두리 */
	        background: white;
	        padding: 30px 40px; 
	        margin: 40px auto; /* 중앙 정렬 */
	        text-align: center;
	        border-radius: 8px; /* 둥근 모서리 */
	    }
	
	    /* 입력창 그룹의 아이콘 영역 스타일 */
	    .login-icon-border {
	        border: 3px solid #6E98E5;
	        border-right: none; /* input과의 경계를 없앰 */
	        background: white;
	        color: black;
	        font-size: 24px;
	        height: 50px;
	        display: flex;
	        align-items: center;
	    }
	    
	    /* 실제 입력 필드(form-control) 스타일 */
	    #login-form-box .form-control {
	        border: 3px solid #6E98E5;
	        border-left: none; /* 아이콘 영역과의 경계를 없앰 */
	        height: 50px;
	        font-size: 20px;
	        font-family: 'Playfair Display', 'Noto Serif KR', serif;
	    }
	    
	    /* 로그인 버튼 스타일 */
	    .go-btn-custom {
	        background: #6CC7F4;
	        color: black;
	        width: 200px;
	        border: none;
	        padding: 10px 0;
	        font-size: 22px;
	        cursor: pointer;
	        margin-top: 25px;
	    }
	    /* 에러 메시지 스타일 */
	    .error-message {
	        color: red;
	        font-size: 1rem;
	        margin-top: 1rem;
	    }
	</style>
	
</head>

<c:if test="${not empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>


<body>
	
	<%-- 레이아웃 헤더(상단 네비게이션) 포함 --%>
	<%@ include file="/layout/header.jsp" %>
	
    <main class="container py-3"> 
        <div class="row justify-content-center">
            <section class="col-md-8 col-lg-6 col-xl-6"> 
                <div class="card login-box" id="login-form-box">
                    
                    <h3 class="login-title mb-4">여행 갈 준비 되셨나요?</h3>

                    <%-- 로그인 폼: 데이터를 /login.do로 POST 방식으로 전송 --%>
                    <form action="${pageContext.request.contextPath}/login.do" method="post">
                        
                        <%-- 아이디 (이메일) 입력 그룹 --%>
                        <div class="input-group mb-3">
                            <span class="input-group-text login-icon-border">
                                <i class="bi bi-person-fill"></i> </span>
                            <%-- name="email"로 서버에 전송 --%>
                            <input type="email" name="email" class="form-control" placeholder="아이디 (이메일)" required>
                        </div>

                        <%-- 암호 (password) 입력 그룹 --%>
                        <div class="input-group mb-4">
                            <span class="input-group-text login-icon-border">
                                <i class="bi bi-lock-fill"></i> </span>
                            <%-- name="password"로 서버에 전송 --%>
                            <input type="password" name="password" class="form-control" placeholder="암호" required>
                        </div>

                        <%-- 로그인 제출 버튼 --%>
                        <button type="submit" class="btn go-btn-custom">로그인</button>
                    </form>
					
					<%-- 
					에러 메시지 표시: 서버에서 로그인 실패 시 'message'라는 이름으로
					에러 메시지를 전달받아 사용자에게 보여줌 (예: 아이디/비밀번호 불일치)
					--%>
                    <c:if test="${not empty message}">
                        <p class="error-message">${message}</p>
                    </c:if>
                    
                </div>
            </section>
        </div>
    </main>
    
    <%-- 레이아웃 푸터 포함 --%>
    <%@ include file="/layout/footer.jsp" %>

</body>
</html>