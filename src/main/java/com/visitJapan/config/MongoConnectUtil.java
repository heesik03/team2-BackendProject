package com.visitJapan.config;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;

import org.bson.codecs.configuration.CodecProvider;
import org.bson.codecs.configuration.CodecRegistry;
import org.bson.codecs.pojo.PojoCodecProvider;

import static com.mongodb.MongoClientSettings.getDefaultCodecRegistry;
import static org.bson.codecs.configuration.CodecRegistries.fromProviders;
import static org.bson.codecs.configuration.CodecRegistries.fromRegistries;

public class MongoConnectUtil {

    private static MongoClient mongoClient;
    private static final String DB_NAME = "dongyang";
    private static MongoDatabase database = null;

    public static MongoDatabase getConnection() {
    	DBConfigReader config = new DBConfigReader();
        if (mongoClient == null) {
            try {
            	// POJO(Plain Old Java Object) 자동 매핑을 위한 CodecProvider 생성
            	CodecProvider pojoCodecProvider = PojoCodecProvider
            			.builder()
            			.automatic(true)
            			.build();
            	
            	// MongoDB 기본 CodecRegistry + POJO 변환용 CodecRegistry 통합
            	CodecRegistry pojoCodecRegistry = fromRegistries(getDefaultCodecRegistry(), fromProviders(pojoCodecProvider));
                
            	mongoClient = MongoClients.create(config.getDbUri());
          
            	// 지정한 CodecRegistry(pojoCodecRegistry)를 현재 데이터베이스에 적용
                database = mongoClient.getDatabase(DB_NAME).withCodecRegistry(pojoCodecRegistry);
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("MongoDB 연결 실패");
            }
        }
        return database;
    }

    public static void close() {
        if (mongoClient != null) {
            mongoClient.close();
            mongoClient = null;
        }
    }
}