package com.gdu.sporters.shop.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class ProdThumbnailDTO {
	private int tnNo;
	private int prodNo;
	private String tnPath;
	private String tnOrigin;
	private String tnFilesystem;
	private int isThumbnail;
}
