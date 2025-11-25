package com.visitJapan.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class DBConfigReader {

    private Properties properties = new Properties();

    public DBConfigReader() {
        // 클래스패스에서 properties 파일 읽기
        try (InputStream input = getClass().getClassLoader()
                .getResourceAsStream("com/visitJapan/dbconfig.properties")) {

            if (input == null) {
                System.out.println("dbconfig.properties 가져오기 실패");
                return;
            }

            properties.load(input); // properties 파일 로드

        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    // MongoDB URI 
    public String getDbUri() {
        return properties.getProperty("db.uri");
    }
    
    // Google Maps Key
    public String getGoogleKey() {
        return properties.getProperty("google.key");
    }
}

