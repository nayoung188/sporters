package com.gdu.sporters.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.sporters.board.domain.SpoCommDTO;

@Mapper
public interface GallerySpoCommMapper {
	public int selectFreeCommentCnt(int spoReviewNo);
	public int insertFreeComment(SpoCommDTO commContent);
	public List<SpoCommDTO> selectFreeCommentList(Map<String, Object> map);
	public int deleteFreeComment(int spoReviewNo);
	public int insertFreeReply(SpoCommDTO reply);
	public int updateCommGroupOrder(SpoCommDTO spoReviewNo);
}