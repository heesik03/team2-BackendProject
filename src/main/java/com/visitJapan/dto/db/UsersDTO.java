package com.visitJapan.dto.db;

import java.time.LocalDateTime;

import org.bson.types.ObjectId;

public class UsersDTO {
	private ObjectId id;
	private String userName;
	private String email;
	private String password;
	private String city;
	private boolean admin;
	private	LocalDateTime createAt;
	
	public UsersDTO() {}

	public UsersDTO(ObjectId id, String userName, String email, String password, String city, boolean admin,
			LocalDateTime createAt) {
		super();
		this.id = id;
		this.userName = userName;
		this.email = email;
		this.password = password;
		this.city = city;
		this.admin = admin;
		this.createAt = createAt;
	}



	public ObjectId getId() {
		return id;
	}

	public void setId(ObjectId id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public boolean isAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public LocalDateTime getCreateAt() {
		return createAt;
	}

	public void setCreateAt(LocalDateTime createAt) {
		this.createAt = createAt;
	}
	
	
	
}
