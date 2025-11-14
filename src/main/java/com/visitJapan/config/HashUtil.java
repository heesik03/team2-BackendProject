package com.visitJapan.config;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;


public class HashUtil {
	
	// 비밀번호 해시 생성 
    public static String hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hashBytes = md.digest(password.getBytes());
        return Base64.getEncoder().encodeToString(hashBytes);
    }

    // 비밀번호 검증 (검증 할 비밀번호, 기존 비밀번호)
    public static boolean verifyPassword(String password, String storedHash) throws NoSuchAlgorithmException {
        String newHash = hashPassword(password);
        return newHash.equals(storedHash);
    }

}
