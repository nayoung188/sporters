package com.gdu.sporters.userSupport.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdu.sporters.userSupport.domain.QnaReplyDTO;
import com.gdu.sporters.userSupport.mapper.QnaReplyMapper;

@Service
public class QnaReplyServiceImpl implements QnaReplyService {

	@Autowired
	private QnaReplyMapper qnaReplyMapper;

	@Override
	public Map<String, Object> addQnaReply(QnaReplyDTO reply, HttpServletRequest request) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isAdd", qnaReplyMapper.insertReply(reply));
		return result;
	}
	
	@Override
	public Map<String, Object> getQnaReplyList(HttpServletRequest request) {
		int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("qnaNo", qnaNo);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("qnaReplyList", qnaReplyMapper.selectReplyList(map));
		
		return result;
	}
	
	@Override
	public Map<String, Object> removeQnaReply(int qnaReplyNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isRemove", qnaReplyMapper.deleteReply(qnaReplyNo));
		return result;
	}
	
	
	
	
	
	
}
