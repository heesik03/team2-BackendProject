package com.visitJapan.controller.community;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.stream.Collectors;

import org.bson.types.ObjectId;
import org.json.JSONObject;

import com.visitJapan.dao.community.CreateCommentDAO;
import com.visitJapan.dao.community.DeleteCommentDAO;
import com.visitJapan.dao.users.get.GetUserDAO;
import com.visitJapan.dto.db.CommentDTO;
import com.visitJapan.dto.db.UsersDTO;


@WebServlet("/community/comment.do")
public class CommentController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CreateCommentDAO createCommentDAO = new CreateCommentDAO();
		request.setCharacterEncoding("UTF-8");
	    String body = request.getReader().lines().collect(Collectors.joining()); // js 요청 본문
	    JSONObject json = new JSONObject(body); // json 읽기

	    String content = json.getString("content");
	    String id = json.getString("id");
	    ObjectId userId = (ObjectId) request.getSession().getAttribute("id");
		
		// 로그인 한 유저가 아닐때
		if (userId == null) {
		    response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
		    return;
		}
		
		CommentDTO commentData = createCommentDAO.pushComment(id, content, userId); // 댓글 생성
		JSONObject responseBody = new JSONObject(); // 응답 본문
		
		if (commentData != null) {
	        response.setStatus(HttpServletResponse.SC_CREATED); // 201
	        responseBody.put("commentId", commentData.getCommentId().toString());
			responseBody.put("authorId", commentData.getAuthorId().toString());
			responseBody.put("authorName", commentData.getAuthorName());
			responseBody.put("commentContent", commentData.getCommentContent());
			responseBody.put("commentCreateAt", commentData.getCommentCreateAt().toString()); // LocalDateTime → 문자열 변환
			response.getWriter().write(responseBody.toString());
		} else {
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500
	    		responseBody.put("status", "error");
	    		responseBody.put("message", "게시글 삭제 실패");
    			response.getWriter().write(responseBody.toString());
		}
	}


	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GetUserDAO getUserDAO = new GetUserDAO();
		DeleteCommentDAO deleteCommentDAO = new DeleteCommentDAO();
		
		request.setCharacterEncoding("UTF-8");
	    String body = request.getReader().lines().collect(Collectors.joining()); // js 요청 본문
	    JSONObject json = new JSONObject(body); // json 읽기

	    String id = json.getString("id"); // 게시글의 id
	    String commentId = json.getString("commentId"); // 댓글의 id
	    String authorId = json.getString("authorId"); // 작성자의 id
	    
		ObjectId userId = (ObjectId) request.getSession().getAttribute("id");
	    ObjectId authorobjectId = new ObjectId(authorId);
		
		// 로그인 한 유저가 아닐때
		if (userId == null) {
		    response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
		    return;
		}

		JSONObject responseBody = new JSONObject(); // 응답 본문
	    UsersDTO userData = getUserDAO.findUser(userId); // 유저 정보 가져옴
	    if (!userData.isAdmin() && !authorobjectId.equals(userId)) { // 관리자, 작성자 둘 다 아니라면
	        response.setStatus(HttpServletResponse.SC_FORBIDDEN); // 403
	        responseBody.put("status", "error");
	        responseBody.put("message", "삭제 권한이 없습니다.");
	        response.getWriter().write(responseBody.toString());
	        return;
	    }
	    
	    boolean result = deleteCommentDAO.remove(id, commentId);
	    
	    response.setContentType("application/json; charset=UTF-8");
	    if (result) {
	    		response.setStatus(HttpServletResponse.SC_NO_CONTENT); // 204
	    } else {
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500
        		responseBody.put("status", "error");
        		responseBody.put("message", "댓글 삭제 실패");
        		response.getWriter().write(responseBody.toString());
	    }
	}

}
