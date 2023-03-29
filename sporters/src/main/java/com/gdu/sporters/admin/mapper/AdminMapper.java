package com.gdu.sporters.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.sporters.users.domain.UsersDTO;

@Mapper
public interface AdminMapper {
	
	public int selectAllUsersCount();
	public List<UsersDTO> selectAllUsers();
	public List<UsersDTO> selectAllUsersByQuery(Map<String, Object> map);
	public List<UsersDTO> selectUserByNo(int userNo);
	public int deleteUser(Map<String, Object> userNo);
	public int insertRetireUser(Map<String, Object> map2);
//	public List<UsersDTO> selectUserByNo(Map<String, Object> userNo);
	public UsersDTO selectUserByNo2(int userNo);
	
	
}
