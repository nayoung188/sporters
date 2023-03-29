package com.gdu.sporters.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.sporters.board.domain.LocalCommDTO;

@Mapper
public interface GalleryLocalCommMapper {
	public int selectFreeCommentCnt(int localBoardNo);
	public int insertFreeComment(LocalCommDTO commContent);
	public List<LocalCommDTO> selectFreeCommentList(Map<String, Object> map);
	public int deleteFreeComment(int localBoardNo);
	public int insertFreeReply(LocalCommDTO reply);
	public int updateCommGroupOrder(LocalCommDTO localBoardNo);
}