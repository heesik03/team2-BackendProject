package com.visitJapan.config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class DBConfigReader {

    private Properties properties = new Properties();

    public DBConfigReader() {
        // 클래스패스에서 properties 파일 읽기
        try (InputStream input = getClass().getClassLoader().getResourceAsStream("com/visitJapan/dbconfig.properties")) {
            if (input == null) {
                System.out.println("Unable to find dbconfig.properties");
                return;
            }
            properties.load(input); // properties 파일 로드
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    public String getDbUri() {
        return properties.getProperty("db.uri");
    }
}

