package com.visitJapan.dao.community;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import com.mongodb.client.result.UpdateResult;
import com.visitJapan.util.MongoConnectUtil;

public class DeleteCommentDAO {
	public boolean remove(String id, String commentId) {
        boolean result = false;
        try {
            if (id != null && commentId != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<Document> collection = database.getCollection("community");
                
                ObjectId objectId = new ObjectId(id);
                ObjectId commentObjectId = new ObjectId(commentId);

                UpdateResult updateResult = collection.updateOne(
                        Filters.eq("_id", objectId),
                        Updates.pull("comment", Filters.eq("commentId", commentObjectId))
                );

                // 댓글이 실제로 삭제되었는지 확인
                result = updateResult.getModifiedCount() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            MongoConnectUtil.close();
        }
        return result;
	}
}
