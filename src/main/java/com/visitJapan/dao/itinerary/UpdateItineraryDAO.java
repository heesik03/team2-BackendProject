package com.visitJapan.dao.itinerary;

import java.util.List;

import org.bson.types.ObjectId;
import org.json.JSONArray;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.visitJapan.dto.db.ItineraryDTO;
import com.visitJapan.dto.db.SpotListDTO;
import com.visitJapan.util.MongoConnectUtil;
import com.visitJapan.util.SpotListConverterUtil;

public class UpdateItineraryDAO {
	public boolean putItinerary(String title, String startDate, String endDate, JSONArray spotList, ObjectId itineraryId) {
		boolean result = false;
        try {
            if (title != null && startDate != null && endDate != null && spotList != null && itineraryId != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<ItineraryDTO> collection = database.getCollection("itinerary", ItineraryDTO.class);

                // JSONArray -> SpotListDTO 로 전환
                List<SpotListDTO> dayPlan = SpotListConverterUtil.fromJSONArray(spotList);
		    	    
				// 일정 id로 검색
				ItineraryDTO itinerary = collection
				        .find(Filters.eq("_id", itineraryId))
				        .first(); 
				
				if (itinerary != null) {
				    // DTO 수정
					itinerary.setTitle(title);
				    itinerary.setStartDate(startDate);
				    itinerary.setEndDate(endDate);
				    itinerary.setSpotList(dayPlan);

				    // MongoDB에 저장
				    collection.replaceOne(
				        Filters.eq("_id", itineraryId), // 조건
				        itinerary                        // 새 문서
				    );
				    
	                result = true;
				}
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            MongoConnectUtil.close();
        }
        return result;
	}
}
