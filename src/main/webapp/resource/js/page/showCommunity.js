// 게시글 삭제
document.querySelectorAll('.delete-btn').forEach(button => {
    button.addEventListener('click', function() {
		
		if (!confirm("정말 게시글을 삭제하시겠습니까?")) {
		    return; // 취소 시 중단
		}
		
		// 파라미터의 id 가져옴
		const params = new URLSearchParams(window.location.search); 
		const id = params.get("id");
		
		fetch(`${contextPath}/community.do`, {
		    method: "DELETE",
		    headers: { "Content-Type": "application/json" },
		    body: JSON.stringify({ id })
		})
		.then(res => {
		    if (res.status === 204) {
		        window.location.href = `${contextPath}/community.do`;
		        return;
		    }
			
			// 401: 로그인 필요
			if (res.status === 401) {
			    alert("로그인이 필요합니다.");
			    return;
			}

			return res.json().then(data => alert(data.message));
		})
		.catch(err => { 
			alert("게시글 삭제 실패");
			console.error(err);
		});
    });
});

// 좋아요 추가
document.querySelectorAll('.add-like-btn').forEach(button => {
    button.addEventListener('click', function() {
		
		// 파라미터의 id 가져옴
		const params = new URLSearchParams(window.location.search); 
		const id = params.get("id");
		
		fetch(`${contextPath}/community.do`, {
		    method: "PUT",
		    headers: { "Content-Type": "application/json" },
		    body: JSON.stringify({ id })
		})
		.then(res => {
			if (res.status === 204) { // 좋아요 성공
			    button.classList.toggle("clicked");
				
				const textParts = button.textContent.trim().split(" "); // 텍스트와 좋아요 숫자 분리
				let count = parseInt(textParts[1]) || 0; // 숫자 추출
				count += 1; // 1 증가
				button.textContent = `${textParts[0]} ${count}`; // 버튼 업데이트
				
			} else if (res.status === 409) { // 이미 좋아요 누름
			    alert("이미 좋아요를 누르셨습니다.");
			} else { // 기타 서버 오류
			    alert("좋아요 추가 실패");
			}
		})
		.catch(err => { 
			alert("좋아요 추가 실패");
			console.error(err);
		});
    });
});

// 댓글 작성
document.getElementById("btn-comment").addEventListener('click', function() {
	
	const params = new URLSearchParams(window.location.search);
	const commentArea = document.getElementById("comment-area"); // 댓글창	
	
	if (!commentArea || commentArea.value.trim().length === 0) {
		alert("댓글을 입력해 주세요.");
		return;
	}
	
	const id = params.get("id");
	const content = commentArea.value;

	fetch(`${contextPath}/community/comment.do`, {
	    method: "POST",
	    headers: { "Content-Type": "application/json" },
	    body: JSON.stringify({ id, content })
	})
	.then(res => {
	    // 401 Unauthorized 체크
	    if (res.status === 401) {
	        alert("로그인이 필요합니다.");
			return;
	    }
	    // 201, 200 등 정상 응답 처리
	    return res.json();
	})	
	.then(comment => {

		const commentSection = document.querySelector("#comment-section");

		// "댓글이 없습니다." 메시지 제거
		const emptyMessage = commentSection.querySelector(".no-comments");
		if (emptyMessage) emptyMessage.remove();
		
		const dateObj = new Date(comment.commentCreateAt); // 생성일

		const formatted = // 생성일 형 변환
		    dateObj.getFullYear() + "-" +
		    String(dateObj.getMonth() + 1).padStart(2, '0') + "-" +
		    String(dateObj.getDate()).padStart(2, '0') + " " +
		    String(dateObj.getHours()).padStart(2, '0') + ":" +
		    String(dateObj.getMinutes()).padStart(2, '0');

		// 댓글 HTML 생성
		const html = `
		    <div class="comment-item">
				<span class="createAt" data-date="${formatted}">${formatted}</span>
				<span>${comment.authorName}</span>
		        <p>${comment.commentContent}</p>
		        <button type="button" class="comment-item-delete"
		                data-id="${comment.commentId}"
		                data-author-id="${comment.authorId}">
		            X
		        </button>
		        <hr>
		    </div>
		`;

		commentSection.insertAdjacentHTML("afterbegin", html);
		commentArea.value = "";
	})
	.catch(err => {
		alert("댓글 작성 실패");
		console.error(err);
	});
	
})

// 댓글 삭제, 새로 생성한 댓글도 삭제할 수 있게 이벤트 위임
document.querySelector("#comment-section").addEventListener("click", function(e) {
	
	if (!e.target.classList.contains("comment-item-delete")) 
		return; // 버튼 아닌 경우 무시
	
	if (!confirm("정말 댓글을 삭제하시겠습니까?")) {
	    return; // 취소 시 중단
	}
	
	const button = e.target;

	const params = new URLSearchParams(window.location.search);
	const id = params.get("id");
	const commentId = button.dataset.id;
	const authorId = button.dataset.authorId;
	
	fetch(`${contextPath}/community/comment.do`, {
	    method: "DELETE",
	    headers: { "Content-Type": "application/json" },
	    body: JSON.stringify({ id, commentId, authorId })
	})
	.then(res => {
	    if (res.status === 204) {
			const commentDiv = button.closest('.comment-item');
			if (commentDiv) commentDiv.remove(); // 댓글 div 삭제

			// 댓글이 "댓글이 없습니다." 표시
			const commentSection = document.querySelector("#comment-section");
			if (commentSection.querySelectorAll('.comment-item').length === 0) {
			    commentSection.innerHTML = `<div class="no-comments"><p>댓글이 없습니다.</p></div>`;
			}		        
	    } else {
			alert("게시글 삭제 실패");
		}
	})
	.catch(err => { 
		alert("게시글 삭제 실패");
		console.error(err);
	});
});

