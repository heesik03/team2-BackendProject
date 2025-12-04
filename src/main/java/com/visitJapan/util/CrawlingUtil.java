package com.visitJapan.util;

import java.util.ArrayList;
import java.util.List;

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
        switch (jp.trim()) {
            case "晴":       // はれ
            case "晴れ":
                return "맑음";

            case "曇":       // くもり
            case "曇り":
                return "흐림";

            case "雨":       // あめ
                return "비";

            case "雪":       // ゆき
                return "눈";

            case "雷":       // かみなり
            case "雷雨":
                return "뇌우";

            case "暴風":
            case "強風":
                return "강풍";

            case "霧":
                return "안개";

            case "みぞれ":
                return "진눈깨비";

            case "快晴":
                return "쾌청";

            case "所により雨":
            case "一時雨":
                return "한때 비";

            case "所により雪":
            case "一時雪":
                return "한때 눈";
            default:
                return jp;
        }
    }
}
