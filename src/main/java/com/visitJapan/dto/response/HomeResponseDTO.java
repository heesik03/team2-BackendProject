package com.visitJapan.dto.response;

public class HomeResponseDTO {
	private SpotDTO spotData;
	private RestaurantDTO restaurantData;
	private WeatherDTO weatherData;
	
    public HomeResponseDTO() {}
    
	public HomeResponseDTO(SpotDTO spotData, RestaurantDTO restaurantData, WeatherDTO weatherData) {
		super();
		this.spotData = spotData;
		this.restaurantData = restaurantData;
		this.weatherData = weatherData;
	}


	public SpotDTO getSpotData() {
		return spotData;
	}

	public void setSpotData(SpotDTO spotData) {
		this.spotData = spotData;
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
