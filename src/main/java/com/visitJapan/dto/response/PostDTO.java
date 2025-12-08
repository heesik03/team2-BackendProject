package com.visitJapan.dto.response;

import org.bson.types.ObjectId;

public class PostDTO {
	private ObjectId id;
	private ObjectId userId; // 입력한 유저의 ID
	private String userName; // 작성자
	private String content;
    private long like; 
    
    public PostDTO() {}

	public PostDTO(ObjectId id, ObjectId userId, String userName,  String content, long like) {
		super();
		this.id = id;
		this.userId = userId;
		this.userName = userName;
		this.content = content;
		this.like = like;
	}

	public ObjectId getId() {
		return id;
	}

	public void setId(ObjectId id) {
		this.id = id;
	}

	public ObjectId getUserId() {
		return userId;
	}

	public void setUserId(ObjectId userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public long getLike() {
		return like;
	}

	public void setLike(long like) {
		this.like = like;
	};
    
    
}


