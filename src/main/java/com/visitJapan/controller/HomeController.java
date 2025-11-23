package com.visitJapan.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

import org.bson.types.ObjectId;
import org.json.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import com.visitJapan.dao.users.put.AddCityDAO;
import com.visitJapan.dto.response.HomeResponseDTO;


@WebServlet("/home.do")
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    private final String tabelogLink = "https://tabelog.com/kr/";
	private final String spotLink = "https://japantravel.navitime.com/ko/area/jp/search/spot/?word=";
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String region = request.getParameter("region"); // 검색한 지역 정보 가져옴
			String crawlingSpotURL = spotLink + region;
			
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
			
	        // 병렬 + 비동기 처리
	        CompletableFuture<Document> spotFuture = CompletableFuture.supplyAsync(() -> {
	            try {
	                return Jsoup.connect(crawlingSpotURL)
	                        .userAgent("Mozilla/5.0")
	                        .timeout(8000) // 8초 지날 경우 에러
	                        .get();
	            } catch (IOException e) {
	                throw new RuntimeException(e);
	            }
	        });
	
	        CompletableFuture<Document> tabelogFuture = CompletableFuture.supplyAsync(() -> {
	            try {
	                return Jsoup.connect(crawlingTabeURL)
	                        .userAgent("Mozilla/5.0")
	                        .timeout(8000)
	                        .get();
	            } catch (IOException e) {
	                throw new RuntimeException(e);
	            }
	        });
	
	        // 두 Future 모두 완료될 때까지 대기
	        Document spotDoc = spotFuture.get();
	        Document tabelogDoc = tabelogFuture.get();

			Elements spotList = spotDoc.select("div.spot-name a:lt(10)"); // 상위 10개만
			Elements restaurantList = tabelogDoc.select("a.list-rst__rst-name-target.cpy-rst-name:lt(10)");
	
	        // dto에 넣은 후 속성으로 보냄
	        HomeResponseDTO homeResponse = new HomeResponseDTO(spotList, restaurantList);
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