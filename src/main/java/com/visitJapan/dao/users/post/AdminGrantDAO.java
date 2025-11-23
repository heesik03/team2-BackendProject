package com.visitJapan.dao.users.post;

import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import com.visitJapan.dto.db.UsersDTO;
import com.visitJapan.util.MongoConnectUtil;

public class AdminGrantDAO {
	
	public void changeRole(String userId) {
		try {
			if (userId != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<UsersDTO> collection = database.getCollection("users", UsersDTO.class);
				ObjectId objectId = new ObjectId(userId);
				
				UsersDTO user = collection.find(Filters.eq("_id", objectId)).first(); // 유저 존재 여부 확인
				
				if (user != null) {
			        collection.updateOne( // 권한 변경 및 업데이트
			            Filters.eq("_id", objectId),
			            Updates.set("admin", true)
			        );
				}
			}
		} catch (Exception e) {
            e.printStackTrace();
        } finally {
            MongoConnectUtil.close();
        }
	}
}
