package com.gdu.sporters.shop.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class ProdCategoryDTO {
	private int prodCategoryNo;
	private String prodCategoryName;
}
