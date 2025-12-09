let centerCity = "도쿄"; // 위도, 경도의 기준이 되는 도시
let touristSpots = [];
let map; // 구글 맵
let place; // 마이페이지 스크랩 추가에서 쓰이는 장소 이름 저장용 변수
let directionsService;
let directionsRenderer;
const travelModeElement = document.getElementById('choose-travel-mode');

const cityCoordinates = {
    "도쿄": { lat: 35.682839, lng: 139.759455 }, // 도쿄역
    "교토": { lat: 35.011636, lng: 135.768029 }, // 교토역 
    "오사카": { lat: 34.693737, lng: 135.502167 }, // 오사카
    "후쿠오카": { lat: 33.590183, lng: 130.401694 }, // 하카타역 
	"삿포로": { lat: 43.068661, lng: 141.350755 },   // 삿포로역 
	"나고야": { lat: 35.170915, lng: 136.881537 },   // 나고야역
	"히로시마": { lat: 34.397720, lng: 132.475025 }  // 히로시마역
};

function initMap() {
    map = new google.maps.Map(document.getElementById("map"), {
        center: cityCoordinates[centerCity], 
        zoom: 15
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
					alert(`${spot} 검색 실패`);
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
				place = results[0].name; // 검색한 장소 저장
				
				// 마커 생성
	            new google.maps.Marker({
	                map, 
	                position: location,
	                title: spot
	            });

	            map.setCenter(location);
	            map.setZoom(15); 
	        } else {
				alert(`${spot} 검색 실패`);
	            console.error("장소 검색 실패:", spot, status);
	        }
	    });
	}
}

// 검색한 주소로 경로 검색 (출발지, 경유지, 목적지)
function drawRoute(coords) {
	const travelModeValue = travelModeElement ? travelModeElement.value : 'DRIVING';
	
	// select 선택에 따라 이동수단 다르게 (기본값 자동차)
	const finalTravelMode = (travelModeValue in google.maps.TravelMode) 
	    ? google.maps.TravelMode[travelModeValue] 
	    : google.maps.TravelMode.DRIVING;
	
	let strokeColor;
    switch (travelModeValue) {
        case 'WALKING':
            strokeColor = '#006400'; // 도보: 진한 녹색
            break;
        case 'BICYCLING':
			strokeColor = '#8B00FF';  // 자전거 : 보라색
            break;
        default:
            strokeColor = '#8B0000'; // 자동차, 기본값 : 진한 붉은색
	 }

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
        travelMode: finalTravelMode 
    }, 
		// 경로 검색 요청 후의 콜백 함수
		(result, status) => {
        if (status === google.maps.DirectionsStatus.OK) { // 경로 검색 성공 시
            directionsRenderer.setDirections(result); // 지도에 경로 표시
			
			// 경로 스타일 설정
			directionsRenderer.setOptions({
				polylineOptions: {
					strokeColor,
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
