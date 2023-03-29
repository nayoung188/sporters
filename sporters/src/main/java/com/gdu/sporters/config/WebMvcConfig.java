package com.gdu.sporters.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.gdu.sporters.shopAdmin.util.ShopAdminFileUtil;
import com.gdu.sporters.users.interceptor.KeepLoginInterceptor;
import com.gdu.sporters.users.interceptor.PreventLoginInterceptor;
import com.gdu.sporters.users.interceptor.SleepUserCheckingInterceptor;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
	
	private ShopAdminFileUtil myFileUtil;
	private KeepLoginInterceptor keepLoginInterceptor;
	private PreventLoginInterceptor preventLoginInterceptor;
	private SleepUserCheckingInterceptor sleepUserCheckingInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(preventLoginInterceptor)
				.addPathPatterns("/users/login")
				.addPathPatterns("/users/join/form")
				.addPathPatterns("/users/agree/form");
		registry.addInterceptor(keepLoginInterceptor)
				.addPathPatterns("/**");
		registry.addInterceptor(sleepUserCheckingInterceptor)
			.addPathPatterns("/users/login");
	}
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/load/image/**")
			.addResourceLocations("file:" + myFileUtil.getSummernotePath() + "/");
	}
	
}
