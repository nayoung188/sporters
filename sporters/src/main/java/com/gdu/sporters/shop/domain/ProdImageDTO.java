package com.gdu.sporters.shop.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class ProdImageDTO {
	private int prodDetailImageNo;
	private int prodNo;
	private String filesystem;
}
