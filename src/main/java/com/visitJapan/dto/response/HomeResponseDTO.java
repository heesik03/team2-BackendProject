package com.visitJapan.dto.response;

import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class HomeResponseDTO {
	private Elements spotList;
	private Elements restaurantList;
	private double yenValue;
	private Element yenDate;
		
	public HomeResponseDTO(Elements spotList, Elements restaurantList, double yenValue, Element yenDate) {
		super();
		this.spotList = spotList;
		this.restaurantList = restaurantList;
		this.yenValue = yenValue;
		this.yenDate = yenDate;
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
	public double getYenValue() {
		return yenValue;
	}
	public void setYenValue(double yenValue) {
		this.yenValue = yenValue;
	}
	public Element getYenDate() {
		return yenDate;
	}
	public void setYenDate(Element yenDate) {
		this.yenDate = yenDate;
	}
	
}
