package com.gdu.sporters.users.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface HeartService {
	public Map<String, Object> isHeartCheck(HttpServletRequest request);
	public Map<String, Object> getHeartCheck(HttpServletRequest request);
	public Map<String, Object> getHeartCount(int userNo);
	public Map<String, Object> getHateCount(int userNo);
	public Map<String, Object> markLike(HttpServletRequest request);
	public Map<String, Object> markhate(HttpServletRequest request);
	public Map<String, Object> likeNhate(int userNo);
	
	
//	public void updateLove(int userNo);
//	public void cancelLove(int userNo);
//	public void updateHate(int userNo);
//	public void cancelHate(int userNo);
}
