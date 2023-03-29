package com.gdu.sporters.shopAdmin.controller;

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

import com.gdu.sporters.shop.domain.ProdCategoryDTO;
import com.gdu.sporters.shopAdmin.service.ShopAdminCateService;

@Controller
public class shopAdmProdCateController {

	@Autowired
	private ShopAdminCateService shopAdminCateService;
	
	// 카테고리 관리 페이지 이동
	@GetMapping("/shopAdmin/categoryManage")
	public String requiredAdmin_categoryManage(HttpServletRequest request, Model model) {
		return "shopAdmin/prodCategoryMng";
	}
	
	// 카테고리 리스트 띄우기
	@ResponseBody
	@GetMapping(value="/shopAdmin/getCategoryList"
				, produces=MediaType.APPLICATION_JSON_VALUE)
	public List<ProdCategoryDTO> requiredAdmin_categoryList() {
		return shopAdminCateService.getCategoryList();
	}
	
	// 카테고리 등록
	@ResponseBody
	@PostMapping(value="/shopAdmin/categoryAdd")
	public String requiredAdmin_categoryAdd(HttpServletRequest request) {
		shopAdminCateService.addCategory(request);
		return "/shopAdmin/getCategoryList";
	}
	
	// 카테고리 삭제
	@ResponseBody
	@GetMapping(value="/shopAdmin/categoryRemove")
	public void requireAdmin_categoryRemove(HttpServletRequest request, HttpServletResponse response) {
		shopAdminCateService.deleteCategory(request, response);
	}
}
