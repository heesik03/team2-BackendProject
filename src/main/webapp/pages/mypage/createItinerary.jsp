<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">


<head>
	<!-- head (페이지 설정) 영역 -->
	<c:set var="pageTitle" value="여행 일정 생성" />
	<%@ include file="/components/pageHead.jsp" %>
</head>


<!-- 로그아웃 상태라면 홈 화면으로 이동 -->
<c:if test="${empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>
	
<body>
	
	<jsp:include page="/layout/header.jsp" />
	
	<main>
		<h3>여행 일정 생성</h3>
		
		<!-- 여행 일정 입력 form -->
		<jsp:include page="/components/itineraryForm.jsp" />
		
	</main>

	<%@ include file="/layout/footer.jsp" %>
	
	<!-- itineraryForm.js 로드 전 미리 배열 생성 -->
	<script>
		let spotList = [];
	</script>
	<!-- js 파일 불러옴 -->
	<script src="${pageContext.request.contextPath}/resource/js/utils/itineraryForm.js"></script>
	<script>
		const submitButton = document.getElementById("submit-btn"); // 입력 button
		const hiddenSpotList = document.getElementById("spot-list-hidden"); // spotList를 저장 할 input
		
		submitButton.addEventListener("click", function() {
		     // spotList 비어있으면 전송 막기
			const isAllEmpty = spotList.every(item => item.spots.length === 0);
			
			if (isAllEmpty) {
			    alert("일정이 모두 비어 있습니다.");
			    return; // 함수 종료
			}

		     hiddenSpotList.value = JSON.stringify(spotList);

		     const title = document.getElementById("title-input").value;
		     const start = document.getElementById("start-date").value;
		     const end = document.getElementById("end-date").value;

		     const requestData = {
		         title: title,
		         start: start,
		         end: end,
		         spotList: spotList
		     };

		     // AJAX(JSON) 전송
		     fetch(`${pageContext.request.contextPath}/mypage/create-itinerary.do`, {
		         method: "POST",
		         headers: {
		             "Content-Type": "application/json; charset=UTF-8"
		         },
		         body: JSON.stringify(requestData)
		     })
		     .then(res => res.json())
		     .then(data => {
		         if(data.result === "success") {
		             alert("저장 성공!");
					 location.href = `${pageContext.request.contextPath}/mypage/itinerary.do`
		         } else {
		             alert("저장 실패!");
		         }
		     })
		     .catch(err => console.error(err));
		 });
	</script>
</body>
</html>