package com.visitJapan.dto.db;

import java.time.LocalDateTime;
import org.bson.types.ObjectId;

public class CommentDTO {
	private ObjectId commentId; // 댓글의 ID
	private ObjectId authorId; // 댓글을 작성한 유저의 ID
	private String authorName; // 댓글을 작성한 유저의 닉네임
    private String commentContent;
    private	LocalDateTime commentCreateAt;
    
    public CommentDTO() {}

	public CommentDTO(ObjectId commentId, ObjectId authorId, String authorName, String commentContent,
			LocalDateTime commentCreateAt) {
		super();
		this.commentId = commentId;
		this.authorId = authorId;
		this.authorName = authorName;
		this.commentContent = commentContent;
		this.commentCreateAt = commentCreateAt;
	}

	public ObjectId getCommentId() {
		return commentId;
	}

	public void setCommentId(ObjectId commentId) {
		this.commentId = commentId;
	}

	public ObjectId getAuthorId() {
		return authorId;
	}

	public void setAuthorId(ObjectId authorId) {
		this.authorId = authorId;
	}

	public String getAuthorName() {
		return authorName;
	}

	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	public LocalDateTime getCommentCreateAt() {
		return commentCreateAt;
	}

	public void setCommentCreateAt(LocalDateTime commentCreateAt) {
		this.commentCreateAt = commentCreateAt;
	};
    
    
    
}
