package com.gdu.sporters.board.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.sporters.board.domain.LocalDTO;

public interface GalleryLocalService {
	
	public void getLocalGalleryList(HttpServletRequest request, Model model);
	public void selectindexThumbNail(HttpServletRequest request, Model model);
	
	public Map<String, Object> saveSummernoteImage(MultipartHttpServletRequest multipartRequest);
	public void saveLocalGallery(HttpServletRequest request, HttpServletResponse response);
	public LocalDTO getLocalGalleryByNo(int localBoardNo);
	
	
	public int increaseLocalHit(int localBoardNo);
//	public ImageDTO getGalleryByNo(int galleryNo);
	public void modifyLocalGallery(HttpServletRequest request, HttpServletResponse response);
	public void removeLocalGallery(HttpServletRequest request, HttpServletResponse response);
//	public Map<String, Object> getLikedUser(HttpServletRequest request);
	
	
//	public ResponseEntity<byte[]> display(int freeNo);
	
}
 