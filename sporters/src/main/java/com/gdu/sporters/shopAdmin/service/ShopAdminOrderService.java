package com.gdu.sporters.shopAdmin.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface ShopAdminOrderService {
	public void getOrderList(HttpServletRequest request, Model model);
	public void getOrderDetail(HttpServletRequest request, Model model);
	public void getOrderState(HttpServletRequest request);
	public Map<String, Object> getGragh();
	public void searchOrders(HttpServletRequest request, Model model);
}
