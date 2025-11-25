let centerCity = "도쿄"; // 위도, 경도의 기준이 되는 도시
let touristSpots = [];
let map; // 구글 맵
let directionsService;
let directionsRenderer;

const cityCoordinates = {
    "도쿄": { lat: 35.682839, lng: 139.759455 }, // 도쿄역 근처
    "교토": { lat: 35.011636, lng: 135.768029 }, // 교토역 근처
    "오사카": { lat: 34.693737, lng: 135.502167 }, // 오사카역 근처
    "후쿠오카": { lat: 33.590183, lng: 130.401694 } // 하카타역 근처
};

// cityCoordinates[city]

function initMap() {
    map = new google.maps.Map(document.getElementById("map"), {
        center: cityCoordinates[centerCity], 
        zoom: 6
    });

    directionsService = new google.maps.DirectionsService();
    directionsRenderer = new google.maps.DirectionsRenderer({map});

    getCoordinatesAndRoute(touristSpots);
}

function getCoordinatesAndRoute(spots) {
    const service = new google.maps.places.PlacesService(map);
    let coordinates = []; // 검색된 좌표 저장

    let processed = 0;

	if (spots.length !== 1) { // 관광지가 2개 이상이라면 경로를 만듦
	    spots.forEach((spot, index) => {
			// 관광지 주소 검색 
	        service.textSearch({query: spot}, (results, status) => {
	            if (status === google.maps.places.PlacesServiceStatus.OK && results[0]) { // 검색 성공 시
	                coordinates[index] = results[0].geometry.location;
	            } else {
					alert("구글 맵 장소 검색 실패");
	                console.error("장소 검색 실패:", spot, status);
	                coordinates[index] = null;
	            }
	
	            processed++;
	            if (processed === spots.length) { // 경로 생성 요청
	                drawRoute(coordinates.filter(coord => coord !== null));
	            }
	        });
	    });
	} else { // 관광지가 1개라면, 마커만 찍음
		const spot = spots[0];
	    service.textSearch({query: spot}, (results, status) => {
	        if (status === google.maps.places.PlacesServiceStatus.OK && results[0]) {
	            const location = results[0].geometry.location;
	            
				// 마커 생성
	            new google.maps.Marker({
	                map, 
	                position: location,
	                title: spot
	            });

	            map.setCenter(location);
	            map.setZoom(15); 
	        } else {
				alert("구글 맵 장소 검색 실패");
	            console.error("장소 검색 실패:", spot, status);
	        }
	    });
	}
}

// 검색한 주소로 경로 검색 (출발지, 경유지, 목적지)
function drawRoute(coords) {
    if (coords.length < 2) return;

	// 경유지 (출발지, 목적지 제외) 좌표 추출
    const waypoints = coords.slice(1, -1).map(loc => ({
		location: loc, // 경유지의 좌표
		stopover: true // 멈춤 여부
	}));

	// 경로 검색 요청
    directionsService.route({
        origin: coords[0], // 첫 번째 좌표 (출발지)
        destination: coords[coords.length - 1], // 마지막 좌표 (목적지)
        waypoints: waypoints, // 중간 경유지들
        travelMode: google.maps.TravelMode.DRIVING // 자동차 이동 모드
    }, 
		// 경로 검색 요청 후의 콜백 함수
		(result, status) => {
        if (status === google.maps.DirectionsStatus.OK) { // 경로 검색 성공 시
            directionsRenderer.setDirections(result); // 지도에 경로 표시
			
			// 경로 스타일 설정
			directionsRenderer.setOptions({
				polylineOptions: {
					strokeColor: '#8B0000', // 색상 (현재 진한 빨강색)
					strokeOpacity: 0.7, // 불투명도 (현재 70%)
					strokeWeight: 6 // 두께 설정 (현재 6 픽셀)
				}
			});
			
        } else {
			alert("구글 맵 경로 생성 실패");
            console.error("경로 생성 실패:", status);
        }
    });
}

document.querySelectorAll(".create-map-btn").forEach(btn => {
	btn.addEventListener("click", function() {
		const spotsStr = this.dataset.spots;
		const cityValue = this.dataset.city; // 기준 도시
		
		document.getElementById('mapSection').style.display = 'block';
		
		if (spotsStr && spotsStr.length !== 0)
			touristSpots = JSON.parse(spotsStr) // 관광지 목록 json 파싱 후 삽입
		
		centerCity = cityValue;
		
		initMap(); // 구글 지도 생성
	})
});