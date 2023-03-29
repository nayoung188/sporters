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
public class SingoDTO {
	private int singoNo;
	private String singoTitle;
	private String singoContent;
	private Date singoCreateDate;
	private int singoHit;
	private int userNo;
	private int freeNo;
}
