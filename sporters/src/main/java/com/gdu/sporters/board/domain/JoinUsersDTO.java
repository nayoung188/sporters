package com.gdu.sporters.board.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class JoinUsersDTO {
	private int userNo;
	private int localBoardNo;
}
