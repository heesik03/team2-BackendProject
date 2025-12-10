package com.visitJapan.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.visitJapan.dto.response.*;

public class CrawlingUtil {
	
	
	// 관광지 이름, 이미지 주소 10개 각각 list에
	public static SpotDTO getSpot(Document doc) {
		Elements spotListAll = doc.select("div.spot-name a");
	    Elements spotList = new Elements();
	    for (int i = 0; i < Math.min(10, spotListAll.size()); i++) {
	        spotList.add(spotListAll.get(i));
	    }

	    Elements imgAll = doc.select("div.image-frame img");
	    List<String> spotImgList = new ArrayList<>();
	    int limit = Math.min(10, imgAll.size());
	    for (int i = 0; i < limit; i++) {
	        spotImgList.add(imgAll.get(i).attr("src"));
	    }
	    return new SpotDTO(spotList, spotImgList);
	}
	
	public static RestaurantDTO getRestaurant(Document doc) {
		Elements restaurantAll = doc.select("a.list-rst__rst-name-target.cpy-rst-name");
		Elements restaurantList = new Elements();
	    for (int i = 0; i < Math.min(10, restaurantAll.size()); i++) {
	    		restaurantList.add(restaurantAll.get(i));
	    }
		
		Elements restaurantImgs = 
				doc.select("img.js-thumbnail-img:nth-child(3n+1)"); // 레스트랑마다 첫번째 이미지만 추출 (레스트랑 하나 당 3개의 이미지가 있음)
		
	    List<String> restaurantImgList = new ArrayList<>();

	    for (Element img : restaurantImgs) {
	        String url = img.attr("data-lazy"); // 이미지 링크 추출
	        if (url != null && !url.isEmpty()) {
	            restaurantImgList.add(url);
	        }
	    }
		
		RestaurantDTO resDto = new RestaurantDTO(restaurantList, restaurantImgList);
		return resDto;
	}
	
	
    public static WeatherDTO getWeather(Document doc) {
        try {
            // 하늘 상태
	        	Element telop = doc.selectFirst("p.weather-telop");
	        	Element temps = doc.selectFirst("dl.date-value");
	        	
	        	String sky = (telop != null) ? telop.text() : "정보 없음";
	        	String highTemp = "정보 없음";
	        	String lowTemp = "정보 없음";
	        	String rain = "정보 없음";

	        	// 최고, 최저 온도
	        	if (temps != null) {
	        	    Element high = temps.selectFirst(".high-temp.temp .value");
	        	    Element low = temps.selectFirst(".low-temp.temp .value");

	        	    if (high != null) 
	        	    		highTemp = high.text();
	        	    if (low != null)  
	        	    		lowTemp = low.text();
	        	}

            // 강수확률 (12~18시 값 사용)
	        	Element rainRow = doc.selectFirst("tr.rain-probability");
	        	if (rainRow != null) {
	        	    Elements greys = rainRow.select("span.grey");
	        	    if (greys.size() > 2) {
	        	        String val = greys.get(2).text().trim();

	        	        if (!val.equals("---")) {
	        	            rain = val;
	        	        }
	        	    }
	        	}
	        	
            // DTO에 담기
            WeatherDTO weatherDto = new WeatherDTO(toKorean(sky), highTemp, lowTemp, rain);
            return weatherDto;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public static String toKorean(String jp) {
        if (jp == null || jp.isBlank()) return jp;
        jp = jp.trim();

        if (WEATHER_MAP.containsKey(jp)) {
            return WEATHER_MAP.get(jp);
        }

        // "X一時Y"  → "X, 한때 Y"
        if (jp.contains("一時")) {
            String[] parts = jp.split("一時");
            if (parts.length == 2)
                return toKorean(parts[0]) + ", 한때 " + toKorean(parts[1]);
        }

        // "X時々Y"  → "X, 가끔 Y"
        if (jp.contains("時々")) {
            String[] parts = jp.split("時々");
            if (parts.length == 2)
                return toKorean(parts[0]) + ", 가끔 " + toKorean(parts[1]);
        }

        // "XのちY" → "X 뒤에 Y"
        if (jp.contains("のち")) {
            String[] parts = jp.split("のち");
            if (parts.length == 2)
                return toKorean(parts[0]) + " 뒤에 " + toKorean(parts[1]);
        }

        // "所によりX" → "곳에 따라 X"
        if (jp.contains("所により")) {
            String after = jp.replace("所により", "");
            return "곳에 따라 " + toKorean(after);
        }

        // 커버되지 않은 경우 원본 반환
        return jp;
    }
    
    private static final Map<String, String> WEATHER_MAP = Map.ofEntries(
            Map.entry("晴", "맑음"),
            Map.entry("晴れ", "맑음"),
            Map.entry("快晴", "쾌청"),

            Map.entry("曇", "흐림"),
            Map.entry("曇り", "흐림"),

            Map.entry("雨", "비"),
            Map.entry("雷雨", "뇌우"),

            Map.entry("雪", "눈"),
            Map.entry("みぞれ", "진눈깨비"),

            Map.entry("雷", "뇌우"),
            Map.entry("霧", "안개"),

            Map.entry("暴風", "강풍"),
            Map.entry("強風", "강풍"),

            Map.entry("一時雨", "한때 비"),
            Map.entry("時々雨", "가끔 비"),
            Map.entry("所により雨", "곳에 따라 비"),

            Map.entry("一時雪", "한때 눈"),
            Map.entry("時々雪", "가끔 눈"),
            Map.entry("所により雪", "곳에 따라 눈")
        );
}
