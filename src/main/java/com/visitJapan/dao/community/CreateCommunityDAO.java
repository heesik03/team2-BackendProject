package com.visitJapan.dao.community;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;

import org.bson.types.ObjectId;
import static com.mongodb.client.model.Filters.eq;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.visitJapan.dto.db.CommunityDTO;
import com.visitJapan.dto.db.UsersDTO;
import com.visitJapan.util.MongoConnectUtil;

public class CreateCommunityDAO {
	
	public boolean insert(ObjectId userId, String itineraryId, String title, String content) {
		boolean result = false;
        try {            
        		if (itineraryId != null && title != null && content != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<CommunityDTO> communityCollection =  database.getCollection("community", CommunityDTO.class);

                MongoCollection<UsersDTO> usersCollection = database.getCollection("users", UsersDTO.class);
                UsersDTO user = usersCollection.find(eq("_id", userId)).first(); // 유저 이름 조회
                String userName = (user != null) ? user.getUserName() : "알 수 없음";
                
		    	    ObjectId objectItineraryId = new ObjectId(itineraryId); // 게시글 id ObjectId형으로 바꿈
				LocalDateTime seoulDate = ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toLocalDateTime(); // 서울 시간대
				
				CommunityDTO communityData = new CommunityDTO 
						(null, userId, objectItineraryId, userName, title, content, 0, new ArrayList<>(), null, seoulDate);
		    	    
				communityCollection.insertOne(communityData);
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
