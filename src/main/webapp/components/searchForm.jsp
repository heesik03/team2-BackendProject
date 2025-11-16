<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

 <!-- 도시 검색 입력창 -->
 <div class="row justify-content-center my-5">
    <div class="col-lg-8">
        <form action="home.do" method="get" class="position-relative">

            <!-- 검색창 -->
            <input type="search" name="region" 
                   class="form-control form-control-lg"
                   placeholder="원하는 도시를 검색해보세요!"
                   style="border-radius: 9999px; padding-right: 60px;" required>

            <!-- 검색 버튼 (SVG 아이콘) -->
            <button type="submit"
                    class="btn position-absolute top-50 end-0 translate-middle-y me-3 p-0"
                    style="border: none; background: transparent;">
		        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
				  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
				</svg>
            </button>

        </form>
    </div>
</div>