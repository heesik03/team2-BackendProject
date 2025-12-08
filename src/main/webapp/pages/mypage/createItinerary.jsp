<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <c:set var="pageTitle" value="Visit Japan - 여행 일정 생성" />
    <%@ include file="/components/pageHead.jsp" %>
	
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/itineraryForm.css">
</head>

<c:if test="${empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>
	
<body>
	
	<%-- 공통 헤더 (네비게이션 바 등) 포함 --%>
	<%@ include file="/layout/header.jsp" %>
	
	<main class="py-5">
        <div class="container main-container">
            <div class="form-card">
                <div class="form-header">
                    <h2 class="form-title">
                        <%-- 비행기 아이콘 추가 --%>
                        <i class="bi bi-airplane-engines text-primary me-2"></i>여행 일정 생성
                    </h2>
                    <p class="form-subtitle">특별한 여행 계획을 시작해보세요.</p>
                </div>
                
                <div class="form-body">
                    <div class="form-content-wrapper">
                        <%-- 실제 일정 생성 폼 필드 (제목, 기간, 장소 등)를 포함하는 외부 JSP 파일 --%>
                        <jsp:include page="/components/itineraryForm.jsp" />
                        
                        <%-- JavaScript에서 생성된 최종 장소 리스트(spotList)를 AJAX 전송 전에 저장하기 위한 숨김 필드 --%>
                        <input type="hidden" id="spot-list-hidden">
                    </div>
                </div>
            </div>
        </div>
	</main>

	<%@ include file="/layout/footer.jsp" %>

	<script>
		// 전역 변수로 일정에 추가된 장소 목록을 저장할 배열 선언
		let spotList = [];
	</script>
	<script src="${pageContext.request.contextPath}/resource/js/utils/itineraryForm.js"></script>
	<script>
		// 필요한 HTML 요소들을 JavaScript 변수에 할당
		const submitButton = document.getElementById("submit-btn"); // 입력 버튼
		const hiddenSpotList = document.getElementById("spot-list-hidden"); // spotList를 저장 할 input
		
		// 버튼 클릭 이벤트 리스너 등록
		submitButton.addEventListener("click", function() {
		     // 폼 필드 값 가져오기
		     const title = document.getElementById("title-input").value.trim();
		     const start = document.getElementById("start-date").value;
		     const end = document.getElementById("end-date").value;
		    
			 // spotList 배열 내의 모든 일자별 장소(spots) 배열이 비어있는지 확인
			const isAllEmpty = spotList.every(item => item.spots.length === 0); 
		 	
			// 유효성 검사: 제목
			if (!title) {
			    alert("제목을 입력해주세요.");
			    return;
			}

			// 유효성 검사: 시작일/종료일
		    if (!start || !end) {
		        alert("시작일과 종료일을 입력해주세요.");
		        return;
		    }
			
			// 유효성 검사: 장소 목록
			if (isAllEmpty) {
			    alert("일정이 모두 비어 있습니다.");
			    return; // 함수 종료
			}

		     // JavaScript 배열 spotList를 JSON 문자열로 변환하여 숨김 필드에 저장
		     hiddenSpotList.value = JSON.stringify(spotList);

		     // 서버로 보낼 데이터를 객체 형태로 준비
		     const requestData = {
		         title,
		         start,
		         end,
		         spotList // spotList 배열 자체도 함께 전송
		     };

		     // AJAX(JSON) 전송 (Fetch API 사용)
		     fetch(`${pageContext.request.contextPath}/mypage/create-itinerary.do`, {
		         method: "POST", // HTTP POST 메소드 사용
		         headers: {
		             "Content-Type": "application/json; charset=UTF-8" // JSON 데이터 전송 명시
		         },
		         body: JSON.stringify(requestData) // JavaScript 객체를 JSON 문자열로 변환하여 본문에 포함
		     })
		     .then(res => res.json()) // 서버 응답을 JSON 형태로 변환
		     .then(data => {
		         if(data.result === "success") {
		             alert("저장 성공!");
					 // 저장 성공 시 일정 목록 페이지로 이동
					 location.href = `${pageContext.request.contextPath}/mypage/itinerary.do`
		         } else {
		             alert("저장 실패!");
		         }
		     })
		     // 네트워크 오류 등 예외 처리
		     .catch(err => console.error(err)); 
		 });
	</script>
	
</body>
</html>