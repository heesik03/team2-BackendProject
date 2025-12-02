<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>    
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="org.jsoup.select.Elements" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<!-- 로딩 페이지는 최상단에 -->
<jsp:include page="/components/loading.jsp" />

<html lang="ko">
<head>
	<!-- head (페이지 설정) 영역 -->
	<c:set var="pageTitle" value="지역 정보" />
	<%@ include file="/components/pageHead.jsp" %>
	<script>
    		const userId = "${sessionScope.id}";
	</script>
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
        		
		<!-- 클릭 시 관광지 정보가 랜덤으로 변경됨 -->
		<button 
			type="button" 
			id="change-spot-list" 
			data-index="${pageIndex}"
			data-region="${region}" >
			관광지 변경 🔄
		</button> <br>
		<c:choose>
			<c:when test="${not empty homeResponse.spotData}">  <!-- spotData가 비어있지 않다면 -->
				<ul id="spot-list">
				    <c:forEach var="spot" items="${homeResponse.spotData.spotList}" varStatus="sp">
				        <li>
				            ${spot.text()} <br>
				            <a href="${spot.attr('href')}" target="_blank">관광지 상세 주소</a>
				            <br>
				
				            <c:if test="${not empty sessionScope.id}">
				                <button class="add-scrap-btn"
				                        data-spot="${spot.text()}"
				                        data-region="${region}"
				                        type="button">
				                    스크랩 추가
				                </button>
				                <br>
				            </c:if>
				
				            <c:if test="${not empty homeResponse.spotData.spotImgList[sp.index]}">
				                <img src="${homeResponse.spotData.spotImgList[sp.index]}"
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
			                
			              <!-- 스크랩 추가  -->
			               <c:if test="${not empty sessionScope.id}">
							    <button class="add-scrap-btn"
							    		data-spot="${res.text()}"
							    		data-region="${region}"
							    		type="button">
							        스크랩 추가
							    </button>
							    <br>
							</c:if>
					
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
	<script src="${pageContext.request.contextPath}/resource/js/page/visitData.js"></script>
    
</body>
</html>