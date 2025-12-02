package com.visitJapan.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.stream.Collectors;

import org.bson.types.ObjectId;
import org.json.JSONObject;
import org.jsoup.nodes.Document;

import com.visitJapan.dao.users.put.AddCityDAO;
import com.visitJapan.dto.response.*;
import com.visitJapan.util.CrawlingUtil;
import com.visitJapan.util.FetchUtil;


@WebServlet("/home.do")
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    private final String tabelogLink = "https://tabelog.com/kr/";
	private final String spotLink = "https://japantravel.navitime.com/ko/area/jp/search/spot/?word=";
	
    // ★ 지역별 날씨 주소 매핑 
	private static final Map<String, String> AREA_URL = Map.of(
		    "도쿄", "https://tenki.jp/forecast/3/16/4410/13101/",
		    "오사카", "https://tenki.jp/forecast/6/30/6200/27100/",
		    "교토", "https://tenki.jp/forecast/6/29/6110/26100/",
		    "후쿠오카", "https://tenki.jp/forecast/9/43/8210/40130/",
		    "삿포로", "https://tenki.jp/forecast/1/2/1400/1100/",
		    "나고야", "https://tenki.jp/forecast/5/26/5110/23100/",
		    "히로시마", "https://tenki.jp/forecast/7/37/6710/34100/"
	);
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String region = request.getParameter("region"); // 검색한 지역 정보 가져옴
			String crawlingSpotURL = spotLink + region; // 관광지 링크
			String crawlingYahooURL = null; // yahoo japan 날씨 링크
			int randomPageIndex = new Random().nextInt(5)+1; // 1~5 페이지까지 랜덤 페이지 

			// DTO에 넣을 결과값들
			SpotDTO spotData = null;
			RestaurantDTO restaurantData = null;
			WeatherDTO weatherData = null;
			
			// 타베로그 크롤링 링크
	        String crawlingTabeURL = switch (region) {
		    	case "도쿄" -> tabelogLink + "tokyo/";
		    	case "오사카" -> tabelogLink + "osaka/";
		    	case "교토" -> tabelogLink + "kyoto/";
		    	case "후쿠오카" -> tabelogLink + "fukuoka/";
		    	case "삿포로" -> tabelogLink + "hokkaido/A0101/";
		    	case "나고야" -> tabelogLink + "aichi/A2301/";
		    	case "히로시마" -> tabelogLink + "hiroshima/";
		        default -> {
		            yield null;
		        }
	        };
	        
	        List<String> crawlingUrls = new ArrayList<>();

	        // 크롤링 URL들 List에 저장
	        if (crawlingSpotURL != null) {	        		
	            crawlingUrls.add(crawlingSpotURL + "&page=" + randomPageIndex);
	        }
	        crawlingUrls.add(crawlingTabeURL);
	        if (AREA_URL.get(region) != null) {
        			crawlingYahooURL = AREA_URL.get(region);
	        		crawlingUrls.add(crawlingYahooURL);
	        }

	        // 병렬 크롤링
	        List<Document> documents = FetchUtil.fetchAll(crawlingUrls);

	        // 문서 인덱스 매핑
	        int idx = 0;
	        Document spotDoc = null;
	        if (crawlingSpotURL != null) {
	            spotDoc = documents.get(idx++);
	        }
	        Document tabelogDoc = documents.get(idx++);
	        Document skyDoc = documents.get(idx);

	        // 가져온 크롤링 페이지에서 원하는 정보 DTO에 담아서 가져옴
	        spotData = CrawlingUtil.getSpot(spotDoc); // 관광지 데이터
	        restaurantData = CrawlingUtil.getRestaurant(tabelogDoc); // 맛집
	        weatherData = CrawlingUtil.getWeather(skyDoc); // 날씨
			
	        // dto에 넣은 후 속성으로 보냄
	        HomeResponseDTO homeResponse = new HomeResponseDTO(spotData, restaurantData, weatherData);
			request.setAttribute("homeResponse", homeResponse);
			request.setAttribute("pageIndex" , randomPageIndex);			
		} catch (Exception e) {
            e.printStackTrace();
        }
				
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/visitData.jsp");
		dispatcher.forward(request, response); 	
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		AddCityDAO addCityDAO = new AddCityDAO();
		request.setCharacterEncoding("UTF-8");
		
	    String body = request.getReader().lines().collect(Collectors.joining()); // js 요청 본문
	    JSONObject requestBody = new JSONObject(body); // json 읽기
	    
	    ObjectId userId = (ObjectId) request.getSession().getAttribute("id");
	    String spot = requestBody.getString("spot");
	    String city = requestBody.getString("city");
	    
	    boolean result = addCityDAO.appendCityToUser(spot, city, userId);
	    
	    JSONObject responseBody = new JSONObject();
	    response.setContentType("application/json; charset=UTF-8");
	    
	    if (result) {
	    		responseBody.put("status", "ok"); // 응답 본문
	    		responseBody.put("spot", spot);  
	        response.setStatus(HttpServletResponse.SC_OK); // 200
	    } else {
	    		responseBody.put("status", "error");
	    		responseBody.put("message", "도시 또는 관광지 추가 실패");
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500
	    }
	    response.getWriter().write(responseBody.toString());
	}
	
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
	    response.setContentType("application/json; charset=UTF-8");
		Random random = new Random();
		SpotDTO spotData = null;

	    String body = request.getReader().lines().collect(Collectors.joining()); // js 요청 본문
	    JSONObject requestBody = new JSONObject(body); // json 읽기
	    
	    String pageIndex = requestBody.getString("pageIndex"); // 현재 관광지 검색 페이지
	    String region = requestBody.getString("region"); // 현재 도시
	    
	    int currentPage = Integer.parseInt(pageIndex); // 현재 관광지 검색 페이지 형변환
	    int newPageIndex = 0; // 새로운 페이지
	    while (true) {
	    		newPageIndex = random.nextInt(5) + 1; 
	    		if (newPageIndex != currentPage) { // 현재 페이지 index와 다른 랜덤값이 나오면 탈출
	    			break; 
	    		}
	    }
	    
		String crawlingSpotURL = spotLink + region; // 관광지 링크
	    Document spotDoc = FetchUtil.fetchDocument(crawlingSpotURL + "&page=" + newPageIndex);
	    spotData = CrawlingUtil.getSpot(spotDoc); // 관광지 데이터
	    
	    // JS에서 쓰기 위해 새로운 정보 JSON으로 보냄
	    JSONObject result = new JSONObject();
	    result.put("newPageIndex", newPageIndex); 
	    result.put("spots", spotData.getSpotList() // 관광지 목록 
	            .stream().map(s -> s.text()).collect(Collectors.toList()));
	    result.put("imgList", spotData.getSpotImgList()); // 이미지 목록

	    response.setStatus(HttpServletResponse.SC_OK);
	    response.getWriter().write(result.toString());

	}
}