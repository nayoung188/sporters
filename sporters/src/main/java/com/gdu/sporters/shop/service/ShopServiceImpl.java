package com.gdu.sporters.shop.service;

import java.io.File;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;

import com.gdu.sporters.shop.domain.CartDTO;
import com.gdu.sporters.shop.domain.OrderDTO;
import com.gdu.sporters.shop.domain.ProdThumbnailDTO;
import com.gdu.sporters.shop.domain.ProductDTO;
import com.gdu.sporters.shop.mapper.ShopMapper;
import com.gdu.sporters.shop.util.ShopPageUtil;

@Service
public class ShopServiceImpl implements ShopService {

	@Autowired
	private ShopMapper shopMapper;
	
	@Autowired
	private ShopPageUtil shopPageUtil;
	
	@Override
	public void getProductList(HttpServletRequest request, Model model) {
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		int prodCount = shopMapper.selectProductCount();
		shopPageUtil.setPageUtil(page, prodCount);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", shopPageUtil.getBegin() - 1);
		map.put("recordPerPage", shopPageUtil.getRecordPerPage());
		
		
		model.addAttribute("prodCount", prodCount);
		model.addAttribute("productList", shopMapper.selectProductListByMap(map));
		model.addAttribute("beginNo", prodCount - (page - 1) * shopPageUtil.getRecordPerPage());
		model.addAttribute("paging", shopPageUtil.getPaging("/shop/list"));
	}
	
	@Override
	public ProductDTO getProductByNo(int prodNo) {
		return shopMapper.selectProductByNo(prodNo);
	}
	
	@Override
	public void addCart(CartDTO cart) {
		shopMapper.addCart(cart);
	}
	
	@Override
	public void getCartList(Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userNo", model.getAttribute("userNo"));
		
		model.addAttribute("cartList", shopMapper.selectCartListByMap(map));
	}
	
	@Override
	public void deleteCart(CartDTO cart) {
		shopMapper.deleteCart(cart);
	}
	
	@Override
	public List<ProductDTO> getCategoryList(int prodCategoryNo) {
		return shopMapper.categoryList(prodCategoryNo);
	}
	
	@Override
	public ResponseEntity<byte[]> display(int prodNo) {
		
		ProdThumbnailDTO thumbnail = shopMapper.selectProdThumbnailListByNo(prodNo);
		File file = new File(thumbnail.getTnPath(), thumbnail.getTnFilesystem());

		ResponseEntity<byte[]> result = null;
		
		try {

			if(thumbnail.getIsThumbnail() == 1) {
				HttpHeaders headers = new HttpHeaders();
				headers.add("Content-Type", Files.probeContentType(file.toPath()));
				File thumbnailFile = new File(thumbnail.getTnPath(), "s_" + thumbnail.getTnFilesystem());
				result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(thumbnailFile), headers, HttpStatus.OK);
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public Map<String, Object> isSameProdNo(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("prodNo", shopMapper.selectProdNo(map) != null);
		return result;
	}
	
	@Override
	@Transactional
	public void addOrder(OrderDTO order, CartDTO cart, Model model) {
		Optional<Integer> opt = Optional.ofNullable(shopMapper.selectOrderNo());
		int cartMax = opt.orElse(1);
		
		List<String> cartNoArray = (List<String>)model.getAttribute("cartNo");
		
		for(int i = 0; i < 1; i++) {
			order.setCartBundle(cartMax + 1);
			for(int j = 0; j < cartNoArray.size(); j++) {
				order.setCartNo(Integer.parseInt(cartNoArray.get(j)));
				cart.setCartNo(Integer.parseInt(cartNoArray.get(j)));
				cart.setCartNo(cart.getCartNo());
				cart.setUserNo(cart.getUserNo());
				shopMapper.insertOrder(order);
				shopMapper.updateCartState(cart);
				// shopMapper.deleteCart(cart);
			}
		}
		
	}
	
	@Override
	public int updateStock(ProductDTO product) {
		return shopMapper.updateStock(product);
	}
	
	@Override
	public void getOrderList(Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userNo", model.getAttribute("userNo"));
		
		model.addAttribute("orderList", shopMapper.selectOrderList(map));
		model.addAttribute("name", model.getAttribute("name"));
	}
	
	@Override
	public void getOrderDetail(HttpServletRequest request, Model model) {
		int orderNo = Integer.parseInt(request.getParameter("orderNo"));
		
		model.addAttribute("order", shopMapper.selectOrderDetail(orderNo));
		model.addAttribute("name", model.getAttribute("name"));
	}
	
}
