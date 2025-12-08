package com.visitJapan.dao.community;

import static com.mongodb.client.model.Filters.eq;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;

import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Updates;
import com.visitJapan.dto.db.CommentDTO;
import com.visitJapan.dto.db.CommunityDTO;
import com.visitJapan.dto.db.UsersDTO;
import com.visitJapan.util.MongoConnectUtil;

public class CreateCommentDAO {
	
	public CommentDTO pushComment(String id, String content, ObjectId userId) {
		CommentDTO result = null;
        try {            
        		if (id != null && content != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<CommunityDTO> communityCollection =  database.getCollection("community", CommunityDTO.class);

                MongoCollection<UsersDTO> userCollection = database.getCollection("users", UsersDTO.class);
                UsersDTO user = userCollection.find(eq("_id", userId)).first(); // 유저 이름 조회
                String userName = (user != null) ? user.getUserName() : "알 수 없음";
                
		    	    ObjectId objectCommunityId = new ObjectId(id); // 게시글 id ObjectId형으로 바꿈
				LocalDateTime seoulDate = ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toLocalDateTime(); // 서울 시간대
				
				CommentDTO commentData = new CommentDTO 
						(new ObjectId(), userId, userName, content, seoulDate);
				
				// 댓글, 게시글 documnet에 추가
				communityCollection.updateOne(
				        eq("_id", objectCommunityId),
				        Updates.push("comment", commentData)
				);
		    	    
                result = commentData;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            MongoConnectUtil.close();
        }
        return result;
	}
}
