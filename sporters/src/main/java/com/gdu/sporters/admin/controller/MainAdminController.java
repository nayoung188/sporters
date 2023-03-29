package com.gdu.sporters.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.gdu.sporters.shopAdmin.service.ShopAdminOrderService;

@Controller
public class MainAdminController {
	
	@Autowired
	private ShopAdminOrderService orderService;
	
	@GetMapping("/admin/adminIndex")
	public String requiredAdmin_adminIndex(Model model) {
		model.addAttribute("orderList", orderService.getGragh());
		return "admin/adminIndex";
	}
	
}
