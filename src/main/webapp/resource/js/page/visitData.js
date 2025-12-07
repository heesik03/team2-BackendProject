const changSpotList = document.getElementById("change-spot-list");

// 관광지 크롤링 정보 랜덤 변경
changSpotList.addEventListener("click", function () {

    const pageIndex = this.dataset.index;
    const region = this.dataset.region;

    fetch("home.do", {
        method: "PUT",
        headers: {
            "Content-Type": "application/json; charset=UTF-8"
        },
        body: JSON.stringify({ pageIndex, region })
    })
    .then(res => res.json())
    .then(data => {
		const spotList = document.getElementById("spot-list"); // 기존 관광지 출력 영역
		let spotHtml = ""; // 새로 렌더링할 HTML

		changSpotList.dataset.index = data.newPageIndex; // pageIndex 업데이트

		data.spots.forEach((spotText, idx) => {
			const spotImg = (data.imgList && data.imgList[idx]) 
			    ? data.imgList[idx]
			    : `${root}/resource/images/no_image.png`;

			const detailUrl = (data.hrefList && data.hrefList[idx])
			    ? data.hrefList[idx]
			    : "#";


			spotHtml += `
			    <div class="col-md-4 col-sm-6">
			        <div class="spot-card">
			            <div style="position: relative; overflow: hidden;">
			                <img src="${spotImg}" 
			                     class="spot-img"
			                     alt="관광지"
			                     onerror="this.onerror=null; this.src='${root}/resource/images/no_image.png';">
			            </div>

			            <div class="spot-body">
			                <h5 class="fw-bold mb-1 text-truncate">${spotText}</h5>
			                <small class="text-muted d-block mb-3">관광 명소</small>

			                <a href="${detailUrl}" target="_blank" 
			                   class="text-decoration-none fw-bold mb-3 d-block"
			                   style="color: #4D88F6; font-size: 0.9rem;">
			                    상세 정보 보러가기 
			                    <i class="bi bi-chevron-right" style="font-size: 0.8rem;"></i>
			                </a>

			                ${userId ? `
			                    <button class="add-scrap-btn"
			                        data-spot="${spotText}"
			                        data-region="${region}" 
			                        type="button">
			                        <i class="bi bi-heart"></i> 스크랩 추가
			                    </button>
			                ` : ""}
			            </div>
			        </div>
			    </div>
			`;

		});

		// 새로 만든 HTML 적용
		spotList.innerHTML = spotHtml;

    })
    .catch(err => { 
		alert("관광지 업데이트 실패");
		console.error(err)
	});
});


// 관광지 스크랩 추가 (관광지 새로 랜더링 후에도 버튼 이벤트를 작동시키기 위해 이벤트 위임)
document.addEventListener("click", function(e) {

	// 스크랩 추가 버튼이 아니라면 실행 중단
    if (!e.target.classList.contains("add-scrap-btn")) {
        return;
    }

    const spot = e.target.dataset.spot;
    const city = e.target.dataset.region;

    fetch("home.do", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ spot, city })
    })
    .then(res => res.json())
    .catch(err => console.error(err));
});
