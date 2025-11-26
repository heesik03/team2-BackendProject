package com.visitJapan.dto.response;

import java.util.List;

import org.jsoup.select.Elements;

public class RestaurantDTO {
	private Elements restaurantList;
	private List<String> restaurantImgList;
	

	public RestaurantDTO(Elements restaurantList, List<String> restaurantImgList) {
		super();
		this.restaurantList = restaurantList;
		this.restaurantImgList = restaurantImgList;
	}

	
	public RestaurantDTO() {}

	public Elements getRestaurantList() {
		return restaurantList;
	}

	public void setRestaurantList(Elements restaurantList) {
		this.restaurantList = restaurantList;
	}

	public List<String> getRestaurantImgList() {
		return restaurantImgList;
	}

	public void setRestaurantImgList(List<String> restaurantImgList) {
		this.restaurantImgList = restaurantImgList;
	}

}
