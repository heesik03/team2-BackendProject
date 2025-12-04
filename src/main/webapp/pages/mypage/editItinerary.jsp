<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">

<head>
	<!-- head (페이지 설정) 영역 -->
	<c:set var="pageTitle" value="여행 일정 수정" />
	<%@ include file="/components/pageHead.jsp" %>
</head>

<!-- 로그아웃 상태라면 홈 화면으로 이동 -->
<c:if test="${empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>
<body>
	<%@ include file="/layout/header.jsp"  %>
	
	<main>
		<h3>여행 일정 수정</h3>
		
		<!-- 여행 일정 입력 form -->
		<jsp:include page="/components/itineraryForm.jsp" />
		
		<input type="hidden" id="edit-spot-list" value='${fn:escapeXml(spotListJson)}'>
	</main>

	<%@ include file="/layout/footer.jsp" %>
	
	<script>
		let spotList = [];
		const editSpotList = document.getElementById("edit-spot-list");
		
	    if (editSpotList) {
	        try {
	            spotList = JSON.parse(editSpotList.value);
	        } catch(e) {
	            console.error("JSON 파싱 실패", e);
	            spotList = [];
	        }
	    }
		
		const contextPath = "${pageContext.request.contextPath}";
		const itineraryId = '${itineraryData.id}';
		
	</script>
	
	<!-- js 파일 불러옴 -->
	<script src="${pageContext.request.contextPath}/resource/js/utils/itineraryForm.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/page/editItinerary.js"></script>
</body>
</html>