<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<jsp:include page="/components/loading.jsp" />

<html lang="ko">
<head>
	<c:set var="pageTitle" value="Visit Japan - 여행 일정 목록" />
	<%@ include file="/components/pageHead.jsp" %>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/itinerary.css">
    <style>
	body {
	    display: flex;
	    flex-direction: column;
	    min-height: 100vh; /* 화면 전체 높이 */
	}
	
	.main-container {
	    flex: 1 0 auto; /* 남은 공간 차지 */
	}
	
	footer {
	    flex-shrink: 0; /* footer는 줄어들지 않도록 */
	}
	</style>
</head>

<c:if test="${empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>

<body data-context-path="${pageContext.request.contextPath}" data-refresh="false">

	<%@ include file="/layout/header.jsp" %>
		
	<main class="container py-5 main-container">
		<section class="page-header">
			<h3 class="page-title"><i class="bi bi-airplane-engines me-2"></i>여행 일정 목록</h3>
            <%-- 일정 작성 페이지로 이동하는 버튼 --%>
            <a href="${pageContext.request.contextPath}/mypage/create-itinerary.do" class="btn btn-primary create-btn">
                <i class="bi bi-plus-lg me-1"></i> 일정 작성
            </a>
		</section>

		<section class="list-card">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th style="width: 50%;">제목</th>
                            <th class="text-center" style="width: 20%;">시작일</th>
                            <th class="text-center" style="width: 20%;">종료일</th>
                            <th class="text-center" style="width: 10%;">삭제</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <%-- JSTL 조건문: itineraryList가 비어 있는 경우 --%>
                            <c:when test="${empty itineraryList}">
                                    <tr>
                                        <td colspan="4">
                                            <div class="empty-state">
                                                <i class="bi bi-calendar-x fs-1 mb-3 d-block"></i>
                                                등록된 여행 일정이 없습니다.<br>
                                                새로운 여행을 계획해보세요!
                                            </div>
                                        </td>
                                    </tr>
                            </c:when>
                
                            <%-- itineraryList가 있는 경우: 반복문을 통해 리스트 출력 --%>
                            <c:otherwise>
                                <c:forEach var="itinerary" items="${itineraryList}">
                                    <tr id="${itinerary.title}">
                                            <td>
                                                <%-- 일정 상세보기 페이지로 이동하는 링크 (쿼리 파라미터로 ID 전달) --%>
                                                <a href="${pageContext.request.contextPath}/mypage/show-itinerary.do?id=${itinerary.id}" class="itinerary-link">
                                                    ${itinerary.title}
                                                </a>
                                            </td>
                                            <td class="text-center text-secondary">${itinerary.startDate}</td> 
                                            <td class="text-center text-secondary">${itinerary.endDate}</td> 
                                            <td class="text-center">
                                                <%-- JavaScript를 통해 AJAX 삭제를 처리할 버튼 (data-id에 일정 ID 저장) --%>
                                                <button type="button" class="delete-btn mx-auto" data-id="${itinerary.id}" title="일정 삭제">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
		</section>

	</main>

	<%@ include file="/layout/footer.jsp" %>
	
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resource/js/utils/deleteItinerary.js"></script>
	
</body>
</html>