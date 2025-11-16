package com.visitJapan.dao;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.visitJapan.config.MongoConnectUtil;
import com.visitJapan.dto.db.CityDTO;
import com.visitJapan.dto.db.UsersDTO;

public class GetUserDAO {
	
	public UsersDTO findUserData(String id) {
		UsersDTO findUser = null;
		try {
			if (id != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<Document> collection = database.getCollection("users");
				ObjectId objectId = new ObjectId(id);
				
				Document user = collection.find(Filters.eq("_id", objectId)).first(); // 유저 검색
				List<CityDTO> cityDTOList = new ArrayList<>(); 
				List<Document> cityDocs = user.getList("cityList", Document.class);

				if (cityDocs != null) {
				    for (Document cityDoc : cityDocs) {
				        CityDTO city = new CityDTO();
				        city.setCityName(cityDoc.getString("cityName"));
				        city.setSpots(cityDoc.getList("spots", String.class));
				        cityDTOList.add(city);
				    }
				}
				
				// 유저 생성일 형변환
				LocalDateTime createAt = user.getDate("createAt").toInstant()
											 .atZone(ZoneId.systemDefault())
				                             .toLocalDateTime();

				findUser = new UsersDTO(
				        objectId,
				        user.getString("userName"),
				        user.getString("email"),
				        null,                               // 비밀번호는 넘기지 않음(보안)
				        user.getString("likeCity"),
				        cityDTOList,                        // DTO 목록 넣기
				        user.getBoolean("admin", false),
				        createAt
				);
			}
		} catch (Exception e) {
            e.printStackTrace();
        } finally {
            MongoConnectUtil.close();
        }
        return findUser;
	}
}
