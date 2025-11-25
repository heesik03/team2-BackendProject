<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
	<!-- head (페이지 설정) 영역 -->
	<c:set var="pageTitle" value="관리자 페이지" />
	<%@ include file="/components/pageHead.jsp" %>
</head>

<!-- 로그아웃 상태라면 홈 화면으로 로 이동 -->
<c:if test="${empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>

<body>
	<jsp:include page="/layout/header.jsp" />
		
		<main>
			<h3>관리자 페이지</h3>
			<br>
			
			<h4>유저 목록</h4>			
			<table>
				<thead>
					<tr>
						<th>이메일</th>
						<th>닉네임</th>
						<th>권한</th>
						<th>가입일</th>
						<th>&nbsp;</th> <!-- 공백 (삭제 버튼 위치) -->
					</tr>
				</thead>
				<tbody>
                    <c:forEach var="user" items="${userList}">
                        <tr>
                        
                        		<td>${user.email}</td>
                        		<td>${user.userName}</td> 
                        		<td>
                        			${user.admin ? '관리자' : '일반 사용자'}
                        			
                        			<!-- 일반 유저라면 권한 버튼 보임 -->
                        			<c:if test="${not user.admin}">
                        				<form action="${pageContext.request.contextPath}/admin.do" method="post" class="grant-form">
	                        				<input type="hidden" name="userId" value="${user.id}">
	                        				
	                        				<button type="button" class="grant-btn">
											권한 부여
										</button>
                        				</form>
								</c:if>
								
                        		</td>
                        		<td class="createAt" data-date="${user.createAt}"></td> <!-- js로 변환 후 출력 -->
                        		<!-- 삭제 버튼 : 자신은 제외 ( ne => != ) -->
                        		<c:if test="${sessionScope.id ne user.id}">
	                        		<td>
		                            	<button type="button" class="delete-user-btn" data-user-id="${user.id}">
		                            			X
		                            </button>
	                            </td>
                        		</c:if>
                            
                        </tr>
                    </c:forEach>
				</tbody>
			</table>
		</main>
	
	<%@ include file="/layout/footer.jsp" %>
	
	<!-- js 파일 불러옴 -->
	<script>
		document.querySelectorAll(".grant-btn").forEach(btn => {
		    btn.addEventListener("click", function () {
		        const confirmed = confirm("정말 승급시키실 겁니까?");
		        if (confirmed) {
		            this.closest("form").submit();
		        }
		    });
		});
		
		document.querySelectorAll(".delete-user-btn").forEach(btn => {
		    btn.addEventListener("click", function () {
		        
		        const confirmed = confirm("정말 삭제하시겠습니까?");
		        if (!confirmed) return;

		        const userId = this.dataset.userId;   // dataset.userId 로 접근
		        const tr = this.closest("tr"); // 현재 tr

		        fetch("admin.do", {   
		            method: "DELETE",
		            headers: {
		                "Content-Type": "application/json"
		            },
		            body: JSON.stringify({ userId })
		        })
		        .then(res => {
		            if (res.status === 204) {
		                tr.remove();  
		            } else {
		                return res.json()
		                    .then(data => console.error(data.message));
		            }
		        })
		        .catch(err => console.error(err));
		    });
		});
	</script>
	<script src="${pageContext.request.contextPath}/resource/js/utils/changeDate.js"></script>
</body>
</html>