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

<body>

	<%@ include file="/layout/header.jsp" %>
		
	<main class="container py-5 main-container">
	
		<section class="page-header">
			<h3 class="page-title d-flex align-items-center gap-2">
				<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor" class="bi bi-luggage" viewBox="0 0 16 16">
				  <path d="M2.5 1a.5.5 0 0 0-.5.5V5h-.5A1.5 1.5 0 0 0 0 6.5v7a1.5 1.5 0 0 0 1 1.415v.335a.75.75 0 0 0 1.5 0V15H4v-1H1.5a.5.5 0 0 1-.5-.5v-7a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 .5.5V7h1v-.5A1.5 1.5 0 0 0 6.5 5H6V1.5a.5.5 0 0 0-.5-.5zM5 5H3V2h2z"/>
				  <path d="M3 7.5a.5.5 0 0 0-1 0v5a.5.5 0 0 0 1 0zM11 6a1.5 1.5 0 0 1 1.5 1.5V8h2A1.5 1.5 0 0 1 16 9.5v5a1.5 1.5 0 0 1-1.5 1.5h-8A1.5 1.5 0 0 1 5 14.5v-5A1.5 1.5 0 0 1 6.5 8h2v-.5A1.5 1.5 0 0 1 10 6zM9.5 7.5V8h2v-.5A.5.5 0 0 0 11 7h-1a.5.5 0 0 0-.5.5M6 9.5v5a.5.5 0 0 0 .5.5H7V9h-.5a.5.5 0 0 0-.5.5m7 5.5V9H8v6zm1.5 0a.5.5 0 0 0 .5-.5v-5a.5.5 0 0 0-.5-.5H14v6z"/>
				</svg>
				게시글 목록
			</h3>
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