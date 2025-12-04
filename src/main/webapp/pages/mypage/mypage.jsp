<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<!-- 로딩 페이지는 최상단에 -->
<jsp:include page="/components/loading.jsp" />

<html lang="ko">
<head>
	<!-- head (페이지 설정) 영역 -->
	<c:set var="pageTitle" value="마이페이지" />
	<%@ include file="/components/pageHead.jsp" %>
	
	<!-- 구글 맵 연결 -->
    <script src="https://maps.googleapis.com/maps/api/js?key=${APIKey}&libraries=places&loading=async"></script>

	<!-- 구글 맵 스타일 (추후 삭제) -->
    <style>
        #map { width: 100%; height: 600px; }
    </style>
</head>

<!-- 로그아웃 상태라면 홈 화면으로 이동 -->
<c:if test="${empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>
<body data-context-path="${pageContext.request.contextPath}">

	<%@ include file="/layout/header.jsp"  %>
	
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
			
			<h3>관광지 검색</h3>	
			<section class="row justify-content-center my-5">
				<div class="col-lg-8">
				   <%@ include file="/components/selectCity.jsp" %> <br>
				
			        <form class="search-from position-relative">
			            <!-- 검색창 -->
			            <input type="search"
			                   id="searchInput"   
			                   class="form-control form-control-lg"
			                   placeholder="관광지 검색"
			                   style="border-radius: 9999px; padding-right: 60px;" 
			                   autocomplete="off"
			                   required>
			
			            <!-- 검색 버튼  -->
			            <button type="submit"
			            			id="search-btn"
			                    class="btn position-absolute top-50 end-0 translate-middle-y me-3 p-0"
			                    style="border: none; background: transparent;">
					        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
							  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
							</svg>
			            </button>
		
			        </form>
			        <br>
		    		</div>
		    		
		    		<div id="mapDiv" style="display: none;">
			    		<div id="map"></div>

					<br>
	  				<button class="add-scrap-btn"
				    		type="button">
				        스크랩 추가
				    </button>
				    	<br>	    
		    		</div>

			</section>
			
			
			<nav>
				<a href="${pageContext.request.contextPath}/pages/mypage/changeInfo.jsp?like-city=${userData.likeCity}">정보 수정</a>
				<!-- bootstrap으로 여백 설정 -->
				<br>
				<br>
				
				<a href="${pageContext.request.contextPath}/mypage/itinerary.do">여행 일정</a>
				
				<!-- 관리자면 보임 -->
				<c:if test="${userData.admin}">
					<a href="${pageContext.request.contextPath}/admin.do" target="_blank">
						관리자 페이지
					</a>
				</c:if>
			</nav>
			
			<br>
			<button id="delete-account-btn" type="button">
				회원탈퇴
			</button>
			
		</main>
		
	<%@ include file="/layout/footer.jsp" %>
	
	<!-- js 파일 불러옴 -->
	<script src="${pageContext.request.contextPath}/resource/js/utils/changeDate.js"></script>
	<script src="${pageContext.request.contextPath}/resource/js/utils/createGoogleMap.js"></script>
	<script>
		const contextPath = "${pageContext.request.contextPath}"
	</script>
	<script src="${pageContext.request.contextPath}/resource/js/page/mypage.js"></script>
</body>
</html>