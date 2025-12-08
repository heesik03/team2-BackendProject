package com.visitJapan.dao.community;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.result.DeleteResult;
import com.visitJapan.util.MongoConnectUtil;

public class DeleteCommunityDAO {
	public boolean remove(ObjectId communityId) {
        boolean result = false;
        try {
            if (communityId != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<Document> collection = database.getCollection("community");
               
                DeleteResult deleteResult = collection.deleteOne(Filters.eq("_id", communityId)); // id로 찾아서 삭제
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
