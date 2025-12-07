package com.visitJapan.util;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

public class FetchUtil {
	
	// HttpClient 선언
	private static final HttpClient http = HttpClient.newBuilder()
	        .connectTimeout(Duration.ofSeconds(5))   
	        .version(HttpClient.Version.HTTP_2)
	        .build();

	public static Document fetchDocument(String url) {
	    HttpRequest req = HttpRequest.newBuilder()
	            .uri(URI.create(url))
	            .timeout(Duration.ofSeconds(5)) // 5초 (5000ms)
	            .GET()
	            .build();

	    try {
	        HttpResponse<String> res = http.send(req, HttpResponse.BodyHandlers.ofString());
	        return Jsoup.parse(res.body());

	    } catch (Exception e) {
	        System.err.println("Fetch failed: " + url + " → " + e.getMessage());
	        return null; 
	    }
	}

	// 크롤링 병렬 호출
	public static List<Document> fetchAll(List<String> urlList) {
        long start = System.currentTimeMillis();
		// 병렬 처리를 위한 고정 크기의 스레드풀 생성
	    ExecutorService executor = Executors.newFixedThreadPool(3);

	    try {
		    	List<CompletableFuture<Document>> futures = urlList.stream()
		    		    .map((String url) -> {
		    		    		// 각 스레드에서 크롤링 호출
		    		        return CompletableFuture.supplyAsync(() -> fetchDocument(url), executor);
		    		    })
		    		    .collect(Collectors.toList()); // 스트림 -> 리스트 변환

		    	// 모든 Future의 결과를 취합하여 반환
	        return futures.stream()
	                .map(CompletableFuture::join)  
	                .collect(Collectors.toList());

	    } finally {
	        executor.shutdown(); // 스레드 풀 종료
	        long end = System.currentTimeMillis();
	        System.out.println("크롤링 소요 시간: " + (end - start) + "ms");
	    }
	}
    
}