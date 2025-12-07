// 서버로 보낼 PUT 요청 (이름, 선호도시 공통)
function sendPutRequest(requestBody) {
	if (!confirm("정말 변경 하시겠습니까?"))
		return;
	
	fetch(`${context}/mypage/change.do`, {
	    method: "PUT",
	    headers: { "Content-Type": "application/json" },
	    body: JSON.stringify(requestBody)
	})
	.then(res => {
	    if (res.status === 204) {
	        alert("변경 성공!");
	        window.location.href = `${context}/mypage.do`;
	    } else {
	        alert("변경 중 오류 발생");
	        res.text().then(text => console.error("변경 실패:", text));
	    }
	})
	.catch(err => {
		alert("변경 중 오류 발생");
		console.error(err)
	});
}

document.getElementById("change-pwd-btn").addEventListener("click", function (e) { 
	
    if (!validatePassword()) {
        alert("비밀번호 조건을 만족해야 합니다.");
        e.preventDefault();
        return false;
    }
	
    if (!validateConfirmPassword()) {
    		alert("비밀번호 확인이 일치해야 합니다.");
        e.preventDefault();
        return false;
    }
	
	
    if (!confirm("정말 비밀번호를 변경하시겠습니까? (변경 후 로그아웃 됨)")) {
        e.preventDefault(); // 취소 시 submit 중단
    }
    
});

document.getElementById("change-name-btn").addEventListener("click", function () {
    const name = document.getElementById("name-input").value; // 보낼 새로운 이름
	const isName = true // 이름 변경인지 아닌지
	const body = {
		isName,
		data : name
	};
	
	sendPutRequest(body);
});

document.getElementById("change-city-btn").addEventListener("click", function () {
	const params = new URLSearchParams(window.location.search);
	const paramsValue = params.get("like-city"); // 파라미터 (현재 선호 도시)
	
    const likeCity = document.getElementById("choose-city").value; // 새로 선택한 도시
	const isName = false // 이름 변경인지 아닌지
	const body = {
		isName,
		data : likeCity,
	};
	
	if (paramsValue === likeCity) {
		alert("현재 선호도시와 같습니다.");
		return;
	}

	sendPutRequest(body);
});



