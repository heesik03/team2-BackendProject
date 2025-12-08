package com.visitJapan.dto.response;

import java.time.LocalDateTime;

import org.bson.types.ObjectId;

public class CommunityListDTO {
	private ObjectId id;
	private String title;
	private String authorName; // 게시글을 공유한 유저의 닉네임
    private	LocalDateTime createAt;
    
    public CommunityListDTO() {}

	public CommunityListDTO(ObjectId id, String title, String authorName, LocalDateTime createAt) {
		super();
		this.id = id;
		this.title = title;
		this.authorName = authorName;
		this.createAt = createAt;
	}

	public ObjectId getId() {
		return id;
	}

	public void setId(ObjectId id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthorName() {
		return authorName;
	}

	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}

	public LocalDateTime getCreateAt() {
		return createAt;
	}

	public void setCreateAt(LocalDateTime createAt) {
		this.createAt = createAt;
	}
    
    
}
