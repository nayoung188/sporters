package com.gdu.sporters.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.sporters.board.domain.SpoReviewDTO;
import com.gdu.sporters.board.domain.LocalDTO;
import com.gdu.sporters.board.domain.LocalImageDTO;
import com.gdu.sporters.board.domain.SpoImageDTO;

@Mapper
public interface SpoReviewMapper {
	public int selectSpoReviewListCnt();
	public List<SpoReviewDTO> selectSpoReviewList(Map<String, Object> map);
	public List<SpoReviewDTO> selectindexThumbNail(Map<String, Object> map);
	
	

	public List<LocalImageDTO> selectSummernoteImageListInGallery(int localBoardNo);
	public List<SpoImageDTO> selectlatterSummernoteImageListInGallery(int spoReviewNo);
	public List<SpoImageDTO> selectAllSummernoteImageList();
	public int insertSpoReview(SpoReviewDTO gallery);
	
	public int insertSummernoteImage(LocalImageDTO summernote);
	public int insertlatterSummernoteImage(SpoImageDTO summernote);
	
	public SpoImageDTO selectSThumbNail(int spoReviewNo);
	
	// 수정 업뎃
	public int updateLocal(LocalDTO gallery);
	public int updateSpoReview(SpoReviewDTO gallery);
	public int updateUserPoint(int userNo);
	
	// 상세
	// 상세
	public LocalDTO selectLocalByNo(int userNo);
	public SpoReviewDTO selectSpoReviewByNo(int userNo);
	
	
//	public List<SpoReviewDTO> selectFreeByNo(Map<String, Object> map);
	
	public int updateHit(int userNo);
	public int latterupdateHit(int userNo);
	
	
	public int deleteSpoReviewGallery(int localBoardNo);
	public int latterdeleteSpoReviewGallery(int spoReviewNo);
	
	public int spoReviewCount(int userNo);
	
}
