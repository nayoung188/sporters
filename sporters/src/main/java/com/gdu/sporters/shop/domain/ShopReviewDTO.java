package com.gdu.sporters.shop.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class ShopReviewDTO {
	private int reviewNo;
	private int orderNo;
	private double star;
	private String content;
	private Date reviewDate;
}
