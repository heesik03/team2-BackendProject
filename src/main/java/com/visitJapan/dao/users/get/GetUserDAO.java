package com.visitJapan.dao.users.get;


import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.visitJapan.dto.db.UsersDTO;
import com.visitJapan.util.MongoConnectUtil;

public class GetUserDAO {
	
	public UsersDTO findUser(ObjectId id) {
		UsersDTO findUser = null;
		try {
			if (id != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<UsersDTO> collection = database.getCollection("users", UsersDTO.class);
				
				UsersDTO user = collection.find(Filters.eq("_id", id)).first(); // 유저 검색
				if (user != null) {
					user.setPassword(null); // 보안을 위해 비밀번호는 null로
					findUser = user;
				}
			}
		} catch (Exception e) {
            e.printStackTrace();
        } finally {
            MongoConnectUtil.close();
        }
        return findUser;
	}
}