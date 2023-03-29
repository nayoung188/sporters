package com.gdu.sporters.shop.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;

import com.gdu.sporters.shop.domain.CartDTO;
import com.gdu.sporters.shop.domain.OrderDTO;
import com.gdu.sporters.shop.domain.ProductDTO;

public interface ShopService {
	public void getProductList(HttpServletRequest request, Model model);
	public ProductDTO getProductByNo(int prodNo);
	public void addCart(CartDTO cart);
	public void getCartList(Model model);
	public void deleteCart(CartDTO cart);
	public List<ProductDTO> getCategoryList(int prodCategoryNo);
	public ResponseEntity<byte[]> display(int prodNo);
	public Map<String, Object> isSameProdNo(Map<String, Object> map);
	public void addOrder(OrderDTO order, CartDTO cart, Model model);
	public int updateStock(ProductDTO product);
	public void getOrderList(Model model);
	public void getOrderDetail(HttpServletRequest request, Model model);
}
