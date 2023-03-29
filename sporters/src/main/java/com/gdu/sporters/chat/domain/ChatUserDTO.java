package com.gdu.sporters.chat.domain;

import com.gdu.sporters.users.domain.UsersDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class ChatUserDTO {
	private int chatRoomId;
	private int userNo;
	private UsersDTO user;
}
