<%-- JSP 페이지 지시문 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%-- JSTL Core 라이브러리 태그 사용 선언--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<%-- 로딩 인디케이터 --%>
<jsp:include page="/components/loading.jsp" />

<html lang="ko">
<head>
    <c:set var="pageTitle" value="마이페이지" />
    <%@ include file="/components/pageHead.jsp" %>

    <%-- Google Maps API 로드 --%>
    <script src="https://maps.googleapis.com/maps/api/js?key=${APIKey}&libraries=places&loading=async"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mypage.css">

	<script>
        // 세션 스코프에서 사용자 ID를 JavaScript 변수에 할당
    		const userId = "${sessionScope.id}";
	</script>
</head>

<c:if test="${empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>

<body data-context-path="${pageContext.request.contextPath}">

    <%-- header.jsp import --%>
	<%@ include file="/layout/header.jsp" %>
    
    <main class="container py-5">
        
        <%-- 1. 내 프로필 섹션 --%>
        <div class="section-card">
            <h3 class="section-title">내 프로필</h3>
            <div class="row align-items-center">
                <%-- 프로필 아이콘 --%>
                <div class="col-md-2 text-center mb-3 mb-md-0">
                    <i class="bi bi-person-circle profile-icon"></i>
                </div>
                
                <%-- 사용자 상세 정보 --%>
                <div class="col-md-10">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="user-detail-label">이름</div>
                            <div class="user-detail-value">${userData.userName} 님</div>
                        </div>
                        <div class="col-md-6">
                            <div class="user-detail-label">이메일</div>
                            <div class="user-detail-value">${userData.email}</div>
                        </div>
                        <div class="col-md-6">
                            <div class="user-detail-label">가입일</div>
                            <div class="user-detail-value">
                                <%-- JavaScript를 이용해 날짜 형식을 변경할 예정인 <span> 태그 --%>
                                <span class="createAt" data-date="${userData.createAt}"></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="user-detail-label">회원 유형</div>
                            <div class="user-detail-value">
                                <%-- 관리자 여부에 따라 뱃지 색상과 텍스트 변경 --%>
                                <span class="badge ${userData.admin ? 'text-bg-warning' : 'text-bg-secondary'}">
                                    ${userData.admin ? '관리자' : '일반 사용자'}
                                </span>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="user-detail-label">선호 도시</div>
                            <div class="user-detail-value text-primary">${userData.likeCity}</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%-- 2. 스크랩한 관광지 섹션 --%>
        <div class="section-card">
            <h3 class="section-title">스크랩한 관광지</h3>
            <div class="row g-4">
                <c:forEach var="city" items="${userData.cityList}">
                    <div class="col-md-6 col-lg-4">
                        <div class="city-card">
                            <div class="city-header">
                                <i class="bi bi-geo-alt-fill text-danger me-1"></i> ${city.cityName}
                            </div>
                            <ul class="spot-list">
                                <c:choose>
                                    <%-- 스크랩된 장소가 없는 경우 --%>
                                    <c:when test="${empty city.spots}">
                                        <li class="spot-item text-muted justify-content-center">
                                            <small>스크랩 된 장소가 없습니다.</small>
                                        </li>
                                    </c:when>
                                    <%-- 스크랩된 장소가 있는 경우 --%>
                                    <c:otherwise>
                                        <c:forEach var="spot" items="${city.spots}">
                                            <li class="spot-item">
                                                <span>${spot}</span>
                                                <%-- 장소 삭제 폼: JavaScript/AJAX로 처리 --%>
                                                <form class="delete-city-form m-0"
                                                      data-spot="${spot}"
                                                      data-city="${city.cityName}">
                                                    <button type="submit" class="delete-btn" title="삭제">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </form>
                                            </li>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <%-- 3. 관광지 검색 & 스크랩 섹션 --%>
        <div class="section-card">
            <h3 class="section-title">관광지 검색, 스크랩</h3>
            <div class="row justify-content-center mb-4">
                <div class="col-lg-8">
                    <div class="mb-3">
                        <%-- 선호 도시 선택 드롭다운 컴포넌트 포함 --%>
                        <%@ include file="/components/selectCity.jsp" %>
                    </div>
                
                    <form class="search-from search-input-group">
                        <%-- 관광지 검색 입력 필드 --%>
                        <input type="search"
                               id="searchInput"   
                               class="form-control form-control-lg"
                               placeholder="관광지를 검색해보세요"
                               autocomplete="off"
                               required>
                        <%-- 검색 버튼 --%>
                        <button type="submit" id="search-btn">
                            <i class="bi bi-search fs-4"></i>
                        </button>
                    </form>
                </div>
            </div>
            
            <%-- Google Map 표시 영역 (검색 전에는 숨겨져 있음) --%>
            <div id="mapDiv" style="display: none;" class="mt-4 animate__animated animate__fadeIn">
                <div id="map"></div>
                <div class="text-center mt-4">
                    <%-- 현재 검색된 장소를 스크랩 목록에 추가하는 버튼 --%>
                    <button class="add-scrap-btn btn btn-primary btn-lg px-5 rounded-pill shadow-sm" type="button">
                        <i class="bi bi-bookmark-plus me-2"></i>스크랩 추가
                    </button>
                </div>
            </div>
        </div>
        
        <%-- 4. 네비게이션 버튼 섹션 --%>
        <nav class="row g-3 justify-content-center">
            <div class="col-md-4">
                <%-- 정보 수정 페이지로 이동 --%>
                <a href="${pageContext.request.contextPath}/pages/mypage/changeInfo.jsp?like-city=${userData.likeCity}" class="nav-btn btn-info-custom">
                    <i class="bi bi-gear-fill me-2"></i>정보 수정
                </a>
            </div>
            <div class="col-md-4">
                <%-- 여행 일정 목록 페이지로 이동 --%>
                <a href="${pageContext.request.contextPath}/mypage/itinerary.do" class="nav-btn btn-schedule-custom">
                    <i class="bi bi-calendar-check-fill me-2"></i>여행 일정
                </a>
            </div>
            
            <%-- 관리자일 경우에만 관리자 페이지 버튼 표시 --%>
            <c:if test="${userData.admin}">
                <div class="col-md-4">
                    <a href="${pageContext.request.contextPath}/admin.do" target="_blank" class="nav-btn btn-admin-custom">
                        <i class="bi bi-shield-lock-fill me-2"></i>관리자 페이지
                    </a>
                </div>
            </c:if>
        </nav>
        
        <%-- 5. 회원 탈퇴 버튼 --%>
        <div class="text-center">
            <button id="delete-account-btn" type="button" class="delete-account">
                회원탈퇴
            </button>
        </div>
        
    </main>
    
    <%@ include file="/layout/footer.jsp" %>
        
    <script src="${pageContext.request.contextPath}/resource/js/utils/changeDate.js"></script>
    <script src="${pageContext.request.contextPath}/resource/js/utils/createGoogleMap.js"></script>
    <script>
        // 컨텍스트 경로를 JavaScript 변수에 저장 (AJAX 요청 등에 사용)
        const contextPath = "${pageContext.request.contextPath}"
    </script>
    <%-- 마이페이지 전용 JavaScript 로드 (검색, 스크랩 추가/삭제, 회원 탈퇴 로직 포함) --%>
    <script src="${pageContext.request.contextPath}/resource/js/page/mypage.js"></script>
</body>
</html>