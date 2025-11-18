package com.visitJapan.dao.users;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import com.mongodb.client.result.UpdateResult;
import com.visitJapan.util.MongoConnectUtil;

public class DeleteCityDAO {
	
	public boolean removeSpot(String spot, String city, ObjectId id) {
        boolean result = false;
        try {
            if (spot != null && city != null && id != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<Document> collection = database.getCollection("users");
               
                // MongoDB updateOne 사용, $pull로 spots 배열에서 특정 값 제거
                UpdateResult updateResult = collection.updateOne(
                    Filters.and(
                        Filters.eq("_id", id),
                        Filters.eq("cityList.cityName", city)
                    ),
                    Updates.pull("cityList.$.spots", spot)
                );
                
                result = updateResult.getModifiedCount() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            MongoConnectUtil.close();
        }
        return result;
	}
}