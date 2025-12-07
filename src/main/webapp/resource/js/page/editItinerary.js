const submitButton = document.getElementById("submit-btn"); // 입력 button
const hiddenSpotList = document.getElementById("spot-list-hidden"); // spotList를 저장 할 input

function buildTag() {
	const dayContainer = document.getElementById("day-container"); // 일정 출력 영역
	const startDate = new Date(startDateInput.value);
	const selectedDay = document.getElementById("selected-day"); // 일정의 일자 select
	
	// 기존 div 초기화
	dayContainer.innerHTML = "";
	
	let i = 1;
	for (const dayData of spotList) {
		const div = document.createElement("div");
		div.className = "day-box my-3";
		
		// i일차 날짜 계산
		const dayValue = dayData.day; // i일차
		const dayDate = new Date(startDate); 
		dayDate.setDate(startDate.getDate() + (i - 1));
		const formattedDate = dayDate.toISOString().split("T")[0];
		div.id = formattedDate; 
		
		// selected-day의 option 동적으로 추가
		selectedDay.add(new Option(dayValue, formattedDate));
		
		// day-box 안의 태그 생성
		const h4 = document.createElement("h4");
		h4.textContent = `🕒 ${dayValue} 일정 (${formattedDate})`;
		div.appendChild(h4);

		for (const spot of dayData.spots) {
			const existDay = spotList.find(item => item.day === dayValue); // 특정 일자만
						
			const childDiv = document.createElement("div");
			const childSpan = document.createElement("span");
			const childButton = document.createElement("button");
			
			const cleanedSpot = spot.replace(/,[^,]*$/, ''); // 지역 정보 (도쿄 등)을 지움 (마지막 콤마 이후 모든 내용 지움)
			
			// 태그 설정
			childDiv.className = "itinerary-item my-1";
			childDiv.id = spot;
			childSpan.textContent = cleanedSpot;
			
			// 삭제 버튼 설정
			childButton.className = "itinerary-item-delete"
			childButton.type = "button";
			childButton.textContent = 'X';
			
			
			// 클릭된 버튼의 상위 div(itinerary-item)만 삭제
			childButton.addEventListener('click', function (e) {
			    const parentDiv = e.target.closest('.itinerary-item'); // 부모 div
			    if (parentDiv) {
					const removeValue = parentDiv.id;  // 삭제 대상 문자열
					existDay.spots = existDay.spots.filter(item => item !== removeValue); // 배열에서 삭제 
					parentDiv.remove();
			    }
			});
			
			childDiv.appendChild(childSpan);
			childDiv.appendChild(childButton);
			div.appendChild(childDiv);
		}
		dayContainer.appendChild(div);
		i++;
	}
}

// 페이지 로딩 후, 전에 작성했던 일정 내용을 태그에 넣음
document.addEventListener("DOMContentLoaded", function() {
    buildTag();
});


submitButton.addEventListener("click", function() {
    // spotList 비어있으면 전송 막기
    if (spotList.length === 0) {
        alert("일정이 비었습니다.");
        return; // 함수 종료
    }

    hiddenSpotList.value = JSON.stringify(spotList);

    const title = document.getElementById("title-input").value.trim();
    const start = document.getElementById("start-date").value;
    const end = document.getElementById("end-date").value;
	
	const isAllEmpty = spotList.every(item => item.spots.length === 0); // spotList 비어있으면 전송 막기

	if (!title) {
	    alert("제목을 입력해주세요.");
	    return;
	}

	if (!start || !end) {
	    alert("시작일과 종료일을 입력해주세요.");
	    return;
	}

	if (isAllEmpty) {
	    alert("일정이 모두 비어 있습니다.");
	    return; // 함수 종료
	}

    const requestData = {
        title,
        start,
        end,
        spotList,
		itineraryId
    };

    // AJAX(JSON) 전송
    fetch(`${contextPath}/mypage/edit-itinerary.do`, {
        method: "PUT",
        headers: {
            "Content-Type": "application/json; charset=UTF-8"
        },
        body: JSON.stringify(requestData)
    })
    .then(res => res.json())
    .then(data => {
        if(data.result === "success") {
            alert("저장 성공!");
		 location.href = `${contextPath}/mypage/itinerary.do`
        } else {
            alert("저장 실패!");
        }
    })
    .catch(err => console.error(err));
});