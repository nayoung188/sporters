package com.gdu.sporters.board.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class FreeImageDTO {
	private int imageNo;	
	private int boardNo;
	private int spoReviewNo;
	private int freeNo;
	private String filesystem;
}
