package com.gdu.sporters.board.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.sporters.board.service.GalleryLocalService;
import com.gdu.sporters.board.service.GallerySpoReviewService;


@Controller
public class BoardSpoController {	
	
	@Autowired
	private GallerySpoReviewService gallerySpoReviewService;
	
	
	@Autowired
	private GalleryLocalService galleryLocalService;
	
	
	@GetMapping(value="/spo_review/list")
	public String spo_reviewList(HttpServletRequest request, HttpSession session, Model model) {
		galleryLocalService.getLocalGalleryList(request, model);
		gallerySpoReviewService.getSpoReviewGalleryList(request, session, model);
		return "community/spo_review/list";
	}
	
	
	@GetMapping("/spo_review/write")
	public String spo_reviewWrite() {
		return "community/spo_review/write";
	}
	
	
	
	@GetMapping("/spo_review/increase/hit")
	public String increaseHit(@RequestParam(value="localBoardNo", required=false, defaultValue="0") int localBoardNo) { // 꼭 필요하지만 혹시 안 올수 있으니까
		int result = gallerySpoReviewService.increaseSpoReviewHit(localBoardNo);
		
		
		if(result > 0) { // 조회수 증가 성공하면 상세보기로 이동
			return "redirect:/spo_review/detail?localBoardNo=" + localBoardNo;			
		} else {		 // 조회수 증가 실패하면 목록으로 이동
			return "redirect:/spo_review/list";
		}
	}
	
	@GetMapping("/latterSpo_review/increase/hit")
	public String increaselatterSpoReviewHit(@RequestParam(value="spoReviewNo", required=false, defaultValue="0") int spoReviewNo) { // 꼭 필요하지만 혹시 안 올수 있으니까
		int result = gallerySpoReviewService.increaselatterSpoReviewHit(spoReviewNo);
		
		
		if(result > 0) { // 조회수 증가 성공하면 상세보기로 이동
			return "redirect:/latterSpo_review/detail?spoReviewNo=" + spoReviewNo;			
		} else {		 // 조회수 증가 실패하면 목록으로 이동
			return "redirect:/spo_review/list";
		}
	}
	
	
	
	
	@PostMapping("/spo_review/add")
	public void add(HttpServletRequest request, HttpServletResponse response) {
		gallerySpoReviewService.saveSpoReviewGallery(request, response);
	}
	
	@PostMapping("/latterSpo_review/add")
	public void latterAdd(HttpServletRequest request, HttpServletResponse response) {
		gallerySpoReviewService.saveSpoReviewGallery(request, response);
	}
	

	@ResponseBody // ajax
	@PostMapping(value="/spo_review/uploadImage", produces = "application/json")
	public Map<String, Object> uploadImage(MultipartHttpServletRequest multipartRequest){
		return gallerySpoReviewService.saveSummernoteImage(multipartRequest);
	}
	
	
	
	
	
	
	

	
	@GetMapping("/spo_review/detail") // model에다 실어놓으면 수정하기 할때 재활용이 X
	public String detail(@RequestParam(value="localBoardNo", required=false, defaultValue="0") int localBoardNo,HttpServletRequest request, Model model) {
		model.addAttribute("LocalgalleryList", gallerySpoReviewService.getLocalGalleryByNo(localBoardNo));
	//	galleryService.getGalleryList(request, model);
		return "community/spo_review/detail";
	}
	
	

	@GetMapping("/latterSpo_review/detail") // model에다 실어놓으면 수정하기 할때 재활용이 X
	public String latterSpo_reviewdetail(@RequestParam(value="spoReviewNo", required=false, defaultValue="0") int spoReviewNo,HttpServletRequest request, Model model) {
		model.addAttribute("SpoReviewgalleryList", gallerySpoReviewService.getSpoReviewGalleryByNo(spoReviewNo));
	//	galleryService.getGalleryList(request, model);
		return "community/spo_review/latterDetail";
	}
	
	

	@PostMapping("/spo_review/edit")
	public String edit(int localBoardNo, Model model) {
		model.addAttribute("gallery", gallerySpoReviewService.getLocalGalleryByNo(localBoardNo));
		return "community/spo_review/edit";
	}
	
	@PostMapping("/latterSpo_review/edit")
	public String latteredit(int spoReviewNo, Model model) {
		model.addAttribute("gallery", gallerySpoReviewService.getSpoReviewGalleryByNo(spoReviewNo));
		return "community/spo_review/edit";
	}
	
	
	@PostMapping("/spo_review/modify")
	public void modify(HttpServletRequest request, HttpServletResponse response) {
		gallerySpoReviewService.modifySpoReviewGallery(request, response); // 수정 후 상세보기로
	}
	
	
	
	
	
	@PostMapping("/spo_review/remove")
	public void remove(HttpServletRequest request, HttpServletResponse response) {
		gallerySpoReviewService.removeSpoReviewGallery(request, response); // 수정 후 목록보기로
	}
	
	
	
	
	
	
	
}