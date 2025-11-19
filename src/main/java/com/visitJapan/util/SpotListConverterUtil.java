package com.visitJapan.util;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.visitJapan.dto.db.SpotListDTO;

public class SpotListConverterUtil {
	
    public static List<SpotListDTO> fromJSONArray(JSONArray spotList) {
        List<SpotListDTO> dayPlan = new ArrayList<>();

	    for (int i = 0; i < spotList.length(); i++) {
	        JSONObject dayObj = spotList.getJSONObject(i);

	        String day = dayObj.getString("day");
	        JSONArray spotsArray = dayObj.getJSONArray("spots");

	        List<String> spots = new ArrayList<>();
	        for (int j = 0; j < spotsArray.length(); j++) {
	            spots.add(spotsArray.getString(j));
	        }

	        SpotListDTO dto = new SpotListDTO(day, spots);
	        dayPlan.add(dto);
	    }
	    
        return dayPlan;
    }
}
