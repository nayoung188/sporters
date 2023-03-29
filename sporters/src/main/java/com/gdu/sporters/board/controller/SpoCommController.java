package com.gdu.sporters.board.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.sporters.board.domain.SpoCommDTO;
import com.gdu.sporters.board.service.GallerySpoCommService;

@Controller
public class SpoCommController {

	@Autowired
	private GallerySpoCommService gallerySpoCommService;
	
	@ResponseBody//(ajax반환한거니까)
	@GetMapping(value="/gallerySpoComm/getCount", produces="application/json")
	public Map<String, Object> getCount(@RequestParam("spoReviewNo") int spoReviewNo) {
		return gallerySpoCommService.getSpoCommentCnt(spoReviewNo);
	}
	
	@ResponseBody
	@PostMapping(value="/gallerySpoComm/add", produces="application/json")
	public Map<String, Object> add(SpoCommDTO commContent, HttpServletRequest request) {
		
		return gallerySpoCommService.addSpoComment(commContent, request);
	}
	
	@ResponseBody
	@GetMapping(value="/gallerySpoComm/list", produces="application/json")
	public Map<String, Object> list(HttpServletRequest request) {
		return gallerySpoCommService.getSpoCommentList(request);
	}
	
	@ResponseBody
	@PostMapping(value="/gallerySpoComm/remove", produces="application/json")
	public Map<String, Object> remove(@RequestParam("spoCoNo") int spoCoNo){
		return gallerySpoCommService.removeSpoComment(spoCoNo);
	}
	
	@ResponseBody
	@PostMapping(value="/gallerySpoComm/reply/add", produces="application/json")
	public Map<String, Object> replyAdd(SpoCommDTO reply, HttpServletRequest request){
		return gallerySpoCommService.addSpoReply(reply, request);
	}
	
	
	
}
