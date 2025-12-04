package com.visitJapan.util;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

public class FetchUtil {

    private static final HttpClient httpClient = HttpClient.newBuilder()
            .followRedirects(HttpClient.Redirect.NORMAL)
            .connectTimeout(Duration.ofSeconds(3))
            .version(HttpClient.Version.HTTP_2)
            .build();
    
    // 비동기 크롤링 호출
    private static CompletableFuture<Document> fetchAsync(String url) {
        long start = System.currentTimeMillis();

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .header("User-Agent", 
                        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36")
                .timeout(Duration.ofSeconds(3))
                .GET()
                .build();

        return httpClient.sendAsync(request, HttpResponse.BodyHandlers.ofString(java.nio.charset.StandardCharsets.UTF_8))
                .thenApply(response -> {
                    if (response.statusCode() >= 300) {
                        throw new RuntimeException("HTTP Error: " + response.statusCode());
                    }
                    String html = response.body(); 

                    long end = System.currentTimeMillis();
                    System.out.println(url + " -> " + (end - start) + "ms"); 

                    return Jsoup.parse(html, url); 
                })
                .exceptionally(ex -> {
                    System.err.println("Error fetching " + url + ": " + ex.getMessage());
                    throw new RuntimeException(ex); 
                });
    }


    // 하나만 호출
    public static Document fetchDocument(String url) {
        return fetchAsync(url).join();
    }


    // 여러개 병렬 호출
    public static List<Document> fetchAll(List<String> urlList) {
        List<CompletableFuture<Document>> futures = urlList.stream()
                .map(FetchUtil::fetchAsync) 
                .collect(Collectors.toList());

        CompletableFuture<Void> allOf = CompletableFuture.allOf(futures.toArray(new CompletableFuture[0]));

        return allOf.thenApply(v -> futures.stream()
                .map(CompletableFuture::join) 
                .collect(Collectors.toList()))
                .join(); 
    }
    
}