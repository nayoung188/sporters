package com.gdu.sporters.users.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.sporters.users.domain.RetireUsersDTO;
import com.gdu.sporters.users.domain.SleepUsersDTO;
import com.gdu.sporters.users.domain.UsersDTO;

@Mapper
public interface UsersMapper {
	
	public UsersDTO selectUsersByMap(Map<String, Object> map);
	public RetireUsersDTO selectRetireUsersById(String id);
	public SleepUsersDTO selectSleepUserById(String id);
	public int updateAccessLog(int userNo);
	public int insertAccessLog(int userNo);
	public int updateSessionInfo(UsersDTO user);
	public int insertUser(UsersDTO user);
	public int insertNaverUser(UsersDTO user);
	public int insertSleepUser();
	public int deleteUserForSleep();
	public int insertComebackUser(SleepUsersDTO user);
	public int deleteSleepUser(String id);
	public int updateUser(UsersDTO user);
	public int updateUserPassword(UsersDTO user);
	public int deleteUser(int userNo);
	public int insertWithdrawUser(RetireUsersDTO retireUser);

}
