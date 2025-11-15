package com.visitJapan.dao;

import java.util.Arrays;

import org.bson.Document;
import org.bson.types.ObjectId;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import com.visitJapan.config.MongoConnectUtil;

public class AddCityDAO {

    public boolean appendCityToUser(String spot, String city, String id) {
        boolean result = false;
        try {
            if (spot != null && city != null && id != null) {
                MongoDatabase database = MongoConnectUtil.getConnection();
                MongoCollection<Document> collection = database.getCollection("users");
                ObjectId objectId = new ObjectId(id);

                // cityList 안에 해당 도시가 있는지 확인
                Document existingCity = collection.find(
                        Filters.and(
                                Filters.eq("_id", objectId),
                                Filters.elemMatch("cityList", Filters.exists(city))
                        )
                ).first();

                if (existingCity != null) {
                    // 도시가 이미 있으면 관광지 배열에 추가
                    collection.updateOne(
                            Filters.and(
                                    Filters.eq("_id", objectId),
                                    Filters.elemMatch("cityList", Filters.exists(city))
                            ),
                            Updates.addToSet("cityList.$." + city, spot)
                    );
                } else {
                    // 도시가 없으면 새로운 Document로 추가
                    Document newCityDoc = new Document(city, Arrays.asList(spot));
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

