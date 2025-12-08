package com.visitJapan.dao.community;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.visitJapan.dto.db.CommunityDTO;
import com.visitJapan.dto.response.CommunityListDTO;
import com.visitJapan.util.MongoConnectUtil;

public class GetCommunityListDAO {
	
	public List<CommunityListDTO> allList() {
		
		List<CommunityListDTO> communityList = new ArrayList<>();;
		try {
            MongoDatabase database = MongoConnectUtil.getConnection();
            MongoCollection<CommunityDTO> communityCollection = database.getCollection("community", CommunityDTO.class);
            
            FindIterable<CommunityDTO> allCommunity = communityCollection.find();
            
            for (CommunityDTO community : allCommunity) {
                // DTO 매핑
                CommunityListDTO dto = new CommunityListDTO();
                dto.setId(community.getId());
                dto.setTitle(community.getTitle());
                dto.setAuthorName(community.getUserName());
                dto.setCreateAt(community.getCreateAt());

                communityList.add(dto);
            }
            
            Collections.reverse(communityList); // 반대로 뒤집음
            
		} catch (Exception e) {
            e.printStackTrace();
        } finally {
            MongoConnectUtil.close();
        }
        return communityList;
	}
}
