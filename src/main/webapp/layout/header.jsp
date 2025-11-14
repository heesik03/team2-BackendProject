<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header>
    <a href="${pageContext.request.contextPath}/index.jsp">홈</a>

    <c:choose>
        <c:when test="${not empty sessionScope.name}">
            <h2>${sessionScope.name}님 환영합니다!</h2>
            
            <form action="logout.do" method="post">
                <button type="submit">로그아웃</button>
            </form>

            <a href="#">마이페이지</a>
        </c:when>

        <c:otherwise>
            <a href="${pageContext.request.contextPath}/pages/login.jsp">로그인</a>
            <a href="${pageContext.request.contextPath}/pages/signup.jsp">회원가입</a>
        </c:otherwise>
    </c:choose>

    <hr>
</header>
