package com.gdu.sporters.admin.domain;

import java.sql.Date;

import com.gdu.sporters.board.domain.FreeDTO;
import com.gdu.sporters.users.domain.UsersDTO;

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
	private String singoCategory;
	private String singoTitle;
	private String singoUserReason;
	private String singoLink;
	private Date singoCreateDate;
	private Date singoRemoveDate;
	private String singoReason;
	private int userNo;
	private int freeNo;
	private UsersDTO users;
	private FreeDTO free;
}