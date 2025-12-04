<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<!-- 로딩 페이지는 최상단에 -->
<jsp:include page="/components/loading.jsp" />

<html lang="ko">
<head>
	<!-- head (페이지 설정) 영역 -->
	<c:set var="pageTitle" value="로그인" />
	<%@ include file="/components/pageHead.jsp" %>

	<style>
	    /*기본 설정 및 폰트 */
	    body {
	        font-family: 'Playfair Display', 'Noto Serif KR', serif; /* 폰트 대체 설정 완료 */
	        background: #F7F7F7;
	        margin: 0;
	        padding: 0;
	    }
	
	    /* 로그인 박스 스타일 */
	    .login-box {
	        border: 3px solid #6E98E5; 
	        background: white;
	        padding: 30px 40px; 
	        margin: 40px auto; 
	        text-align: center;
	        border-radius: 8px; /*둥근 모서리 카 */
	    }
	
	    /* 입력창 그룹 스타일 */
	    .login-icon-border {
	        border: 3px solid #6E98E5;
	        border-right: none;
	        background: white;
	        color: black;
	        font-size: 24px;
	        height: 50px;
	        display: flex;
	        align-items: center;
	    }
	    
	    #login-form-box .form-control {
	        border: 3px solid #6E98E5;
	        border-left: none;
	        height: 50px;
	        font-size: 20px;
	        font-family: 'Playfair Display', 'Noto Serif KR', serif;
	    }
	    
	    /* 버튼 스타일 */
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


<!-- 로그인 상태라면 홈 화면으로 로 이동 -->
<c:if test="${not empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>


<body>
	
	<%@ include file="/layout/header.jsp"  %>
	
    <main class="container py-3"> 
        <div class="row justify-content-center">
            <section class="col-md-8 col-lg-6 col-xl-6"> 
                <div class="card login-box" id="login-form-box">
                    
                    <h3 class="login-title mb-4">여행 갈 준비 되셨나요?</h3>

                    <form action="${pageContext.request.contextPath}/login.do" method="post">
                        <div class="input-group mb-3">
                            <span class="input-group-text login-icon-border">
                                <i class="bi bi-person-fill"></i> </span>
                            <input type="email" name="email" class="form-control" placeholder="아이디 (이메일)" required>
                        </div>

                        <div class="input-group mb-4">
                            <span class="input-group-text login-icon-border">
                                <i class="bi bi-lock-fill"></i> </span>
                            <input type="password" name="password" class="form-control" placeholder="암호" required>
                        </div>

                        <button type="submit" class="btn go-btn-custom">로그인</button>
                    </form>
					
					<!-- 아이디나 비밀번호가 틀리거나 서버에서 오류가 났을때 -->
                    <c:if test="${not empty message}">
                        <p class="error-message">${message}</p>
                    </c:if>
                    
                </div>
            </section>
        </div>
    </main>
    <%@ include file="/layout/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>