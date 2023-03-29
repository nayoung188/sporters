package com.gdu.sporters.board.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class AttachDTO {
	private int attachNo;
	private int boardNo;
	private int spoReviewNo;
	private int freeNo;
	private String path;
	private String origin;
	private String filesystem;
	private int downloadCnt;
}
