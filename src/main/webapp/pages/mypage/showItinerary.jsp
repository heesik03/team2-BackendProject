<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="java.util.List" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
	<!-- head (페이지 설정) 영역 -->
	<c:set var="pageTitle" value="여행 일정 보기" />
	<%@ include file="/components/pageHead.jsp" %>
	
	 <!-- 구글 맵 연결 -->
    <script src="https://maps.googleapis.com/maps/api/js?key=${APIKey}&libraries=places&loading=async"></script>
	
	<!-- 구글 맵 스타일 (추후 삭제) -->
    <style>
        #map { width: 100%; height: 600px; }
    </style>
</head>

<!-- 로그아웃 상태라면 홈 화면으로 이동 -->
<c:if test="${empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>

<!-- js 삭제 요청을 위한 속성 삽입 -->
<body data-context-path="${pageContext.request.contextPath}" data-refresh="true">
	<jsp:include page="/layout/header.jsp" />
	
	<main>
		
		<!-- 일정 출력 영역 -->
		<section>
			<c:choose>
				<c:when test="${empty itineraryData}">
	                	<!-- itineraryData 가 비어있으면 "없음" 표시 -->
	                	<p>일정을 가져오지 못했습니다.</p>
                </c:when>
	
                <c:otherwise>
                		<h3>${itineraryData.title}</h3>
					<p>시작일 ${itineraryData.startDate} | 종료일 ${itineraryData.endDate}</p>
					<p class="createAt" data-date="${itineraryData.createAt}"></p> <!-- js로 변환 후 출력 -->
					
					
					<div id="day-container">
						<c:forEach var="spotList" items="${itineraryData.spotList}">
							<h4>${spotList.day}</h4>
							
							<c:set var="currentSpots" value="${spotList.spots}" scope="request" />
						    <%
						        // request 영역에 저장된 spotList.spots 가져옴
						        Object currentSpotsObj = request.getAttribute("currentSpots");
						        JSONArray currentSpotsJson = new JSONArray();
						
						        // Object가 List 타입인지 확인 후, JSONArray로 변환 (JS에 보내기 위해)
						        if (currentSpotsObj != null && currentSpotsObj instanceof java.util.List) {
						            currentSpotsJson = new JSONArray((java.util.List<?>) currentSpotsObj);
						        }
						    %>
							
							<c:if test="${not empty spotList.spots}">
								<button 
									class="create-map-btn"
									type="button"
								    data-spots='<%= currentSpotsJson.toString() %>'
								    data-city="${spotList.city}">
									지도 생성
								</button>
							</c:if>
							
							<ol type='A'> <!-- 대문자 알파벳 순서로 출력 -->
								<!-- spotList 출력 (없으면 "없음) 으로 출력 -->
								<c:choose>
									<c:when test="${empty spotList.spots}">
						                	<p>없음</p>
					                </c:when>
					                <c:otherwise>
							            <c:forEach var="spot" items="${spotList.spots}">
											<li>${spot}</li>
										</c:forEach>
					                </c:otherwise>
								</c:choose>
							</ol>
						</c:forEach>
						
						<button type="button" class="delete-btn" data-id="${itineraryData.id}">
							삭제
						</button>
		
				         <a href="${pageContext.request.contextPath}/mypage/edit-itinerary.do?id=${itineraryData.id}">
                      		수정
                      	</a>
					</div>
                </c:otherwise>
			</c:choose>
		</section>
		
		<section id="mapSection" style="display: none;">
		    <h3>일본 관광지 경로</h3>
		    
		    <label for="choose-travel-mode" class="form-label">경로 이동수단 선택</label>
			<select id="choose-travel-mode" class="form-select">
			    <option value="" disabled selected>이동수단 선택</option>
			    <option value="DRIVING">자동차</option>
			    <option value="WALKING">도보</option>
			    <option value="BICYCLING">자전거</option>
			    <option value="TRANSIT">대중교통</option>
			</select>
			<br>
		  
		    <!-- 구글 맵 출력 영역 -->
		    <div id="map"></div>
		</section>
		
	</main>
	
	<%@ include file="/layout/footer.jsp" %>
	
	<!-- js 파일 불러옴 -->
	<script src="${pageContext.request.contextPath}/resource/js/utils/changeDate.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/utils/deleteItinerary.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/page/createGoogleMap.js"></script>

</body>
</html>