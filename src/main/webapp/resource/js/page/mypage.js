// 마이페이지 선호 관광지 삭제
document.querySelectorAll(".delete-city-form").forEach(form => {
    form.addEventListener("submit", function(e) {
        e.preventDefault();  // 새로고침 방지

        const spot = this.dataset.spot;  // EL에서 넘긴 spot
        const city = this.dataset.city; // EL에서 넘긴 cityName
        const li = this.closest("li"); // 현재 li

        fetch("mypage.do", {
            method: "DELETE",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                spot,
                city
            })
        })
        .then(res => {
            if (res.status === 204) {
                li.remove();   // 성공이므로 삭제
            } else {
                return res.json().then(data => console.error(data.message));
            }
        })
        .catch(err => console.error(err));
    });
});


document.getElementById("delete-account-btn").addEventListener("click", function() {
	
	const contextPath = document.body.dataset.contextPath; // JSP에서 바디에 contextPath 전달

	if (!confirm("정말 탈퇴 하시겠습니까?")) {
	    return; // 취소 시 중단
	}

	fetch(`${contextPath}/mypage/change.do`, {
	    method: "DELETE",
	    headers: { "Content-Type": "application/json" },
	})
	.then(res => {
		if (res.status === 204) {
		    window.location.href = contextPath + "/index.jsp"; 
		} else {
		    alert("탈퇴 중 오류 발생");
		}
	})
	.catch(err => {
		alert("오류로 인해 회원탈퇴 실패");
		console.error(err)
	});
});



