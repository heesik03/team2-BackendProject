<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<style>
    /* footer: 하단 푸터 영역 */
    footer {
        background: #160E0E;
        color: white;
        padding: 64px 0; 
    }
    /* footer h3: 푸터 안의 소제목 */
    footer h3 {
        font-size: 24px; 
        font-weight: 800;
        margin-bottom: 24px; 
    }
    /* footer p, footer a: 텍스트 및 링크 */
    footer p, footer a {
        font-size: 20px; 
        color: #ccc; 
        text-decoration: none;
        line-height: 1.8;
    }
    footer a:hover {
        color: white;
        text-decoration: underline;
    }
    /* 푸터 오른쪽 정보 */
    .footer-info {
        font-size: 14px; 
        line-height: 1.6;
    }
</style>

 <footer class="mt-5">
    <div class="container">
        <div class="row">

            <!-- 빠른링크 -->
            <nav class="col-12 col-md-3 mb-4">
                <h3>빠른링크</h3>
                <p>
                		<a href="${pageContext.request.contextPath}/pages/about.jsp" target="_blank">about</a>
                	</p>
                	
                <!-- 로그인 여부에 따른 조건 영역 -->
			    <c:choose>	
			        <c:when test="${not empty sessionScope.id}"> 
			        	<!-- 유저가 로그인 상태라면 -->
			            <p>
				            <a href="${pageContext.request.contextPath}/mypage.do">
				            		my page
				            	</a>
			           	</p>
			        </c:when>
			
			        <c:otherwise>	
			        	<!-- 유저가 로그아웃 상태라면 -->		
			  			<p>
				            	<a href="${pageContext.request.contextPath}/pages/signup.jsp">
				            		sign up 
				            	</a>
			           	</p>	            
			        </c:otherwise>
			    </c:choose>
			    
                <p><a href="#">community</a></p>
            </nav>

            <!-- 예약 -->
            <nav class="col-12 col-md-3 mb-4">
                <h3>예약</h3>
                <p><a href="https://tabelog.com/kr/" target="_blank">Tabelog</a></p>
                <p><a href="https://kr.trip.com/?locale=ko-KR&curr=KRW" target="_blank">Trip.com</a></p>
                <p><a href="https://www.skyscanner.co.kr/" target="_blank">SkyScanner</a></p>
            </nav>

            <!-- 고객지원 -->
            <nav class="col-12 col-md-3 mb-4">
                <h3>고객지원</h3>
                <p><a href="https://www.japan.travel/ko/plan/faq/" target="_blank">자주 묻는 질문</a></p>
                <p><a href="about.jsp" target="_blank">이용 안내</a></p>
                <p><a href="https://mail.naver.com/" target="_blank">문의하기</a></p>
            </nav>

            <!-- 브랜드 정보 -->
            <div class="col-12 col-md-3 text-md-end">
                <h3 style="font-size: 40px; font-weight: 400;">visit Japan</h3>
                <p style="font-size: 24px; color: #eee; font-weight: 400;">일본 여행을 보다 편리하게</p>

                <div class="mt-4 footer-info">
                    <p style="margin: 0;">김희식 | 조영재 | 길재현</p>
                    <p style="margin: 0;">email : cka8701@gmail.com</p>
                   	<p style="margin: 0;">Dongyang Mirae University</p>
                </div>
            </div>

        </div>
    </div>
</footer>