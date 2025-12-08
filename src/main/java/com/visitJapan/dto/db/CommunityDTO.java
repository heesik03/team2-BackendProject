package com.visitJapan.dto.db;

import java.time.LocalDateTime;
import java.util.List;

import org.bson.types.ObjectId;

public class CommunityDTO {
	private ObjectId id;
	private ObjectId userId; // 입력한 유저의 ID
	private ObjectId itineraryId; // 공유한 유저의 ID
	private String userName; // 작성자
    private String title;
    private String content;
    private long like; 
    private List<ObjectId> likedUsers; // 좋아요를 누른 유저의 id
    private List<CommentDTO> comment;
    private	LocalDateTime createAt;
    
    public CommunityDTO() {}

	public CommunityDTO(ObjectId id, ObjectId userId, ObjectId itineraryId, String userName, String title,
			String content, long like, List<ObjectId> likedUsers, List<CommentDTO> comment, LocalDateTime createAt) {
		super();
		this.id = id;
		this.userId = userId;
		this.itineraryId = itineraryId;
		this.userName = userName;
		this.title = title;
		this.content = content;
		this.like = like;
		this.likedUsers = likedUsers;
		this.comment = comment;
		this.createAt = createAt;
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

	public ObjectId getItineraryId() {
		return itineraryId;
	}

	public void setItineraryId(ObjectId itineraryId) {
		this.itineraryId = itineraryId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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
	}

	public List<ObjectId> getLikedUsers() {
		return likedUsers;
	}

	public void setLikedUsers(List<ObjectId> likedUsers) {
		this.likedUsers = likedUsers;
	}

	public List<CommentDTO> getComment() {
		return comment;
	}

	public void setComment(List<CommentDTO> comment) {
		this.comment = comment;
	}

	public LocalDateTime getCreateAt() {
		return createAt;
	}

	public void setCreateAt(LocalDateTime createAt) {
		this.createAt = createAt;
	}
    
}	
