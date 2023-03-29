package com.gdu.sporters.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.sporters.board.domain.FreeCommDTO;

@Mapper
public interface GalleryCommMapper {
	public int selectFreeCommentCnt(int freeNo);
	public int insertFreeComment(FreeCommDTO commContent);
	public List<FreeCommDTO> selectFreeCommentList(Map<String, Object> map);
	public int deleteFreeComment(int freeCoNo);
	public int insertFreeReply(FreeCommDTO reply);
	public int updateCommGroupOrder(FreeCommDTO freeCoNo);
}