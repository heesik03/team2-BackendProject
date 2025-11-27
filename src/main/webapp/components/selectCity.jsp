<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<label for="choose-city" class="form-label">주요 관심 도시 선택</label>
<select id="choose-city" name="city" class="form-select" required>
    <option value="" disabled selected>도시 선택</option>
    <!-- head에서 선언한 검색어 목록 사용 -->
   	<c:forEach var="city" items="${regionList}">
   	 	<option value="${city}">${city}</option>
        "${city}"
    </c:forEach> 
</select>