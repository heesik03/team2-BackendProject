package com.visitJapan.dao.users;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.visitJapan.dto.db.UsersDTO;
import com.visitJapan.util.MongoConnectUtil;

public class SignUpDAO {
	
	public boolean createUser(UsersDTO signUpData) {
		boolean result = false;
		try {
			if (signUpData != null) {
				MongoDatabase database = MongoConnectUtil.getConnection();
		        MongoCollection<UsersDTO> collection =  database.getCollection("users", UsersDTO.class);
		        collection.insertOne(signUpData);
		        result = true;
			}
		} catch (Exception e) {
            e.printStackTrace();
        } finally {
            MongoConnectUtil.close();
        }
        return result;
	}
}
