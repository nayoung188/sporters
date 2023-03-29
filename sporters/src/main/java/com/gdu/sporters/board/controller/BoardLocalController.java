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

import com.gdu.sporters.board.service.GalleryLocalService;


@Controller
public class BoardLocalController {	
	
	@Autowired
	private GalleryLocalService galleryLocalService;
	
	
	
	@GetMapping(value="/local/list")
	public String localList(HttpServletRequest request, Model model) {
		galleryLocalService.getLocalGalleryList(request, model);
		return "community/local/list";
	}
	
	
	@GetMapping("/local/write")
	public String localWrite() {
		return "community/local/write";
	}
	
	
	
	@PostMapping("/local/add")
	public void add(HttpServletRequest request, HttpServletResponse response) {
		galleryLocalService.saveLocalGallery(request, response);
	}
	

	@ResponseBody // ajax
	@PostMapping(value="/local/uploadImage", produces = "application/json")
	public Map<String, Object> uploadImage(MultipartHttpServletRequest multipartRequest){
		return galleryLocalService.saveSummernoteImage(multipartRequest);
	}
	
	
	
	
	
	
	
	@GetMapping("/local/increase/hit")
	public String increaseHit(@RequestParam(value="localBoardNo", required=false, defaultValue="0") int localBoardNo) { // 꼭 필요하지만 혹시 안 올수 있으니까
		int result = galleryLocalService.increaseLocalHit(localBoardNo);
		
		
		if(result > 0) { // 조회수 증가 성공하면 상세보기로 이동
			return "redirect:/local/detail?localBoardNo=" + localBoardNo;			
		} else {		 // 조회수 증가 실패하면 목록으로 이동
			return "redirect:/local/list";
		}
	}
	
	
	@GetMapping("/local/detail") // model에다 실어놓으면 수정하기 할때 재활용이 X
	public String detail(@RequestParam(value="localBoardNo", required=false, defaultValue="0") int localBoardNo,HttpServletRequest request, Model model) {
		model.addAttribute("LocalgalleryList", galleryLocalService.getLocalGalleryByNo(localBoardNo));
	//	galleryService.getGalleryList(request, model);
		return "community/local/detail";
	}
	
	
	
	
	@PostMapping("/local/edit")
	public String edit(int localBoardNo, Model model) {
		model.addAttribute("gallery", galleryLocalService.getLocalGalleryByNo(localBoardNo));
		return "community/local/edit";
	}
	
	
	@PostMapping("/local/modify")
	public void modify(HttpServletRequest request, HttpServletResponse response) {
		galleryLocalService.modifyLocalGallery(request, response); // 수정 후 상세보기로
	}
	
	
	
	
	
	@PostMapping("/local/remove")
	public void remove(HttpServletRequest request, HttpServletResponse response) {
		galleryLocalService.removeLocalGallery(request, response); // 수정 후 목록보기로
	}
	
	
	
	
	
	
	
}