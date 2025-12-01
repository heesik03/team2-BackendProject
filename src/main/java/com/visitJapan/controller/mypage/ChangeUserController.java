package com.visitJapan.controller.mypage;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.stream.Collectors;

import org.bson.types.ObjectId;
import org.json.JSONObject;

import com.visitJapan.dao.users.delete.DeleteUserDAO;
import com.visitJapan.dao.users.post.ChangePasswordDAO;
import com.visitJapan.dao.users.put.ChangeUserInfoDAO;
import com.visitJapan.util.LogoutUtil;

@WebServlet("/mypage/change.do")
public class ChangeUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ChangePasswordDAO changePasswordDAO = new ChangePasswordDAO();
		RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/mypage/changeInfo.jsp");
		
		ObjectId userId = (ObjectId) request.getSession().getAttribute("id"); // 유저 아이디
		String currentPassword = request.getParameter("currentPassword");
	    String newPassword = request.getParameter("newPassword");
	    String confirmPassword = request.getParameter("confirmPassword");
	    
	    if (!newPassword.equals(confirmPassword)) {
		    	request.setAttribute("pwdError", "암호와 확인용 암호가 다릅니다.");
		    	dispatcher.forward(request, response); 
		    	return;
	    } 
	    
	    String result = changePasswordDAO.updatePwd(userId, currentPassword, newPassword);
	    
	    // 비밀번호 변경 성공 시, 로그아웃
	    if (result == null) {
	    		LogoutUtil.logout(request, response); 
	    } else {
	    		// 실패 시 오류 return
		    	request.setAttribute("pwdError", result); 
		    	dispatcher.forward(request, response); 
	    }
	}


	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ChangeUserInfoDAO changeUserInfoDAO = new ChangeUserInfoDAO();
		request.setCharacterEncoding("UTF-8");

	    String body = request.getReader().lines().collect(Collectors.joining()); // js 요청 본문
	    JSONObject requestBody = new JSONObject(body); // json 읽기
	    
	    ObjectId userId = (ObjectId) request.getSession().getAttribute("id"); // 유저 아이디
		boolean isName = requestBody.getBoolean("isName"); // true면 닉네임, false면 선호 도시를 변경
		String newData = requestBody.getString("data"); // 바꿀 데이터
		
		boolean result = changeUserInfoDAO.updateUserInfo(userId, isName, newData);
				
        if (result) {
            response.setStatus(HttpServletResponse.SC_NO_CONTENT); // 204
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 실패 (500)
        }
	}


	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DeleteUserDAO deleteUserDAO = new DeleteUserDAO();
		request.setCharacterEncoding("UTF-8");
		
		ObjectId userId = (ObjectId) request.getSession().getAttribute("id");
		
		boolean result = deleteUserDAO.removeUser(userId);
		
        if (result) {
        		System.out.println(userId + " 회원 탈퇴 완료");
        		HttpSession session = request.getSession(false);
                if (session != null && session.getAttribute("id") != null) {
                    session.invalidate(); // 세션 무효화
            }
            response.setStatus(HttpServletResponse.SC_NO_CONTENT); // 204
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 실패 (500)
        }
	}

}
