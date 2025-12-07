<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">

<head>
	<c:set var="pageTitle" value="Visit Japan - 여행 일정 수정" />
	<%@ include file="/components/pageHead.jsp" %>

    <%-- css 시작  --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/itineraryForm.css">
</head>

<c:if test="${empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>

<body>
	<jsp:include page="/layout/header.jsp" />
	
	<main class="py-5">
        <div class="container main-container">
            <div class="form-card">
                <div class="form-header">
                    <%-- Bootstrap Icons 수정 아이콘(연필) --%>
                    <h2 class="form-title">
                        <i class="bi bi-pencil-square text-warning me-2"></i>여행 일정 수정
                    </h2>
                    <p class="form-subtitle">기존에 작성한 여행 계획을 수정합니다.</p>
                </div>

                <div class="form-body">
                    <div class="form-content-wrapper">
                        <%-- 실제 일정 입력/수정 필드 및 동적 장소 추가 UI를 포함하는 외부 JSP 파일을 포함 --%>
                        <jsp:include page="/components/itineraryForm.jsp" />
                        
                        <%-- 숨김 필드: 서버에서 받은 기존 spotList 데이터를 JSON 문자열 형태로 저장 --%>
                        <input type="hidden" id="edit-spot-list" value='${fn:escapeXml(spotListJson)}'>
                    </div>
                </div>
            </div>
        </div>
	</main>

	<%-- footer.jsp import --%>
	<%@ include file="/layout/footer.jsp" %>

    <script>
		// 전역 변수로 수정할 장소 목록을 저장할 배열 선언
		let spotList = [];
		// 기존 데이터를 담은 숨김 필드 요소 가져오기
		const editSpotList = document.getElementById("edit-spot-list");
		
        // 서버에서 전달된 JSON 데이터를 파싱하여 spotList 초기화 (데이터 로드 기능)
	    if (editSpotList) {
	        try {
                // 숨김 필드에 저장된 JSON 문자열을 JavaScript 객체로 변환하여 spotList에 저장
	            spotList = JSON.parse(editSpotList.value);
	        } catch(e) {
                // JSON 파싱 실패 시 오류를 콘솔에 기록하고 spotList를 빈 배열로 초기화
	            console.error("JSON 파싱 실패", e);
	            spotList = [];
	        }
	    }
		
		// JSP 컨텍스트 경로와 현재 수정 중인 일정 ID를 JavaScript 변수에 할당 (AJAX 요청에 사용됨)
		const contextPath = "${pageContext.request.contextPath}";
		const itineraryId = '${itineraryData.id}';
	</script>
	
	<script src="${pageContext.request.contextPath}/resource/js/utils/itineraryForm.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/page/editItinerary.js"></script>
	
</body>
</html>