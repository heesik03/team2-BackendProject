package com.visitJapan.dao.itinerary;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.result.DeleteResult;
import com.visitJapan.util.MongoConnectUtil;

public class DeleteItineraryDAO {
	public boolean remove(String itineraryId) {
        boolean result = false;
        try {
            if (itineraryId != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<Document> itineraryCollection = database.getCollection("itinerary");
                MongoCollection<Document> communityCollection = database.getCollection("community");

                ObjectId objectId = new ObjectId(itineraryId); // ObjectId 타입으로 변환

                // 일정 삭제
                DeleteResult itineraryResult = itineraryCollection.deleteOne(
                    Filters.eq("_id", objectId)
                );

                // 공유된 일정 게시글 삭제
                communityCollection.deleteMany(
                    Filters.eq("itineraryId", objectId)
                );
                
                result = itineraryResult.getDeletedCount() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            MongoConnectUtil.close();
        }
        return result;
	}
}
