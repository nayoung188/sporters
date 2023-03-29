package com.gdu.sporters.admin.aop;

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

import com.gdu.sporters.users.domain.UsersDTO;


@EnableAspectJAutoProxy
@Component
@Aspect
public class RequireAdminAop {
	
	@Pointcut("execution(* com.gdu.sporters.admin.controller.*Controller.requiredAdmin_*(..))")	
	public void requiredAdmin() {}
	
	@Before("requiredAdmin()") // 포인트컷 실행 전에 requiredLogin() 메소드 실행
	public void requiredAdminAspect(JoinPoint joinPoint) throws Throwable{
		
		ServletRequestAttributes servletWebRequest = (ServletRequestAttributes)RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = servletWebRequest.getRequest();
		HttpServletResponse response = servletWebRequest.getResponse();
		
		
		// 세션
		HttpSession session = request.getSession();
		UsersDTO user = (UsersDTO) session.getAttribute("loginUser");
		// 로그인 여부 확인
		if(user == null || !user.getId().equals("admin")) {
			
	       response.setContentType("text/html; charset=UTF-8");
	         PrintWriter out = response.getWriter();
	            
            out.println("<script>");
            out.println("if(confirm('접근 권한 밖입니다. 정상적인 경로를 이용해주세요.')) {");
            out.println("location.href='/';");
            out.println("} else {");
            out.println("history.back();");
            out.println("}");
            out.println("</script>");

            out.close();
		
		}
		
		
	}
	
	
	
	
	
}