package com.gdu.sporters.board.domain;

import java.sql.Date;

import com.gdu.sporters.users.domain.UsersDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class FreeCommDTO {
	private int freeCoNo;
	private int freeNo;
	private String commContent;
	private Date createDate;
	private int state;
	private int depth;
	private int groupNo;
	private int groupOrder;
	private int userNo;
	private UsersDTO users;
}
