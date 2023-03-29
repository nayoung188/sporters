package com.gdu.sporters.shopAdmin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gdu.sporters.shop.domain.OrderDTO;
import com.gdu.sporters.shopAdmin.mapper.ShopAdminOrderMapper;
import com.gdu.sporters.shopAdmin.util.ShopAdminPageUtil;
import com.gdu.sporters.shopAdmin.util.ShopAdminSearchPageUtil;

@Service
public class ShopAdminOrderServiceImpl implements ShopAdminOrderService {

	@Autowired
	private ShopAdminOrderMapper shopAdminOrderMapper;
	
	@Autowired
	private ShopAdminPageUtil pageUtil;
	
	@Autowired
	private ShopAdminSearchPageUtil searchPageUtil;
	
	@Override
	public void getOrderList(HttpServletRequest request, Model model) {
		// Page 파라미터
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		// 주문개수
		int totalOrderRecord = shopAdminOrderMapper.selectOrderCnt();
		
		// 페이징 처리에필요한 계산
		pageUtil.setPageUtil(page, totalOrderRecord);
		
		// map 생성
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin() - 1);
		map.put("recordPerPage", pageUtil.getRecordPerPage());
		
		// 주문 리스트
		List<OrderDTO> orderList = shopAdminOrderMapper.selectOrderList(map);
		
		model.addAttribute("totalRecord", pageUtil.getRecordPerPage());
		model.addAttribute("orderList", orderList);
		model.addAttribute("beginNo", totalOrderRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("paging", pageUtil.getPaging("/shopAdmin/orderManage"));
	}
	
	@Override
	public void getOrderDetail(HttpServletRequest request, Model model) {
		
		// 파라미터
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));
		
		// mapper로 전달할 map
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orderNo", orderNo);
		
		OrderDTO order = shopAdminOrderMapper.selectOrderDetailByUserNo(map);
		

		model.addAttribute("order", order);
		model.addAttribute("orderInfo", shopAdminOrderMapper.selectOrderProdDetailByUserNo(map));
		
	}
	
	@Override
	public void getOrderState(HttpServletRequest request) {
		
		// 파라미터 받기
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));
		String orderState = request.getParameter("orderState"); 
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orderNo", orderNo);
		map.put("orderState", orderState);
		
		shopAdminOrderMapper.updateOrderState(map);
		
	}
	
	@Override
	public Map<String, Object> getGragh() {
		return shopAdminOrderMapper.selectOrderCountByDay();
	}
	
	@Override
	public void searchOrders(HttpServletRequest request, Model model) {
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		// 검색 대상
		String column = request.getParameter("column");
		// 검색어
		String query = request.getParameter("query");
		
		// 조회와 검색된 사원수를 알아낼 때 사용하는 Map
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("column", column);
		map.put("query", query);
		
		// 검색된 사원수
		int totalRecord = shopAdminOrderMapper.selectSearchCount(map);
		
		// 페이징 계산
		searchPageUtil.setNaverPageUtil(page, totalRecord);
		
		// 조회에서 사용하는 Map
		map.put("begin", searchPageUtil.getBegin());
		map.put("recordPerPage", searchPageUtil.getRecordPerPage());
		
	
		
		// 검색된 주문목록
		List<OrderDTO> orderList = shopAdminOrderMapper.selectSearchOrderList(map);
		
		// search.jsp로 보낼 데이터
		model.addAttribute("orderList", orderList);
		model.addAttribute("beginNo", totalRecord - (page - 1) * searchPageUtil.getRecordPerPage());
		
		String path = "/shopAdmin/orderSearch?column=" + column + "&query=" + query;
	
		model.addAttribute("paging", searchPageUtil.getNaverPaging(path));

		// 검색된 상품 개수
		int totalProdRecord = shopAdminOrderMapper.selectSearchCount(map);
		model.addAttribute("totalRecord", totalProdRecord); // 상품전체갯수
		
	}
}
