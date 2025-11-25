document.addEventListener("DOMContentLoaded", function() { // 1번만 실행되게 함
    const contextPath = document.body.dataset.contextPath; // JSP에서 바디에 contextPath 전달
    const refreshAfterDelete = document.body.dataset.refresh === "true"; // 페이지 새로고침 여부

    document.querySelectorAll('.delete-btn').forEach(button => {
        button.addEventListener('click', function() {
			
			if (!confirm("정말 삭제하시겠습니까?")) {
			    return; // 취소 시 중단
			}
			
            const tr = this.closest('tr'); // 상위 tr 찾기
            const itineraryId = this.dataset.id; // ObjectId 가져오기

            fetch(`${contextPath}/mypage/itinerary.do`, {
                method: "DELETE",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ itineraryId })
            })
            .then(res => {
                if (res.status === 204) {
                    if (refreshAfterDelete) {
                        // 페이지 이동
                        window.location.href = `${contextPath}/mypage/itinerary.do`;
                    } else {
                        // 테이블 행 삭제
                        if (tr) 
							tr.remove();
                    }
                } else {
                    res.text().then(text => console.error("삭제 실패:", text));
                }
            })
            .catch(err => console.error(err));
        });
    });
});

