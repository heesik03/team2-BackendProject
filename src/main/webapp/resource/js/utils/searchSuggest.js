// 검색창 요소 찾기
const searchInput = document.getElementById("searchInput");

// 검색창이 없으면(특정 페이지) JS 실행 중단
if (searchInput) {

    // suggestion-box 생성
    const suggestionBox = document.createElement("div");
    suggestionBox.id = "suggestion-box";
    suggestionBox.style.position = "absolute";
    suggestionBox.style.background = "white";
    suggestionBox.style.border = "1px solid #ddd";
    suggestionBox.style.width = searchInput.offsetWidth + "px";
    suggestionBox.style.maxHeight = "200px";
    suggestionBox.style.overflowY = "auto";
    suggestionBox.style.zIndex = "9999";
    suggestionBox.style.display = "none";
    suggestionBox.style.cursor = "pointer";
    suggestionBox.style.borderRadius = "4px";
    suggestionBox.style.fontSize = "18px";

    // 검색창 바로 아래 붙이기
    searchInput.parentNode.style.position = "relative";
    searchInput.parentNode.appendChild(suggestionBox);

    // 연관검색어 박스 업데이트 함수
    function updateSuggestionBox(list) {
        suggestionBox.innerHTML = "";
        if (list.length === 0) {
            suggestionBox.style.display = "none";
            return;
        }

        list.forEach(region => {
            const item = document.createElement("div");
            item.innerText = region;
            item.style.padding = "10px 14px";
            item.style.borderBottom = "1px solid #eee";

            item.addEventListener("mouseover", () => {
                item.style.background = "#f0f0f0";
            });
            item.addEventListener("mouseout", () => {
                item.style.background = "white";
            });

            // 클릭하면 해당 지역 검색으로 이동
            item.addEventListener("click", () => {
				const loader = document.getElementById("loading");

				// 로딩 표시
				if (loader) {
				    loader.style.display = "flex";
				    loader.style.opacity = "1";
				}
				setTimeout(() => {
				    window.location.href = `home.do?region=${region}`;
				}, 500); 
				
            });
            suggestionBox.appendChild(item);
        });

        suggestionBox.style.display = "block";
    }

    // 검색창 클릭 시 전체 지역 목록 표시
    searchInput.addEventListener("focus", () => {
        updateSuggestionBox(regionList);
    });

    // 입력할 때 자동 필터링
    searchInput.addEventListener("input", () => {
        const keyword = searchInput.value.trim();
        const filtered = regionList.filter(region => region.includes(keyword));
        updateSuggestionBox(filtered);
    });

    // 검색창 외부 클릭 시 숨기기
    document.addEventListener("click", (e) => {
        if (e.target !== searchInput && e.target.parentNode !== suggestionBox) {
            suggestionBox.style.display = "none";
        }
    });
}
