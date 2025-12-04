<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<!-- 로딩 페이지는 최상단에 -->
<jsp:include page="/components/loading.jsp" />

<html lang="ko">
<head>
	<!-- head (페이지 설정) 영역 -->
	<c:set var="pageTitle" value="여행 일정 목록" />
	<%@ include file="/components/pageHead.jsp" %>
</head>

<!-- 로그아웃 상태라면 홈 화면으로 이동 -->
<c:if test="${empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>

<!-- js 삭제 요청을 위한 속성 삽입 -->
<body data-context-path="${pageContext.request.contextPath}" data-refresh="false">
	<%@ include file="/layout/header.jsp"  %>
		
	<main>
		<!-- 일정 목록 영역 -->
		<section>
			<h3>일정 목록</h3>
			<table>
				<thead>
					<tr>
						<th>제목</th>
						<th>시작일</th>
						<th>종료일</th>
						<th>&nbsp;</th> <!-- 공백 (삭제 버튼 위치) -->
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty itineraryList}">
			                	<!-- itineraryData 가 비어있으면 "없음" 표시 -->
			                    <tr>
									<td colspan="4">등록된 일정이 없습니다.</td>
			                    </tr>
		                </c:when>
			
		                <c:otherwise>
		                    <c:forEach var="itinerary" items="${itineraryList}">
		                    	<!-- itineraryData 가 있으면 반복 출력 -->
		                        <tr id="${itinerary.title}">
		                        		 <!-- 제목 (누르면 일정 상세 출력 페이지로 이동) -->
		                        		<td>
		                        			<a href="${pageContext.request.contextPath}/mypage/show-itinerary.do?id=${itinerary.id}">
		                        				${itinerary.title}
		                        			</a>
		                        		</td>
		                        		<td>${itinerary.startDate}</td> <!-- 시작일 -->
		                        		<td>${itinerary.endDate}</td> <!-- 종료일 -->
		                        		<!-- 삭제 버튼 -->
		                            <td>
		                            		<button type="button" class="delete-btn" data-id="${itinerary.id}">
		                            			X
		                            		</button>
		                            </td>
		                        </tr>
		                    </c:forEach>
		                </c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</section>

		<br>
		<a href="${pageContext.request.contextPath}/mypage/create-itinerary.do">
			일정 작성
		</a>

	</main>

	<%@ include file="/layout/footer.jsp" %>
	
	<script src="${pageContext.request.contextPath}/resource/js/utils/deleteItinerary.js"></script>
	
</body>
</html>