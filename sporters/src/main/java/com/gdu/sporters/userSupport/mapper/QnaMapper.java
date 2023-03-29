package com.gdu.sporters.userSupport.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.sporters.userSupport.domain.QnaDTO;

@Mapper
public interface QnaMapper {

	public int selectAllQnaCount();
	public List<QnaDTO> selectAllQnaList(Map<String, Object> map);
	public QnaDTO selectQnaByNo(int qnaNo);
	public QnaDTO selectQnaByPw(Map<String, Object> map);
	public int insertQna (QnaDTO qna);
	public int insertQnaPw(QnaDTO qna);
	public int updateQna (QnaDTO qna);
	public int deleteQna (int qnaNo);

}
