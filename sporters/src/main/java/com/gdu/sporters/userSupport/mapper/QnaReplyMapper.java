package com.gdu.sporters.userSupport.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.sporters.userSupport.domain.QnaReplyDTO;

@Mapper
public interface QnaReplyMapper {

	public List<QnaReplyDTO> selectReplyList(Map<String, Object> map);
	public int insertReply(QnaReplyDTO reply);
	public int updateGroupNo(QnaReplyDTO reply);
	public int deleteReply(int qnaReplyNo);
}
