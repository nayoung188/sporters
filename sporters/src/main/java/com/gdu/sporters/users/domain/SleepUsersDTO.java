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
public class SleepUsersDTO {
	private int userNo;
	private String sleepUserId;
	private String sleepUserPw;
	private String sleepUserNickname;
	private String sleepUserName;
	private String sleepUserGender;
	private String sleepUserEmail;
	private String sleepUserMobile;
	private String sleepUserBirthyear;
	private String sleepUserBirthmonth;
	private String sleepUserBirthday;
	private String postcode;
	private String roadAddress;
	private String jibunAddress;
	private String detailAddress;
	private int agreeCode;
	private String snsType;
	private Date joinDate;
	private Date lastLoginDate;
	private Date sleepDate;
}
