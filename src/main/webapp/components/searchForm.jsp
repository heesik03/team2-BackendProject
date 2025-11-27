<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 도시 검색 입력창 -->
<div>
	<div class="row justify-content-center my-5">
	    <div class="col-lg-8">
	    
	        <form action="${pageContext.request.contextPath}/pages/loading.jsp" method="get" class="position-relative">
	            <!-- 검색창 -->
	            <input type="search" name="region"
	                   id="searchInput"   
	                   class="form-control form-control-lg"
	                   placeholder="원하는 도시를 검색해보세요!"
	                   style="border-radius: 9999px; padding-right: 60px;" 
	                   autocomplete="off"
	                   required>
	
	            <!-- 검색 버튼  -->
	            <button type="submit"
	                    class="btn position-absolute top-50 end-0 translate-middle-y me-3 p-0"
	                    style="border: none; background: transparent;">
			        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
					  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
					</svg>
	            </button>
	
	            <!-- 연관검색어 리스트 -->
	            <ul id="suggestList"
	                class="list-group position-absolute w-100 mt-2"
	                style="display:none; z-index: 999;">
	                <li class="list-group-item list-group-item-action" data-region="도쿄">도쿄</li>
	                <li class="list-group-item list-group-item-action" data-region="오사카">오사카</li>
	                <li class="list-group-item list-group-item-action" data-region="후쿠오카">후쿠오카</li>
	                <li class="list-group-item list-group-item-action" data-region="교토">교토</li>
	            </ul>
	        </form>
	        
	    </div>
	</div>
	
	<!-- 연관 검색어 박스 -->
	<div id="suggestionBox" class="suggestion-box"></div>
	

	<!-- 뒤로가기 버그 방지 -->
	<script>
		const context = "${pageContext.request.contextPath}"
		
		document.querySelector("form").addEventListener("submit", function(){
		    history.replaceState(null, null, location.href);
		});
	</script>
</div>


