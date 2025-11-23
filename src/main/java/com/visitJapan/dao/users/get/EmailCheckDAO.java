package com.visitJapan.dao.users.get;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.visitJapan.dto.db.UsersDTO;
import com.visitJapan.util.MongoConnectUtil;

public class EmailCheckDAO {

    public boolean emailExists(String email) {
        boolean exists = false;
        
        try {
            MongoDatabase database = MongoConnectUtil.getConnection();
            MongoCollection<UsersDTO> collection = database.getCollection("users", UsersDTO.class);

            UsersDTO user = collection.find(Filters.eq("email", email)).first();

            if (user != null) {
                exists = true; // 이미 사용 중인 이메일
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            MongoConnectUtil.close();
        }
        return exists;
    }
}
