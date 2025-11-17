package com.visitJapan.dto.db;

import java.time.LocalDateTime;
import java.util.List;

import org.bson.types.ObjectId;

public class ItineraryDTO {
	private ObjectId id;
	private ObjectId userId; // 입력한 유저의 ID
    private String title;
    private String startDate;
    private String endDate;
    private List<DayPlanDTO> spotList;
    private	LocalDateTime createAt;
    
    public ItineraryDTO () {}

	public ItineraryDTO(ObjectId id, ObjectId userId, String title, String startDate, String endDate,
			List<DayPlanDTO> spotList, LocalDateTime createAt) {
		super();
		this.id = id;
		this.userId = userId;
		this.title = title;
		this.startDate = startDate;
		this.endDate = endDate;
		this.spotList = spotList;
		this.createAt = createAt;
	}

	public ObjectId getId() {
		return id;
	}

	public void setId(ObjectId id) {
		this.id = id;
	}

	public ObjectId getUserId() {
		return userId;
	}

	public void setUserId(ObjectId userId) {
		this.userId = userId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public List<DayPlanDTO> getSpotList() {
		return spotList;
	}

	public void setSpotList(List<DayPlanDTO> spotList) {
		this.spotList = spotList;
	}

	public LocalDateTime getCreateAt() {
		return createAt;
	}

	public void setCreateAt(LocalDateTime createAt) {
		this.createAt = createAt;
	}
    
    
}
