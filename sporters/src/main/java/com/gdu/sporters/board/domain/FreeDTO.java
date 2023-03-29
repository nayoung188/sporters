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
public class FreeDTO {
	private int freeNo;
	private String title;
	private String content;
	private Date createDate;
	private int hit;
	private int userNo;
	private int state;
	private String ip;
	private Date modifyDate;
	private UsersDTO users;
}
