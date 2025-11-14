package com.visitJapan.dao;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.visitJapan.config.HashUtil;
import com.visitJapan.config.MongoConnectUtil;
import com.visitJapan.dto.db.UsersDTO;

public class LoginDAO {
	
	public String checkUser(String email, String password) {
		String userName = null;
		try {
			if (email != null && password != null) {
				MongoDatabase database = MongoConnectUtil.getConnection();
		        MongoCollection<UsersDTO> collection = database.getCollection("users", UsersDTO.class);
		        
		        UsersDTO user = collection.find(Filters.eq("email", email)).first(); 
	            if (user != null) { // 이메일을 가진 사용자가 있다면
	            	if (HashUtil.verifyPassword(password, user.getPassword())) { // 비밀번호가 일치한다면
	            		userName = user.getUserName();
	            	}
	            }
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		MongoConnectUtil.close();
		return userName;
	}
}
