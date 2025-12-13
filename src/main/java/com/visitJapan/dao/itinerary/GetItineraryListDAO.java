package com.visitJapan.dao.itinerary;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.visitJapan.dto.db.ItineraryDTO;
import com.visitJapan.util.MongoConnectUtil;

public class GetItineraryListDAO {
	
	public List<ItineraryDTO> findList(ObjectId userId) {
		List<ItineraryDTO> findItinerarys = null;
		try {
			if (userId != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<ItineraryDTO> collection = database.getCollection("itinerary", ItineraryDTO.class);
				
                // 유저 id에 맞는 List 전달
                List<ItineraryDTO> itineraryList = collection
                        .find(Filters.eq("userId", userId))
                        .into(new ArrayList<>()); // List<ItineraryDTO>로 반환
                
				if (itineraryList != null) {
					Collections.reverse(itineraryList); // 일정 목록 뒤집음 (최신순 정렬)
					findItinerarys = itineraryList;
				}
			}
		} catch (Exception e) {
            e.printStackTrace();
        } finally {
            MongoConnectUtil.close();
        }
        return findItinerarys;
	}
}
