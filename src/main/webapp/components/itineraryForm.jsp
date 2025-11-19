<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form id="itinerary-form">
	
    <!-- 일정 제목 -->
    <label for="title-input">일정 제목: </label>
    <input
        type="text"
        name="title"
        id="title-input"
        placeholder="일정 제목 입력"
        value="${not empty itineraryData ? itineraryData.title : ''}"
        required
    ><br>

    <!-- 시작 날짜 -->
    <label for="start-date">Start date:</label>
    <input
        type="date"
        id="start-date"
        name="start"
        value="${not empty itineraryData ? itineraryData.startDate : ''}"
        required
    />

    <!-- 종료 날짜 -->
    <label for="end-date">End date:</label>
    <input
        type="date"
        id="end-date"
        name="end"
        value="${not empty itineraryData ? itineraryData.endDate : ''}"
        required
    /><br>
		
	<!-- 일정 입력 영역 -->
	<div id ="input-itinerary"> 
		<h4>일정 만들기</h4>
		
		<!-- 관광지 선택 -->
		<select id="selectd-spot"> 
		    <option value="" disabled selected>관광지 선택</option>
		    
	    		<c:forEach var="city" items="${cityList}">
		        <optgroup label="${city.cityName}">
		        	<c:choose>
		                <c:when test="${empty city.spots}">
		                	<!-- spots 배열이 비어있으면 "없음" 표시 -->
		                    <option value="" disabled selected>없음</option>
		                </c:when>
		
		                <c:otherwise>
		                    <c:forEach var="spot" items="${city.spots}">
		                    	<!-- spots 배열이 있으면 반복 출력 -->
		                    	<option value="${spot}">${spot}</option>
		                    </c:forEach>
		                </c:otherwise>
		            </c:choose>
			    </optgroup>
		    </c:forEach>
		    			    
		</select>
					
		<!-- 일자 선택 (js로 옵션 채워짐) -->
		<select id="selectd-day">
			<option value="" disabled selected>일자 선택</option>
		</select>
		
		<button type="button" id="input-itinerary-button">추가</button>
	</div>
	
	<div id="day-container">
	</div>
	
	<!-- 일정 목록을 채워 넣을 input창 (안보임) -->
	<input type="hidden" id="spot-list-hidden" name="spotList">
	
	<button type="button" id="submit-btn">
		제출
	</button>
		
</form>