package com.gdu.sporters.userSupport.aop;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@EnableAspectJAutoProxy
@Component
@Aspect
public class RequireLoginAspectUserSupport {
	
	@Pointcut("execution(* com.gdu.sporters.userSupport.controller.*Controller.requiredUserSuppLogin_*(..))")
	public void requiredLogin() {}
	
	@Before("requiredLogin()")
	public void requiredLoginHandler(JoinPoint joinPoint) throws Throwable {
		
		// 로그인이 되어 있는지 확인하기 위해서 session이 필요하므로 request가 필요하다.
		ServletRequestAttributes servletRequestAttr = (ServletRequestAttributes)RequestContextHolder.getRequestAttributes();
		
		HttpServletRequest request = servletRequestAttr.getRequest();
		HttpServletResponse response = servletRequestAttr.getResponse();
		
		// 세션
		HttpSession session = request.getSession();
		
		// 로그인 여부 확인
		if(session.getAttribute("loginUser") == null) {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
				
			out.println("<script>");
			out.println("if(confirm('로그인이 필요한 기능입니다. 로그인 하시겠습니까?')) {");
			out.println("location.href='/users/login/form';");
			out.println("} else {");
			out.println("history.back();");
			out.println("}");
			out.println("</script>");
			out.close();
			
		}
	
	}
}
