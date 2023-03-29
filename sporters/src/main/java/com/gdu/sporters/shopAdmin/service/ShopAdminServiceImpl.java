package com.gdu.sporters.shopAdmin.service;

import java.io.File;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.sporters.shop.domain.ProdImageDTO;
import com.gdu.sporters.shop.domain.ProdThumbnailDTO;
import com.gdu.sporters.shop.domain.ProductDTO;
import com.gdu.sporters.shopAdmin.mapper.ShopAdminMapper;
import com.gdu.sporters.shopAdmin.util.ShopAdminFileUtil;
import com.gdu.sporters.shopAdmin.util.ShopAdminPageUtil;
import com.gdu.sporters.shopAdmin.util.ShopAdminSearchPageUtil;

import net.coobird.thumbnailator.Thumbnails;

@Service
public class ShopAdminServiceImpl implements ShopAdminService{

	@Autowired
	private ShopAdminMapper shopAdminMapper;
	
	@Autowired
	private ShopAdminPageUtil pageUtil;
	
	@Autowired
	private ShopAdminSearchPageUtil searchPageUtil;
	
	@Autowired
	private ShopAdminFileUtil myFileUtil;
	
	@Override
	public void getProdList(HttpServletRequest request, Model model) {
		
		// Page 파라미터
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		// 상품 개수
		int totalProdRecord = shopAdminMapper.selectProdListCount();

		// Paging 처리에 필요한 변수 계산
		pageUtil.setPageUtil(page, totalProdRecord);
		
		// Map 생성
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("begin", pageUtil.getBegin() - 1);
		map.put("end", pageUtil.getEnd());
		map.put("recordPerPage", pageUtil.getRecordPerPage()); // begin부터 몇개 로 동작함.
		
		// 상품 리스트
		List<ProductDTO> prodList = shopAdminMapper.selectProdListAllByPage(map);
		
		// view로 전달할 데이터 model에 저장
		model.addAttribute("totalRecord", totalProdRecord); // 상품전체갯수
		model.addAttribute("prodList", prodList);
		model.addAttribute("beginNo", totalProdRecord - (page - 1) * pageUtil.getRecordPerPage());
		model.addAttribute("paging", pageUtil.getPaging("/shopAdmin/prodManage"));
		
	}
	
	@Override
	public Map<String, Object> saveProdImage(MultipartHttpServletRequest multipartRequest) {
		
		// 파라미터 files
		MultipartFile multipartFile = multipartRequest.getFile("file");
		
		// 저장경로
		String path =  myFileUtil.getSummernotePath();
		
		// 저장할 파일명
		String filesystem = myFileUtil.getFilename(multipartFile.getOriginalFilename());
		
		// 저장 경로가 없으면 만들기
		File dir = new File(path);
		if(dir.exists() == false) {
			dir.mkdirs();
		}
		
		// 저장할 File 객체
		File file = new File(path, filesystem);
		
		// HDD에 File 객체 저장하기
		try {
			multipartFile.transferTo(file);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 저장된 파일을 확인할 수 있는 매핑을 반납
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("src", "/load/image/" + filesystem);
		map.put("tnFilesystem", filesystem);
		
		return map;
	}
	
	@Transactional
	@Override
	public void saveProd(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		
		// 파라미터
		String prodName = multipartRequest.getParameter("prodName");
		int prodCategoryNo = Integer.parseInt(multipartRequest.getParameter("prodCategoryNo"));
		int price = Integer.parseInt(multipartRequest.getParameter("price"));
		int discount = Integer.parseInt(multipartRequest.getParameter("discount"));
		String origin = multipartRequest.getParameter("origin");
		int stock = Integer.parseInt(multipartRequest.getParameter("stock"));
		String content = multipartRequest.getParameter("content");
		
		// 썸네일 받아오기
		List<MultipartFile> thumbnail = multipartRequest.getFiles("thumbnail");
		
		String filesystem = null;
		String path = null;
		ProductDTO product= null;
		
		// 첨부 결과
		int thumbnailResult;
		if(thumbnail.get(0).getSize() == 0) {  // 첨부가 없는 경우 (files 리스트에 [MultipartFile[field="files", filename=, contentType=application/octet-stream, size=0]] 이렇게 저장되어 있어서 files.size()가 1이다.
			thumbnailResult = 1;
		} else {
			thumbnailResult = 0;
		}
				
		product = ProductDTO.builder()
				.prodName(prodName)
				.prodCategoryNo(prodCategoryNo)
				.price(price)
				.discount(discount)
				.origin(origin)
				.stock(stock)
				.prodContent(content)
				.build();
		
		// 상품 DB에 저장
		int result = shopAdminMapper.insertProd(product);
		
		// 첨부된 파일 목록 순회(하나씩 저장)
		for(MultipartFile multipartFile : thumbnail) {
			
			try {
				
				// 첨부가 있는지 점검
				if(multipartFile != null && multipartFile.isEmpty() == false) {  // 둘 다 필요함
					
					// 원래 이름
					String originName = multipartFile.getOriginalFilename();
					originName = originName.substring(originName.lastIndexOf("\\") + 1);  // IE는 origin에 전체 경로가 붙어서 파일명만 사용해야 함
					
					// 저장할 이름
					filesystem = myFileUtil.getFilename(originName);
					
					// 저장할 경로
					path = "testImageThumb";
					
					// 저장할 경로 만들기
					File dir = new File(path);
					if(dir.exists() == false) {
						dir.mkdirs();
					}
					
					// 첨부할 File 객체
					File file = new File(dir, filesystem);
					
					// 첨부파일 서버에 저장(업로드 진행)
					multipartFile.transferTo(file);

					// ThumbnailDTO 생성
					ProdThumbnailDTO thumbnailDTO = ProdThumbnailDTO.builder()
							.prodNo(product.getProdNo())
							.tnPath(path)
							.tnOrigin(originName)
							.tnFilesystem(filesystem)
							.isThumbnail(0)
							.build();
					
					// 첨부파일의 Content-Type 확인
					String contentType = Files.probeContentType(file.toPath());  // 이미지의 Content-Type(image/jpeg, image/png, image/gif)

					// 첨부파일이 이미지이면 썸네일을 만듬
					if(contentType != null && contentType.startsWith("image")) {
					
						// 썸네일을 서버에 저장
						Thumbnails.of(file)
							.size(500, 500)
							.toFile(new File(dir, "s_" + filesystem));  // 썸네일의 이름은 s_로 시작함
						
						thumbnailDTO.setIsThumbnail(1);
					}
					
					// DB에 Thumbnail 저장
					thumbnailResult += shopAdminMapper.insertThumbnail(thumbnailDTO);
				}
				
			} catch(Exception e) {
				e.printStackTrace();
			}
			
		}  // for
		
		
		// 응답
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			if(result > 0 || thumbnailResult > 0) {
				
				// 파라미터 summernoteImageNames
				String[] summernoteImageNames = multipartRequest.getParameterValues("summernoteImageNames");
				
				// DB에 SummernoteImage 저장
				if(summernoteImageNames !=  null) {
					for(String summernoteImage : summernoteImageNames) {
						ProdImageDTO prodImageDTO = ProdImageDTO.builder()
								.prodNo(product.getProdNo())
								.filesystem(summernoteImage)
								.build();
						shopAdminMapper.insertProdImage(prodImageDTO);
					}
				}
				
				out.println("alert('상품이 등록되었습니다.');");
				out.println("location.href='/shopAdmin/prodManage';");
			} else {
				out.println("alert('예기치 못한 오류로 상품의 등록을 완료하지 못했습니다.\n다시 시도해 주세요.');");
				out.println("history.back();");
			}
			out.println("</script>");
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Override
	public ResponseEntity<byte[]> display(int prodNo) {
		
		ProdThumbnailDTO thumbnail = shopAdminMapper.selectProdThumbnailListByNo(prodNo);
		File file = new File(thumbnail.getTnPath(), thumbnail.getTnFilesystem());

		ResponseEntity<byte[]> result = null;
		
		try {

			if(thumbnail.getIsThumbnail() == 1) {
				HttpHeaders headers = new HttpHeaders();
				headers.add("Content-Type", Files.probeContentType(file.toPath()));
				File thumbnailFile = new File(thumbnail.getTnPath(), "s_" + thumbnail.getTnFilesystem());
				result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(thumbnailFile), headers, HttpStatus.OK);
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
		
	}
	
	// 상품 상세보기
	@Override
	public ProductDTO getProdByNo(int prodNo) {

		// 써머노트 이미지
		List<ProdImageDTO> imageList = shopAdminMapper.selectProdImageListByNo(prodNo);
		
		ProductDTO product = shopAdminMapper.selectProdByNo(prodNo);
		
		// 블로그에서 사용한 것으로 저장되어 있으나 블로그 내용(content)에는 없는 써머노트 이미지를 찾아서 제거
		if(imageList != null && imageList.isEmpty() == false) {
			for(ProdImageDTO prodImage : imageList) {
				if(product.getProdContent().contains(prodImage.getFilesystem()) == false) {
					File file = new File(myFileUtil.getSummernotePath(), prodImage.getFilesystem());
					if(file.exists()) {
						file.delete();  // HDD에 저장된 파일 지우기
					}
					shopAdminMapper.deleteProdImage(prodImage.getFilesystem()); // DB에 목록에서 지우기
				}
			}
		}
		
		return shopAdminMapper.selectProdByNo(prodNo);
	}
	
	@Transactional
	@Override
	public void prodModify(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
		
		// 파라미터
		int prodNo = Integer.parseInt(multipartRequest.getParameter("prodNo"));
		String prodName = multipartRequest.getParameter("prodName");
		int prodCategoryNo = Integer.parseInt(multipartRequest.getParameter("prodCategoryNo"));
		int price = Integer.parseInt(multipartRequest.getParameter("price"));
		int discount = Integer.parseInt(multipartRequest.getParameter("discount"));
		String origin = multipartRequest.getParameter("origin");
		int stock = Integer.parseInt(multipartRequest.getParameter("stock"));
		String content = multipartRequest.getParameter("content");
		int tnNo = Integer.parseInt(multipartRequest.getParameter("tnNo"));
		
		// 새로 바꾸려는 썸네일
		List<MultipartFile> thumbnail = multipartRequest.getFiles("thumbnail");
		
		ProductDTO product = ProductDTO.builder()
				.prodNo(prodNo)
				.prodName(prodName)
				.prodCategoryNo(prodCategoryNo)
				.price(price)
				.discount(discount)
				.origin(origin)
				.stock(stock)
				.prodContent(content)
				.build();
		
		// 수정 전 상품 불러오기
		String path = "";
		String filesystem = "";
		int thumbnailResult = 0;
		// Thumbnail 새로 추가하려고 한다면 filesystem 삭제 후 교체, 아니라면 그대로 유지
		if(thumbnail.size() > 0) {
		// 첨부된 파일 목록 순회(하나씩 저장)
			for(MultipartFile multipartFile : thumbnail) {
				
				try {
					
					// 첨부가 있는지 점검
					if(multipartFile != null && multipartFile.isEmpty() == false) {  // 둘 다 필요함
						
						
						// 원래 이름
						String originName = multipartFile.getOriginalFilename();
						originName = originName.substring(originName.lastIndexOf("\\") + 1);  // IE는 origin에 전체 경로가 붙어서 파일명만 사용해야 함
						
						// 저장할 이름
						filesystem = myFileUtil.getFilename(originName);
						
						// 저장할 경로
						path = "testImageThumb";
						
						// 저장할 경로 만들기
						File dir = new File(path);
						if(dir.exists() == false) {
							dir.mkdirs();
						}
						
						// 첨부할 File 객체
						File file = new File(dir, filesystem);
						
						// 첨부파일 서버에 저장(업로드 진행)
						multipartFile.transferTo(file);

						// ThumbnailDTO 생성
						ProdThumbnailDTO thumbnailDTO = ProdThumbnailDTO.builder()
								.tnNo(tnNo)
								.prodNo(product.getProdNo())
								.tnPath(path)
								.tnOrigin(originName)
								.tnFilesystem(filesystem)
								.isThumbnail(1)
								.build();
						
						// 기존 썸네일 이미지 삭제
						File thumbnailFile = new File(thumbnailDTO.getTnPath(), "s_" + thumbnailDTO.getTnFilesystem());
						if(thumbnailFile.exists()) {
							thumbnailFile.delete();
						}
						
						// 첨부파일의 Content-Type 확인
						String contentType = Files.probeContentType(file.toPath());  // 이미지의 Content-Type(image/jpeg, image/png, image/gif)

						// 첨부파일이 이미지이면 썸네일을 만듬
						if(contentType != null && contentType.startsWith("image")) {
						
							// 썸네일을 서버에 저장
							Thumbnails.of(file)
								.size(500, 500)
								.toFile(new File(dir, "s_" + filesystem));  // 썸네일의 이름은 s_로 시작함
							
						}
						
						// DB에 Thumbnail 저장
						thumbnailResult = shopAdminMapper.updateThumbnail(thumbnailDTO);
						
					}
					
				} catch(Exception e) {
					e.printStackTrace();
				}
			
			}
		} 
			
			int result = shopAdminMapper.updateProd(product);
			
			// 응답
			try {
				
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
				if(result > 0 && thumbnailResult == thumbnail.size()) {
					
					// 파라미터 summernoteImageNames
					String[] summernoteImageNames = multipartRequest.getParameterValues("summernoteImageNames");
					
					// DB에 SummernoteImage 저장
					if(summernoteImageNames !=  null) {
						for(String summernoteImage : summernoteImageNames) {
							ProdImageDTO prodImageDTO = ProdImageDTO.builder()
									.prodNo(product.getProdNo())
									.filesystem(summernoteImage)
									.build();
							shopAdminMapper.insertProdImage(prodImageDTO);
						}
					}
					
					out.println("alert('상품 정보가 수정되었습니다.');");
					out.println("location.href='/shopAdmin/prod/detail?prodNo=" + prodNo + "';");
				} else {
					out.println("alert('변경사항이 없습니다. 상품 정보를 변경해주세요.');");
					out.println("history.back();");
				}
				out.println("</script>");
				out.close();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		
			
		
	}
	
	@Override
	public void removeThumbnailByTnNo(int tnNo, HttpServletResponse response) {

		// 삭제할 썸네일 정보 가져오기
		ProdThumbnailDTO thumbnail = shopAdminMapper.selectProdThumbnailListByNo(tnNo);
		
		thumbnail = ProdThumbnailDTO.builder()
				.prodNo(0)
				.tnPath("")
				.tnOrigin("")
				.tnFilesystem("")
				.isThumbnail(0)
				.build();
		
		// DB에서 썸네일 삭제
		int result = shopAdminMapper.updateThumbnail(thumbnail);
		
		if(result > 0) {
			
			// 첨부 파일을 File 객체로 만듬
			File file = new File(thumbnail.getTnPath(), thumbnail.getTnFilesystem());
			
			// 원본 이미지 삭제
			if(file.exists()) {
				file.delete();
			}
			
			// 첨부파일이 이미지이면 썸네일을 삭제
			if(thumbnail.getIsThumbnail() == 1) {
				
			// 썸네일 이미지 삭제
			File thumbnailFile = new File(thumbnail.getTnPath(), "s_" + thumbnail.getTnFilesystem());
			if(thumbnailFile.exists()) {
				thumbnailFile.delete();
			}
				
			}
			
		}
		
		// 응답
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			if(result > 0) {
				out.println("alert('상품의 썸네일(대표사진)이 삭제되었습니다.');");
			} else {
				out.println("alert('상품의 썸네일(대표사진)을 삭제하지 못했습니다. 다시 시도해주세요.');");
			}
			out.println("</script>");
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public ProdThumbnailDTO getProdThumbnailByNo(int prodNo) {
		return shopAdminMapper.selectProdThumbnailListByNo(prodNo);
	}

	@Override
	public void removeProd(HttpServletRequest request, HttpServletResponse response) {
		
		int prodNo = Integer.parseInt(request.getParameter("prodNo"));
		
		int result = shopAdminMapper.deleteProd(prodNo);
		
		// 응답
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(result > 0) {
				out.println("<script>");
				out.println("alert('상품이 삭제 되었습니다.');");
				out.println("location.href='" + "/shopAdmin/prodManage'");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('상품 삭제가 실패했습니다.');");
				out.println("history.back();");
				out.println("</script>");
			}
			out.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public Map<String, Object> getAutoCompleteList(HttpServletRequest request) {
		
		String column = request.getParameter("column");
		String query = request.getParameter("query");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("column", column);
		map.put("query", query);
		
		List<ProductDTO> list = shopAdminMapper.selectAutoCompleteList(map);
		
		Map<String, Object> result = new HashMap<String, Object>();
		if(list.size() == 0) {
			result.put("status", 400);
			result.put("list", null);
		} else {
			result.put("status", 200);
			result.put("list", list);
		}
		
		switch(column) {
		case "PROD_NAME": result.put("column", "prodName"); break;
		case "PROD_CONTENT": result.put("column", "prodContent"); break;
		case "ORIGIN": result.put("column", "origin"); break;
		}
		
		return result;
	}
	
	@Override
	public void searchProducts(HttpServletRequest request, Model model) {
		
		Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(opt.orElse("1"));
		
		// 검색 대상
		String column = request.getParameter("column");
		// 검색어
		String query = request.getParameter("query");
		
		// 조회와 검색된 사원수를 알아낼 때 사용하는 Map
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("column", column);
		map.put("query", query);
		
		// 검색된 사원수
		int totalRecord = shopAdminMapper.selectSearchCount(map);
		
		// 네이버 웹툰 방식으로 페이징 계산
		searchPageUtil.setNaverPageUtil(page, totalRecord);
		
		// 조회에서 사용하는 Map
		map.put("begin", searchPageUtil.getBegin());
		map.put("recordPerPage", searchPageUtil.getRecordPerPage());
		
		// 검색된 사원목록
		List<ProductDTO> productList = shopAdminMapper.selectSearchProductList(map);
		
		// search.jsp로 보낼 데이터
		model.addAttribute("prodList", productList);
		model.addAttribute("beginNo", totalRecord - (page - 1) * searchPageUtil.getRecordPerPage());
		
		String path = "/shopAdmin/prodSearch?column=" + column + "&query=" + query;
	
		model.addAttribute("paging", searchPageUtil.getNaverPaging(path));

		// 검색된 상품 개수
		int totalProdRecord = shopAdminMapper.selectSearchCount(map);
		model.addAttribute("totalRecord", totalProdRecord); // 상품전체갯수
	}
 }
