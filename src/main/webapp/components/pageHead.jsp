<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<meta charset="UTF-8">
<title>${pageTitle}</title>

<!-- bootstrap 연결 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> 
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- 폰트 스타일 연결 등 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
    href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;700&family=Playfair+Display:wght@400;800&display=swap"
    rel="stylesheet">

<% 
	String[] regionList = {"도쿄", "오사카", "교토", "후쿠오카", "삿포로", "나고야", "히로시마"}; // 검색어 목록 선언
	request.setAttribute("regionList", regionList);
%>

<script>
	// 검색어 목록 js에 넣기
    const regionList = [
        <c:forEach var="city" items="${regionList}" varStatus="st">
            "${city}"<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];
</script>
