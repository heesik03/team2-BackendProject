package com.visitJapan.dto.db;

import java.time.LocalDateTime;
import java.util.List;

import org.bson.types.ObjectId;

public class UsersDTO {
	private ObjectId id;
	private String userName;
	private String email;
	private String password;
	private String likeCity;
	private List<CityDTO> cityList;
	private boolean admin;
	private	LocalDateTime createAt;
	
	public UsersDTO() {}
	
	public UsersDTO(ObjectId id, String userName, String email, String password, String likeCity,
			List<CityDTO> cityList, boolean admin, LocalDateTime createAt) {
		super();
		this.id = id;
		this.userName = userName;
		this.email = email;
		this.password = password;
		this.likeCity = likeCity;
		this.cityList = cityList;
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



	public String getLikeCity() {
		return likeCity;
	}



	public void setLikeCity(String likeCity) {
		this.likeCity = likeCity;
	}



	public List<CityDTO> getCityList() {
		return cityList;
	}



	public void setCityList(List<CityDTO> cityList) {
		this.cityList = cityList;
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
