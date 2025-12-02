package com.visitJapan.dto.response;

import java.util.List;

import org.jsoup.select.Elements;

public class SpotDTO {
	private Elements spotList;
	private List<String> spotImgList;
	
	public SpotDTO() {}
	
	public SpotDTO(Elements spotList, List<String> spotImgList) {
		super();
		this.spotList = spotList;
		this.spotImgList = spotImgList;
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
	
}
