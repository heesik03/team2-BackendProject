<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<style>
    /* 전체 화면 덮는 기본 로딩 레이어 */
    #loading {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: #ffffff;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        z-index: 99999;

        opacity: 1;
        transition: opacity 0.45s ease;
    }

    /* 기본 스피너 */
    .spinner {
        width: 48px;
        height: 48px;
        border: 6px solid #e0e0e0;
        border-top-color: #000000;
        border-radius: 50%;
        animation: spin 0.9s linear infinite;
    }

    @keyframes spin {
        to { transform: rotate(360deg); }
    }

    /* 텍스트 */
    .loading-text {
        font-size: 20px;
        margin-top: 16px;
        color: #333;
        font-weight: 500;
    }

    /* 페이지 이동 시 표시되는 보조 스피너 */
    #loadingSpinner {
        position: fixed;
        top: 0; left: 0;
        width: 100%; height: 100%;
        background: rgba(255, 255, 255, 0.85);
        display: none;
        align-items: center;
        justify-content: center;
        z-index: 9999;
    }
</style>


<div id="loading">
    <div class="spinner"></div>
    <div class="loading-text">로딩 중...</div>

    <!-- Bootstrap 스타일 스피너(보조) -->
    <div id="loadingSpinner">
        <div class="spinner-border" role="status" style="width: 3rem; height: 3rem;"></div>
    </div>
</div>

 
<script>	
	// 브라우저가 페이지를 표시할 때, 로딩페이지 숨김
	const loader = document.getElementById("loading");

	window.addEventListener("pageshow", function (event) {
	
	    if (!loader) return;
	
	    // 뒤로가기 등으로 페이지가 복원 되었을때
	    if (event.persisted) {
	    		// 애니메이션 제거 후 숨김
	        loader.style.transition = "none"; 
	        loader.style.display = "none";
	        loader.style.opacity = "0";
	    } else {
	    		// 페이드 아웃 (로딩 페이지가 0.2초에 거쳐 천천히 사라짐)
	        loader.style.transition = "opacity 0.2s ease";
	        loader.style.opacity = "0";   
	
	        setTimeout(function () {
	            loader.style.display = "none";
	        }, 200);
	    }
	});
	
	document.addEventListener("DOMContentLoaded", function () {	
	    // a 태그 클릭 시 로딩 표시
	    document.querySelectorAll("a").forEach(a => {
	        a.addEventListener("click", function (event) {
	            
	            // target = "_blank" 가 아닌 경우엔 로딩 표시
	            if (a.target !== "_blank") {
	                loader.style.display = "flex";
	                loader.style.opacity = "1";
	            }

	        });
	    });
	});
	
	// form 제출 시 로딩창 보이게
    document.querySelectorAll("form").forEach(form => {
        form.addEventListener("submit", function (event) {
            // 로딩 화면 표시
            loader.style.display = "flex";
            loader.style.opacity = "1";
        });
    });
	
	// 뒤로 가기 오류 방지
	history.replaceState(null, null, location.href);
	
</script>
