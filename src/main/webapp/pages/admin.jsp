<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="/pages/errorPage.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
	<c:set var="pageTitle" value="관리자 페이지" />
	<%@ include file="/components/pageHead.jsp" %>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/admin.css">
</head>


<c:if test="${empty sessionScope.id}">
    <c:redirect url="/index.jsp" />
</c:if>

<body>
	<jsp:include page="/layout/header.jsp" />
		
		<main>
			<%-- 페이지 주요 제목 --%>
			<h3>관리자 페이지</h3>
			
			<%-- 사용자 목록 테이블 제목 --%>
			<h4>유저 목록</h4>			
			<table>
				<thead>
					<tr>
						<th>이메일</th>
						<th>닉네임</th>
						<th>권한</th>
						<th>가입일</th>
						<th>액션</th> <%-- 권한 부여 및 삭제 버튼 위치 --%>
					</tr>
				</thead>
				<tbody>
                    <%-- Model에서 전달받은 'userList'를 순회하며 각 사용자에 대한 행을 생성 --%>
                    <c:forEach var="user" items="${userList}">
                        <tr>
                        		
                        		<td>${user.email}</td>
                        		<td>${user.userName}</td> 
                        		
                        		<%-- 권한 표시 및 버튼 로직 --%>
                        		<td>
                                    <c:choose>
                                        <c:when test="${user.admin}">
                                            <%-- 관리자인 경우: 관리자 배지 표시 --%>
                                            <span class="admin-badge">관리자</span>
                                        </c:when>
                                        <c:otherwise>
                                            <%-- 일반 사용자인 경우: 일반 사용자 표시와 권한 부여 버튼 제공 --%>
                                            <span class="user-status">일반 사용자</span>
                                            
                                            <%-- 권한 부여 폼: POST 요청으로 서버에 권한 부여 요청 --%>
                                            <form action="${pageContext.request.contextPath}/admin.do" method="post" class="grant-form">
                                                <input type="hidden" name="userId" value="${user.id}">
                                                
                                                <button type="button" class="grant-btn">
                                                    권한 부여
                                                </button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                        		</td>
                        		
                        		<%-- 가입일: JS로 포맷팅하기 위해 data 속성에 원본 날짜 저장 --%>
                        		<td class="createAt" data-date="${user.createAt}"></td> 
                        		
                        		<%-- 삭제 버튼 표시 로직 --%>
                                
                                <%-- 현재 로그인된 관리자 본인이 아닌 경우에만 삭제 버튼 표시 (ne: not equal) --%>
                        		<c:if test="${sessionScope.id ne user.id}">
	                        		<td>
                                        <%-- 삭제 버튼: data-user-id에 삭제할 사용자 ID 저장 --%>
		                            	<button type="button" class="delete-user-btn" data-user-id="${user.id}">
		                            			X
		                            </button>
	                            </td>
                        		</c:if>
                                
                                <%-- 현재 로그인된 관리자 본인인 경우: 삭제 불가 표시 --%>
                                <c:if test="${sessionScope.id eq user.id}">
                                    <td>-</td> 
                                </c:if>
                        </tr>
                    </c:forEach>
				</tbody>
			</table>
		</main>
	
	<%@ include file="/layout/footer.jsp" %>
	
	<script>
		// 1. 권한 부여 버튼(grant-btn) 클릭 이벤트 처리
		document.querySelectorAll(".grant-btn").forEach(btn => {
		    btn.addEventListener("click", function () {
		        // 사용자에게 권한 부여 확인
		        const confirmed = confirm("정말 승급시키실 겁니까?");
		        if (confirmed) {
		            // 확인 시, 가장 가까운 form (grant-form)을 제출하여 서버로 요청
		            this.closest("form").submit();
		        }
		    });
		});
		
		// 2. 사용자 삭제 버튼(delete-user-btn) 클릭 이벤트 처리
		document.querySelectorAll(".delete-user-btn").forEach(btn => {
		    btn.addEventListener("click", function () {
		        
		        // 사용자에게 삭제 확인
		        const confirmed = confirm("정말 삭제하시겠습니까?");
		        if (!confirmed) return; // 취소 시 함수 종료

		        const userId = this.dataset.userId;   // data-user-id 속성에서 사용자 ID를 가져옴
		        const tr = this.closest("tr"); // 삭제할 대상 행(<tr>)을 찾음

		        // Fetch API를 사용한 비동기 DELETE 요청
		        fetch("admin.do", {   
		            method: "DELETE",
		            headers: {
		                "Content-Type": "application/json"
		            },
		            // 삭제할 사용자 ID를 JSON 형식으로 본문에 담아 전송
		            body: JSON.stringify({ userId })
		        })
		        .then(res => {
                    if (res.ok) { // 응답 상태가 200-299 범위인 경우 (성공)
		                tr.remove();  // 테이블에서 해당 행(<tr>) 제거
		            } else {
		                // 실패 응답 처리
		                return res.json()
		                    .then(data => alert("삭제 실패: " + data.message)); 
		            }
		        })
		        .catch(err => alert("삭제 중 오류 발생: " + err)); // 네트워크 오류 등 예외 처리
		    });
		});
	</script>
	
	<script src="${pageContext.request.contextPath}/resource/js/utils/changeDate.js"></script>
</body>
</html>