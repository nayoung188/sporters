package com.gdu.sporters.board.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.gdu.sporters.board.domain.FreeCommDTO;


public interface GalleryFreeCommService {

	public Map<String, Object> getCommentCnt(int freeNo); 
	public Map<String, Object> addComment(FreeCommDTO commContent, HttpServletRequest request);
	public Map<String, Object> getCommentList(HttpServletRequest request);
	public Map<String, Object> removeComment(int freeCoNo);
	public Map<String, Object> addReply(FreeCommDTO reply, HttpServletRequest request);
	
	
	
}
