package com.visitJapan.dto.db;

import java.util.List;

public class DayPlanDTO {
    private String day;
    private List<String> spots;
    
    public DayPlanDTO() {}

	public DayPlanDTO(String day, List<String> spots) {
		super();
		this.day = day;
		this.spots = spots;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public List<String> getSpots() {
		return spots;
	}
	public void setSpots(List<String> spots) {
		this.spots = spots;
	}
    
    
}
