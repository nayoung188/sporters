package com.gdu.sporters.board.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.gdu.sporters.board.domain.SpoCommDTO;


public interface GallerySpoCommService {

	public Map<String, Object> getSpoCommentCnt(int spoReviewNo); 
	public Map<String, Object> addSpoComment(SpoCommDTO commContent, HttpServletRequest request);
	public Map<String, Object> getSpoCommentList(HttpServletRequest request);
	public Map<String, Object> removeSpoComment(int spoReviewNo);
	public Map<String, Object> addSpoReply(SpoCommDTO reply, HttpServletRequest request);
	
	
	
}
