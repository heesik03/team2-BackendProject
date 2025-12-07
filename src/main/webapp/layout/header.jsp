<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* 폰트 로드: Google Fonts에서 'Playfair Display' 폰트를 불러옴 */
    @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&display=swap');
    
    /* body 전체의 기본 폰트 설정 (최우선 순위 확보) */
    body {
        /* 로고와 본문에 특정 폰트(Playfair Display)를 강제 적용 */
        font-family: 'Playfair Display', 'Noto Sans KR', serif !important;
    }
</style>


<header>
    <nav class="navbar navbar-expand-lg bg-white">
        <div class="container-fluid">

            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp" style="font-size: 40px;">
                visit japan
            </a>
            
            <%-- 모바일 환경에서 메뉴를 토글하는 버튼 (햄버거 버튼) --%>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button> 
            
            <%-- 네비게이션 메뉴 영역 (모바일에서 축소, 데스크탑에서 확장) --%>
			<div class="collapse navbar-collapse" id="navbarNav" style="font-size: 24px;">
			    <ul class="navbar-nav ms-auto align-items-center">
			
			        <li class="nav-item me-3">
			            <a class="nav-link" href="${pageContext.request.contextPath}/pages/about.jsp">about</a>
			        </li>
			
			        <c:choose>
			            <c:when test="${not empty sessionScope.id}">
			                <!-- 로그인 상태 -->
			                <li class="nav-item me-3">
			                    <a class="nav-link" href="${pageContext.request.contextPath}/mypage.do">my page</a>
			                </li>
			
			                <li class="nav-item">
			                    <form action="${pageContext.request.contextPath}/logout.do" method="post" class="d-flex">
			                        <button type="submit" class="btn btn-primary px-3"
			                            style="font-size: 19px; background-color: #6E98E5; border: none;">
			                            log out
			                        </button>
			                    </form>
			                </li>
			            </c:when>
			
			            <c:otherwise>
			                <!-- 로그아웃 상태 -->
			                <li class="nav-item me-3">
			                    <a class="nav-link" href="${pageContext.request.contextPath}/pages/signup.jsp">sign up</a>
			                </li>
			
			                <li class="nav-item">
			                    <a class="btn btn-primary px-3"
			                       href="${pageContext.request.contextPath}/pages/login.jsp"
			                       style="font-size: 19px; background-color: #6E98E5; border: none;">
			                        log in
			                    </a>
			                </li>
			            </c:otherwise>
			        </c:choose>
			
			    </ul>
			</div>

        </div>
    </nav>
    
</header>