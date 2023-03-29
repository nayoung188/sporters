package com.gdu.sporters.board.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.sporters.board.service.GalleryService;


@Controller
public class BoardController {	
	
	@Autowired
	private GalleryService galleryService;
	
	
	
	/*
	 * @GetMapping("/free/list") public String freeList() { return
	 * "community/free/list"; }
	 */
	

	
	
	@GetMapping(value="/free/list")
	public String freeList(HttpServletRequest request, Model model) {
		galleryService.getGalleryList(request, model);
		return "community/free/list";
	}
	
	@GetMapping("/free/write")
	public String freeWrite() {
		return "community/free/write";
	}

	
	
	
	@PostMapping("/free/add")
	public void add(HttpServletRequest request, HttpServletResponse response) {
		galleryService.saveGallery(request, response);
	}
	

	@ResponseBody // ajax
	@PostMapping(value="/free/uploadImage", produces = "application/json")
	public Map<String, Object> uploadImage(MultipartHttpServletRequest multipartRequest){
		return galleryService.saveSummernoteImage(multipartRequest);
	}
	
	
	
	
	
	
	
	@GetMapping("/free/increase/hit")
	public String increaseHit(@RequestParam(value="freeNo", required=false, defaultValue="0") int freeNo) { // 꼭 필요하지만 혹시 안 올수 있으니까
		int result = galleryService.increaseFreeHit(freeNo);
		
		
		if(result > 0) { // 조회수 증가 성공하면 상세보기로 이동
			return "redirect:/free/detail?freeNo=" + freeNo;			
		} else {		 // 조회수 증가 실패하면 목록으로 이동
			return "redirect:/free/list";
		}
	}
	
	
	@GetMapping("/free/detail") // model에다 실어놓으면 수정하기 할때 재활용이 X
	public String detail(@RequestParam(value="freeNo", required=false, defaultValue="0") int freeNo,HttpServletRequest request, Model model) {
		model.addAttribute("gallery", galleryService.getGalleryByNo(freeNo));
	//	galleryService.getGalleryList(request, model);
		return "community/free/detail";
	}
	
	
	
	
	@PostMapping("/free/edit")
	public String edit(int freeNo, Model model) {
		model.addAttribute("gallery", galleryService.getGalleryByNo(freeNo));
		return "community/free/edit";
	}
	
	
	@PostMapping("/free/modify")
	public void modify(HttpServletRequest request, HttpServletResponse response) {
		galleryService.modifyGallery(request, response); // 수정 후 상세보기로
	}
	
	
	
	
	
	@PostMapping("/free/remove")
	public void remove(HttpServletRequest request, HttpServletResponse response) {
		galleryService.removeGallery(request, response); // 수정 후 목록보기로
	}
	
	
	
	
	
	
	
}