<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<jsp:include page="/components/loading.jsp" />

<html lang="ko">

<head>
	<c:set var="pageTitle" value="Visit Japan - 일정 공유글 수정" />
	<%@ include file="/components/pageHead.jsp" %>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/itineraryForm.css">
</head>

<body>

	<%@ include file="/layout/header.jsp" %>
	
	
	<main class="py-5">
        <div class="container main-container">
            <div class="form-card">
                <div class="form-header">
                    <h2 class="form-title">
                        <i class="bi bi-airplane-engines text-primary me-2"></i>일정 공유글 수정
                    </h2>
                    <p class="form-subtitle">나의 여행 계획을 공유해 보세요!</p>
                </div>
                
				<jsp:include page="/components/communityForm.jsp" />
				
            </div>
        </div>
		
	</main>
	<%@ include file="/layout/footer.jsp" %>
	
	<script>	
		document.getElementById("share-form").addEventListener("submit", function(e) {
		    e.preventDefault();
	
		    const titleInput = document.getElementById("title-input");
		    const contentArea = document.getElementById("content-area");
		    const params = new URLSearchParams(window.location.search);
	
		    if (!titleInput || titleInput.value.trim().length === 0) {
		        alert("제목을 입력해 주세요.");
		        return;
		    }
	
		    if (!contentArea || contentArea.value.trim().length === 0) {
		        alert("내용을 입력해 주세요.");
		        return;
		    }
	
		    const title = titleInput.value;
		    const content = contentArea.value;
		    const id = params.get("id");
	
		    fetch(`${pageContext.request.contextPath}/community.do`, {
		        method: "PUT",
		        headers: { "Content-Type": "application/json" },
		        body: JSON.stringify({ id, title, content })
		    })
		    .then(res => {
		        if (res.status === 204) {
		            alert("게시글 수정 성공!");
		            window.location.href = `${pageContext.request.contextPath}/community.do`;
		        } else {
		            alert("게시글 수정 실패");
		        }
		    })
		    .catch(err => { 
		        alert("게시글 수정 실패");
		        console.error(err);
		    });
		});
	</script>

	
</body>
</html>