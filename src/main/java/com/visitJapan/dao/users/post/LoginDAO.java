package com.visitJapan.dao.users.post;

import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.visitJapan.dto.db.UsersDTO;
import com.visitJapan.util.HashUtil;
import com.visitJapan.util.MongoConnectUtil;

public class LoginDAO {
	
	public ObjectId checkUser(String email, String password) {
		ObjectId userId = null;
		try {
			if (email != null && password != null) {
				MongoDatabase database = MongoConnectUtil.getConnection();
		        MongoCollection<UsersDTO> collection = database.getCollection("users", UsersDTO.class);
		        
		        UsersDTO user = collection.find(Filters.eq("email", email)).first(); 
	            if (user != null) { // 이메일을 가진 사용자가 있다면
		            	if (HashUtil.verifyPassword(password, user.getPassword())) { // 비밀번호가 일치한다면
		            		userId = user.getId();
		            	}
	            }
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
            MongoConnectUtil.close();
        }
		return userId;
	}
}