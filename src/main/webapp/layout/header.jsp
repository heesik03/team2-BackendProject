<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header>
    <nav class="navbar navbar-expand-lg bg-white">
        <div class="container-fluid">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp" style="font-size: 40px; font-family: 'Playfair Display', serif;">visit japan</a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button> 
            
            <div class="collapse navbar-collapse" id="navbarNav" style="font-size: 24px;">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/pages/about.jsp">about</a>
                    </li>
                    
                    <c:choose>  
                        <c:when test="${not empty sessionScope.id}"> 
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/mypage.do">
                                    my page
                                </a>
                            </li>
                            <li class="nav-item ms-lg-3"> <form action="logout.do" method="post">
                                    <button type="submit" class="btn btn-primary" 
                                        style="font-size: 19px; background-color: #6E98E5; border: none;">
                                        log out
                                    </button>
                                </form>
                            </li>
                        </c:when>
                
                        <c:otherwise>   
                            <li class="nav-item">   
                                <a class="nav-link" href="${pageContext.request.contextPath}/pages/signup.jsp">
                                    sign up
                                </a>
                            </li>
                            <li class="nav-item ms-lg-3"> <a class="btn btn-primary" href="${pageContext.request.contextPath}/pages/login.jsp" role="button"
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
</header>