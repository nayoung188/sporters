package com.gdu.sporters.userSupport.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gdu.sporters.userSupport.domain.FaqDTO;

@Mapper
public interface FaqMapper {
	public int selectAllFaqCount();
	public List<FaqDTO> selectAllFaqList(Map<String, Object> map);
	public int insertFaq(FaqDTO faq);
	public int updateFaq(FaqDTO faq);
	public int deleteFaq(int faqNo);
}
