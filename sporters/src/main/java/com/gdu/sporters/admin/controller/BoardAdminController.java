package com.gdu.sporters.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.gdu.sporters.admin.service.AdminService;
import com.gdu.sporters.board.service.GalleryService;

@Controller
public class BoardAdminController {
	
	@Autowired
	private GalleryService galleryService;
	
	@Autowired
	private AdminService adminService;
	
	// 자유게시판 목록
	@GetMapping(value="admin/adminFreeList")
	public String requiredAdmin_freeList(HttpServletRequest request, Model model) {
		galleryService.getGalleryList(request, model);
		return new String("admin/adminFreeList");
	}
	
	
	// 다중삭제
	@PostMapping(value="/admin/removeFreeList")
	public void requiredAdmin_removeList(HttpServletRequest request, HttpServletResponse response) {
		// removeBoardList() 메소드에 list.jsp로 redirect하는 코드가 있기 때문에 return 없이 void 처리합니다.
		adminService.removeFreeBoardList(request, response);
	}
	
		


}
