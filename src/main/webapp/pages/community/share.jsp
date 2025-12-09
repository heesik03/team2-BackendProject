<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<jsp:include page="/components/loading.jsp" />

<html lang="ko">

<head>
	<c:set var="pageTitle" value="Visit Japan - 일정 공유" />
	<%@ include file="/components/pageHead.jsp" %>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/itineraryForm.css">
</head>

<body>

	<%@ include file="/layout/header.jsp" %>
	
	
	<main class="py-5">
        <div class="container main-container">
            <div class="form-card">
                <div class="form-header">
                    <h2 class="form-title">
                        <i class="bi bi-airplane-engines text-primary me-2"></i>여행 일정 공유
                    </h2>
                    <p class="form-subtitle">나의 여행 계획을 공유해 보세요!</p>
                </div>
                
				<jsp:include page="/components/communityForm.jsp" />
				
            </div>
        </div>
        
        <%-- 서버에서 응답 메시지가 오면 --%>
		<c:if test="${not empty message}">
			<script>
			    alert("${message}");
			
			    // 성공이면 index.jsp로 이동
			    <%-- 성공이면 이동 --%>
			    <c:if test="${result == 'success'}">
			        window.location.href = "${pageContext.request.contextPath}/community.do";
			    </c:if>
			</script>
		</c:if>
		
	</main>
	<%@ include file="/layout/footer.jsp" %>
	
</body>
</html>