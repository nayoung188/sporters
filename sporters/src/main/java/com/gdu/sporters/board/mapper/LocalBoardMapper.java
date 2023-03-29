package com.gdu.sporters.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.sporters.board.domain.LocalDTO;
import com.gdu.sporters.board.domain.LocalImageDTO;

@Mapper
public interface LocalBoardMapper {
	public int selectLocalListCnt();
	public List<LocalDTO> selectLocalList(Map<String, Object> map);
	public List<LocalDTO> selectindexThumbNail(Map<String, Object> map);
	
	public List<LocalImageDTO> selectSummernoteImageListInGallery(int localBoardNo);
	public List<LocalImageDTO> selectAllSummernoteImageList();
	public int insertLocal(LocalDTO gallery);
	public int insertSummernoteImage(LocalImageDTO summernote);
	
	public LocalImageDTO selectSThumbNail(int localBoardNo);
	
	// 수정 업뎃
	public int updateLocal(LocalDTO gallery);
	public int updateUserPoint(int userNo);
	
	// 상세
	public LocalDTO selectLocalByNo(int userNo);
	
	
//	public List<LocalDTO> selectFreeByNo(Map<String, Object> map);
	
	public int updateHit(int userNo);
	public int deleteLocalGallery(int localBoardNo);
	
	
}
