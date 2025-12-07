<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
    
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="org.jsoup.select.Elements" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%-- 페이지 로직 변수 설정 --%>
<c:set var="rawRegion" value="${param.region != null ? param.region : '도쿄'}" />

<c:choose>
    <c:when test="${rawRegion eq '도쿄'}"> <c:set var="regionEng" value="Tokyo" /> </c:when>
    <c:when test="${rawRegion eq '오사카'}"> <c:set var="regionEng" value="Osaka" /> </c:when>
    <c:when test="${rawRegion eq '교토'}"> <c:set var="regionEng" value="Kyoto" /> </c:when>
    <c:when test="${rawRegion eq '후쿠오카'}"> <c:set var="regionEng" value="Fukuoka" /> </c:when>
    <c:when test="${rawRegion eq '삿포로'}"> <c:set var="regionEng" value="Sapporo" /> </c:when>
    <c:when test="${rawRegion eq '히로시마'}"> <c:set var="regionEng" value="Hiroshima" /> </c:when>
    <c:when test="${rawRegion eq '나고야'}"> <c:set var="regionEng" value="Nagoya" /> </c:when>
    <c:otherwise> <c:set var="regionEng" value="${rawRegion}" /> </c:otherwise>
</c:choose>

<c:set var="lowerRegion" value="${fn:toLowerCase(regionEng)}" />
<c:set var="root" value="${pageContext.request.contextPath}" />

<%-- 배너 URL 설정 --%>
<c:choose>
    <c:when test="${lowerRegion eq 'tokyo'}">
        <c:url var="bannerUrl" value="/resource/images/tokyohome/tokyo-1.jpg"/>
    </c:when>
    <c:otherwise>
        <c:url var="bannerUrl" value="/resource/images/city/${lowerRegion}.jpg"/>
    </c:otherwise>
</c:choose>

<!DOCTYPE html>
<jsp:include page="/components/loading.jsp" />

<html lang="ko">
<head>
	<c:set var="pageTitle" value="지역 정보" />
	<%@ include file="/components/pageHead.jsp" %>
    <link rel="stylesheet" href="${root}/resource/css/visitData.css">
    
	<script>
    	const userId = "${sessionScope.id}";
	</script>
</head>

<body>
	<jsp:include page="/layout/header.jsp" />
	
    <div class="hero-section" style="background-image: url('${bannerUrl}');">
        <div class="hero-overlay">
            <h1 class="display-4 fw-bold" style="text-shadow: 0 2px 4px rgba(0,0,0,0.5);">${rawRegion}</h1>
            <p class="fs-5" style="opacity: 0.9;">Travel Information</p>
        </div>
    </div>

	<main class="container mb-5">
		<div class="row justify-content-center mb-5">
            <div class="col-md-8">
                <%@ include file="/components/searchForm.jsp" %>
            </div>
        </div>

		<c:set var="region" value="${param.region}" />
		
        <h3 class="section-header">오늘의 날씨</h3>
		
		<c:choose>
			<c:when test="${not empty homeResponse.weatherData}">
                <div class="row justify-content-center">
                    <div class="col-lg-6 col-md-8">
                        <div class="weather-simple">
                            <div class="weather-icon-area">
                                <i class="bi bi-sun"></i> 
                            </div>
                            
                            <div class="weather-info mb-2">
                                <p>현재 하늘 상태</p>
                                <strong>${homeResponse.weatherData.skyStatus}</strong>
                            </div>
                            
                            <div class="weather-detail weather-info">
                                <p>기온 <span style="color:#ff4757; font-weight:bold;">${homeResponse.weatherData.highTemp}℃</span> / <span style="color:#1e90ff; font-weight:bold;">${homeResponse.weatherData.lowTemp}℃</span></p>
                                <p style="font-size: 0.95rem; margin-top: 5px;">강수확률 <span style="color:#555;">${homeResponse.weatherData.precipitation}</span></p>
                            </div>
                        </div>
                    </div>
                </div>
	        </c:when>
	        
        		<c:otherwise>
                <div class="text-secondary p-3 text-center">날씨 정보를 불러올 수 없습니다.</div>
	    		</c:otherwise>
	    	</c:choose>
        		
        <h3 class="section-header">${rawRegion} 관광지</h3>
        
       <button 
			type="button" 
			id="change-spot-list" 
			data-index="${pageIndex}"
			data-region="${region}" >
			관광지 변경 🔄
		</button> 

		<c:choose>
			<c:when test="${not empty homeResponse.spotData}">
				<div id="spot-list" class="row g-4">
				    <c:forEach var="spot" items="${homeResponse.spotData.spotList}" varStatus="sp">
				        <div class="col-md-4 col-sm-6">
                            <div class="spot-card">
                                <div style="position: relative; overflow: hidden;">
                                    
                                    <%-- 1. 이미지가 존재할 때 (onerror 추가: 이미지가 깨지면 대체 이미지로 변경) --%>
                                    <c:if test="${not empty homeResponse.spotData.spotImgList[sp.index]}">
                                        <img src="${homeResponse.spotData.spotImgList[sp.index]}" 
                                             class="spot-img" 
                                             alt="관광지"
                                             onerror="this.onerror=null; this.src='${root}/resource/images/no_image.png';">
                                    </c:if>
                                    
                                    <%-- 2. 이미지가 애초에 없을 때 --%>
                                    <c:if test="${empty homeResponse.spotData.spotImgList[sp.index]}">
                                        <img src="${root}/resource/images/no_image.png" class="spot-img" alt="이미지 없음">
                                    </c:if>
                                    
                                </div>

                                <div class="spot-body">
                                    <h5 class="fw-bold mb-1 text-truncate">${spot.text()}</h5>
                                    <small class="text-muted d-block mb-3">관광 명소</small>
                                    
                                    <a href="${spot.attr('href')}" target="_blank" class="text-decoration-none fw-bold mb-3 d-block" style="color: #4D88F6; font-size: 0.9rem;">
                                        상세 정보 보러가기 <i class="bi bi-chevron-right" style="font-size: 0.8rem;"></i>
                                    </a>

                                    <c:if test="${not empty sessionScope.id}">
                                        <button class="add-scrap-btn"
                                                data-spot="${spot.text()}"
                                                data-region="${rawRegion}" 
                                                type="button">
                                            <i class="bi bi-heart"></i> 스크랩 추가
                                        </button>
                                    </c:if>
                                </div>
                            </div>
				        </div>
				    </c:forEach>
				</div>
			</c:when>
			<c:otherwise>
		        <div class="text-center py-5 text-muted">표시할 관광지 정보가 없습니다.</div>
	    		</c:otherwise>
	    	</c:choose>
			
        <h3 class="section-header">${rawRegion} 맛집</h3>
		<c:choose>
		    <c:when test="${not empty homeResponse.restaurantData.restaurantList}">
			    <div class="row g-4">
			        <c:forEach var="res" items="${homeResponse.restaurantData.restaurantList}" varStatus="st">
			            <div class="col-md-3 col-sm-6">
                            <div class="spot-card">
                                <div style="position: relative;">
                                    
                                    <%-- 1. 이미지가 존재할 때 (onerror 추가) --%>
                                    <c:if test="${not empty homeResponse.restaurantData.restaurantImgList[st.index]}">
                                        <img src="${homeResponse.restaurantData.restaurantImgList[st.index]}" 
                                             class="spot-img" 
                                             alt="맛집"
                                             onerror="this.onerror=null; this.src='${root}/resource/images/no_image.png';">
                                    </c:if>
                                    
                                    <%-- 2. 이미지가 애초에 없을 때 --%>
                                    <c:if test="${empty homeResponse.restaurantData.restaurantImgList[st.index]}">
                                        <img src="${root}/resource/images/no_image.png" class="spot-img" alt="이미지 없음">
                                    </c:if>
                                    
                                </div>

                                <div class="spot-body">
                                    <h6 class="fw-bold mb-2 text-truncate">${res.text()}</h6>
                                    
                                    <a href="${res.absUrl('href')}" target="_blank" class="text-decoration-none d-block mb-3" style="color: #ffae00; font-size: 0.85rem; font-weight: 600;">
                                        <img src="https://tabelog.com/favicon.ico" width="16" style="vertical-align: text-bottom;"> 타베로그 보기
                                    </a>

                                    <c:if test="${not empty sessionScope.id}">
                                        <button class="add-scrap-btn"
                                                data-spot="${res.text()}"
                                                data-region="${rawRegion}"
                                                type="button">
                                            <i class="bi bi-heart"></i> 스크랩 추가
                                        </button>
                                    </c:if>
                                </div>
                            </div>
			            </div>
			        </c:forEach>
			    </div>
    			</c:when>
	    		<c:otherwise>
		        <div class="text-center py-5 text-muted">표시할 맛집 정보가 없습니다.</div>
	    		</c:otherwise>
	    	</c:choose>
	</main>

    <%@ include file="/layout/footer.jsp" %>
    <script>
    	const root = "${pageContext.request.contextPath}";
    </script>
    
    <script src="${pageContext.request.contextPath}/resource/js/utils/searchSuggest.js"></script>
    <script src="${pageContext.request.contextPath}/resource/js/page/visitData.js"></script>
    
    <script>
    document.addEventListener("click", function(e) {
        if (e.target.classList.contains("add-scrap-btn")) {
            
            const button = e.target;
            const spot = button.dataset.spot;
            const city = button.dataset.region;

            const isScraped = button.classList.contains("scraped");

            fetch("home.do", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({ spot, city }) 
            })
            .then(res => res.json())
            .then(data => {
                if (!isScraped) {
                    button.classList.add("scraped");
                    button.innerHTML = '<i class="bi bi-heart-fill"></i> 스크랩 완료';
                } else {
                    button.classList.remove("scraped");
                    button.innerHTML = '<i class="bi bi-heart"></i> 스크랩 추가';
                }
            })
            .catch(err => console.error(err));
        }
    });
    </script>
    
</body>
</html>