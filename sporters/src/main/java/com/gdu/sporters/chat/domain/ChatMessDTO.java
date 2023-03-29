package com.gdu.sporters.chat.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class ChatMessDTO {
	private int messID;
	private String messContent;
	private Date recMessTime;
	private int userNo;
	private int chatRoomId;
}
