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
import java.util.stream.Collectors;

import org.bson.types.ObjectId;
import org.json.JSONObject;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

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
		    "후쿠오카", "https://tenki.jp/forecast/9/43/8210/40130/"
	);
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String region = request.getParameter("region"); // 검색한 지역 정보 가져옴
			String crawlingSpotURL = spotLink + region; // 관광지 링크
			String crawlingYahooURL = AREA_URL.get(region); // yahoo japan 날씨 링크

			// 결과값
			Elements spotList = null;
			List<String> spotImgList = null;
			RestaurantDTO restaurantData = null;
			WeatherDTO weatherData = null;
			
			// 타베로그 크롤링 링크
	        String crawlingTabeURL = switch (region) {
		    	case "도쿄" -> tabelogLink + "tokyo/";
		    	case "오사카" -> tabelogLink + "osaka/";
		    	case "교토" -> tabelogLink + "kyoto/";
		    	case "후쿠오카" -> tabelogLink + "fukuoka/";
		        default -> {
		            yield null;
		        }
	        };
	        
	        List<String> crawlingUrls = new ArrayList<>();

	        // 크롤링 URL들 List에 저장
	        if (crawlingSpotURL != null) {
	            crawlingUrls.add(crawlingSpotURL);
	        }
	        crawlingUrls.add(crawlingTabeURL);
	        crawlingUrls.add(crawlingYahooURL);

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

	        // 관광지 데이터
	        if (spotDoc != null) {
	            spotList = spotDoc.select("div.spot-name a:lt(10)");
	            spotImgList = spotDoc.select("div.image-frame img:lt(10)").eachAttr("src");
	        }

	        // 맛집
	        restaurantData = CrawlingUtil.getRestaurant(tabelogDoc);

	        // 날씨
	        weatherData = CrawlingUtil.getWeather(skyDoc);

			
	        // dto에 넣은 후 속성으로 보냄
	        HomeResponseDTO homeResponse = new HomeResponseDTO(spotList, spotImgList, restaurantData, weatherData);
			request.setAttribute("homeResponse", homeResponse);
			
		} catch (Exception e) {
            e.printStackTrace();
        }
				
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/visitData.jsp");
		dispatcher.forward(request, response); 	
	}
	
	@Override
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException {
		AddCityDAO addCityDAO = new AddCityDAO();
		request.setCharacterEncoding("UTF-8");
		
	    String body = request.getReader().lines().collect(Collectors.joining()); // js 요청 본문
	    JSONObject json = new JSONObject(body); // json 읽기
	    
	    ObjectId userId = (ObjectId) request.getSession().getAttribute("id");
	    String spot = json.getString("spot");
	    String city = json.getString("city");
	    
	    boolean result = addCityDAO.appendCityToUser(spot, city, userId);
	    
	    response.setContentType("application/json; charset=UTF-8");
	    if (result) {
	        response.setStatus(HttpServletResponse.SC_OK); // 200
	        response.getWriter().write(
	            "{\"status\":\"ok\", \"spot\":\"" + spot + "\"}"
	        );
	    } else {
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500
	        response.getWriter().write(
	            "{\"status\":\"error\", \"message\":\"도시 또는 관광지 추가 실패\"}"
	        );
	    }
	}

}