package com.visitJapan.dao.users;

import java.util.ArrayList;
import java.util.List;

import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.visitJapan.dto.db.UsersDTO;
import com.visitJapan.util.MongoConnectUtil;

public class GetAllUserDAO {
	
	public List<UsersDTO> getUserList(ObjectId id) {
		List<UsersDTO> userList = null;
		try {
			if (id != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<UsersDTO> collection = database.getCollection("users", UsersDTO.class);
				
				UsersDTO adminUser = collection.find(Filters.eq("_id", id)).first(); 
				
				if (adminUser!=null && adminUser.isAdmin()) { // 관리자가 맞다면
	                List<UsersDTO> allUser = collection
	                        .find() // 모든 유저 가져옴
	                        .into(new ArrayList<>()); // List<ItineraryDTO>로 반환
	                
	                // 비밀번호와 선호 관광지는 null로
	                for (UsersDTO user : allUser) {
	                    user.setPassword(null);
	                    user.setCityList(null);
	                }
	                
	                userList = allUser;
				}
			}
		} catch (Exception e) {
            e.printStackTrace();
        } finally {
            MongoConnectUtil.close();
        }
        return userList;
	}
}
