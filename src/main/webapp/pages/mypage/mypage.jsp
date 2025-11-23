<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<!-- head (페이지 설정) 영역 -->
<c:set var="pageTitle" value="마이페이지" />
<%@ include file="/components/pageHead.jsp" %>

<!-- 로그아웃 상태라면 홈 화면으로 이동 -->
<c:if test="${empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>
<body>
	<jsp:include page="/layout/header.jsp" />
	
		<main>
			<!-- 유저 정보 -->
			<section>
				<h3>${userData.userName} 님 환영합니다!</h3>
				<p>${userData.email}</p>
				<p>
					가입일 : <span class="createAt" data-date="${userData.createAt}"></span> <!-- js로 변환 후 출력 (가입일) -->
				</p>
				<p>
					${userData.admin ? '관리자' : '일반 사용자'}
				</p>
				<p>선호도시 <strong>${userData.likeCity}</strong></p>
			</section>
			
			<h3>스크랩한 관광지</h3>		
			<section>
			    <c:forEach var="city" items="${userData.cityList}">
			        <h4>${city.cityName}</h4>
			        <ul>
			            <c:choose>
			                <c:when test="${empty city.spots}">
			                	<!-- spots 배열이 비어있으면 "없음" 표시 -->
			                    <li>없음</li>
			                </c:when>
			
			                <c:otherwise>
			                    <c:forEach var="spot" items="${city.spots}">
			                    	<!-- spots 배열이 있으면 반복 출력 -->
			                        <li>
			                            <form class="delete-city-form"
			                                  data-spot="${spot}"
			                                  data-city="${city.cityName}">
			                                <p>${spot} <button type="submit">X</button></p>
			                            </form>
			                        </li>
			                    </c:forEach>
			                </c:otherwise>
			            </c:choose>
			        </ul>
			    </c:forEach>
			</section>
			
			<a href="${pageContext.request.contextPath}/mypage/itinerary.do">여행 일정</a>
			
			<!-- 관리자면 보임 -->
			<c:if test="${userData.admin}">
				<a href="${pageContext.request.contextPath}/admin.do" target="_blank">
					관리자 페이지
				</a>
			</c:if>
			
		</main>
		
	<script>
		document.querySelectorAll(".delete-city-form").forEach(form => {
		    form.addEventListener("submit", function(e) {
		        e.preventDefault();  // 새로고침 방지
		
		        const spot = this.dataset.spot;  // EL에서 넘긴 spot
		        const city = this.dataset.city; // EL에서 넘긴 cityName
		        const li = this.closest("li"); // 현재 li
		
		        fetch("mypage.do", {
		            method: "DELETE",
		            headers: {
		                "Content-Type": "application/json"
		            },
		            body: JSON.stringify({
		                spot,
		                city
		            })
		        })
		        .then(res => {
		            if (res.status === 204) {
		                li.remove();   // 성공이므로 삭제
		            } else {
		                return res.json().then(data => console.error(data.message));
		            }
		        })
		        .catch(err => console.error(err));
		    });
		});
	</script>
		
	<%@ include file="/layout/footer.jsp" %>
	
	<!-- js 파일 불러옴 -->
	<script src="${pageContext.request.contextPath}/resource/js/changeDate.js"></script>
</body>
</html>