package com.visitJapan.dao.users.delete;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.result.DeleteResult;
import com.visitJapan.util.MongoConnectUtil;

public class DeleteUserDAO {
	
	public boolean removeUser(ObjectId id) {
        boolean result = false;
        try {
            if (id != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<Document> collection = database.getCollection("users");
                
                DeleteResult deleteResult = collection.deleteOne(Filters.eq("_id", id)); // id로 찾아서 삭제
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
