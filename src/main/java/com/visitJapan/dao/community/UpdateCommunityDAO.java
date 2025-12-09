package com.visitJapan.dao.community;

import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.visitJapan.dto.db.CommunityDTO;
import com.visitJapan.util.MongoConnectUtil;

public class UpdateCommunityDAO {
	
	public boolean putData(String id, String title, String content) {
		boolean result = false;
        try {
            if (id != null && title != null && content != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<CommunityDTO> collection = database.getCollection("community", CommunityDTO.class);
				ObjectId objectId = new ObjectId(id);
				
				// 일정 id로 검색
				CommunityDTO communityData = collection
				        .find(Filters.eq("_id", objectId))
				        .first(); 
				
				if (communityData != null) {
				    // DTO 수정
					communityData.setTitle(title);
					communityData.setContent(content);
					
				    // MongoDB에 저장
				    collection.replaceOne(
				        Filters.eq("_id", objectId), 
				        communityData          
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
