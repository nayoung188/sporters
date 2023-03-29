package com.gdu.sporters.chat.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class ChatLoginInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		if(request.getSession().getAttribute("loginUser") != null) {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("alert('해당 기능은 로그인 후 사용가능합니다.');");
			out.println("location.href='/users/login/form';");
			out.println("</script>");
			out.close();
			
			return false; // 컨트롤러의 요청이 처리되지 않는다.
			
		} else {			
			return true; // 컨트롤러의 요청이 처리된다.
		}
	}
}
