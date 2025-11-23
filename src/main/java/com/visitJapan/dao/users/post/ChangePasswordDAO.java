package com.visitJapan.dao.users.post;

import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import com.mongodb.client.result.UpdateResult;
import com.visitJapan.dto.db.UsersDTO;
import com.visitJapan.util.HashUtil;
import com.visitJapan.util.MongoConnectUtil;

public class ChangePasswordDAO {
	
	public String updatePwd(ObjectId id, String currentPassword, String newPassword) {
		String error = "서버 오류입니다.";
		try {
			if (id != null && newPassword != null) {
				MongoDatabase database = MongoConnectUtil.getConnection();
		        MongoCollection<UsersDTO> collection = database.getCollection("users", UsersDTO.class);
		        
		        UsersDTO user = collection.find(Filters.eq("_id", id)).first(); 
	            if (user != null) { 
		            	if (HashUtil.verifyPassword(currentPassword, user.getPassword())) { // 비밀번호가 일치한다면
		            		// 비밀번호 암호화 후 변경
		            		UpdateResult result = collection.updateOne( 
					            Filters.eq("_id", id),
					            Updates.set("password", HashUtil.hashPassword(newPassword))
					     );
		            		
		            		// 올바르게 번경되었다면 null return
				        if (result.getModifiedCount() > 0) {
				            error = null; 
				        }
		            	} else {
		            		error = "암호가 틀렸습니다."; // 비밀번호가 일치하지 않는다면
		            	}
	            }
			}
		} catch (Exception e) {
            e.printStackTrace();
        }
        return error;
	}
}
