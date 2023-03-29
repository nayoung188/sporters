package com.gdu.sporters.shop.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.sporters.shop.domain.CartDTO;
import com.gdu.sporters.shop.domain.OrderDTO;
import com.gdu.sporters.shop.domain.ProdCategoryDTO;
import com.gdu.sporters.shop.domain.ProdThumbnailDTO;
import com.gdu.sporters.shop.domain.ProductDTO;

@Mapper
public interface ShopMapper {
	public List<ProductDTO> selectProductListByMap(Map<String, Object> map);
	public int selectProductCount();
	public ProductDTO selectProductByNo(int prodNo);
	public int addCart(CartDTO cart);
	public List<CartDTO> selectCartListByMap(Map<String, Object> map);
	public int deleteCart(CartDTO cart);
	public List<ProductDTO> categoryList(int prodCategoryNo);
	public ProdThumbnailDTO selectProdThumbnailListByNo(int prodNo);
	public CartDTO selectProdNo(Map<String, Object> map);
	public int insertOrder(OrderDTO order);
	public int updateCartState(CartDTO cart);
	
	public int updateStock(ProductDTO product);
	public List<OrderDTO> selectOrderList(Map<String, Object> map);
	public OrderDTO selectOrderDetail(int OrderNo);
	public Integer selectOrderNo();
	public ProdCategoryDTO selectCategoryList();
	
}
