package com.visitJapan.dto.response;

import java.util.List;

import org.jsoup.select.Elements;

public class HomeResponseDTO {
	private Elements spotList;
	private Elements restaurantList;
	private List<String> spotImgList;
	private List<String> restaurantImgList;
	
	public HomeResponseDTO(Elements spotList, Elements restaurantList, List<String> spotImgList,
			List<String> restaurantImgList) {
		super();
		this.spotList = spotList;
		this.restaurantList = restaurantList;
		this.spotImgList = spotImgList;
		this.restaurantImgList = restaurantImgList;
	}

	public Elements getSpotList() {
		return spotList;
	}

	public void setSpotList(Elements spotList) {
		this.spotList = spotList;
	}

	public Elements getRestaurantList() {
		return restaurantList;
	}

	public void setRestaurantList(Elements restaurantList) {
		this.restaurantList = restaurantList;
	}

	public List<String> getSpotImgList() {
		return spotImgList;
	}

	public void setSpotImgList(List<String> spotImgList) {
		this.spotImgList = spotImgList;
	}

	public List<String> getRestaurantImgList() {
		return restaurantImgList;
	}

	public void setRestaurantImgList(List<String> restaurantImgList) {
		this.restaurantImgList = restaurantImgList;
	}
	
}
