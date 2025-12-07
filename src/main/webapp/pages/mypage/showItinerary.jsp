<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="java.util.List" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <c:set var="pageTitle" value="여행 일정 보기" />
    <%@ include file="/components/pageHead.jsp" %>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/itinerary.css"> 
    
    <%-- Google Maps API 로드 --%>
    <script src="https://maps.googleapis.com/maps/api/js?key=${APIKey}&libraries=places&loading=async"></script>
</head>

<c:if test="${empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>

<body data-context-path="${pageContext.request.contextPath}" data-refresh="true">
    <jsp:include page="/layout/header.jsp" />
    
    <main class="py-5">
        <div class="view-container">
            <section>
                <c:choose>
                    <c:when test="${empty itineraryData}">
                        <%-- 여행 일정 데이터가 없을 경우 --%>
                        <div class="text-center py-5 text-muted">
                            <i class="bi bi-exclamation-circle display-4 mb-3 d-block"></i>
                            일정을 가져오지 못했습니다.
                        </div>
                    </c:when>
    
                    <c:otherwise>
                        <%-- 여행 일정 데이터가 있을 경우 --%>
                        <div class="itinerary-header">
                            <div>
                                <h3 class="itinerary-title">${itineraryData.title}</h3>
                                <%-- 여행 일정 제목 표시 --%>
                                <div class="itinerary-meta">
                                    <span class="me-3"><i class="bi bi-calendar-range me-1"></i> ${itineraryData.startDate} ~ ${itineraryData.endDate}</span>
                                    <%-- 여행 기간 표시 --%>
                                    <span><i class="bi bi-pencil-square me-1"></i> 작성일: <span class="createAt" data-date="${itineraryData.createAt}"></span></span>
                                    <%-- 작성일 표시 (스크립트에서 실제 날짜 포맷팅) --%>
                                </div>
                            </div>
                            <div>
                                <a href="${pageContext.request.contextPath}/mypage/edit-itinerary.do?id=${itineraryData.id}" class="btn-action btn-edit">
                                    <i class="bi bi-pencil"></i> 수정
                                </a>
                                <%-- 일정 수정 페이지로 이동 버튼 --%>
                                <button type="button" class="btn-action btn-del delete-btn" data-id="${itineraryData.id}">
                                    <i class="bi bi-trash"></i> 삭제
                                </button>
                                <%-- 일정 삭제 버튼 (스크립트에서 처리) --%>
                            </div>
                        </div>
                        
                        <div id="day-container">
                            <%-- 각 날짜별 일정 목록 반복 --%>
                            <c:forEach var="spotList" items="${itineraryData.spotList}">
                                <div class="day-card">
                                    <div class="day-header">
                                        <h4 class="day-title">${spotList.day}</h4>
                                        <%-- Day (예: Day 1, Day 2) 표시 --%>
                                        
                                        <c:set var="currentSpots" value="${spotList.spots}" scope="request" />
                                        <%-- 현재 날짜의 장소 목록을 'request' 스코프 변수에 저장 --%>
                                        <%
                                            // Java Scriptlet 시작 (JSP에서 자바 코드를 직접 실행)
                                            Object currentSpotsObj = request.getAttribute("currentSpots");
                                            JSONArray currentSpotsJson = new JSONArray();
                                            if (currentSpotsObj != null && currentSpotsObj instanceof java.util.List) {
                                                // List 객체를 org.json.JSONArray로 변환
                                                currentSpotsJson = new JSONArray((java.util.List<?>) currentSpotsObj);
                                                // 변환된 JSONArray 문자열을 다시 request 스코프에 저장
                                                request.setAttribute("currentSpotsJson", currentSpotsJson.toString());
                                            }
                                        %>
                                        
                                        <c:if test="${not empty spotList.spots}">
                                            <%-- 해당 날짜에 여행지가 있을 경우에만 경로 보기 버튼 표시 --%>
                                            <button 
                                                class="btn-action btn-map create-map-btn"
                                                type="button"
                                                data-bs-toggle="modal"
                                                data-bs-target="#mapModal"
                                                data-spots='${fn:escapeXml(currentSpotsJson)}'
                                                <%-- 경로 보기에 사용할 장소 목록 (JSON 문자열)을 data 속성으로 전달 (XSS 방지 위해 escapeXml 사용) --%>
                                                data-city="${spotList.city}">
                                                <%-- 해당 Day의 도시 이름을 data 속성으로 전달 --%>
                                                <i class="bi bi-map"></i> 경로 보기
                                            </button>
                                        </c:if>
                                    </div>
                                    
                                    <div class="spot-list">
                                        <ol class="m-0 ps-3"> 
                                            <%-- 여행지 목록 (순서 있는 목록) --%>
                                            <c:choose>
                                                <c:when test="${empty spotList.spots}">
                                                    <p class="text-muted m-0 small">등록된 여행지가 없습니다.</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach var="spot" items="${spotList.spots}">
                                                        <li class="spot-item">${spot}</li>
                                                        <%-- 개별 여행지 이름 표시 --%>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </ol>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>
        </div>
    </main>

    <%-- Google Map 모달 창 정의 시작 --%>
    <div class="modal fade" id="mapModal" tabindex="-1" aria-labelledby="mapModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="mapModalLabel"><i class="bi bi-geo-alt-fill text-danger"></i> 이동 경로 확인</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="control-panel d-flex align-items-center justify-content-end mb-2">
                        <div class="d-flex align-items-center">
                            <label for="choose-travel-mode" class="form-label me-2 m-0 small fw-bold">이동 수단:</label>
                            <%-- 이동 수단 선택 드롭다운 --%>
                            <select id="choose-travel-mode" class="form-select form-select-sm" style="width: 120px;">
                                <option value="" disabled selected>선택</option>
                                <option value="DRIVING">자동차</option>
                                <option value="WALKING">도보</option>
                                <option value="BICYCLING">자전거</option>
                            </select>
                        </div>
                    </div>
                    <div id="map"></div>
                    <%-- 지도가 표시될 영역 --%>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
    
    <%@ include file="/layout/footer.jsp" %>

    
    <script src="${pageContext.request.contextPath}/resource/js/utils/changeDate.js"></script>
    <script src="${pageContext.request.contextPath}/resource/js/utils/deleteItinerary.js"></script>
    <script src="${pageContext.request.contextPath}/resource/js/utils/createGoogleMap.js"></script>
    
    <script>
        const mapModalEl = document.getElementById('mapModal');
        
        // 1. "경로 보기" 버튼 클릭 시 지도 생성에 필요한 데이터 설정
        document.querySelectorAll(".create-map-btn").forEach(btn => {
            btn.addEventListener("click", function() {
                const spotsStr = this.dataset.spots; // 장소 목록 JSON 문자열
                const cityValue = this.dataset.city; // 도시 이름
                
                // createGoogleMap.js의 전역 변수 touristSpots 업데이트 (let 재선언 금지)
                if (spotsStr && spotsStr.length !== 0) {
                    touristSpots = JSON.parse(spotsStr); // JSON 문자열을 객체로 변환
                } else {
                    touristSpots = [];
                }
                
                // createGoogleMap.js의 전역 변수 centerCity 업데이트
                // cityCoordinates 데이터 유효성 체크
                if (typeof cityCoordinates !== 'undefined' && cityCoordinates[cityValue]) {
                    centerCity = cityValue; // 중심 도시 설정
                } else {
                    centerCity = "도쿄"; // 기본값 설정
                }
            });
        });
        
        mapModalEl.addEventListener('shown.bs.modal', function () {
            // 약간의 딜레이를 주어 모달 애니메이션이 완전히 끝난 뒤 실행
            setTimeout(() => {
                if (typeof initMap !== 'undefined') {
                    // 지도 초기화 실행 (createGoogleMap.js의 initMap 함수 호출)
                    initMap(); 
                    
                    if (typeof map !== 'undefined' && map) {
                        google.maps.event.trigger(map, "resize");
                        
                        // 리사이즈 후 중심 좌표가 틀어질 수 있으므로 다시 설정
                        if (typeof cityCoordinates !== 'undefined' && centerCity) {
                            map.setCenter(cityCoordinates[centerCity]);
                        }
                    }
                } else {
                    console.error("createGoogleMap.js가 로드되지 않았거나 initMap 함수가 없습니다.");
                }
            }, 200); // 200ms 딜레이
        });

        // 3. 이동 수단 변경 시 경로 재요청
        // 변수명을 modalTravelModeSelect로 변경하여 createGoogleMap.js의 travelModeElement와 충돌 방지
        const modalTravelModeSelect = document.getElementById('choose-travel-mode'); 
        if(modalTravelModeSelect) {
            modalTravelModeSelect.addEventListener('change', function() {
                if (touristSpots.length >= 2 && typeof getCoordinatesAndRoute !== 'undefined') {
                    // 장소가 2개 이상이고 경로를 그리는 함수가 정의되어 있다면 경로 재요청
                    getCoordinatesAndRoute(touristSpots);
                }
            });
        }
    </script>

</body>
</html>