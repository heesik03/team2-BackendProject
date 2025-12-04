<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
<!DOCTYPE html>
<html lang="ko">
<head>
	<!-- head (페이지 설정) 영역 -->
	<c:set var="pageTitle" value="About" />
	<%@ include file="/components/pageHead.jsp" %>
	<style>
	    /* 기본 폰트 설정 */
	    body {
	        font-family: 'Playfair Display', 'Noto Serif KR', serif;
	    }
	
	    /* Inter 폰트 사용 영역 (한글은 Noto Sans KR로 대체) */
	    .font-inter {
	        font-family: 'Inter', 'Noto Sans KR', sans-serif;
	    }
	
	    /* ▼ 히어로(메인 배너) 섹션 스타일 */
	    .hero-about {
	        position: relative;
	        height: 90vh; /* 화면 높이의 90% */
	        min-height: 800px;
	        background: url('${pageContext.request.contextPath}/resource/images/about/about-1.jpg') no-repeat center center; 
	        background-size: cover;
	        color: white;
	    }
	    .hero-overlay-about {
	        position: absolute; top: 0; left: 0;
	        width: 100%; height: 100%;
	        background-color: rgba(0, 0, 0, 0.2); /* 배경 오버레이는 80% 투명 */
	        display: flex;
	        justify-content: center;
	        align-items: center; 
	        text-align: center;
	    }
	    
	    
	    .hero-overlay-about h1 {
	        font-size: 150px;
	        font-weight: 800;
	        font-family: 'Inter', 'Noto Sans KR', sans-serif;
	    
	        color: white;
	        
	        text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
	    }
	    /* ▲ 히어로 섹션 끝 */
	
	
	    /* ▼ 인용구 섹션 */
	    .quote-section {
	        border-top: 3px solid black;
	        border-bottom: 3px solid black;
	    }
	    .quote-section h2 {
	        font-size: 100px;
	        font-weight: 800;
	    }
	    /* ▲ 인용구 섹션 끝 */
	
	
	    /* ▼ 기능 소개 섹션 */
	    .feature-section .feature-title {
	        font-size: 100px;
	        font-weight: 800;
	    }
	    .feature-section .feature-subtitle {
	        font-size: 60px;
	        font-weight: 400;
	    }
	    .feature-section .feature-box {
	        background: #FBFBFB;
	        border: 1px solid #6E98E5;
	        padding: 2rem;
	        font-size: 30px;
	        font-weight: 400;
	    }
	    .feature-section img {
	        border: 3px solid #6E98E5;
	        width: 100%;
	        height: auto;
	    }
	    /* ▲ 기능 소개 섹션 끝 */
	    
	
	    /* 푸터 스타일 */
	    footer {
	        background: #160E0E; color: white; padding: 64px 0; 
	    }
	    footer h3 {
	        font-size: 24px; font-weight: 800; margin-bottom: 24px; 
	    }
	    footer p, footer a {
	        font-size: 20px; color: #ccc; text-decoration: none; line-height: 1.8;
	    }
	    footer a:hover { color: white; text-decoration: underline; }
	    .footer-info { font-size: 14px; line-height: 1.6; }
	</style>
</head>

<body>  

 <!-- HEADER (상단 네비게이션) -->
	<%@ include file="/layout/header.jsp"  %>
    
    <main>      

        <section class="hero-about">
            <div class="hero-overlay-about">
                <h1 class="font-inter">Welcome to the Japan</h1>
            </div>
        </section>
        
        <section class="container-fluid quote-section my-5 py-5">
            <div class="container text-center">
                <h2 class="font-inter">“Simple is the Best”</h2>
            </div>
        </section>

        <section class="container feature-section my-5 py-5">
            <h2 class="feature-title font-inter">즐거운 여행, <br/>하지만 귀찮지 않으세요?</h2>
        </section>

        <section class="container feature-section my-5 py-5">
            <div class="row align-items-center g-5">
                <div class="col-lg-6">
                    <p class="feature-subtitle font-inter">
                        저희를 통해<br/>
                        맛집, 관광지 정보를 쉽게 찾고<br/>
                        동선을 짜보세요!
                    </p>
                    <div class="feature-box font-inter mt-4">
                        일본 4대 도시 중 한 곳을 선택하고<br/>
                        tabelog를 바탕으로 맛집을!<br/>
                        인기 도시 관광지를!<br/>
                        쉽게 찾아보고 저장해 보세요!
                    </div>
                    </div>
                <div class="col-lg-6">
                   <img src="${pageContext.request.contextPath}/resource/images/about/about-2.jpg" alt="맛집, 관광지 정보" class="img-fluid">
                </div>
            </div>
        </section>

        <section class="container feature-section my-5 py-5">
            <div class="row align-items-center g-5">
                <div class="col-lg-6 order-lg-1">
                    <img src="${pageContext.request.contextPath}/resource/images/about/about-3.jpg" alt="플래너 기능" class="img-fluid">
                </div>
                <div class="col-lg-6 order-lg-2">
                    <div class="feature-box font-inter">
                        날짜와 저장한 관광지, 맛집들을<br/>
                        한눈에 보면서 실시간으로<br/>
                        지도에 표시 해보세요!
                    </div>
                </div>
            </div>
        </section>
    
    </main>
    <!-- FOOTER : 페이지 하단 정보 영역  -->
	<%@ include file="/layout/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>