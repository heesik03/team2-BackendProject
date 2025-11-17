<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<!-- head (페이지 설정) 영역 -->
<c:set var="pageTitle" value="여행 일정 목록" />
<%@ include file="/components/pageHead.jsp" %>

<!-- 로그아웃 상태라면 홈 화면으로 이동 -->
<c:if test="${empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>
<body>
	<jsp:include page="/layout/header.jsp" />
		
	<main>
	
		<a href="${pageContext.request.contextPath}/mypage/create-itinerary.do">일정 작성</a>
	
	</main>
	
	
	
	<%@ include file="/layout/footer.jsp" %>
</body>
</html>