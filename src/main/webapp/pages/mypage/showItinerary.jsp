<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="java.util.List" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <c:set var="pageTitle" value="Visit Japan - 여행 일정 보기" />
    <%@ include file="/components/pageHead.jsp" %>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/itinerary.css"> 
    
    <%-- Google Maps API 로드 --%>
    <script src="https://maps.googleapis.com/maps/api/js?key=${APIKey}&libraries=places&loading=async"></script>
</head>

<c:if test="${empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>

<body data-context-path="${pageContext.request.contextPath}" data-refresh="true">

	<%@ include file="/layout/header.jsp" %>
    
    <main class="py-5">
        <div class="view-container">
        		<jsp:include page="/components/itineraryView.jsp" />
        </div>
    </main>

    <%-- Google Map 모달 창 정의 시작 --%>
    <jsp:include page="/components/googleMapModal.jsp" />

    <%@ include file="/layout/footer.jsp" %>

    
    <script src="${pageContext.request.contextPath}/resource/js/utils/changeDate.js"></script>
    <script src="${pageContext.request.contextPath}/resource/js/utils/deleteItinerary.js"></script>
    <script src="${pageContext.request.contextPath}/resource/js/utils/createGoogleMap.js"></script>
    <script src="${pageContext.request.contextPath}/resource/js/utils/modalGoogleMap.js"></script>

</body>
</html>