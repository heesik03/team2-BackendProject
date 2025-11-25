<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header>
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
        <div class="container-fluid">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp" style="font-size: 40px; font-family: 'Playfair Display', serif;">visit japan</a> <!--사이트이름-->
            <!--내이게이션 바 반응형 크기 조절-->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#Flip">
                <span class="navbar-toggler-icon"></span>
            </button> <!--모바일 화면에서 보이는 3줄짜리 버튼 collapse = 접기 펼치기-->
            
            <!--접고 펼쳐지는 부분에 들어갈 것들(header) 요소-->
            <div class="collapse navbar-collapse" id="Flip" style="font-size: 24px;">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#">about</a> <!--about 텍스트-->
                    </li>
                    
                    <!-- 로그인 여부에 따른 조건 영역 -->
				    <c:choose>	
				        <c:when test="${not empty sessionScope.id}"> 
				        	<!-- 유저가 로그인 상태라면 -->
				            <li class="nav-item">
				                <a class="nav-link" href="${pageContext.request.contextPath}/mypage.do">
				                	my page
				                </a>
				            </li>
				            <li class="nav-item ms-lg-3"> <!-- log out 버튼 -->
					         	<form action="${pageContext.request.contextPath}/logout.do" method="post">
					                <button type="submit" class="btn btn-primary" 
					                	style="font-size: 19px; background-color: #6E98E5; border: none;">
					                	log out
					                </button>
					            </form>
				            </li>
				        </c:when>
				
				        <c:otherwise>	
				        	<!-- 유저가 로그아웃 상태라면 -->			            
				            <li class="nav-item">	
				                <a class="nav-link" href="${pageContext.request.contextPath}/pages/signup.jsp">
				                	sign up
				                </a>
				            </li>
				            <li class="nav-item ms-lg-3"> <!--log in 버튼-->
				                <a class="btn btn-primary" href="${pageContext.request.contextPath}/pages/login.jsp" role="button"
				                   style="font-size: 19px; background-color: #6E98E5; border: none;">
				                   	log in
				                </a>
				            </li>
				        </c:otherwise>
				    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
    <!-- 구분선 -->	
    <hr>
</header>