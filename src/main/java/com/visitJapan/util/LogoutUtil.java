package com.visitJapan.util;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LogoutUtil {
	public static void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("id") != null) {
            session.invalidate(); // 세션 무효화
        }
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	} 
}
