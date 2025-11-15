package com.visitJapan.dto.db;

import java.util.List;

// CityDTO를 위한 DTO
public class CityDTO {
    private String cityName;
    private List<String> spots;

    public CityDTO() {}

    public CityDTO(String cityName, List<String> spots) {
        this.cityName = cityName;
        this.spots = spots;
    }

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public List<String> getSpots() {
		return spots;
	}

	public void setSpots(List<String> spots) {
		this.spots = spots;
	}
    
}