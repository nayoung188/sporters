package com.gdu.sporters.users.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class UsersDTO {
	private int userNo;
	private String id;
	private String nickname;
	private String pw;
	private String name;
	private String gender;
	private String email;
	private String mobile;
	private String birthyear;
	private String birthmonth;
	private String birthday;
	private String postcode;
	private String roadAddress;
	private String jibunAddress;
	private String detailAddress;
	private int agreeCode;
	private String snsType;
	private Date joinDate;
	private Date infoModifyDate;
	private Date pwModifyDate;
	private String sessionId;
	private Date sessionLimitDate;
	private int bannedState;
}
