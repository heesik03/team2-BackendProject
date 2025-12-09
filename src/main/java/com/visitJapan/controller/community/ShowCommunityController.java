package com.visitJapan.controller.community;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.stream.Collectors;

import org.bson.types.ObjectId;
import org.json.JSONObject;

import com.visitJapan.dao.community.AddLikeDAO;
import com.visitJapan.dao.community.GetCommunityDAO;
import com.visitJapan.dao.itinerary.GetItineraryDAO;
import com.visitJapan.dto.db.CommunityDTO;
import com.visitJapan.dto.db.ItineraryDTO;
import com.visitJapan.dto.response.PostDTO;
import com.visitJapan.util.DBConfigReader;


@WebServlet("/community/show.do")
public class ShowCommunityController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GetCommunityDAO getCommunityDAO = new GetCommunityDAO();
		GetItineraryDAO getItineraryDAO = new GetItineraryDAO();
		DBConfigReader config = new DBConfigReader(); // dbconfig.properties 연결 class
		
		ItineraryDTO itineraryData = null; // 일정 정보 초깃값
		PostDTO postData = null;
		
		String id = request.getParameter("id");  
		CommunityDTO findCommunity = getCommunityDAO.findData(id); // 게시글 찾음
		if (findCommunity != null) {
			itineraryData = getItineraryDAO.findData(findCommunity.getItineraryId());
			
			// 제목, 작성 기간 변경
			itineraryData.setTitle(findCommunity.getTitle());
			itineraryData.setCreateAt(findCommunity.getCreateAt());
			
			postData = new PostDTO ( // 게시글 정보 담은 DTO
					findCommunity.getId(), 
					findCommunity.getUserId(), 
					findCommunity.getUserName(),
					findCommunity.getContent(),
					findCommunity.getLike());
		}

		request.setAttribute("itineraryData", itineraryData); // 일정 정보
		request.setAttribute("postData", postData); // 게시글 정보
		request.setAttribute("commentList", findCommunity.getComment()); // 댓글 정보
		request.setAttribute("APIKey", config.getGoogleKey()); // 구글 맵 API Key JSP로 전달

		RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/community/showCommunity.jsp");
		dispatcher.forward(request, response); 	
	}


	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AddLikeDAO addLikeDAO = new AddLikeDAO();
		request.setCharacterEncoding("UTF-8");
	    String body = request.getReader().lines().collect(Collectors.joining()); // js 요청 본문
	    JSONObject json = new JSONObject(body); // json 읽기

	    String id = json.getString("id");
		ObjectId userId = (ObjectId) request.getSession().getAttribute("id");
		
		// 로그인 한 유저가 아닐때
		if (userId == null) {
		    response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
		    return;
		}
	    
	    int result = addLikeDAO.plusLike(id, userId);
	    
		JSONObject responseBody = new JSONObject(); // 응답 본문
	    response.setContentType("application/json; charset=UTF-8");
	    switch (result) {
	    case 1: // 좋아요 성공
	        response.setStatus(HttpServletResponse.SC_NO_CONTENT); // 204
	        break;
	    case 0: // 이미 좋아요 누름
	        response.setStatus(HttpServletResponse.SC_CONFLICT); // 409
	        responseBody.put("message", "이미 좋아요를 누르셨습니다.");
	        response.getWriter().write(responseBody.toString());
	        break;
	    case -1: // 서버 오류
	    default:
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500
	        responseBody.put("status", "error");
	        responseBody.put("message", "좋아요 추가 실패");
	        response.getWriter().write(responseBody.toString());
	        break;
	    }
	}

}
