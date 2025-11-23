<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<!-- head (페이지 설정) 영역 -->
<c:set var="pageTitle" value="여행 일정 보기" />
<%@ include file="/components/pageHead.jsp" %>

<!-- 로그아웃 상태라면 홈 화면으로 이동 -->
<c:if test="${empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>

<!-- js 삭제 요청을 위한 속성 삽입 -->
<body data-context-path="${pageContext.request.contextPath}" data-refresh="true">
	<jsp:include page="/layout/header.jsp" />
	
	<main>
		<article>
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
							<!-- spotList 출력 (없으면 "없음) 으로 출력 -->
							<c:choose>
								<c:when test="${empty spotList.spots}">
					                	<p>없음</p>
				                </c:when>
				                <c:otherwise>
						            <c:forEach var="spot" items="${spotList.spots}">
										<p>${spot}</p>
									</c:forEach>
				                </c:otherwise>
							</c:choose>
							
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
		</article>
	</main>
	
	<%@ include file="/layout/footer.jsp" %>
	
	<!-- js 파일 불러옴 -->
	<script src="${pageContext.request.contextPath}/resource/js/changeDate.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/deleteItinerary.js"></script>
</body>
</html>