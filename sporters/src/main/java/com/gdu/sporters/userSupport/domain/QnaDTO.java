package com.gdu.sporters.userSupport.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class QnaDTO {
	private int qnaNo;
	private int userNo;
	private String qnaTitle;
	private String qnaId;
	private int qnaPw;
	private String qnaContent;
	private Date qnaCreateDate;
	private int state;
	private int depth;
	private int groupNo;
	private int isPw;
}
