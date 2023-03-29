package com.gdu.sporters.shop.domain;

import com.gdu.sporters.users.domain.UsersDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class CartDTO {
	private int cartNo;
	private int userNo;
	private int prodNo;
	private int prodCnt;
	private int cartState;
	private ProductDTO product;
	private UsersDTO users;
	private OrderDTO order;
}
