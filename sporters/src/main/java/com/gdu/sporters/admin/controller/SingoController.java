package com.gdu.sporters.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.sporters.admin.domain.SingoCategoryDTO;
import com.gdu.sporters.admin.service.SingoService;

@Controller
public class SingoController {
	
	@Autowired
	private SingoService singoService;
	
	
//		// 카테고리 관리 페이지 이동
//		@GetMapping("admin/singoList")
//		public String singoList(HttpServletRequest request, Model model) {
//			return "admin/singoList";
//		}
		
		@ResponseBody
		@GetMapping(value="/admin/getCategoryList", produces=MediaType.APPLICATION_JSON_VALUE)
		public List<SingoCategoryDTO> categoryList() {
			return singoService.getCategoryList();
		}
		
		@ResponseBody
		@PostMapping(value="/admin/addCategory")
		public String addCategory(HttpServletRequest request) {
			singoService.addCategory(request);
			return "admin/getCategoryList";
		}
		
		@ResponseBody
		@GetMapping(value="/admin/removeCategory")
		public void removeCategory(HttpServletRequest request, HttpServletResponse response) {
			singoService.deleteCategory(request, response);
		}
		
		@GetMapping("/admin/singoList")
		public String selectSingoList(HttpServletRequest request, Model model) {
			model.addAttribute("singoList", singoService.getSingoList(request, model));
//			singoService.getSingoList(request, model);
			
			System.out.println(request);
			System.out.println(model);
			return "/admin/singoList";
		}
		
		@PostMapping("free/admin/userSingo")
		public void singoButton(HttpServletRequest request, HttpServletResponse response) {
			singoService.singoButton(request, response);
		}


}
