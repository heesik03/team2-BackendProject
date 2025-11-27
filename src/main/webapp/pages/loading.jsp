<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Loading...</title>

    <style>
        body {
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background: #ffffff;
            font-family: 'Pretendard', sans-serif;
        }

        .spinner {
            width: 45px;
            height: 45px;
            border: 6px solid #ddd;
            border-top-color: #000;
            border-radius: 50%;
            animation: spin 0.9s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .text {
            font-size: 22px;
            margin-top: 20px;
            color: #333;
        }
    </style>
</head>

<body>

    <div class="spinner"></div>
    <div class="text">로딩 중...</div>
    
	<!-- 로딩 스피너 -->
	<div id="loadingSpinner" 
	     style="display:none; position:fixed; top:0; left:0; width:100%; height:100%;
	            background:rgba(255,255,255,0.8); z-index:9999;
	            align-items:center; justify-content:center;">
	    <div class="spinner-border text-primary" role="status" style="width:3rem; height:3rem;"></div>
	</div>
    
    <!-- 자동 submit 폼 -->
    <form id="loadingForm" action="${pageContext.request.contextPath}/home.do" method="get">
        <input type="hidden" name="region" value="${param.region}">
    </form>
    
    <script>
        // 페이지가 로드되면 바로 다음 요청으로 이동
        window.onload = function () {
            document.getElementById("loadingForm").submit();
        };
    </script>

</body>

</html>
