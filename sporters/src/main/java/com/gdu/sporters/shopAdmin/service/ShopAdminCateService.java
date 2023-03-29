package com.gdu.sporters.shopAdmin.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gdu.sporters.shop.domain.ProdCategoryDTO; 

public interface ShopAdminCateService {
	public List<ProdCategoryDTO> getCategoryList();
	public void addCategory(HttpServletRequest request);
	public void deleteCategory(HttpServletRequest request, HttpServletResponse response);
}
