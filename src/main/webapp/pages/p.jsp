<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Visit Japan</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@400;700&family=Playfair+Display:wght@400;800&display=swap"
	rel="stylesheet">

<style>
	body {
		margin: 0;
		padding: 0;
		font-family: 'Playfair Display', 'Noto Serif KR', serif;
	}
	
	img {
		display: block;
	}
</style>
</head>
<body>	
	<c:url value="/resource/image/h1.jpg" var="h1Img"/>
	<c:url value="/resource/image/h2.jpg" var="h2Img"/>
	<c:url value="/resource/image/h3.jpg" var="h3Img"/>
	<c:url value="/resource/image/h4.jpg" var="h4Img"/>
	
	
	<div
		style="width: 1440px; height: 3249px; position: relative; background: white; overflow: hidden">
		
		
		<!-- 헤더 영역  -->
		<header
			style="width: 1440px; height: 80px; left: 0px; top: 0px; position: absolute; overflow: hidden">
			
			<nav>
				<div
					style="left: 22px; top: 13px; position: absolute; color: black; font-size: 40px; font-family: 'Playfair Display', 'Noto Serif KR', serif; font-weight: 400; word-wrap: break-word">visit
					japan</div>
				<a href="#"
					style="left: 1011px; top: 13px; position: absolute; color: black; font-size: 30px; font-family: 'Playfair Display', 'Noto Serif KR', serif; font-weight: 400; word-wrap: break-word">about</a>
				<a href="#"
					style="left: 1148px; top: 13px; position: absolute; color: black; font-size: 30px; font-family: 'Playfair Display', 'Noto Serif KR', serif; font-weight: 400; word-wrap: break-word">my
					page</a>
				<a href="#"
					style="width: 97px; height: 43px; left: 1319px; top: 18px; position: absolute; background: #6E98E5; overflow: hidden; outline: 1px black solid; outline-offset: -1px">
					<span
						style="left: 24px; top: 8px; position: absolute; color: black; font-size: 20px; font-family: 'Playfair Display', 'Noto Serif KR', serif; font-weight: 400; word-wrap: break-word">log
						in</span>
				</a>
			</nav>
		</header>
		
		<!-- 메인(본문) 영역  -->
		<main>		

			<!-- Trip to Japan  -->
			<div id="trip-to-japan">
				<img
				style="width: 100%; height: auto; left: 0px; top: 80px; position: absolute; opacity: 0.75;"
				src="${h1Img}" />
				<div
					style="width: 854px; height: 379px; left: 56px; top: 469px; position: absolute; color: white; font-size: 120px; font-family: 'Playfair Display', 'Noto Serif KR', serif; font-weight: 400; word-wrap: break-word">Trip
					to japan</div>
				
				<span
					style="left: 56px; top: 640px; position: absolute; color: white; font-size: 40px; font-family: 'Playfair Display', 'Noto Serif KR', serif; font-weight: 400; word-wrap: break-word">
					고즈넉한 사찰부터 화려한 도시까지<br />
					당신의 일본여행을 계획하세요
				</span>
			</div>
		</main>
			


		<!-- 푸터 영역  -->
		<footer
			style="width: 1440px; height: 391px; left: -4px; top: 2860px; position: absolute">
			
			<!-- 개발자 신상 영역  -->
			<div id="developer">
				<span
					style="width: 1440px; height: 407px; left: 0px; top: 0px; position: absolute; background: #160E0E"></span>
	
				<span
					style="left: 1329px; top: 183px; position: absolute; color: white; font-size: 25px; font-family: 'Playfair Display', 'Noto Serif KR', serif; font-weight: 400; word-wrap: break-word">
					김희식<br />조영재<br />길재현
				</span>
				<span
					style="left: 1237px; top: 39px; position: absolute; color: white; font-size: 40px; font-family: 'Playfair Display', 'Noto Serif KR', serif; font-weight: 400; word-wrap: break-word">visit
					Japan</span>
				<span
					style="left: 1020px; top: 101px; position: absolute; color: white; font-size: 35px; font-family: 'Playfair Display', 'Noto Serif KR', serif; font-weight: 400; word-wrap: break-word">일본
					여행을 보다 편리하게</span>
				<span
					style="left: 32px; top: 46px; position: absolute; color: white; font-size: 30px; font-family: 'Playfair Display', 'Noto Serif KR', serif; font-weight: 800; word-wrap: break-word">빠른링크</span>
				<span
					style="left: 986px; top: 210px; position: absolute; color: white; font-size: 25px; font-family: 'Playfair Display', 'Noto Serif KR', serif; font-weight: 400; word-wrap: break-word">
					tel : 010-2354-3453<br />email : zlkdjkdj@naver.com
				</span>
			</div>

			
			<!-- 빠른 링크 영역  -->
			<div id="quick-link">
				<nav
					style="left: 32px; top: 144px; position: absolute; color: white; font-size: 40px; font-family: 'Playfair Display', 'Noto Serif KR', serif; font-weight: 400; word-wrap: break-word">
					<a href="#">about</a> <br/>
					<a href="#">my page</a> <br/>
					<a href="#">community</a> <br/>
				</nav>
			</div>
			
			<!-- 예약 영역  -->
			<div id="reservation">
				<nav
					style="width: 238px; height: 225px; left: 414px; top: 144px; position: absolute; color: white; font-size: 40px; font-family: 'Playfair Display', 'Noto Serif KR', serif; font-weight: 400; word-wrap: break-word">
					<a href="https://tabelog.com/kr/" target="_blank">Tabelog</a>
					<a href="https://kr.trip.com/?locale=ko-KR&curr=KRW" target="_blank">Trip.com</a>
					<a href="https://www.skyscanner.co.kr/" target="_blank">SkyScanner</a>
				</nav>
				<span
					style="left: 414px; top: 54px; position: absolute; color: white; font-size: 30px; font-family: 'Playfair Display', 'Noto Serif KR', serif; font-weight: 800; word-wrap: break-word">
					예약
				</span>
			</div>
		
		</footer>
	</div>

</body>
</html>