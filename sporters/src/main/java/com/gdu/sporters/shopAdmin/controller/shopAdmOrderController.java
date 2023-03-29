package com.gdu.sporters.shopAdmin.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.gdu.sporters.shopAdmin.service.ShopAdminOrderService;

@Controller
public class shopAdmOrderController {

	@Autowired
	private ShopAdminOrderService shopAdminOrderService;
	
	@GetMapping("/shopAdmin/orderManage")
	public String requiredAdmin_shopOrderManage(HttpServletRequest request, Model model) {
		shopAdminOrderService.getOrderList(request, model);
		return "shopAdmin/orderManage";
	}
	
	@GetMapping("/shopAdmin/order/detail")
	public String requiredAdmin_shopOrderDetail(HttpServletRequest request, Model model) {
		shopAdminOrderService.getOrderDetail(request, model);
		return "shopAdmin/orderDetail";
	}
	
	@GetMapping("/shopAdmin/order/state")
	public String requiredAdmin_shopOrderState(HttpServletRequest request) {
		shopAdminOrderService.getOrderState(request);
		return "redirect:/shopAdmin/orderManage";
	}
	
	@GetMapping("/shopAdmin/orderSearch")
	public String requiredAdmin_search(HttpServletRequest request, Model model) {
		shopAdminOrderService.searchOrders(request, model);
		return "shopAdmin/orderManage";
	}
	
	@GetMapping("/shopAdmin/orderGraph")
	public Map<String, Object> graph() {
		return shopAdminOrderService.getGragh();
	}
	
}
