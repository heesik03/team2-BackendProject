package com.visitJapan.util;

import java.util.ArrayList;
import java.util.List;

import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.visitJapan.dto.response.RestaurantDTO;
import com.visitJapan.dto.response.WeatherDTO;

public class CrawlingUtil {
	
	public static RestaurantDTO getRestaurant(Document doc) {
		Elements restaurantList = doc.select("a.list-rst__rst-name-target.cpy-rst-name:lt(10)");
		Elements restaurantImgs = doc.select("img.js-thumbnail-img:lt(10)");
		List<String> restaurantImgList = new ArrayList<>();
		// 레스트랑마다 첫번째 이미지만 추출 (레스트랑 하나 당 3개의 이미지가 있음)
		for (int i = 0; i < restaurantImgs.size(); i++) {
		    // 3의 배수(0, 3, 6, ...)만 처리
		    if (i % 3 != 0) 
		    		continue;
		    Element img = restaurantImgs.get(i);

		    String url = img.attr("data-lazy"); // 이미지 URL은 data-lazy 속성에 있음

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
            String sky = doc.selectFirst("p.weather-telop") != null
                    ? doc.selectFirst("p.weather-telop").text()
                    : "정보 없음";

            // 최고 기온
            Element highEl = doc.selectFirst("dd.high-temp .value");
            String highTemp = (highEl != null) ? highEl.text() : "정보 없음";

            // 최저 기온
            Element lowEl = doc.selectFirst("dd.low-temp .value");
            String lowTemp = (lowEl != null) ? lowEl.text() : "정보 없음";

            // 강수확률 (12~18시 값 사용)
            Element rainEl = doc.selectFirst(".rain-probability tbody tr:nth-child(1) td:nth-child(4)");
            String rain = (rainEl != null) ? rainEl.text() : "정보 없음";

            // DTO에 담기
            WeatherDTO weatherDto = new WeatherDTO(sky, highTemp, lowTemp, rain);

            return weatherDto;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
