package com.gdu.sporters.board.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.sporters.board.domain.LocalDTO;
import com.gdu.sporters.board.domain.SpoReviewDTO;

public interface GallerySpoReviewService {
	
	public void getSpoReviewGalleryList(HttpServletRequest request, HttpSession session, Model model);
	public void selectindexThumbNail(HttpServletRequest request, Model model);
	
	public Map<String, Object> saveSummernoteImage(MultipartHttpServletRequest multipartRequest);
	
	public void saveSpoReviewGallery(HttpServletRequest request, HttpServletResponse response);
	public void lattersaveSpoReviewGallery(HttpServletRequest request, HttpServletResponse response);
	
	public LocalDTO getLocalGalleryByNo(int localBoardNo);
	public SpoReviewDTO getSpoReviewGalleryByNo(int spoReviewNo);
	
	
	public int increaseSpoReviewHit(int localBoardNo);
	public int increaselatterSpoReviewHit(int spoReviewNo);
//	public ImageDTO getGalleryByNo(int galleryNo);
	
	
	public void modifylatterSpoReviewGallery(HttpServletRequest request, HttpServletResponse response);
	public void modifySpoReviewGallery(HttpServletRequest request, HttpServletResponse response);
	public void removeSpoReviewGallery(HttpServletRequest request, HttpServletResponse response);
//	public Map<String, Object> getLikedUser(HttpServletRequest request);
	
	
//	public ResponseEntity<byte[]> display(int freeNo);
	
}
 