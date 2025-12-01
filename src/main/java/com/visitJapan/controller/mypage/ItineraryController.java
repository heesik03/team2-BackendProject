package com.visitJapan.controller.mypage;

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

import com.visitJapan.dao.itinerary.DeleteItineraryDAO;
import com.visitJapan.dao.itinerary.GetItineraryListDAO;
import com.visitJapan.dto.db.ItineraryDTO;

@WebServlet("/mypage/itinerary.do")
public class ItineraryController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GetItineraryListDAO getUserItineraryDAO = new GetItineraryListDAO();
		ObjectId userId = (ObjectId) request.getSession().getAttribute("id"); // 유저 아이디
		
		List<ItineraryDTO> itineraryList  = getUserItineraryDAO.findItineraryData(userId);
		if (itineraryList != null) {
			request.setAttribute("itineraryList", itineraryList);
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/mypage/itinerary.jsp");
		dispatcher.forward(request, response); 	
	}
	
	@Override
	protected void doDelete(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    request.setCharacterEncoding("UTF-8");
	    DeleteItineraryDAO deleteItinerary = new DeleteItineraryDAO();
	    String body = request.getReader().lines().collect(Collectors.joining()); // js 요청 본문
	    JSONObject json = new JSONObject(body); // json 읽기

	    String itineraryId = json.getString("itineraryId");
	    boolean result = deleteItinerary.removeItinerary(itineraryId);
	    
	    response.setContentType("application/json; charset=UTF-8");
	    if (result) {
	    		response.setStatus(HttpServletResponse.SC_NO_CONTENT); // 204
	    } else {
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500
        		JSONObject responseBody = new JSONObject();
        		responseBody.put("status", "error");
        		responseBody.put("message", "일정 삭제 실패");
        		response.getWriter().write(responseBody.toString());
	    }
	}

}
