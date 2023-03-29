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
public class AccessLogDTO {
	private int accessLogNo;
	private int userNo;
	private Date lastLoginDate;
}
