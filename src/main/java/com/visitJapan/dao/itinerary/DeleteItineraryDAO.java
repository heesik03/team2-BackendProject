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
                MongoCollection<Document> collection = database.getCollection("itinerary");
                ObjectId objectId = new ObjectId(itineraryId); // ObjectId 타입으로 변환
               
                DeleteResult deleteResult = collection.deleteOne(Filters.eq("_id", objectId)); // id로 찾아서 삭제
                result = deleteResult.getDeletedCount() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            MongoConnectUtil.close();
        }
        return result;
	}
}
