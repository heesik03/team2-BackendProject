package com.visitJapan.dto.response;

import org.jsoup.select.Elements;

public class HomeResponseDTO {
	private Elements spotList;
	private Elements restaurantList;
	
	public HomeResponseDTO(Elements spotList, Elements restaurantList) {
		super();
		this.spotList = spotList;
		this.restaurantList = restaurantList;
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
}
