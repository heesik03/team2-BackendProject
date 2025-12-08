<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<jsp:include page="/components/loading.jsp" />

<html lang="ko">
<head>
	<c:set var="pageTitle" value="Visit Japan - 게시글 목록" />
	<%@ include file="/components/pageHead.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/itinerary.css">
</head>

<body>

	<%@ include file="/layout/header.jsp" %>
		
	<main class="container py-5 main-container">
	
		<section class="page-header">
			<h3 class="page-title"><i class="bi bi-airplane-engines me-2"></i>게시글 목록</h3>
		</section>

		<section class="list-card">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th style="width: 50%;">제목</th>
                            <th class="text-center" style="width: 20%;">작성자</th>
                            <th class="text-center" style="width: 20%;">작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <%-- JSTL 조건문: communityList가 비어 있는 경우 --%>
                            <c:when test="${empty communityList}">
                                    <tr>
                                        <td colspan="4">
                                            <div class="empty-state">
                                                <i class="bi bi-calendar-x fs-1 mb-3 d-block"></i>
                                                등록된 게시글이 없습니다.<br>
                                                새로운 여행 일정을 공유해 보세요!
                                            </div>
                                        </td>
                                    </tr>
                            </c:when>
                
                            <%-- communityList가 있는 경우: 반복문을 통해 리스트 출력 --%>
                            <c:otherwise>
                                <c:forEach var="community" items="${communityList}">
                                    <tr>
	                                    <td>
	                                        <%-- 게시글 상세보기 페이지로 이동하는 링크 (쿼리 파라미터로 ID 전달) --%>
	                                        <a href="${pageContext.request.contextPath}/community/show.do?id=${community.id}" class="itinerary-link">
	                                            ${community.title}
	                                        </a>
	                                    </td>
	                                    <td class="text-center text-secondary">${community.authorName}</td> 
	                                    <td class="text-center text-secondary">
	                                    		<%-- JavaScript를 이용해 날짜 형식을 변경 --%>
	                                    		<span class="createAt" data-date="${community.createAt}"></span>
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
		
	<script src="${pageContext.request.contextPath}/resource/js/utils/changeDate.js"></script>
		
</body>
</html>