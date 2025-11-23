package com.visitJapan.dao.users.put;

import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import com.mongodb.client.result.UpdateResult;
import com.visitJapan.dto.db.UsersDTO;
import com.visitJapan.util.MongoConnectUtil;

public class ChangeNameDAO {
	
	public boolean updateUserName(ObjectId id, String newName) {
		boolean result = false;
        try {
            if (id != null && newName != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
		        MongoCollection<UsersDTO> collection = database.getCollection("users", UsersDTO.class);
                
        			UpdateResult updateResult = collection.updateOne( 
			            Filters.eq("_id", id),
			            Updates.set("userName", newName)
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
