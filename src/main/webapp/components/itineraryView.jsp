<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.JSONArray" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
                    		 <%-- 여행 기간 표시 --%>
                        <span class="me-3"><i class="bi bi-calendar-range me-1"></i> ${itineraryData.startDate} ~ ${itineraryData.endDate}</span>
                        <%-- 작성일 표시 (스크립트에서 실제 날짜 포맷팅) --%>
                        <span class="me-3"><i class="bi bi-pencil-square me-1"></i> 작성일: <span class="createAt" data-date="${itineraryData.createAt}"></span></span>                        
                        
                        <%-- 작성자 표시 (공유된 글일때만) --%>
                        <c:if test="${not empty postData}">
                        		<span><i class="bi bi-vector-pen me-1"></i> 작성자: ${postData.userName}</span>                        
	                		</c:if>
                    </div>

                </div>
                <div>

                    <c:if test="${empty postData}">
	                    <%-- 일정 수정 페이지로 이동 버튼 --%>
	                    <a href="${pageContext.request.contextPath}/mypage/edit-itinerary.do?id=${itineraryData.id}" class="btn-action btn-edit">
	                        <i class="bi bi-pencil"></i> 수정
	                    </a>  
	                </c:if>
	                
	                <%-- 일정 수정 or 공유 버튼 --%>
					<c:choose>
					    <c:when test="${not empty postData}">
					    		<c:if test="${not empty sessionScope.id}">
					        <%-- 공유된 게시글이고, 로그인 상태라면 수정 버튼을 보여줌 --%>
						        <a href="${pageContext.request.contextPath}/pages/community/editShared.jsp?id=${postData.id}" 
						           class="btn-action btn-edit">
						            <i class="bi bi-pencil"></i> 수정
						        </a>
					        </c:if>
					    </c:when>
					
					    <c:otherwise>
					        <%-- 아니라면 공유 --%>
					        <a href="${pageContext.request.contextPath}/pages/community/share.jsp?id=${itineraryData.id}" 
					           class="btn-action btn-share">
					            <i class="bi bi-share"></i> 공유
					        </a>
					    </c:otherwise>
					</c:choose>
	                
	                <%-- 일정 삭제 버튼 (스크립트에서 처리) --%>
                    <button type="button" class="btn-action btn-del delete-btn" data-id="${itineraryData.id}" class="btn-action btn-edit">
                        <i class="bi bi-trash"></i> 삭제
                    </button>                   
                    
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
                            <ol class="m-0 ps-3" type='A'> 
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