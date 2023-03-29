package com.gdu.sporters.admin.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface AdminService {
	
	public int getAllUsersCount(HttpServletRequest request);
	public Map<String, Object> getAllUsers(HttpServletRequest request);
	public Map<String, Object> searchUsersbyQuery(HttpServletRequest request);
	public Map<String, Object> removeUsers(HttpServletRequest request, Map<String, Object> parameterMap);
//	public void removeUsers(HttpServletResponse response, HttpServletRequest request ); 
	public void removeFreeBoardList(HttpServletRequest request, HttpServletResponse response);

}
