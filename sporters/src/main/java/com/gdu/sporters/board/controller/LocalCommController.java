package com.gdu.sporters.board.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.sporters.board.domain.LocalCommDTO;
import com.gdu.sporters.board.service.GalleryLocalCommService;

@Controller
public class LocalCommController {

	@Autowired
	private GalleryLocalCommService galleryLocalCommService;
	
	@ResponseBody//(ajax반환한거니까)
	@GetMapping(value="/galleryLocalComm/getCount", produces="application/json")
	public Map<String, Object> getCount(@RequestParam("localBoardNo") int localBoardNo) {
		return galleryLocalCommService.getLocalCommentCnt(localBoardNo);
	}
	
	@ResponseBody
	@PostMapping(value="/galleryLocalComm/add", produces="application/json")
	public Map<String, Object> add(LocalCommDTO commContent, HttpServletRequest request) {
		return galleryLocalCommService.addLocalComment(commContent, request);
	}
	
	@ResponseBody
	@GetMapping(value="/galleryLocalComm/list", produces="application/json")
	public Map<String, Object> list(HttpServletRequest request) {
		return galleryLocalCommService.getLocalCommentList(request);
	}
	
	@ResponseBody
	@PostMapping(value="/galleryLocalComm/remove", produces="application/json")
	public Map<String, Object> remove(@RequestParam("localCoNo") int localCoNo){
		return galleryLocalCommService.removeLocalComment(localCoNo);
	}
	
	@ResponseBody
	@PostMapping(value="/galleryLocalComm/reply/add", produces="application/json")
	public Map<String, Object> replyAdd(LocalCommDTO reply, HttpServletRequest request){
		
		return galleryLocalCommService.addLocalReply(reply, request);
	}
	
	
	
}
