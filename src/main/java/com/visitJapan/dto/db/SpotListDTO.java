package com.visitJapan.dto.db;

import java.util.List;

public class SpotListDTO {
    private String day;
    private String city;
    private List<String> spots;
    
    public SpotListDTO() {}

	public SpotListDTO(String day, String city, List<String> spots) {
		super();
		this.day = day;
		this.city = city;
		this.spots = spots;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public List<String> getSpots() {
		return spots;
	}

	public void setSpots(List<String> spots) {
		this.spots = spots;
	}
}
