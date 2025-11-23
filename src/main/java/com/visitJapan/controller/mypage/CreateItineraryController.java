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
import org.json.JSONArray;
import org.json.JSONObject;

import com.visitJapan.dao.itinerary.CreateItineraryDAO;
import com.visitJapan.dao.users.get.GetUserDAO;
import com.visitJapan.dto.db.UsersDTO;

@WebServlet("/mypage/create-itinerary.do")
public class CreateItineraryController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GetUserDAO getUserDAO = new GetUserDAO();
		ObjectId userId = (ObjectId) request.getSession().getAttribute("id"); // 유저 아이디
		
		UsersDTO userData = getUserDAO.findUserData(userId);
		// 선호 관광지만 보내기
		if (userData != null)
			request.setAttribute("cityList", userData.getCityList());
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/mypage/createItinerary.jsp");
		dispatcher.forward(request, response); 	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CreateItineraryDAO createItineraryDAO = new CreateItineraryDAO();
		request.setCharacterEncoding("UTF-8");

	    String body = request.getReader().lines().collect(Collectors.joining()); // js 요청 본문
	    JSONObject json = new JSONObject(body); // json 읽기
	    
	    ObjectId userId = (ObjectId) request.getSession().getAttribute("id");
		String title = json.getString("title");
	    String startDate = json.getString("start");
	    String endDate = json.getString("end");
	    JSONArray spotList = json.getJSONArray("spotList");
	    
	    boolean result = createItineraryDAO.appendSpotList(userId, title, startDate, endDate, spotList);
	    String responseBody = "{\"result\": \"" + (result ? "success" : "fail") + "\"}";
	    
        response.setContentType("application/json; charset=UTF-8");
        if (result) {
            response.setStatus(HttpServletResponse.SC_CREATED); // 201
            response.getWriter().write(responseBody);
        } else {
            // 실패 (500)
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 실패 (500)
            response.getWriter().write(responseBody);
        }
	}

}
