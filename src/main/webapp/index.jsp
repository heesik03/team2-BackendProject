<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">

<!-- 로딩 페이지는 최상단에 -->
<jsp:include page="/components/loading.jsp" />

<head>
	<!-- head (페이지 설정) 영역 -->
	<c:set var="pageTitle" value="visit japan (가칭)" />
	<%@ include file="/components/pageHead.jsp" %>
</head>

<body>
	
	<!-- 이미지 경로 선언 -->
	<c:url value="/resource/images/city/tokyo.jpg" var="tokyoImg"/>
	<c:url value="/resource/images/city/osaka.jpg" var="osakaImg"/>
	<c:url value="/resource/images/city/kyoto.jpg" var="kyotoImg"/>
	<c:url value="/resource/images/city/fukuoka.jpg" var="fukuokaImg"/>
	
	<!-- 도시 목록 배열로 선언 -->
	<%
		String[][] cityArr = {
			    {"도쿄", "tokyo", "tokyoImg"},
			    {"교토", "kyoto", "kyotoImg"},
			    {"오사카", "osaka", "osakaImg"},
			    {"후쿠오카", "fukuoka", "fukuokaImg"}
		};
		request.setAttribute("cityArr", cityArr);
	%>
		
	<!--Flip : 반응형 적용시 접혀지는 header 부분 관리-->
	<!--Top-Banner : 메인 배너 이미지 + 문구 -->
	<!--city-choice : 도시 선택 이미지 부분-->
	<!--city-group : 도시 선택 이미지 사진 + 글자-->
	
	<!-- HEADER (상단 네비게이션) -->
	<%@ include file="/layout/header.jsp"  %>
	
	<main>
        <!-- ■ Top-Banner : 메인 배너 이미지 + 문구 -->
        <section id="Top-Banner" style="position: relative;">
            
            <img src="${tokyoImg}" alt="메인 배너"
                 style="width: 100%; height: auto; opacity: 0.75;" />
            
            <!-- 홈화면 텍스트 -->
            <h1 style="width: 854px; left: 56px; top: 389px; position: absolute;
                       color: white; font-size: 120px; font-weight: 400; margin: 0;">
                Trip to japan
            </h1>

            <!-- 홈화면 배너 설명 텍스트 -->
            <p style="left: 56px; top: 560px; position: absolute; color: white;
                      font-size: 40px; font-weight: 400; margin: 0;">
                고즈넉한 사찰부터 화려한 도시까지<br/>
                당신의 일본여행을 계획하세요
            </p>
        </section>
        
       <!-- 도시 선택 이미지 카드 목록 -->
        <section id="city-choice" class="container my-5 py-5">
            
            <!-- 도시 선택 이미지 설명글 -->
            <div class="text-center mb-4">
                <h2 style="font-size: 80px; font-weight: 400;">Choose your trip</h2>
                <p style="font-size: 56px; font-weight: 400; color: #333;">당신의 여행지를 골라보세요.</p>
            </div>

            <!-- 도시 검색 입력창 -->
            <%@ include file="/components/searchForm.jsp" %>

            <!-- to,ky,oa,fu 이미지 부분 감싸기-->
            <div id="city-group" class="row mt-5 justify-content-center">
            	<!-- 배열은 순회하며 이미지 출력 -->
                <c:forEach var="city" items="${cityArr}">
			        <div class="col-12 col-md-6 col-lg-4">
			            <a href="home.do?region=${city[0]}" style="text-decoration: none; color: inherit;">
			                <div class="city-card">
			                    <!-- 이미지 출력 -->
			                     <img src="${pageScope[city[2]]}"
			                         alt="${city[0]}" 
			                         class="img-fluid">
			
			                    <h3>${city[1]}</h3>
			                </div>
			            </a>
			        </div>
			    </c:forEach>
            </div>
        </section>
        
	</main>
	
	<!-- FOOTER : 페이지 하단 정보 영역  -->
	<%@ include file="/layout/footer.jsp" %>
		
	<script src="${pageContext.request.contextPath}/resource/js/utils/searchSuggest.js"></script>
</body>
</html>