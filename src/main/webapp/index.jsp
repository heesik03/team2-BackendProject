<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">

<jsp:include page="/components/loading.jsp" />

<head>
	<c:set var="pageTitle" value="visit japan" />
	<%@ include file="/components/pageHead.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/index.css">
</head>

<body>
	
	<c:url value="/resource/images/city/tokyo.jpg" var="tokyoImg"/>
	<c:url value="/resource/images/city/osaka.jpg" var="osakaImg"/>
	<c:url value="/resource/images/city/kyoto.jpg" var="kyotoImg"/>
	<c:url value="/resource/images/city/fukuoka.jpg" var="fukuokaImg"/>
	<c:url value="/resource/images/city/sapporo.jpg" var="sapporoImg"/>
	<c:url value="/resource/images/city/nagoya.jpg" var="nagoyaImg"/>
	
	<%
		String[][] cityArr = {
			    {"도쿄", "tokyo", "tokyoImg"},
			    {"교토", "kyoto", "kyotoImg"},
			    {"오사카", "osaka", "osakaImg"},
			    {"후쿠오카", "fukuoka", "fukuokaImg"},
			    {"삿포로", "sapporo", "sapporoImg"},
			    {"나고야", "nagoya", "nagoyaImg"}
		};
		request.setAttribute("cityArr", cityArr);
	%>
		
	<jsp:include page="/layout/header.jsp" />
	
	<main>
        <section id="Top-Banner" style="position: relative;">
            
            <%-- 도쿄 이미지를 메인 배너로 사용 --%>
            <img src="${osakaImg}" alt="메인 배너"
                 style="width: 100%; height: auto; opacity: 0.75;" />
            
            <h1 class="main-title">
                Trip to japan
            </h1>

            <p class="main-subtitle">
                고즈넉한 사찰부터 화려한 도시까지<br/>
                당신의 일본여행을 계획하세요
            </p>
        </section>
        
       <section id="city-choice" class="container my-5 py-5">
            
            <div class="text-center mb-4">
                <h2 style="font-size: 80px; font-weight: 400;">Choose your trip</h2>
                <p style="font-size: 56px; font-weight: 400; color: #333;">당신의 여행지를 골라보세요.</p>
            </div>

            <%@ include file="/components/searchForm.jsp" %>

            <div id="city-group" class="row mt-5 justify-content-center">
            	
            	<%-- request scope에 저장된 cityArr 배열을 순회하며 이미지 출력 --%>
                <c:forEach var="city" items="${cityArr}">
			        <div class="col-12 col-md-6 col-lg-4"> <%-- 반응형 그리드 설정 --%>
			            <a href="home.do?region=${city[0]}" style="text-decoration: none; color: inherit;">
			                <div class="city-card">
			                    <%-- 이미지 출력 --%>
			                    <img src="${pageScope[city[2]]}"
			                         alt="${city[0]}" 
			                         class="img-fluid">
			
			                    <%-- 도시 이름 (영문 약자) --%>
			                    <h3>${city[1]}</h3>
			                </div>
			            </a>
			        </div>
			    </c:forEach>
            </div>
        </section>
        
	</main>
	
	<%@ include file="/layout/footer.jsp" %>
		
	<%-- 검색어 자동완성 기능을 위한 JavaScript 파일 로드 --%>
	<script src="${pageContext.request.contextPath}/resource/js/utils/searchSuggest.js"></script>
</body>
</html>