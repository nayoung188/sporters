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
public class QnaReplyDTO {
	private int qnaReplyNo;
	private int qnaNo;
	private String qnaReplyContent;
	private Date qnaReplyCreateDate;
	private int state;
	private int depth;
	private int groupNo;
}
