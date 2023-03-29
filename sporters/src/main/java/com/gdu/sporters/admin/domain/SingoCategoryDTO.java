package com.gdu.sporters.admin.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class SingoCategoryDTO {
	private int singoCategoryNo;
	private String singoCategoryName;
}