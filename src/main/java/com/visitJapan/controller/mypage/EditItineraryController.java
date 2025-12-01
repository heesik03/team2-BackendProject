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

import com.visitJapan.dao.itinerary.GetItineraryDAO;
import com.visitJapan.dao.itinerary.UpdateItineraryDAO;
import com.visitJapan.dao.users.get.GetUserDAO;
import com.visitJapan.dto.db.ItineraryDTO;
import com.visitJapan.dto.db.SpotListDTO;
import com.visitJapan.dto.db.UsersDTO;

@WebServlet("/mypage/edit-itinerary.do")
public class EditItineraryController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GetUserDAO getUserDAO = new GetUserDAO();
		GetItineraryDAO getItineraryDAO = new GetItineraryDAO();
		
		ObjectId userId = (ObjectId) request.getSession().getAttribute("id"); // 유저 아이디
		String itineraryId = request.getParameter("id"); // 일정의 id 파라메터
		
		UsersDTO userData = getUserDAO.findUserData(userId);
		ItineraryDTO itineraryData = getItineraryDAO.findItineraryData(itineraryId);
		
		if (userData != null && itineraryData != null) {
			
			JSONArray spotListArr = new JSONArray();
			// 기존에 입력했던 관광지를 js에 보내기 위해 json으로 파싱하는 과정
			for (SpotListDTO item : itineraryData.getSpotList()) {
			    JSONObject obj = new JSONObject();
			    obj.put("day", item.getDay());
			    obj.put("city", item.getCity());

			    // spots(List<String>) → JSONArray
			    JSONArray spotsArr = new JSONArray();
			    for (String s : item.getSpots()) {
			        spotsArr.put(s);
			    }

			    obj.put("spots", spotsArr);

			    spotListArr.put(obj);
			}

			// JSP에 spotList JSON 전달
			request.setAttribute("spotListJson", spotListArr.toString());
			// JSP에 전달
			itineraryData.setUserId(null); // userId는 필요 없음으로 null
			request.setAttribute("cityList", userData.getCityList());
			request.setAttribute("itineraryData", itineraryData);
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/mypage/editItinerary.jsp");
		dispatcher.forward(request, response); 	
	}
	
	@Override
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
		UpdateItineraryDAO updateItineraryDAO = new UpdateItineraryDAO();
		
	    String body = request.getReader().lines().collect(Collectors.joining()); // js 요청 본문
	    JSONObject json = new JSONObject(body); // json 읽기
	    
		String title = json.getString("title");
	    String startDate = json.getString("start");
	    String endDate = json.getString("end");
	    JSONArray spotList = json.getJSONArray("spotList");
	    ObjectId itineraryId = new ObjectId(json.getString("itineraryId"));
	    
	    boolean result = updateItineraryDAO.putItinerary(title, startDate, endDate, spotList, itineraryId);
		
	    response.setContentType("application/json; charset=UTF-8");
	    
	    JSONObject responseBody = new JSONObject();
		responseBody.put("result", (result ? "success" : "fail")); // 응답 본문
        if (result) {
            response.setStatus(HttpServletResponse.SC_OK); // 200
        } else {
            // 실패 (500)
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 실패 (500)
        }
        response.getWriter().write(responseBody.toString());
	}

}
