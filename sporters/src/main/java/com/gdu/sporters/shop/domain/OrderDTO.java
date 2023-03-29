package com.gdu.sporters.shop.domain;

import java.sql.Date;

import com.gdu.sporters.users.domain.UsersDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class OrderDTO {
	private int orderNo;
	private int userNo;
	private int cartBundle; // 카트묶음
	private int cartNo;
	private int payment;
	private int priceAll; // 전체가격
	private int prodCnt;
	private String orderState; // 주문상태
	private String name;
	private String mobile;
	private String postcode;
	private String roadAddress;
	private String jibunAddress;
	private String detailAddress;
	private Date orderDate;
	private UsersDTO users;
	private CartDTO cart;
}
