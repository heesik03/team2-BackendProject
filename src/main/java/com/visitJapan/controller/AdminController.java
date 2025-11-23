package com.visitJapan.controller;

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

import com.visitJapan.dao.users.delete.DeleteUserDAO;
import com.visitJapan.dao.users.get.GetAllUserDAO;
import com.visitJapan.dao.users.post.AdminGrantDAO;
import com.visitJapan.dto.db.UsersDTO;


@WebServlet("/admin.do")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GetAllUserDAO getAllUserDAO = new GetAllUserDAO();
		ObjectId userId = (ObjectId) request.getSession().getAttribute("id");
		
		List<UsersDTO> userList = getAllUserDAO.getUserList(userId);
		
		if (userList != null) {
			request.setAttribute("userList", userList);
			RequestDispatcher dispatcher = request.getRequestDispatcher("pages/admin.jsp");
			dispatcher.forward(request, response); 	
		} else {
			response.sendRedirect("index.jsp"); // 유저 목록을 불러오지 못했거나 관리자가 아니면 index.jsp로
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminGrantDAO adminGrantDAO = new AdminGrantDAO();
		String userId = request.getParameter("userId");

		adminGrantDAO.changeRole(userId); // 일반 사용자에게 관리자 권한 부여
		
	    response.sendRedirect(request.getContextPath() + "/admin.do");
	}


	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DeleteUserDAO deleteUserDAO = new DeleteUserDAO();
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=UTF-8");
	    
	    String body = request.getReader().lines().collect(Collectors.joining()); // js 요청 본문
	    JSONObject json = new JSONObject(body); // json 읽기
	    
	    String userId = json.getString("userId");
	    ObjectId id = new ObjectId(userId);
	    ObjectId myId = (ObjectId) request.getSession().getAttribute("id"); // 현재 로그인 중인 유저의 id
	    
	    if (id != myId) { // 자기 자신이 아니라면
		    boolean result = deleteUserDAO.removeUser(id);
		    
		    if (result) {
        			System.out.println(id + " 회원 탈퇴 완료");
		    		response.setStatus(HttpServletResponse.SC_NO_CONTENT); // 204
		    } else {
		        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500
		        response.getWriter().write(
		            "{\"status\":\"error\", \"message\":\"유저 삭제 실패\"}"
		        );
		    }
		 
	    } else {
	        response.setStatus(HttpServletResponse.SC_FORBIDDEN); // 403
	        response.setContentType("application/json; charset=UTF-8");
	        response.getWriter().write(
	            "{\"status\":\"forbidden\", \"message\":\"본인은 삭제할 수 없습니다.\"}"
	        );
	    }
	}

}
