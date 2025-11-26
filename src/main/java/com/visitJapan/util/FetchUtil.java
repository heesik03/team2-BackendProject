package com.visitJapan.util;

import java.io.IOException;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;


public class FetchUtil {
	
	private static final int THREAD_COUNT = 3; // 링크 배열 길이
	
	// 크롤링 호출 메서드
	private static Document fetchDocument(String url) {
	    try {
	        return Jsoup.connect(url)
	                .userAgent("Mozilla/5.0")
	                .timeout(8000)
	                .get();
	    } catch (IOException e) {
	        throw new RuntimeException(e);
	    }
	}

	// 크롤링 병렬 호출
	public static List<Document> fetchAll(List<String> urlList) {
		// 병렬 처리를 위한 고정 크기의 스레드풀 생성
	    ExecutorService executor = Executors.newFixedThreadPool(THREAD_COUNT);

	    try {
	    		// URL 리스트를 비동기 작업(CompletableFuture) 리스트로 변환
		    	List<CompletableFuture<Document>> futures = urlList.stream()
		    		    .map((String url) -> {
		    		    		// 각 스레드에서 크롤링 호출 (fetchDocument) 실시
		    		        return CompletableFuture.supplyAsync(() -> fetchDocument(url), executor);
		    		    })
		    		    .collect(Collectors.toList()); // 스트림 → 리스트 변환

		    	// 모든 Future의 결과(Document)를 취합하여 반환
	        return futures.stream()
	                .map(CompletableFuture::join)  // Future 결과값(Document) 가져오기
	                .collect(Collectors.toList());

	    } finally {
	        executor.shutdown(); // 스레드 풀 종료
	    }
	}
}
