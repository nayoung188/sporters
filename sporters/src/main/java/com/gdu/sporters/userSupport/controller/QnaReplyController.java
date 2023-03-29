package com.gdu.sporters.userSupport.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.sporters.userSupport.domain.QnaReplyDTO;
import com.gdu.sporters.userSupport.service.QnaReplyService;

@Controller
public class QnaReplyController {

	@Autowired
	private QnaReplyService qnaReplyService;
	
	@GetMapping("/qna/replyWrite")
	public String replyWrite() {
		return "/qnaList/qna/replyWrite";
	}
	
	@ResponseBody
	@PostMapping(value="/qna/addReply", produces="application/json")
	public Map<String, Object> addQnaReply(QnaReplyDTO reply, HttpServletRequest request){
		return qnaReplyService.addQnaReply(reply, request);
	}
	
	
	@ResponseBody
	@GetMapping(value="/qna/replyList", produces="application/json")
	public Map<String, Object> list(HttpServletRequest request){
		return qnaReplyService.getQnaReplyList(request);
	}
	
	@ResponseBody
	@PostMapping(value="/qna/replyRemove", produces="application/json")
	public Map<String, Object> remove(@RequestParam("qnaReplyNo") int qnaReplyNo){
		return qnaReplyService.removeQnaReply(qnaReplyNo);
	}
	
	
}
