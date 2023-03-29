package com.gdu.sporters.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.sporters.board.domain.FreeDTO;
import com.gdu.sporters.board.domain.FreeImageDTO;

@Mapper
public interface BoardMapper {
	public int selectFreeListCnt();
	public List<FreeDTO> selectFreeList(Map<String, Object> map);
	public List<FreeImageDTO> selectSummernoteImageListInGallery(int freeNo);
	public List<FreeImageDTO> selectAllSummernoteImageList();
	public int insertFree(FreeDTO gallery);
	public int insertSummernoteImage(FreeImageDTO summernote);
	
	public FreeImageDTO selectSThumbNail(int freeNo);
	
	// 수정 업뎃
	public int updateFree(FreeDTO gallery);
	public int updateUserPoint(int userNo);
	
	// 상세
	public FreeDTO selectFreeByNo(int userNo);
	
	
//	public List<FreeDTO> selectFreeByNo(Map<String, Object> map);
	
	public int updateHit(int userNo);
	public int deleteFreeGallery(int freeNo);
	
	// 게시판 관리용 다중삭제, (지원추가)
	public int deleteFreeList(List<String> freeNoList);

	
	
}
