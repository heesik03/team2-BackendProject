<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<jsp:include page="/components/loading.jsp" />

<html lang="ko">
<head>
	<c:set var="pageTitle" value="Visit Japan - 게시글 보기" />
	<%@ include file="/components/pageHead.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/itinerary.css"> 
    
    <%-- Google Maps API 로드 --%>
    <script src="https://maps.googleapis.com/maps/api/js?key=${APIKey}&libraries=places&loading=async"></script>
    
    <style>
		.comment-item-delete {
		    border: 1px solid #dc3545;
		    color: #dc3545;
		    background: white;
		    margin-left: 5px;
		}

		.comment-item-delete:hover {
		    background: #dc3545;
		    color: white;
		}
		
		/* 좋아요 버튼 */
		.add-like-btn {
		    display: block;            
		    margin: 10px auto;           /* 상하 10px, 좌우 자동으로 가운데 정렬 */
		    background-color: white;
		    border: 1px solid #f0c419;  /* 노란색 테두리 */
		    color: #f0c419;       
		    padding: 6px 10px;      
		    border-radius: 6px;
		    transition: all 0.2s;
		    font-weight: 600;
		    font-size: 0.9rem;
		    width: 120px;           
		    cursor: pointer;
		    text-align: center;     
		}
		
		.add-like-btn:hover { 
		    background-color: #f0c419; 
		    color: white; 
		}
		
		.add-like-btn.clicked {
		    background-color: #f0c419 !important;
		    color: white !important;
		    border-color: #f0c419 !important;
		}
		
    </style>
</head>

<body>

	<%@ include file="/layout/header.jsp" %>
    
    <main class="py-5">
        <div class="view-container">
        		<jsp:include page="/components/itineraryView.jsp" />
        		
        		<article>
        			<%-- 게시글 내용 --%>
        			<p class="fs-5">
        				${postData.content}
        			</p>
        			
        			<%-- 좋아요 버튼, 로그아웃 상태일시 클릭 안됨 --%>
				<button type="button" class="add-like-btn"
				    data-id="${postData.id}"
				    ${empty sessionScope.id ? "disabled" : ""}>
				        좋아요 ${postData.like}
			    </button>
        		</article>
        		
        		<br>
        		<h4>댓글 작성</h4>
        		<form>
			    <textarea
			        id="comment-area"
			        class="form-control mt-3"
			        placeholder="댓글 입력 (최대 200자)"
			        maxlength="200"
			        required
			    ></textarea>
			    <br>
			    
			    <%-- 댓글 버튼, 로그아웃 상태일시 클릭 안됨 --%>
			    <button type="button"
				        id="btn-comment"
				        class="btn btn-outline-info"
				        ${empty sessionScope.id ? 'disabled' : ''}>
				    제출
				</button>
			    
        		</form>
        		
        		<hr>
        		<section id="comment-section">
           		<c:choose>
	                 <c:when test="${empty commentList}">
	                 	<div class="no-comments">
	                 		<p>댓글이 없습니다.</p>
	                 	</div>
	                 </c:when>
	     
	                 <%-- communityList가 있는 경우: 반복문을 통해 리스트 출력 --%>
	                 <c:otherwise>
	                     <c:forEach var="comment" items="${commentList}">
	                     
							<div class="comment-item border rounded p-3 mb-3 bg-white">
							    <div class="d-flex align-items-center justify-content-between mb-2">
							        <div class="d-flex align-items-center">
							            <!-- 날짜 -->
							            <span class="text-muted small createAt" data-date="${comment.commentCreateAt}"></span>
							            <!-- 구분선 -->
							            <span class="border-start mx-2" style="height: 1em;"></span>
							            <!-- 닉네임 -->
							            <span>${comment.authorName}</span>
							        </div>
							
							        <!-- 삭제 버튼 -->
							        <c:if test="${not empty sessionScope.id}">
							            <button type="button"
							                    class="btn btn-sm btn-outline-danger comment-item-delete"
							                    data-id="${comment.commentId}"
							                    data-author-id="${comment.authorId}">
							                X
							            </button>
							        </c:if>
							    </div>
							    <!-- 댓글 내용 -->
							    <p class="mb-0">${comment.commentContent}</p>
							</div>

	                     </c:forEach>
	                 </c:otherwise>
             	</c:choose>
        		</section>
        		
        </div>
    </main>

    <%-- Google Map 모달 창 정의 시작 --%>
    <jsp:include page="/components/googleMapModal.jsp" />

    <%@ include file="/layout/footer.jsp" %>
	<script>
		const contextPath = "${pageContext.request.contextPath}"
	</script>
	<script src="${pageContext.request.contextPath}/resource/js/page/showCommunity.js"></script>
    <script src="${pageContext.request.contextPath}/resource/js/utils/changeDate.js"></script>
    <script src="${pageContext.request.contextPath}/resource/js/utils/createGoogleMap.js"></script>
    <script src="${pageContext.request.contextPath}/resource/js/utils/modalGoogleMap.js"></script>
    	
</body>
</html>