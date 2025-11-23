<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>    
<%@ page import="com.visitJapan.dto.response.HomeResponseDTO" %>
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="org.jsoup.select.Elements" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<!-- head (페이지 설정) 영역 -->
<c:set var="pageTitle" value="지역 정보" />
<%@ include file="/components/pageHead.jsp" %>
<body>

	<jsp:include page="/layout/header.jsp" />
	
	<main>
		<!-- 도시 검색 입력창 -->		
		<%@ include file="/components/searchForm.jsp" %>

		<c:set var="region" value="${param.region}" />  <!-- 파라미터 region 가져옴  -->
		<h3>${region} 관광지</h3>
		
		
		<c:if test="${not empty homeResponse.spotList}">  <!-- spotList가 비어있지 않다면 -->
		    <ul>
		        <c:forEach var="spot" items="${homeResponse.spotList}">
		            <li>
		                ${spot.text()} <br>
		                <a href="${spot.attr('href')}" target="_blank">관광지 상세 주소</a>
		                
		                <!-- 스크랩 추가  -->
		               <c:if test="${not empty sessionScope.id}">
							<form class="add-city-form"
							      data-spot="${spot.text()}"
							      data-region="${region}">
							    <button type="submit">
							        스크랩 추가
							    </button>
							</form>
						</c:if>
						
						<hr>
					
		            </li>
		        </c:forEach>
		    </ul>
		</c:if>
		<c:if test="${empty homeResponse.spotList}"> <!-- spotList가 비어있다면 -->
		    <p>크롤링 결과가 없습니다.</p>
		</c:if>
			
		<h3>${region} 맛집</h3>
		<c:if test="${not empty homeResponse.restaurantList}">
		    <ul class="list-group">
		        <c:forEach var="res" items="${homeResponse.restaurantList}">
		            <li class="list-group-item">
		                ${res.text()} <br>
		                <a href="${res.absUrl('href')}" target="_blank">타베로그 주소</a>
		                <hr>
		            </li>
		        </c:forEach>
		    </ul>
		</c:if>
	
		<c:if test="${empty homeResponse.restaurantList}">
		    <p>크롤링 결과가 없습니다.</p>
		</c:if>
	</main>
	
	<script>
		document.querySelectorAll(".add-city-form").forEach(form => {
		    form.addEventListener("submit", function(e) {
		        e.preventDefault();  // 새로고침 방지
		
		        const spot = this.dataset.spot;  // EL에서 넘긴 spot.text()
		        const city = this.dataset.region;      // EL에서 넘긴 region
		
		        fetch("home.do", {
		            method: "PUT",
		            headers: {
		                "Content-Type": "application/json"
		            },
		            body: JSON.stringify({
		                spot: spot,
		                city: city
		            })
		        })
		        .then(res => res.json())
		        .then(data => {
		            alert("스크랩 추가 성공!");
		        })
		        .catch(err => console.error(err));
		    });
		});
	</script>

    <%@ include file="/layout/footer.jsp" %>
</body>
</html>