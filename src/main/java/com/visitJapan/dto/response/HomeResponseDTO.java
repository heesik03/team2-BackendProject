package com.visitJapan.dto.response;

import java.util.List;

import org.jsoup.select.Elements;

public class HomeResponseDTO {
	private Elements spotList;
	private List<String> spotImgList;
	private RestaurantDTO restaurantData;
	private WeatherDTO weatherData;
	
    public HomeResponseDTO() {}

	public HomeResponseDTO(Elements spotList, List<String> spotImgList, RestaurantDTO restaurantData,
			WeatherDTO weatherData) {
		super();
		this.spotList = spotList;
		this.spotImgList = spotImgList;
		this.restaurantData = restaurantData;
		this.weatherData = weatherData;
	}

	public Elements getSpotList() {
		return spotList;
	}

	public void setSpotList(Elements spotList) {
		this.spotList = spotList;
	}

	public List<String> getSpotImgList() {
		return spotImgList;
	}

	public void setSpotImgList(List<String> spotImgList) {
		this.spotImgList = spotImgList;
	}

	public RestaurantDTO getRestaurantData() {
		return restaurantData;
	}

	public void setRestaurantData(RestaurantDTO restaurantData) {
		this.restaurantData = restaurantData;
	}

	public WeatherDTO getWeatherData() {
		return weatherData;
	}

	public void setWeatherData(WeatherDTO weatherData) {
		this.weatherData = weatherData;
	}

	
}
