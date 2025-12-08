package com.visitJapan.dao.community;

import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.visitJapan.dto.db.CommunityDTO;
import com.visitJapan.util.MongoConnectUtil;

public class GetCommunityDAO {
	
	public CommunityDTO findData(String id) {
		CommunityDTO findCommunity = null;
		try {
			if (id != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<CommunityDTO> collection = database.getCollection("community", CommunityDTO.class);

                ObjectId objectId = new ObjectId(id);
				
				// 게시글 id로 검색
                CommunityDTO community = collection
				        .find(Filters.eq("_id", objectId))
				        .first(); 
				
				if (community != null) {
					findCommunity = community;
				}
			}
		} catch (Exception e) {
            e.printStackTrace();
        } finally {
            MongoConnectUtil.close();
        }
        return findCommunity;
	}
}
