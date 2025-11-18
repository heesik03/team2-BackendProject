package com.visitJapan.controller.mypage;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.visitJapan.dao.itinerary.GetItineraryDAO;
import com.visitJapan.dto.db.ItineraryDTO;


@WebServlet("/mypage/show-itinerary.do")
public class showItineraryController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		GetItineraryDAO getItineraryDAO = new GetItineraryDAO();
		String itineraryId = request.getParameter("id"); // 일정의 id 파라메터 가져옴
		
		ItineraryDTO itineraryData = getItineraryDAO.findItineraryData(itineraryId);
		if (itineraryData != null) {
			itineraryData.setUserId(null); // userId는 필요 없음으로 null
			request.setAttribute("itineraryData", itineraryData);
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/mypage/show-itinerary.jsp");
		dispatcher.forward(request, response); 	
	}

}
