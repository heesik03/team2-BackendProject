package com.visitJapan.dao.itinerary;

import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.visitJapan.dto.db.ItineraryDTO;
import com.visitJapan.util.MongoConnectUtil;

public class GetItineraryDAO {
	
	public ItineraryDTO findData(ObjectId itineraryId) {
		ItineraryDTO findItinerary = null;
		try {
			if (itineraryId != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<ItineraryDTO> collection = database.getCollection("itinerary", ItineraryDTO.class);
				
				// 일정 id로 검색
				ItineraryDTO itinerary = collection
				        .find(Filters.eq("_id", itineraryId))
				        .first(); 
				
				if (itinerary != null) {
					findItinerary = itinerary;
				}
			}
		} catch (Exception e) {
            e.printStackTrace();
        } finally {
            MongoConnectUtil.close();
        }
        return findItinerary;
	}
}
