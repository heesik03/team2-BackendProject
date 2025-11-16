package com.visitJapan.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.visitJapan.dao.LoginDAO;

@WebServlet("/login.do")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LoginDAO loginDAO = new LoginDAO();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        String userId  = loginDAO.checkUser(email, password); // 아이디, 비밀번호 검증
        
		if (userId != null) {
		    HttpSession session = request.getSession();
		    session.setMaxInactiveInterval(6 * 10 * 60); // 1시간
		    session.setAttribute("id", userId);    
		    response.sendRedirect("index.jsp"); 
		} else {
			request.setAttribute("message", "아이디나 비밀번호가 다릅니다.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("pages/login.jsp");
			dispatcher.forward(request, response);
		}
	}

}
