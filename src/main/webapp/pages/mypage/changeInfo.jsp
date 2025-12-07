<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
	<c:set var="pageTitle" value="Visit Japan - 정보 변경" />
	<%@ include file="/components/pageHead.jsp" %>

    <%-- CSS 스타일 --%>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f9fa; /* 연한 회색 배경, 인덱스 가독성상승 목적  */
            color: #333;
        }
        
        .settings-container { /* 정보 수정 폼 전체 컨테이너 설정  */
            max-width: 600px; /* 폼 컨테이너 최대 너비 */
            margin: 0 auto; /* 중앙 정렬 */
        }

        .section-card { /* 닉네임, 선호도시, 비밀번호 변경 등 각각의 기능 섹션  */
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.04); 
            padding: 2rem;
            margin-bottom: 1.5rem;
            border: 1px solid #e9ecef;
        }

        .section-title { /* 각 기능 섹션 제목(ex.비밀번호변경, 닉네임변경 ) */
            font-weight: 700;
            font-size: 1.1rem;
            margin-bottom: 1.25rem;
            color: #495057;
            border-bottom: 2px solid #f1f3f5; /* 구분선 */
            padding-bottom: 0.75rem;
        }

        .form-label { /* 입력 필드 라벨, 필드 제목 역할  */
            font-weight: 500;
            color: #666;
            font-size: 0.95rem;
        }

        .form-control, .form-select { /* 텍스트 입력 칸 및 드롭다운 선택 메뉴  */
            padding: 0.75rem;
            border-radius: 8px;
            border: 1px solid #dee2e6;
        }
        .form-control:focus { /* 입력칸에 커서가 있을때 상태 변경  */
            box-shadow: 0 0 0 3px rgba(13, 110, 253, 0.15); /* 포커스 시 부드러운 파란색 그림자 */
        }

        .btn-action { /* 버튼 액션 디자인 설정  */
            width: 100%;
            padding: 0.75rem;
            border-radius: 8px;
            font-weight: 600;
            margin-top: 1rem;
        }
        
        .message-text { 
            font-size: 0.85rem;
            margin-top: 0.25rem;
            display: block; 
        }
    </style>
</head>

<c:if test="${empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>

<body>
	<jsp:include page="/layout/header.jsp" />
	
    <main class="container py-5">
        <div class="settings-container">
            <h2 class="text-center fw-bold mb-4">내 정보 수정</h2>

            <%-- 닉네임 변경 섹션 --%>
            <div class="section-card">
                <h4 class="section-title">닉네임 변경</h4> 
                <form> <%-- 사용자 입력 컨테이너 폼  --%>
                    <div class="mb-3">
                        <label for="name-input" class="form-label">새 닉네임</label> 
                        <input type="text" name="name" <%-- 서버로 전달될 파라미터 이름 name --%>
                            id="name-input" class="form-control" 
                            placeholder="닉네임 입력 (최대 20자)" maxlength="20" required> <%-- 닉네임 최대 입력 20자 설정  --%>
                    </div>
                    
                    <%-- 닉네임 변경 버튼 (JavaScript로 처리될 예정) --%>
                    <button id="change-name-btn" type="button" class="btn btn-primary btn-action"> <%-- 클릭 이벤트 연결 id  --%>
                        닉네임 변경
                    </button>
                </form>
            </div>
            
            <%-- 선호 도시 변경 섹션 --%>
            <div class="section-card">
                <h4 class="section-title">선호 도시 변경</h4>
                <form>
                    <div class="mb-3">
                        <label class="form-label">도시 선택</label>
                        <%-- 도시 선택 드롭다운 메뉴 포함 --%>
                        <%@ include file="/components/selectCity.jsp" %>
                    </div>
                    
                    <%-- 선호 도시 변경 버튼 (JavaScript로 처리될 예정) --%>
                    <button id="change-city-btn" type="button" class="btn btn-outline-primary btn-action">
                        선호 도시 변경
                    </button>
                </form>
            </div>

            <%-- 비밀번호 변경 섹션 --%>
            <div class="section-card">
                <h4 class="section-title">비밀번호 변경</h4>
                <%-- 폼 제출 시 POST 방식으로 /mypage/change.do 서블릿 호출 --%>
                <form action="${pageContext.request.contextPath}/mypage/change.do" method="post">
                    <div class="mb-3">
                        <label for="current-password-input" class="form-label">현재 암호</label>
                        <input type="password" name="currentPassword" 
                            id="current-password-input" class="form-control" 
                            placeholder="기존 암호 입력" maxlength="30" required>
                    </div>
                
                    <div class="mb-3">
                        <label for="password-input" class="form-label">새 암호</label>
                        <input type="password" name="newPassword" 
                            id="password-input" class="form-control" 
                            placeholder="새 암호 입력 (최대 30자)" maxlength="30" required>
                        <%-- 비밀번호 유효성 검사 메시지 표시 영역 --%>
                        <span id="pw-message" class="message-text"></span>
                    </div>

                    <div class="mb-3">
                        <label for="confirm_password-input" class="form-label">새 암호 확인</label>
                        <input type="password" name="confirmPassword" 
                            id="confirm_password-input" class="form-control" 
                            placeholder="확인용 암호 입력" maxlength="30" required>
                        <%-- 비밀번호 확인 메시지 표시 영역 --%>
                        <span id="confirm-message" class="message-text"></span>
                    </div>
                    
                    <%-- 비밀번호 변경 제출 버튼 --%>
                    <button id="change-pwd-btn" type="submit" class="btn btn-warning text-white btn-action">
                        비밀번호 변경
                    </button>
                    
                    <%-- 비밀번호 변경 실패 시 서버에서 전달된 에러 메시지 출력 --%>
                    <c:if test="${not empty pwdError}">
                        <div class="alert alert-danger mt-3 mb-0 text-center" role="alert">
                            ${pwdError}
                        </div>
                    </c:if>
                </form>
            </div>
            
        </div>
    </main>
		
	<%@ include file="/layout/footer.jsp" %>

	<script>
		// JSP 컨텍스트 경로를 JavaScript 변수로 저장
		const context = "${pageContext.request.contextPath}"; // 현재 경로 js에 전달
	</script>
	<script src="${pageContext.request.contextPath}/resource/js/utils/checkPassword.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/page/changeInfo.js"></script>
	
</body>
</html>