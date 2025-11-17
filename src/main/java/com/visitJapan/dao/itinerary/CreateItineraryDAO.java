package com.visitJapan.dao.itinerary;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.List;

import org.bson.types.ObjectId;
import org.json.JSONArray;
import org.json.JSONObject;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.visitJapan.dto.db.DayPlanDTO;
import com.visitJapan.dto.db.ItineraryDTO;
import com.visitJapan.util.MongoConnectUtil;

public class CreateItineraryDAO {
	
	public boolean appendSpotList(String id, String title, String startDate, String endDate, JSONArray spotList) {
		boolean result = false;
        try {
            if (title != null && startDate != null && endDate != null && spotList != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<ItineraryDTO> collection =  database.getCollection("itinerary", ItineraryDTO.class);
                ObjectId userId = new ObjectId(id);
                
		    	    List<DayPlanDTO> dayPlan = new ArrayList<>();
		    	    // JSONArray → DayPlanDTO List로 변환
		    	    for (int i = 0; i < spotList.length(); i++) {
		    	        JSONObject dayObj = spotList.getJSONObject(i);
		
		    	        String day = dayObj.getString("day");
		    	        JSONArray spotsArray = dayObj.getJSONArray("spots");
		
		    	        List<String> spots = new ArrayList<>();
		    	        for (int j = 0; j < spotsArray.length(); j++) {
		    	            spots.add(spotsArray.getString(j));
		    	        }
		
		    	        DayPlanDTO dto = new DayPlanDTO(day, spots);
		    	        dayPlan.add(dto);
		    	    }
		    	    
				LocalDateTime seoulDate = ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toLocalDateTime(); // 서울 시간대
		    	    ItineraryDTO itineraryData = new ItineraryDTO (null, userId, title, startDate, endDate, dayPlan, seoulDate);
		    	    collection.insertOne(itineraryData);
                result = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            MongoConnectUtil.close();
        }
        return result;
	}
}
