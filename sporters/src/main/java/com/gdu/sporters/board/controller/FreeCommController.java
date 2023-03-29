package com.gdu.sporters.board.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.sporters.board.domain.FreeCommDTO;
import com.gdu.sporters.board.service.GalleryFreeCommService;

@Controller
public class FreeCommController {

	@Autowired
	private GalleryFreeCommService galleryCommService;
	
	@ResponseBody//(ajax반환한거니까)
	@GetMapping(value="/galleryFreeComm/getCount", produces="application/json")
	public Map<String, Object> getCount(@RequestParam("freeNo") int freeNo) {
		return galleryCommService.getCommentCnt(freeNo);
	}
	
	@ResponseBody
	@PostMapping(value="/galleryFreeComm/add", produces="application/json")
	public Map<String, Object> add(FreeCommDTO commContent, HttpServletRequest request) {
		
		return galleryCommService.addComment(commContent, request);
	}
	
	@ResponseBody
	@GetMapping(value="/galleryFreeComm/list", produces="application/json")
	public Map<String, Object> list(HttpServletRequest request) {
		return galleryCommService.getCommentList(request);
	}
	
	@ResponseBody
	@PostMapping(value="/galleryFreeComm/remove", produces="application/json")
	public Map<String, Object> remove(@RequestParam("freeCoNo") int freeCoNo){
		return galleryCommService.removeComment(freeCoNo);
	}
	
	@ResponseBody
	@PostMapping(value="/galleryFreeComm/reply/add", produces="application/json")
	public Map<String, Object> replyAdd(FreeCommDTO reply, HttpServletRequest request){
		return galleryCommService.addReply(reply, request);
	}
	
	
	
}
