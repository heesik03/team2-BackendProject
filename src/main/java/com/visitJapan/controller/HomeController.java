package com.visitJapan.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.visitJapan.dao.AddCityDAO;
import com.visitJapan.dto.response.HomeResponseDTO;


@WebServlet("/home.do")
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    private final String tabelogLink = "https://tabelog.com/kr/";
	private final String googleFinanceLink = "https://www.google.com/finance/quote/JPY-KRW"; // 구글 금융 엔/원 환율 링크
	private final String spotLink = "https://japantravel.navitime.com/ko/area/jp/search/spot/?word=";
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String region = request.getParameter("region"); // 검색한 지역 정보 가져옴
		
		// 관광지 크롤링
		String crawlingSpotURL = spotLink + region;
		Document spotDoc = Jsoup.connect(crawlingSpotURL).get();
		Elements spotList = spotDoc.select("div.spot-name a:lt(10)"); // 상위 10개만
		
		// 타베로그 크롤링
        String crawlingTabeURL = switch (region) {
	    	case "도쿄" -> tabelogLink + "tokyo/";
	    	case "오사카" -> tabelogLink + "osaka/";
	    	case "교토" -> tabelogLink + "kyoto/";
	    	case "후쿠오카" -> tabelogLink + "fukuoka/";
	        default -> {
	            yield null;
	        }
        };
		Document tabelogDoc = Jsoup.connect(crawlingTabeURL).get();
		Elements restaurantList = tabelogDoc.select("a.list-rst__rst-name-target.cpy-rst-name:lt(10)");
		
		// 엔 크롤링
        Document yenDoc = Jsoup.connect(googleFinanceLink).get();
        Element yenForex = yenDoc.selectFirst("div.YMlKec.fxKbKc"); // 환율 데이터
        Element yenDate = yenDoc.selectFirst("div.ygUjEc"); // 기준 날짜, 시간 (9시간 더해야 함)
        double yenValue =  Double.parseDouble(yenForex.text()) * 100; // 100엔 단위로
        
        // dto에 넣은 후 속성으로 보냄
        HomeResponseDTO homeResponse = new HomeResponseDTO(spotList, restaurantList, yenValue, yenDate);
		request.setAttribute("homeResponse", homeResponse);
				
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/visitData.jsp");
		dispatcher.forward(request, response); 	
	}
	
	@Override
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException {
		AddCityDAO addCityDAO = new AddCityDAO();
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");

		String userId = (String) request.getSession().getAttribute("id"); // 유저 아이디
	    StringBuilder sb = new StringBuilder(); 
	    String line;

	    try (BufferedReader reader = request.getReader()) {
	        while ((line = reader.readLine()) != null) {
	            sb.append(line);
	        }
	    }

	    String body = sb.toString(); // 응답 본문 Ex {"spot":"도쿄","region":"관동"}
	    body = body.replace("{", "").replace("}", "").replace("\"", "");
	    
	    String spot = "";
	    String city = "";

	    int dataIndex = body.indexOf("data-region=");
	    if (dataIndex != -1) {
	        // spot = "spot:" 이후부터 " data-region=" 직전까지
	        spot = body.substring(body.indexOf("spot:") + 5, dataIndex).trim();
	        
	        // region = "data-region=" 이후부터 끝까지
	        city = body.substring(dataIndex + 12).trim();
	    }

	    boolean result = addCityDAO.appendCityToUser(spot, city, userId);
	    if (result) {
		    System.out.println(spot);
	    	response.getWriter().write("{\"status\":\"ok\", \"spot\":\"" + spot + "\"}");
	    } else {
	    	System.out.println("추가 실패");
	    }

	}

}
