package com.gdu.sporters.shop.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gdu.sporters.shop.domain.CartDTO;
import com.gdu.sporters.shop.domain.OrderDTO;
import com.gdu.sporters.shop.domain.ProductDTO;
import com.gdu.sporters.shop.service.ShopService;
import com.gdu.sporters.users.domain.UsersDTO;

@Controller
public class ShopController {

	@Autowired
	private ShopService shopService;
	
	@GetMapping(value="/shop/list", produces="application/json")
	public String list(HttpServletRequest request, Model model) {
		shopService.getProductList(request, model);
		return "shop/list";
	}
	
	@GetMapping("/shop/detail")
	public String detail(@RequestParam(value="prodNo", required=false) int prodNo, Model model) {
		model.addAttribute("product", shopService.getProductByNo(prodNo));
		return "shop/detail";
	}
	
	@ResponseBody
	@RequestMapping(value="/shop/addCart", method=RequestMethod.POST)
	public int requiredShopLogin_addCart(CartDTO cart, HttpSession session) {
		int result = 0;
		
		UsersDTO loginUser = (UsersDTO)session.getAttribute("loginUser");
		if(loginUser != null) {
			cart.setUserNo(loginUser.getUserNo());
			shopService.addCart(cart);
			result = 1;
		}
		
		return result;
	}
	
	@GetMapping(value="/shop/cartList", produces="application/json")
	public String requiredShopLogin_getCartList(HttpSession session, Model model) {
		UsersDTO loginUser = (UsersDTO)session.getAttribute("loginUser");
		int userNo = loginUser.getUserNo();
		model.addAttribute("userNo", userNo);
		shopService.getCartList(model);
		return "shop/cartList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/cartList/priceAll", method = RequestMethod.POST)	
	public int priceAll(@RequestParam("priceAll") int priceAll) {
		return priceAll;
	}
	
	@ResponseBody
	@RequestMapping(value = "/shop/deleteCart", method = RequestMethod.POST)
	public int requiredShopLogin_deleteCart(HttpSession session, @RequestParam("checkOne[]") List<String> checkOne, CartDTO cart) throws Exception {
		UsersDTO loginUser = (UsersDTO)session.getAttribute("loginUser");
		int userNo = loginUser.getUserNo();
		int result = 0;
		int cartNo = 0;
		if(loginUser != null) {
			cart.setUserNo(userNo);
			for(String i : checkOne) {  
				cartNo = Integer.parseInt(i);
				cart.setCartNo(cartNo);
				shopService.deleteCart(cart);
				}   
			result = 1;
			}
		return result;  
	}
	
	@ResponseBody
	@RequestMapping(value = "/cartList/sameAdd", method = RequestMethod.POST)	
	public OrderDTO requiredShopLogin_sameAdd(HttpSession session, OrderDTO order) {
		UsersDTO loginUser = (UsersDTO)session.getAttribute("loginUser");
		String name = loginUser.getName();
		String mobile = loginUser.getMobile();
		String postcode = loginUser.getPostcode();
		String roadAddress = loginUser.getRoadAddress();
		String jibunAddress = loginUser.getJibunAddress();
		String detailAddress = loginUser.getDetailAddress();
		order.setName(name);
		order.setMobile(mobile);
		order.setPostcode(postcode);
		order.setRoadAddress(roadAddress);
		order.setJibunAddress(jibunAddress);
		order.setDetailAddress(detailAddress);
		return order;
	}
	
	@ResponseBody
	@GetMapping(value="/cartList/sameProdNo", produces="application/json")
	public Map<String, Object> checkSameProdNo(@RequestParam(value="prodNo", required=false) int prodNo, Map<String, Object> map, HttpSession session) {
		UsersDTO loginUser = (UsersDTO)session.getAttribute("loginUser");
		int userNo = loginUser.getUserNo();
		map.put("userNo", userNo);
		map.put("prodNo", prodNo);
		return shopService.isSameProdNo(map);
	}
	
	@RequestMapping(value = "/shop/categoryList", method = RequestMethod.GET)
	public void getList(@RequestParam(value="prodCategoryNo", required=false) int prodCategoryNo, Model model) throws Exception {
		List<ProductDTO> list = null;
		list = shopService.getCategoryList(prodCategoryNo);
 
		model.addAttribute("list", list);
	 }
	
	@ResponseBody
	@GetMapping("/shop/prod/display")
	public ResponseEntity<byte[]> display(@RequestParam int prodNo){
		return shopService.display(prodNo);
	}
	
	@ResponseBody
	@RequestMapping(value="/shop/addOrder", method=RequestMethod.POST)
	public int requiredShopLogin_addOrder(OrderDTO order, CartDTO cart, HttpSession session, Model model
									, @RequestParam("cartNo[]") List<String> cartNo
									, @RequestParam("name") String name
									, @RequestParam("mobile") String mobile
									, @RequestParam("postcode") String postcode
									, @RequestParam("roadAddress") String roadAddress
									, @RequestParam("jibunAddress") String jibunAddress
									, @RequestParam("detailAddress") String detailAddress) {
		int result = 0;
		UsersDTO loginUser = (UsersDTO)session.getAttribute("loginUser");
		if(loginUser != null) { 
			int userNo = loginUser.getUserNo();
			order.setUserNo(userNo);
			cart.setUserNo(userNo);
			model.addAttribute("cartNo", cartNo);
			shopService.addOrder(order, cart, model);
			result = 1;
		}
		
		return result;
	}
	
	@PostMapping("/shop/updateStock")
	public void updateStock(ProductDTO product
						  , @RequestParam("stock[]") List<String> stock
						  , @RequestParam("prodNo[]") List<String> prodNo) {
		for(int i = 0; i < stock.size(); i++) {
			product.setStock(Integer.parseInt(stock.get(i)));
			product.setProdNo(Integer.parseInt(prodNo.get(i)));
			shopService.updateStock(product);
		}
	}
	
	@GetMapping("/shop/orderList")
	public String requiredShopLogin_orderList(HttpSession session, Model model) {
		UsersDTO loginUser = (UsersDTO)session.getAttribute("loginUser");
		String name = loginUser.getName();
		int userNo = loginUser.getUserNo();
		model.addAttribute("name", name);
		model.addAttribute("userNo", userNo);
		shopService.getOrderList(model);
		return "shop/orderList";
	}
	
	@GetMapping("/shop/order/detail")
	public String requiredShopLogin_shopOrderDetail(HttpSession session, HttpServletRequest request, Model model) {
		UsersDTO loginUser = (UsersDTO)session.getAttribute("loginUser");
		String name = loginUser.getName();
		model.addAttribute("name", name);
		shopService.getOrderDetail(request, model);
		return "shop/orderDetail";
	}
	
}
