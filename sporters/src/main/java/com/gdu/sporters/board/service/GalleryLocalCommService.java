package com.gdu.sporters.board.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.gdu.sporters.board.domain.LocalCommDTO;


public interface GalleryLocalCommService {

	public Map<String, Object> getLocalCommentCnt(int localBoardNo); 
	public Map<String, Object> addLocalComment(LocalCommDTO commContent, HttpServletRequest request);
	public Map<String, Object> getLocalCommentList(HttpServletRequest request);
	public Map<String, Object> removeLocalComment(int localBoardNo);
	public Map<String, Object> addLocalReply(LocalCommDTO reply, HttpServletRequest request);
	
	
	
}
