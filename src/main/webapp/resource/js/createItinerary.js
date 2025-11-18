const startDateInput = document.getElementById("start-date"); // 일정 시작 날짜 입력창
const endDateInput = document.getElementById("end-date"); // 일정 완료 날짜 입력창
const selectdDay = document.getElementById("selectd-day"); // 일정의 일자 select
const submitButton = document.getElementById("submit-btn"); // 입력 button
const hiddenSpotList = document.getElementById("spot-list-hidden"); // spotList를 저장 할 input

const spotList = [];

const today = new Date().toISOString().split("T")[0]; // 오늘 날짜(최소값)
startDateInput.setAttribute("min", today); // 최소 날짜 설정
endDateInput.setAttribute("min", today); // 최소 날짜 설정

// start-date 변경 시 end-date의 max 값을 start + 15일로 설정
startDateInput.addEventListener("change", function () {
	if (!this.value) return;

  	const startDate = new Date(this.value);

  	// start-date + 15일 계산
  	const maxEnd = new Date(startDate);
  	maxEnd.setDate(startDate.getDate() + 15);

  	const maxEndFormatted = maxEnd.toISOString().split("T")[0];

  	// end-date의 min = start-dates
  	endDateInput.value = "";  
  	endDateInput.setAttribute("min", this.value);

  	// end-date의 max = start-date + 15일
  	endDateInput.setAttribute("max", maxEndFormatted);
 })
 
  
 // end-date 선택 시 날짜 차이만큼 div 생성
endDateInput.addEventListener("change", function () {
	if (!startDateInput.value || !this.value) // start와 end가 입력이 안되었을땐 실행 안함
		return;
	
	const inputItinerary = document.getElementById("input-itinerary"); // 일정 추가 영역
	const dayContainer = document.getElementById("day-container"); // 일정 출력 영역
	
	// input-itinerary 보여짐
	inputItinerary.style.display = "inline-block";

    const startDate = new Date(startDateInput.value);
    const endDate = new Date(this.value);

    // 날짜 차이 계산
    const diffTime = endDate.getTime() - startDate.getTime();
    const dayCount = diffTime / (1000 * 60 * 60 * 24) + 1; // 시작일 포함

    // 기존 div 초기화
    dayContainer.innerHTML = "";
	
    // dayCount 만큼 div 생성
	for (let i = 1; i <= dayCount; i++) {
		const div = document.createElement("div");
	    div.className = "day-box";
		
	    // i일차 날짜 계산
	    const dayDate = new Date(startDate);
	    dayDate.setDate(startDate.getDate() + (i - 1));
	    const formattedDate = dayDate.toISOString().split("T")[0];
		div.id = formattedDate; 
		
		// selectd-day의 option 동적으로 추가
		selectdDay.add(new Option(`${i}일차`, formattedDate));
		
		// spotList 일차 추가
		spotList.push({
		    day: `${i}일차`,
		    spots: []
		});

	     // day-box 안의 태그 생성
	    const h4 = document.createElement("h4");
	    h4.textContent = `${i}일차 일정 (${formattedDate})`;
	    div.appendChild(h4);
		 
	    // 부모에 삽입
	    dayContainer.appendChild(div);
	 }
 });
 
 
// 일정 추가 시 배열에 추가 + day-box div에 추가
document.getElementById("input-itinerary-button").addEventListener('click', function() {
	const spotValue = document.getElementById("selectd-spot").value; // 선택한 관광지
	const spotOption = document.querySelector('#selectd-spot option:checked'); // 선택한 관광지의 optgroup
	const spotCity = spotOption.parentElement.label; // optgroup의 label (도쿄, 후쿠오카 등)
	
	const dayText = selectdDay.options[selectdDay.selectedIndex].text; // "1일차"
	const dayValue = selectdDay.value; // 선택한 일자
	const dayBox = document.getElementById(dayValue); // 선택한 일자의 div

	// spots 배열에 관광지추가 
	const spotData = `${spotValue} [${spotCity}]`; // 관광지 (도시) 방식으로 배열 저장 (ex 도쿄타워 (도쿄)
	const existDay = spotList.find(item => item.day === dayText); // 특정 일자만
	existDay.spots.push(spotData); 
	console.log(spotList)
	
	const div = document.createElement("div");
	const span = document.createElement("span");
	const button = document.createElement("button");

	// 태그 설정
	div.classList.add("itinerary-item");
	div.id = spotData;
	span.textContent = spotValue;
	
	// 삭제 버튼 설정
	button.class = "itinerary-item-delete"
	button.type = "button";
	button.textContent = 'X';
	
	// 클릭된 버튼의 상위 div(itinerary-item)만 삭제
	button.addEventListener('click', function (e) {
	    const parentDiv = e.target.closest('.itinerary-item'); // 부모 div
	    if (parentDiv) {
	        parentDiv.remove();
			const removeValue = parentDiv.id;  // 삭제 대상 문자열
			existDay.spots = existDay.spots.filter(spot => spot !== removeValue); // 배열에서 삭제 (해당 날짜의 spots에서만)
			parentDiv.remove();
	    }
	});

	div.appendChild(span);
	div.appendChild(button);
	dayBox.appendChild(div);
 });
 

 submitButton.addEventListener("click", function() {
     // spotList 비어있으면 전송 막기
     if (spotList.length === 0) {
         alert("일정이 비었습니다.");
         return; // 함수 종료
     }

     hiddenSpotList.value = JSON.stringify(spotList);

     const title = document.getElementById("title-input").value;
     const start = document.getElementById("start-date").value;
     const end = document.getElementById("end-date").value;

     const requestData = {
         title: title,
         start: start,
         end: end,
         spotList: spotList
     };

     // AJAX(JSON) 전송
     fetch(`${contextPath}/mypage/create-itinerary.do`, {
         method: "POST",
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
 
 