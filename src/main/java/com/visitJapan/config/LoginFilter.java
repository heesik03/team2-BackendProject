package com.visitJapan.config;

//
//import java.io.IOException;
//
//import jakarta.servlet.*;
//import jakarta.servlet.annotation.WebFilter;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//
//@WebFilter("/secure/*")
//public class LoginFilter implements  Filter {
//	private static final long serialVersionUID = 1L;
//	
//  public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
//          throws IOException, ServletException {
//      HttpServletRequest request = (HttpServletRequest) req;
//      HttpServletResponse response = (HttpServletResponse) res;
//
//      HttpSession session = request.getSession(false);
//      if (session == null) {
//          response.sendRedirect("/login.jsp");
//          return;
//      }
//
//      chain.doFilter(req, res); // 로그인 되어있으면 다음 단계로
//  }
//}


