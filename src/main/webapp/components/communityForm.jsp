<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="form-body">
    <div class="form-content-wrapper">
        <form action="${pageContext.request.contextPath}/community.do" method="post" id="share-form">
        
            <label for="title-input" class="form-label"> 제목 </label>
            <input
                type="text"
                name="title"
                id="title-input"
                class="form-control"
                placeholder="제목 입력 (최대 50자)"
                maxlength="50"
                required
            ><br>
            
            <label for="content-area" class="form-label"> 내용 </label>
            <textarea
                name="content"
                id="content-area"
                class="form-control"
                placeholder="내용 입력 (최대 1000자)"
                maxlength="1000"
                rows="10"
                required
            ></textarea>
            <br>
            
            <button type="submit" class="btn btn-primary-custom w-100">제출</button>
            
            <input type="hidden" name="id" value="${param.id}">

        </form>
    </div>
</div>
