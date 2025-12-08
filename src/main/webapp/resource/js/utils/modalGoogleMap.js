const mapModalEl = document.getElementById('mapModal');

// 1. "경로 보기" 버튼 클릭 시 지도 생성에 필요한 데이터 설정
document.querySelectorAll(".create-map-btn").forEach(btn => {
    btn.addEventListener("click", function() {
        const spotsStr = this.dataset.spots; // 장소 목록 JSON 문자열
        const cityValue = this.dataset.city; // 도시 이름
        
        // createGoogleMap.js의 전역 변수 touristSpots 업데이트 (let 재선언 금지)
        if (spotsStr && spotsStr.length !== 0) {
            touristSpots = JSON.parse(spotsStr); // JSON 문자열을 객체로 변환
        } else {
            touristSpots = [];
        }
        
        // createGoogleMap.js의 전역 변수 centerCity 업데이트
        // cityCoordinates 데이터 유효성 체크
        if (typeof cityCoordinates !== 'undefined' && cityCoordinates[cityValue]) {
            centerCity = cityValue; // 중심 도시 설정
        } else {
            centerCity = "도쿄"; // 기본값 설정
        }
    });
});

mapModalEl.addEventListener('shown.bs.modal', function () {
    // 약간의 딜레이를 주어 모달 애니메이션이 완전히 끝난 뒤 실행
    setTimeout(() => {
        if (typeof initMap !== 'undefined') {
            // 지도 초기화 실행 (createGoogleMap.js의 initMap 함수 호출)
            initMap(); 
            
            if (typeof map !== 'undefined' && map) {
                google.maps.event.trigger(map, "resize");
                
                // 리사이즈 후 중심 좌표가 틀어질 수 있으므로 다시 설정
                if (typeof cityCoordinates !== 'undefined' && centerCity) {
                    map.setCenter(cityCoordinates[centerCity]);
                }
            }
        } else {
            console.error("createGoogleMap.js가 로드되지 않았거나 initMap 함수가 없습니다.");
        }
    }, 200); // 200ms 딜레이
});

// 3. 이동 수단 변경 시 경로 재요청
// 변수명을 modalTravelModeSelect로 변경하여 createGoogleMap.js의 travelModeElement와 충돌 방지
const modalTravelModeSelect = document.getElementById('choose-travel-mode'); 
if(modalTravelModeSelect) {
    modalTravelModeSelect.addEventListener('change', function() {
        if (touristSpots.length >= 2 && typeof getCoordinatesAndRoute !== 'undefined') {
            // 장소가 2개 이상이고 경로를 그리는 함수가 정의되어 있다면 경로 재요청
            getCoordinatesAndRoute(touristSpots);
        }
    });
}