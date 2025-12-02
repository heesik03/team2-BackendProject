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
		const spotList = document.getElementById("spot-list"); // 기존 관광지 ul
		let spotHtml = ""; // 새로 랜더링 할 HTML

        changSpotList.dataset.index = data.newPageIndex; 	// pageIndex 업데이트
        data.spots.forEach((spotText, idx) => {
			// 새로 크롤링한 데이터로 HTML 만듦
            const img = data.imgList[idx] ? 
                `<img src="${data.imgList[idx]}" class="img-fluid rounded" style="max-width:300px;">` : "";
				
            spotHtml += `
                <li class="li-style">
                    ${spotText}<br>
                    <a href="#" target="_blank">관광지 상세 주소</a>
                    <br>

                    ${userId ? `
                        <button class="add-scrap-btn"
                            data-spot="${spotText}"
                            data-region="${region}"
                            type="button">
                            스크랩 추가
                        </button><br>
                    ` : ""}

                    ${img}
                    <hr>
                </li>
            `;
        });
        spotList.innerHTML = spotHtml; // 새로 만든 HTML 적용
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
    .then(() => {
        alert("스크랩 추가 성공!");
    })
    .catch(err => console.error(err));
});
