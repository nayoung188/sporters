package com.gdu.sporters.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.sporters.admin.domain.SingoCategoryDTO;
import com.gdu.sporters.admin.domain.SingoDTO;

@Mapper
public interface SingoMapper {
	
	public List<SingoCategoryDTO> selectSingoCategoryList();
	public int selectSingoCategoryCnt();
	public int insertSingoCategory(SingoCategoryDTO category);
	public int deleteSingoCategory(int prodCategoryNo);
	public int selectSingoCount();
	public List<SingoDTO> selectSingoList();
	public int insertSingo(SingoDTO singo);
	public int adminUpdateSingo(SingoDTO singo);
}
