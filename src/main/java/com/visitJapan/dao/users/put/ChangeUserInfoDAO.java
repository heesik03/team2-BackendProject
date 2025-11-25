package com.visitJapan.dao.users.put;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import com.mongodb.client.result.UpdateResult;
import com.visitJapan.util.MongoConnectUtil;

public class ChangeUserInfoDAO {
		
	public boolean updateUserInfo(ObjectId id, boolean isName, String newData) {
		boolean result = false;
        try {
            if (id != null && newData != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<Document> collection = database.getCollection("users");
		        
		        String field = isName ? "userName" : "likeCity"; // 닉네임을 바꿀지, 선호 도시를 바꿀지 선택
                
        			UpdateResult updateResult = collection.updateOne( 
			            Filters.eq("_id", id),
			            Updates.set(field, newData) // 선택한 필드에 따라 바꿈
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
