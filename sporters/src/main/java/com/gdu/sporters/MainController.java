package com.gdu.sporters;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.gdu.sporters.board.service.GalleryLocalService;

@Controller
public class MainController {

	
	@Autowired
	private GalleryLocalService galleryLocalService;
	
	@GetMapping(value="/")
	public String index(HttpServletRequest request, Model model) {
		galleryLocalService.selectindexThumbNail(request, model);
		return "index";
	}
	
	/*
	@GetMapping(value="/local/list")
	public String localList(HttpServletRequest request, Model model) {
		galleryLocalService.getLocalGalleryList(request, model);
		return "community/local/list";
	}
	*/
	
	
	
	
	
	
	
}
