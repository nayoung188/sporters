package com.gdu.sporters.board.service;

import java.io.File;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.sporters.board.domain.LocalDTO;
import com.gdu.sporters.board.domain.LocalImageDTO;
import com.gdu.sporters.board.domain.SpoImageDTO;
import com.gdu.sporters.board.domain.SpoReviewDTO;
import com.gdu.sporters.board.mapper.SpoReviewMapper;
import com.gdu.sporters.users.domain.UsersDTO;
import com.gdu.sporters.util.GalleryPageUtil;
import com.gdu.sporters.util.MyFileUtil;

@Service
public class GallerySpoReviewServiceImpl implements GallerySpoReviewService {

	@Autowired
	private SpoReviewMapper spoReviewMapper;
	
	@Autowired
	private MyFileUtil myFileUtil;
	
	
	@Autowired
	private GalleryPageUtil galleryPageUtil;
	
	
	
	@Override
	public void getSpoReviewGalleryList(HttpServletRequest request, HttpSession session, Model model) {

		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));

		
		
		
		HttpSession sessions = request.getSession();
		
		// 로그인 여부 확인
		if(sessions.getAttribute("loginUser") != null) {
			UsersDTO loginUser = (UsersDTO)session.getAttribute("loginUser");
			int userNo = loginUser.getUserNo();
			int totalCount = spoReviewMapper.spoReviewCount(userNo);
			int totalRecord = spoReviewMapper.selectSpoReviewListCnt();
			galleryPageUtil.setPageUtil(page, totalRecord);
			model.addAttribute("totalRecord", totalRecord);
			model.addAttribute("beginNo", totalRecord - (page - 1) * galleryPageUtil.getRecordPerPage());
			model.addAttribute("totalCount", totalCount);
		}
		else {
			
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", galleryPageUtil.getBegin() - 1);
		map.put("recordPerPage", galleryPageUtil.getRecordPerPage());

		List<SpoReviewDTO> SpoReviewgalleryList = spoReviewMapper.selectSpoReviewList(map);

		
		model.addAttribute("SpoReviewgalleryList", SpoReviewgalleryList);
		model.addAttribute("paging", galleryPageUtil.getPaging("/spo_review/list"));
	

	} 
	

	
	
	@Transactional
	@Override
	public void saveSpoReviewGallery(HttpServletRequest request, HttpServletResponse response) {
		String filesystem = request.getParameter("filesystem");

		
		String title = request.getParameter("title");
		String content = request.getParameter("content");	
		int localBoardNo = Integer.parseInt(request.getParameter("localBoardNo"));
		
		Optional<String> opt = Optional.ofNullable(request.getHeader("X-Forwarded-For"));
		String Ip = opt.orElse(request.getRemoteAddr());		
		
		
		
		HttpSession session = request.getSession();
		UsersDTO loginUser = (UsersDTO) session.getAttribute("loginUser");
		
		SpoReviewDTO freeBbs = SpoReviewDTO.builder()
						.title(title)
						.content(content)						
						.ip(Ip)
						.userNo(loginUser.getUserNo())						
						.localBoardNo(localBoardNo)
						.build();
				
		
	

		// DB에 Gallery 저장
		int result = spoReviewMapper.insertSpoReview(freeBbs);
		
		
		// 응답
		try {

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
	
			out.println("<script>");
			if (result > 0) {

				// 파라미터 summernoteImageNames
				String[] summernoteImageNames = request.getParameterValues("summernoteImageNames");
				
				// DB에 SummernoteImage 저장
				if (summernoteImageNames != null) {
				
					for (String summernoteImage : summernoteImageNames) {
						SpoImageDTO summernote = SpoImageDTO.builder()
								.filesystem(summernoteImage)
								.spoReviewNo(freeBbs.getSpoReviewNo())												
								.build();
						spoReviewMapper.insertlatterSummernoteImage(summernote);
			
					}
				}
				
				
			
				out.println("alert('게시글을 등록했습니다.');");
				out.println("location.href='/spo_review/list';");
			} else {
				out.println("alert('게시글을 등록할 수 없습니다.');");
				out.println("history.back();");
			}
			out.println("</script>");
			out.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@Transactional
	@Override
	public void lattersaveSpoReviewGallery(HttpServletRequest request, HttpServletResponse response) {
		String filesystem = request.getParameter("filesystem");
	
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");	
		/*
		String joinStart = request.getParameter("joinStart");
		String joinEnd = request.getParameter("joinEnd");
		*/
		int localNo = Integer.parseInt(request.getParameter("localNo"));
		Optional<String> opt = Optional.ofNullable(request.getHeader("X-Forwarded-For"));
		String Ip = opt.orElse(request.getRemoteAddr());		
		
		
		
		HttpSession session = request.getSession();
		UsersDTO loginUser = (UsersDTO) session.getAttribute("loginUser");
		
		SpoReviewDTO freeBbs = SpoReviewDTO.builder()
						.title(title)
						.content(content)						
						.ip(Ip)
						.userNo(loginUser.getUserNo())
						.localNo(localNo)
					//	.localBoardNo(localNo)
						.build();
			
		
	

		// DB에 Gallery 저장
		int result = spoReviewMapper.insertSpoReview(freeBbs);
		
		
		// 응답
		try {

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
		
			out.println("<script>");
			if (result > 0) {

				// 파라미터 summernoteImageNames
				String[] summernoteImageNames = request.getParameterValues("summernoteImageNames");
				
				// DB에 SummernoteImage 저장
				if (summernoteImageNames != null) {
			
					for (String summernoteImage : summernoteImageNames) {
						SpoImageDTO summernote = SpoImageDTO.builder()
								.filesystem(summernoteImage)
								.spoReviewNo(freeBbs.getSpoReviewNo())												
								.build();
						spoReviewMapper.insertlatterSummernoteImage(summernote);
				
					}
				}
				
				
			
				out.println("alert('게시글을 등록했습니다.');");
				out.println("location.href='/spo_review/list';");
			} else {
				out.println("alert('게시글을 등록할 수 없습니다.');");
				out.println("history.back();");
			}
			out.println("</script>");
			out.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public Map<String, Object> saveSummernoteImage(MultipartHttpServletRequest multipartRequest) {
		// 파라미터 file 꺼내기 (파일을 꺼내는 건 getParameter 하면 안됨)
		MultipartFile multipartFile = multipartRequest.getFile("file");

		// 저장 경로 (separator : 경로 구분자) 윈도우만 쓰려고할 때는 C:\\upload
		String path = myFileUtil.getSummernotePath();
//		String path = "file:"+ File.separator +"///summernoteImage";

		// 저장할 파일 이름
		String filesystem = myFileUtil.getFilename(multipartFile.getOriginalFilename());

		// 저장 경로가 없으면 만들기
		File dir = new File(path);
		if (dir.exists() == false) {
			dir.mkdirs();
		}

		// 저장할 File 객체
		File file = new File(dir, filesystem); // new File(dir, filesystem)도 가능

		// HDD에 File 객체 저장하기
		try {
			multipartFile.transferTo(file);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 포인트 업데이트
		/*
		HttpSession session = multipartRequest.getSession();
		UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
		loginUser.setPoint(galleryMapper.updateUserPoint(loginUser.getUserNo()));
	*/
		// 저장된 파일을 확인할 수 있는 매핑을 반환
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("src", "/load/image/" + filesystem);
		map.put("filesystem", filesystem);
		return map;

		// 저장된 파일이 aaa.jpg라고 가정하면
		// src=${contextPath}/load/image/aaa.jpg 이다.

	}
	
	
	@Override
	public LocalDTO getLocalGalleryByNo(int localBoardNo) {

		// DB에서 갤러리 정보 가져오기
		LocalDTO gallery = spoReviewMapper.selectLocalByNo(localBoardNo);
		
		// 갤러리에서 사용한 것으로 되어 있는 써머노트 이미지(저장된 파일명이 DB에 저장되어 있고, 실제로 HDD에도 저장되어 있음)
		List<LocalImageDTO> LocalsummernoteImageList = spoReviewMapper.selectSummernoteImageListInGallery(localBoardNo); 

		// 갤러리에서 사용한 것으로 저장되어 있으나 갤러리 내용(content)에는 없는 써머노트 이미지를 찾아서 제거
		if (LocalsummernoteImageList != null && LocalsummernoteImageList.isEmpty() == false) {
			for (LocalImageDTO summernoteImage : LocalsummernoteImageList) {
				if (gallery.getContent().contains(summernoteImage.getFilesystem()) == false) {
					String path = myFileUtil.getSummernotePath();
					File file = new File(path);
			//		File file = new File("file:"+ File.separator + "///summernoteImage", summernoteImage.getFilesystem());
					if (file.exists()) {
						file.delete();
					}
				}
			}
		}

		// 갤러리 반환
		return gallery;
	}

	
	
	
	
	
	@Override
	public SpoReviewDTO getSpoReviewGalleryByNo(int spoReviewNo) {

		// DB에서 갤러리 정보 가져오기
		SpoReviewDTO gallery = spoReviewMapper.selectSpoReviewByNo(spoReviewNo);
		
		// 갤러리에서 사용한 것으로 되어 있는 써머노트 이미지(저장된 파일명이 DB에 저장되어 있고, 실제로 HDD에도 저장되어 있음)
		List<SpoImageDTO> SpoReviewsummernoteImageList = spoReviewMapper.selectlatterSummernoteImageListInGallery(spoReviewNo);

		// 갤러리에서 사용한 것으로 저장되어 있으나 갤러리 내용(content)에는 없는 써머노트 이미지를 찾아서 제거
		if (SpoReviewsummernoteImageList != null && SpoReviewsummernoteImageList.isEmpty() == false) {
			for (SpoImageDTO summernoteImage : SpoReviewsummernoteImageList) {
				if (gallery.getContent().contains(summernoteImage.getFilesystem()) == false) {
					String path = myFileUtil.getSummernotePath();
					File file = new File(path);
			//		File file = new File("file:"+ File.separator + "///summernoteImage", summernoteImage.getFilesystem());
					if (file.exists()) {
						file.delete();
					}
				}
			}
		}

		// 갤러리 반환
		return gallery;
	}

	@Override
	public int increaseSpoReviewHit(int localBoardNo) {
		return spoReviewMapper.updateHit(localBoardNo);
	}
	
	
	
	@Override
	public int increaselatterSpoReviewHit(int spoReviewNo) {
		return spoReviewMapper.latterupdateHit(spoReviewNo);
	}
	
	// 후기글 작성하는곳
	@Override
	public void modifylatterSpoReviewGallery(HttpServletRequest request, HttpServletResponse response) {
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int localBoardNo = Integer.parseInt(request.getParameter("localBoardNo"));		

		// DB에서 갤러리 정보 가져오기
		// FreeDTO gallery = localBoardMapper.selectFreeByNo(freeNo);
		// db로 보낼 freeDTO
		LocalDTO freeBbs = LocalDTO.builder()
				.title(title)
				.content(content)
				.localBoardNo(localBoardNo)
				.build();
		
		int result = spoReviewMapper.updateLocal(freeBbs); 
		
		// 응답 
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			
			if( result > 0 ) {
				
				String[] summernoteImageNames = request.getParameterValues("summernoteImageNames");
				
				// db에 서머노트 저장
				if( summernoteImageNames != null ) {
					for( String filesystem : summernoteImageNames  ) {
						LocalImageDTO summernoteImage = LocalImageDTO.builder()
								.filesystem(filesystem)
								.localBoardNo(freeBbs.getLocalBoardNo())												
								.build();		
						spoReviewMapper.insertSummernoteImage(summernoteImage);
					}					
				}
				out.println("alert('게시글을 수정하였습니다.');");
				out.println(
						"location.href='/local/detail?localBoardNo=" + localBoardNo + "';");
				}else {
					out.println("alert('게시글을 수정할 수 없습니다');");
					out.println("history.back();");
				}
				out.println("</script>");
				out.close();

			} catch (Exception e) {
				e.printStackTrace();
			}

		}
	
	
	
	
	
	
	// 후기글 수정하는곳
	@Override
	public void modifySpoReviewGallery(HttpServletRequest request, HttpServletResponse response) {
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int spoReviewNo = Integer.parseInt(request.getParameter("spoReviewNo"));		

		// DB에서 갤러리 정보 가져오기
		// FreeDTO gallery = spoReviewMapper.selectFreeByNo(freeNo);
		// db로 보낼 freeDTO
		SpoReviewDTO freeBbs = SpoReviewDTO.builder()
				.title(title)
				.content(content)
				.spoReviewNo(spoReviewNo)
				.build();
		
		int result = spoReviewMapper.updateSpoReview(freeBbs);
		
		// 응답 
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			
			if( result > 0 ) {
				
				String[] summernoteImageNames = request.getParameterValues("summernoteImageNames");
				
				// db에 서머노트 저장
				if( summernoteImageNames != null ) {
					for( String filesystem : summernoteImageNames  ) {
						SpoImageDTO summernoteImage = SpoImageDTO.builder()
								.filesystem(filesystem)
								.spoReviewNo(freeBbs.getSpoReviewNo())												
								.build();		
						spoReviewMapper.insertlatterSummernoteImage(summernoteImage);
					}					
				}
				out.println("alert('게시글을 수정하였습니다.');");
				out.println(
						"location.href='/spo_review/detail?spoReviewNo=" + spoReviewNo + "';");
				}else {
					out.println("alert('게시글을 수정할 수 없습니다');");
					out.println("history.back();");
				}
				out.println("</script>");
				out.close();

			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		
		

	@Override
	public void removeSpoReviewGallery(HttpServletRequest request, HttpServletResponse response) {
		// 파라미터
		int spoReviewNo = Integer.parseInt(request.getParameter("spoReviewNo"));

		// HDD에서 삭제해야 하는 SummernoteImage 리스트
		List<SpoImageDTO> summernoteImageList = spoReviewMapper.selectlatterSummernoteImageListInGallery(spoReviewNo);

		// DB에서 삭제
		int result = spoReviewMapper.deleteSpoReviewGallery(spoReviewNo);

		// 응답
		try {

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();

			out.println("<script>");
			if (result > 0) {

				// HDD에서 SummernoteImage 리스트 삭제
				if (summernoteImageList != null && summernoteImageList.isEmpty() == false) {
					for (SpoImageDTO summernoteImage : summernoteImageList) {
						String path = myFileUtil.getSummernotePath();
						File file = new File(path,
								summernoteImage.getFilesystem());
						if (file.exists()) {
							file.delete();
						}
					}
				}

				out.println("alert('게시글을 삭제하였습니다.');");

				HttpSession session = request.getSession();
				UsersDTO loginUser = (UsersDTO) session.getAttribute("loginUser");
			//	spoReviewMapper.cancelUserPoint(loginUser.getUserNo());
			//	loginUser.setPoint(loginUser.getPoint() - 5);
				
				if(loginUser.getId().equals("admin")) {
					out.println("location.href='/spo_review/list';");
				} else {
					out.println("location.href='/spo_review/list';");
				}
			} else {
				out.println("alert('게시글을 삭제할 수 없습니다.');");
				out.println("history.back();");
			}
			out.println("</script>");
			out.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	
	@Override
	public void selectindexThumbNail(HttpServletRequest request, Model model) {	
		
		Map<String, Object> map = new HashMap<String, Object>();

		List<SpoReviewDTO> selectindexThumbNail = spoReviewMapper.selectindexThumbNail(map);

		model.addAttribute("selectindexThumbNail", selectindexThumbNail);
		
	}
	
	/*
	@Override
	public ResponseEntity<byte[]> display(int freeNo) {
		FreeImageDTO product = spoReviewMapper.selectSThumbNail(freeNo);
		File file = new File(product.getPath(), product.getFilesystem());

		ResponseEntity<byte[]> result = null;

		try {

			if(product.getProdThumbnail() == 1) {
				HttpHeaders headers = new HttpHeaders();
				headers.add("Content-Type", Files.probeContentType(file.toPath()));
				File thumbnail = new File(product.getPath(), "s_" + product.getFilesystem());
				result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(thumbnail), headers, HttpStatus.OK);
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
		
	}
	*/
	
	
}