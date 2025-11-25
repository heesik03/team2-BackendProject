package com.visitJapan.controller.mypage;

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

import com.visitJapan.dao.users.delete.DeleteCityDAO;
import com.visitJapan.dao.users.get.GetUserDAO;
import com.visitJapan.dto.db.UsersDTO;

@WebServlet("/mypage.do")
public class MyPageController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GetUserDAO getUserDAO = new GetUserDAO();
		ObjectId userId = (ObjectId) request.getSession().getAttribute("id"); // 유저 아이디
		
		UsersDTO userData = getUserDAO.findUserData(userId);
		if (userData != null)
			request.setAttribute("userData", userData);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("pages/mypage/mypage.jsp");
		dispatcher.forward(request, response); 	
	}
	
	
	@Override
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DeleteCityDAO deleteCityDAO = new DeleteCityDAO();
	    request.setCharacterEncoding("UTF-8");
	    
	    String body = request.getReader().lines().collect(Collectors.joining()); // js 요청 본문
	    JSONObject json = new JSONObject(body); // json 읽기

	    String spot = json.getString("spot");
	    String city = json.getString("city");
	    ObjectId userId = (ObjectId) request.getSession().getAttribute("id");
	    
	    boolean result = deleteCityDAO.removeSpot(spot, city, userId);
	    
	    response.setContentType("application/json; charset=UTF-8");
	    if (result) {
	    		response.setStatus(HttpServletResponse.SC_NO_CONTENT); // 204
	    } else {
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500
	        response.getWriter().write(
	            "{\"status\":\"error\", \"message\":\"도시 또는 관광지 삭제 실패\"}"
	        );
	    }
	}

}