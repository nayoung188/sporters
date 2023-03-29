package com.gdu.sporters.users.batch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gdu.sporters.users.service.UsersService;

@EnableScheduling
@Component
public class SleepUsersScheduler {
	
	@Autowired
	private UsersService usersService;
	
	// 매일 새벽 3시, 1분마다 실행
	@Scheduled(cron="0 0 3 * * *")
	public void execute() {
		usersService.sleepUserHandle();
	}

}
