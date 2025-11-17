package com.visitJapan.dao.users;

import java.util.Arrays;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import com.visitJapan.util.MongoConnectUtil;

public class AddCityDAO {

    public boolean appendCityToUser(String spot, String city, String id) {
        boolean result = false;
        try {
            if (spot != null && city != null && id != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<Document> collection = database.getCollection("users");
                ObjectId objectId = new ObjectId(id);

             // cityList 안에 cityName 이 city 와 같은 Document가 있는지 확인
                Document existingCity = collection.find(
                        Filters.and(
                                Filters.eq("_id", objectId),
                                Filters.elemMatch("cityList", Filters.eq("cityName", city))
                        )
                ).first();

                if (existingCity != null) {
                    // 이미 존재하는 도시 → 해당 spots 배열에 spot 추가
                    collection.updateOne(
                            Filters.and(
                                    Filters.eq("_id", objectId),
                                    Filters.elemMatch("cityList", Filters.eq("cityName", city))
                            ),
                            Updates.addToSet("cityList.$.spots", spot)
                    );
                } else {
                    // 도시가 없으면 새로운 Document 삽입
                    Document newCityDoc = new Document()
                            .append("cityName", city)
                            .append("spots", Arrays.asList(spot));

                    collection.updateOne(
                            Filters.eq("_id", objectId),
                            Updates.addToSet("cityList", newCityDoc)
                    );
                }
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