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
public class ProductDTO {
	private int prodNo;
	private int prodCategoryNo;
	private String prodName;
	private int price;
	private int discount;
	private String prodContent;
	private String origin;
	private int stock;
	private Date prodCreateDate;
	private ProdCategoryDTO prodCategory;
	private ProdThumbnailDTO prodThumbnail;
}
