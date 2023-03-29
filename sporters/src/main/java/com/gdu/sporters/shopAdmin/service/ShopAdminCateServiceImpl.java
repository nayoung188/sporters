package com.gdu.sporters.shopAdmin.service;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gdu.sporters.shop.domain.ProdCategoryDTO;
import com.gdu.sporters.shopAdmin.mapper.ShopAdminCategoryMapper;

@Service
public class ShopAdminCateServiceImpl implements ShopAdminCateService{

	@Autowired
	private ShopAdminCategoryMapper shopAdminCategoryMapper;
	
	@Override
	public List<ProdCategoryDTO> getCategoryList() {
		return shopAdminCategoryMapper.selectCategoryList();
	}
	
	@Override
	public void addCategory(HttpServletRequest request) {
	
		// 파라미터
		String cateName = request.getParameter("cateName");
		
		ProdCategoryDTO category = ProdCategoryDTO.builder()
				.prodCategoryName(cateName)
				.build();
		
		shopAdminCategoryMapper.insertCategory(category);
	}
	
	@Override
	public void deleteCategory(HttpServletRequest request, HttpServletResponse response) {
		
		int prodCategoryNo = Integer.parseInt(request.getParameter("prodCategoryNo"));
		
		// DB에서 카테고리 삭제
		int result = shopAdminCategoryMapper.deleteCategory(prodCategoryNo);
		
		// 응답
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(result > 0) {
				out.println("<script>");
				out.println("alert('카테고리가 정상적으로 삭제 되었습니다.');");
				out.println("location.href='/shopAdmin/categoryManage';");
				
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('카테고리 삭제를 실패했습니다. 다시 시도해 주세요.');");
				out.println("history.back();");
				out.println("</script>");
			}
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
 }
