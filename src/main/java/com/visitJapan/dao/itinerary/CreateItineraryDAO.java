package com.visitJapan.dao.itinerary;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.List;

import org.bson.types.ObjectId;
import org.json.JSONArray;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.visitJapan.dto.db.SpotListDTO;
import com.visitJapan.dto.db.ItineraryDTO;
import com.visitJapan.util.MongoConnectUtil;
import com.visitJapan.util.SpotListConverterUtil;

public class CreateItineraryDAO {
	
	public boolean append(ObjectId userId, String title, String startDate, String endDate, JSONArray spotList) {
		boolean result = false;
        try {
            if (title != null && startDate != null && endDate != null && spotList != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<ItineraryDTO> collection =  database.getCollection("itinerary", ItineraryDTO.class);

                // JSONArray -> SpotListDTO 로 전환
                List<SpotListDTO> dayPlan = SpotListConverterUtil.fromJSONArray(spotList);
		    	    
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
