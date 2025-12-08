package com.visitJapan.dao.community;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import com.mongodb.client.result.UpdateResult;
import com.visitJapan.util.MongoConnectUtil;

public class AddLikeDAO {
	
	public int plusLike(String id, ObjectId userId) {
	    try {
	        if (id != null && userId != null) {
	            MongoDatabase database = MongoConnectUtil.getConnection();
	            MongoCollection<Document> collection = database.getCollection("community");

	            ObjectId objectId = new ObjectId(id);

	            UpdateResult updateResult = collection.updateOne(
	                Filters.and(
	                    Filters.eq("_id", objectId),
	                    Filters.not(Filters.elemMatch("likedUsers", Filters.eq("$eq", userId)))
	                ),
	                Updates.combine(
	                    Updates.addToSet("likedUsers", userId),
	                    Updates.inc("like", 1)
	                )
	            );

	            if (updateResult.getModifiedCount() > 0) 
	            		return 1; // 좋아요 성공
	            else 
	            		return 0; // 이미 좋아요 누름
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return -1; // 서버 오류
	    } finally {
	        MongoConnectUtil.close();
	    }
	    return -1; // 서버 오류
	}
	
}
