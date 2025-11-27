<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>    
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="org.jsoup.select.Elements" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
	<!-- head (페이지 설정) 영역 -->
	<c:set var="pageTitle" value="지역 정보" />
	<%@ include file="/components/pageHead.jsp" %>
</head>

<body>

	<jsp:include page="/layout/header.jsp" />
	
	<main>
		<!-- 도시 검색 입력창 -->		
		<%@ include file="/components/searchForm.jsp" %>

		<c:set var="region" value="${param.region}" />  <!-- 파라미터 region 가져옴  -->
		<h3>${region} 관광지</h3>
		
		<c:choose>
			<c:when test="${not empty homeResponse.weatherData}">
	            <div style="
	                border: 1px solid #ddd;
	                padding: 20px;
	                border-radius: 12px;
	                margin: 20px 0;
	                background: #f9f9f9;
	                max-width: 400px;">
	                
	                <h3 style="margin-bottom: 10px;">오늘의 날씨</h3>
	
	                <p>🌤 하늘 상태: ${homeResponse.weatherData.skyStatus}</p>
	                <p>🔥 최고 기온: ${homeResponse.weatherData.highTemp}℃</p>
	                <p>❄ 최저 기온: ${homeResponse.weatherData.lowTemp}℃</p>
	                <p>🌧 강수 확률: ${homeResponse.weatherData.precipitation}</p>
	            </div>
	        </c:when>
	        
        		<c:otherwise>
		        <p>표시할 날씨 정보가 없습니다.</p>
	    		</c:otherwise>
	    	</c:choose>
        		
		
		<c:choose>
			<c:when test="${not empty homeResponse.spotList}">  <!-- spotList가 비어있지 않다면 -->
			    <ul>
			        <c:forEach var="spot" items="${homeResponse.spotList}" varStatus="sp">
			            <li>
			                ${spot.text()} <br>
			                <a href="${spot.attr('href')}" target="_blank">관광지 상세 주소</a>
			                <br>
			                
			                <!-- 스크랩 추가  -->
			               <c:if test="${not empty sessionScope.id}">
							    <button class="add-city-btn"
							    		data-spot="${spot.text()}"
							    		data-region="${region}"
							    		type="button">
							        스크랩 추가
							    </button>
							    <br>
							</c:if>
							
							 <!-- 대응되는 이미지 -->
			                <c:if test="${not empty homeResponse.spotImgList[sp.index]}">
			                    <img src="${homeResponse.spotImgList[sp.index]}" 
			                         class="img-fluid rounded"
			                         style="max-width: 300px;">
			                </c:if>
							
							<hr>
						
			            </li>
			        </c:forEach>
			    </ul>
			</c:when>
			
			<c:otherwise>
		        <p>표시할 관광지 없습니다.</p>
	    		</c:otherwise>
	    	</c:choose>
			
		<h3>${region} 맛집</h3>
		<c:choose>
		    <c:when test="${not empty homeResponse.restaurantData.restaurantList}">
			    <ul class="list-group">
			        <c:forEach var="res" items="${homeResponse.restaurantData.restaurantList}" varStatus="st">
			            <li class="list-group-item">
			                <!-- 식당 이름 -->
			                <strong>${res.text()}</strong><br>
			
			                <!-- 타베로그 링크 -->
			                <a href="${res.absUrl('href')}" target="_blank" class="text-primary">
			                    타베로그 주소
			                </a><br>
					
			                <!-- 대응되는 이미지 -->
			                <c:if test="${not empty homeResponse.restaurantData.restaurantImgList[st.index]}">
			                    <img src="${homeResponse.restaurantData.restaurantImgList[st.index]}" 
			                         class="img-fluid rounded"
			                         style="max-width: 300px;">
			                </c:if>
			                
			                <hr>
			            </li>
			        </c:forEach>
			    </ul>
    			</c:when>
    			
	    		<c:otherwise>
		        <p>표시할 레스토랑 정보가 없습니다.</p>
	    		</c:otherwise>
	    	</c:choose>
	</main>

    <%@ include file="/layout/footer.jsp" %>
    
    	<script src="${pageContext.request.contextPath}/resource/js/utils/searchSuggest.js"></script>

	<script>
		document.querySelectorAll(".add-city-btn").forEach(form => {
		    form.addEventListener("click", function() {
		
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
    
</body>
</html>