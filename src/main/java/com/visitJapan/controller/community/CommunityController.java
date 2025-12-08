package com.visitJapan.controller.community;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import org.bson.types.ObjectId;
import org.json.JSONObject;

import com.visitJapan.dao.community.AddLikeDAO;
import com.visitJapan.dao.community.CreateCommunityDAO;
import com.visitJapan.dao.community.DeleteCommunityDAO;
import com.visitJapan.dao.community.GetCommunityListDAO;
import com.visitJapan.dao.users.get.GetUserDAO;
import com.visitJapan.dto.db.UsersDTO;
import com.visitJapan.dto.response.CommunityListDTO;


@WebServlet("/community.do")
public class CommunityController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GetCommunityListDAO getCommunityListDAO = new GetCommunityListDAO();
		
		List<CommunityListDTO> communityList = getCommunityListDAO.allList();
		
		request.setAttribute("communityList", communityList);
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/community/community.jsp");
		dispatcher.forward(request, response); 	
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CreateCommunityDAO createCommunityDAO = new CreateCommunityDAO();
		
		ObjectId userId = (ObjectId) request.getSession().getAttribute("id");
		String itineraryId = request.getParameter("id"); 
		String title = request.getParameter("title");
        String content = request.getParameter("content");
        
        boolean result = createCommunityDAO.insert(userId, itineraryId, title, content);
        
        if (result) {
            request.setAttribute("result", "success");
            request.setAttribute("message", "게시글 작성 성공!");
        } else {
            request.setAttribute("result", "fail");
            request.setAttribute("message", "서버 오류로 작성 실패했습니다.");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("pages/community/create.jsp");
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
	        responseBody.put("status", "conflict");
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
	

	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GetUserDAO getUserDAO = new GetUserDAO();
		DeleteCommunityDAO deleteCommunityDAO = new DeleteCommunityDAO();
		
		request.setCharacterEncoding("UTF-8");
	    String body = request.getReader().lines().collect(Collectors.joining()); // js 요청 본문
	    JSONObject json = new JSONObject(body); // json 읽기

	    String id = json.getString("id");
	    ObjectId communityId = new ObjectId(id);
		ObjectId userId = (ObjectId) request.getSession().getAttribute("id");
		
		// 로그인 한 유저가 아닐때
		if (userId == null) {
		    response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
		    return;
		}
		
		JSONObject responseBody = new JSONObject(); // 응답 본문
	    UsersDTO userData = getUserDAO.findUser(userId); // 유저 정보 가져옴
	    if (!userData.isAdmin() && !communityId.equals(userId)) { // 관리자, 작성자 둘 다 아니라면
	        response.setStatus(HttpServletResponse.SC_FORBIDDEN); // 403
	        responseBody.put("status", "error");
	        responseBody.put("message", "삭제 권한이 없습니다.");
	        response.getWriter().write(responseBody.toString());
	        return;
	    }
	    
	    boolean result = deleteCommunityDAO.remove(communityId);
	    
	    response.setContentType("application/json; charset=UTF-8");
	    if (result) {
	    		response.setStatus(HttpServletResponse.SC_NO_CONTENT); // 204
	    } else {
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500
        		responseBody.put("status", "error");
        		responseBody.put("message", "게시글 삭제 실패");
        		response.getWriter().write(responseBody.toString());
	    }
	}
}
