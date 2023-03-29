package com.gdu.sporters.users.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.gdu.sporters.users.domain.SleepUsersDTO;
import com.gdu.sporters.users.service.UsersService;

@Component
public class SleepUserCheckingInterceptor implements HandlerInterceptor {
	
	@Autowired
	private UsersService usersService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String id = request.getParameter("id");
		SleepUsersDTO sleepUser = usersService.getSleepUsersById(id);
		//System.out.println(sleepUser.getSleepUserId());
		
		HttpSession session = request.getSession();
		session.setAttribute("sleepUser", sleepUser);
		
		if(sleepUser != null) {
			response.sendRedirect("/users/sleep/display");
			return false;
		} else {
			return true;
		}
	}

}
