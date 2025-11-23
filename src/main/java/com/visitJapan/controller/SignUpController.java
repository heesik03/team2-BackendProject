package com.visitJapan.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.ArrayList;

import com.visitJapan.dao.users.get.EmailCheckDAO;
import com.visitJapan.dao.users.post.SignUpDAO;
import com.visitJapan.dto.db.UsersDTO;
import com.visitJapan.util.HashUtil;

@WebServlet("/signup.do")
public class SignUpController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");

        EmailCheckDAO dao = new EmailCheckDAO();
        boolean exists = dao.emailExists(email);

        // JSON 결과 만들기
        String resultJson;
        if (exists) {
            resultJson = "{\"result\":\"exists\"}";
        } else {
            resultJson = "{\"result\":\"ok\"}";
        }

        response.setContentType("application/json; charset=UTF-8");
        response.getWriter().write(resultJson);
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		try {
			SignUpDAO signupDAO = new SignUpDAO();
			RequestDispatcher dispatcher = request.getRequestDispatcher("pages/signup.jsp");
			
			String name = request.getParameter("name");
		    String email = request.getParameter("email");
		    String password = request.getParameter("password");
		    String city = request.getParameter("city");
		    
		    String confirmPassword = request.getParameter("confirm_password");
		    LocalDateTime seoulDate = ZonedDateTime.now(ZoneId.of("Asia/Seoul")).toLocalDateTime(); // 서울 시간대
		    
		    if (!password.equals(confirmPassword)) {
			    	request.setAttribute("error", "암호와 확인용 암호가 다릅니다.");
			    	dispatcher.forward(request, response); 
			    	return;
		    }
			String hashPassword = HashUtil.hashPassword(password);
			
	        UsersDTO signUpData = new UsersDTO
	        		(null, name, email, hashPassword, city, new ArrayList<>(), false, seoulDate);
	        boolean signupResult = signupDAO.createUser(signUpData);
	        
	        if (signupResult) {
		        	System.out.println(email + " 회원가입 성공!");
		        	response.sendRedirect("index.jsp");
	        } else {
			    	request.setAttribute("error", "서버 문제로 회원가입 실패");
			    	dispatcher.forward(request, response); 
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}