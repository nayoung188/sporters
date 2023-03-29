package com.gdu.sporters.userSupport.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.gdu.sporters.userSupport.domain.QnaReplyDTO;

public interface QnaReplyService {
	
	public Map<String, Object> getQnaReplyList(HttpServletRequest request);
	public Map<String, Object> addQnaReply(QnaReplyDTO reply, HttpServletRequest request);
	public Map<String, Object> removeQnaReply(int qnaReplyNo);

}
