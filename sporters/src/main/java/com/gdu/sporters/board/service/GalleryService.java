package com.gdu.sporters.board.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.sporters.board.domain.FreeDTO;

public interface GalleryService {
	
	public void getGalleryList(HttpServletRequest request, Model model);

	public Map<String, Object> saveSummernoteImage(MultipartHttpServletRequest multipartRequest);
	public void saveGallery(HttpServletRequest request, HttpServletResponse response);
	public FreeDTO getGalleryByNo(int freeNo);
	
	public int increaseFreeHit(int freeNo);
//	public ImageDTO getGalleryByNo(int galleryNo);
	public void modifyGallery(HttpServletRequest request, HttpServletResponse response);
	public void removeGallery(HttpServletRequest request, HttpServletResponse response);
//	public Map<String, Object> getLikedUser(HttpServletRequest request);
	
	
//	public ResponseEntity<byte[]> display(int freeNo);
	
}
 