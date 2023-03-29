<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../layout/adminHeader.jsp">
	<jsp:param value="쇼핑몰상품관리" name="title" />
</jsp:include>
<jsp:include page="../admin/adminLeftSide.jsp">
	<jsp:param value="left_side" name="left_side" />
</jsp:include>
<script src="/resources/js/jquery-3.6.1.min.js"></script>
<script src="/resources/summernote-0.8.18-dist/summernote-lite.js"></script>
<script src="/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.min.js"></script>
<link rel="stylesheet" href="/resources/summernote-0.8.18-dist/summernote-lite.css">
<script>

// shopAdmin css
$('.shopAdmin').addClass('checked');

$(function(){
	
	fileCheck();
	fn_file_change();
	
	// summernote
	$('#content').summernote({
		width: 830,
		height: 400,
		lang: 'ko-KR',
		toolbar:[
			['style', ['style']],
			['font', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			['fontname', ['fontname']],
		 	['color', ['color']],
			['para', ['ul', 'ol', 'paragraph']],
			['table', ['table']],
			['insert', ['link', 'picture', 'video']],
			['view', ['fullscreen', 'codeview', 'help']],
		],
		callbacks: {
			spellCheck: true,
			// summernote 편집기에 이미지를 로드할 때 이미지는 function의 매개변수 files로 전달됨 
			onImageUpload: function(files){
				// 동시에 여러 이미지를 올릴 수 있음
				for(let i = 0; i < files.length; i++) {
					// 이미지를 ajax를 이용해서 서버로 보낼 때 가상 form 데이터 사용 
					var formData = new FormData();
					formData.append('file', files[i]);  // 파라미터 file, summernote 편집기에 추가된 이미지가 files[i]임
					// 이미지를 HDD에 저장하고 경로를 받아오는 ajax
					$.ajax({
						type: 'post',
						url: '/shopAdmin/prodImage',
						data: formData,
						contentType: false,  // ajax 이미지 첨부용
						processData: false,  // ajax 이미지 첨부용
						dataType: 'json',    // HDD에 저장된 이미지의 경로를 json으로 받아옴
						success: function(resData){
							$('#content').summernote('insertImage', resData.src);
							$('#summernote_image_list').append($('<input type="hidden" name="summernoteImageNames" value="' + resData.tnFilesystem + '">'))
						}
					});  // ajax
				}  // for
			}  // onImageUpload
		}  // callbacks
	});
	
	function fileCheck() {
		
		$('#thumbnail').on('change', function(){
			
			// 파일 확장자 제한
			var file_path = $(this).val();
			var reg = /(.*?)\.(gif|GIF|jpg|JPG|jpeg|JPEG|png|PNG)$/;
			
			// 허용되지 않은 확장자일 경우
			if(file_path != "" && (file_path.match(reg) == null || reg.test(file_path) == false)) {
				alert('이미지 파일만 업로드 가능합니다.');
				$(this).val('');
			}
			
			// 대표사진(썸네일) 개수 체크
			if($('#thumbnail')[0].files.length > 1) {
				alert('대표사진은 1장만 설정할 수 있습니다.');
				$(this).val(''); 
				event.preventDefault();
				return;
			}
			
		});
		
	}

		// 목록
		$('#btn_list').click(function(){
			location.href = '/shopAdmin/prodManage';
		});
		
		// 서브밋
		$('#frm_write').submit(function(event){
			if($('#prodName').val() == ''){
				alert('상품명은 필수입니다.');
				event.preventDefault();  // 서브밋 취소
				$('#prodName').focus();
				return;  // 더 이상 코드 실행할 필요 없음
			}
			
			if($('#prodCategoryNo').val() == ''){
				alert('카테고리 선택은 필수입니다.');
				event.preventDefault();  // 서브밋 취소
				$('#prodCategoryNo').focus();
				return;  // 더 이상 코드 실행할 필요 없음
			}
			
			if($('#price').val() == ''){
				alert('정가 가격 입력은 필수입니다.');
				event.preventDefault();  // 서브밋 취소
				$('#price').focus();
				return;  // 더 이상 코드 실행할 필요 없음
			}
			
			if($('#discount').val() == ''){
				alert('할인가격 입력은 필수입니다.\n할인을 하지않으려면 정가와 같게 입력해주세요.');
				event.preventDefault();  // 서브밋 취소
				$('#discount').focus();
				return;  // 더 이상 코드 실행할 필요 없음
			}
			
			if($('#origin').val() == ''){
				alert('원산지 입력은 필수입니다.');
				event.preventDefault();  // 서브밋 취소
				$('#origin').focus();
				return;  // 더 이상 코드 실행할 필요 없음
			}
			
			if($('#stock').val() == ''){
				alert('재고 개수 입력은 필수입니다.');
				event.preventDefault();  // 서브밋 취소
				$('#stock').focus();
				return;  // 더 이상 코드 실행할 필요 없음
			}
			
			if($('#content').val() == ''){
				alert('상품의 상세 내용 입력은 필수입니다.');
				event.preventDefault();  // 서브밋 취소
				$('#content').focus();
				return;  // 더 이상 코드 실행할 필요 없음
			}
			
			if($('#thumbnail').val() == ''){
				alert('상품 대표사진은 필수 삽입해야 합니다.');
				event.preventDefault();  // 서브밋 취소
				$('#thumbnail').focus();
				return;  // 더 이상 코드 실행할 필요 없음
			}
			
		});
		
		
	});
	function fn_file_change() {
		$('#thumbnail').on('change',function(){
		  	var fileName = $("#thumbnail").val();	
		  	$('.upload-name').val(fileName);
		});
	}
	
</script>
<style>
h2 {
	font-size: 30px;
}
#all_content_wrap {
	margin-left: 60px;
    margin-top: 30px;
}
/* input box */
.input_wrap {
	margin-top: 7px;
	font-size: 20px;
	margin-left: 70px;
    margin-bottom: 20px;
}
.input_box {
	width: 500px;
	height: 35px;
	border: none;
	border-radius: 10px;
	background-color: #dcdcdc;
}
.label {
	display: inline-block;
	width:120px;
	vertical-align: middle;
}
.star_point {
	color:#FF88A7;
	vertical-align: top;
}
/* select 박스 */
#prodCategoryNo {
	width: 216px; 
	padding: .5em .5em; 
	border: 1px solid #000;
	color: #000;
	font-family: inherit;  
	background: url('/resources/images/shopAdmin/arrow.jpeg') no-repeat 95% 50%; 
	border-radius: 0px; 
	-webkit-appearance: none; 
	-moz-appearance: none;
	appearance: none;
	border-radius: 10px;
}
#prodCategoryNo::-ms-expand {
    display: none;
}
/* 첨부파일 */
.file_wrap {
	margin-top: 7px;
	font-size: 20px;
	margin-left: 70px;
    margin-bottom: 20px;
    position: relative;
}
.filebox {
	position: absolute;
    top: 1px;
    margin-left: 300px;
}
.filebox .upload-name {
    display: inline-block;
    height: 40px;
    padding: 0 10px;
    vertical-align: middle;
    border: 1px solid #dddddd;
    width: 240px;
    color: #999999;
    font-size: 15px;
}
.filebox label {
    display: inline-block;
    padding: 1px 20px;
    color: #fff;
    vertical-align: middle;
    background-color: #999999;
    cursor: pointer;
    height: 40px;
    margin-left: 10px;
}
.filebox input[type="file"] {
    position: absolute;
    width: 0;
    height: 0;
    padding: 0;
    overflow: hidden;
    border: 0;
}
#thumbnail_add {
	font-size: 16px;
	line-height: 40px;
}
.file_info {
	font-size: 13px;
	color: #FF88A7;
	position: absolute;
	top: 29px;
	
}

/* 상품 상세 내용 */
#content {
	margin-top: 5px;
    width: 100%;
    height: 6.25em;
    border: none;
    resize: none;
}
.content_wrap {
	padding-top: 10px;
}
.lbl_content {
	margin-bottom: 3px;
}

/* button */
.button{
  	background:#8c8cff;
  	color:#fff;
  	border:none;
  	position:relative;
  	height:31px;
  	font-size:18px;
  	padding:0 2em;
  	cursor:pointer;
  	transition:800ms ease all;
  	outline:none;
  	vertical-align: bottom;
}
.button:hover{
  	background:#fff;
  	color:#8c8cff;
}
.button:before, .button:after{
  	content:'';
  	position:absolute;
  	top:0;
  	right:0;
  	height:2px;
  	width:0;
  	background: #c8c8ff;
  	transition:400ms ease all;
}
.button:after{
  	right:inherit;
  	top:inherit;
  	left:0;
  	bottom:0;
}
.button:hover:before, .button:hover:after{
  	width:100%;
  	transition:800ms ease all;
}
/* pink button */
.pink_button {
  	background:#F09494;
  	color:#fff;
  	border:none;
  	display: inline-block;
    height: 30px;
    line-height: 30px;
  	font-size:18px;
  	padding:0 2em;
  	cursor:pointer;
  	transition:800ms ease all;
  	outline:none;
  	vertical-align: bottom;
}
.pink_button:hover{
  	background:#fff;
  	color:#F09494;
}
.pink_button:before, .pink_button:after{
  	content:'';
  	position:absolute;
  	top:0;
  	right:0;
  	height:2px;
  	width:0;
  	background: #FFC8C8;
  	transition:400ms ease all;
}
.pink_button:after{
  	right:inherit;
  	top:inherit;
  	left:0;
  	bottom:0;
}
.pink_button:hover:before, .pink_button:hover:after{
  	width:100%;
  	transition:800ms ease all;
}
.button_wrap {
	position: relative;
	margin-left: 70px;
}
.loc_btn_submit {
	position: absolute;
    bottom: -35px;
    margin-left:690px;
}
.loc_btn_list {
	position: absolute;
    bottom: -35px;
    margin-left: 580px;
}
</style>
<body>
<div class="body_wrap">
	<div class="code_wrap">
		<div class="in_wrap">
			<form id="frm_write" action="/shopAdmin/prod/add" method="post" enctype="multipart/form-data">
				<div>
					<h2>상품등록</h2>
					<span>등록할 상품을 입력해주세요.</span>
					<hr>
					<div id="all_content_wrap">
						<div class="input_wrap">
							<div class="label">
								카테고리 <span class="star_point">*</span>
							</div>
							<select name="prodCategoryNo" id="prodCategoryNo">
								<option value="">=====선택=====</option>
								<c:forEach items="${prodCategoryList}" var="category">
									<option value="${category.prodCategoryNo}">${category.prodCategoryName}</option>
								</c:forEach>
							</select>
						</div>
						<div class="input_wrap">
							<div class="label">
								<label for="prodName">상품명 <span class="star_point">*</span></label>
							</div>
							<input type="text" id="prodName" class="input_box" name="prodName">
						</div>
						<div class="input_wrap">
							<div class="label">
								<label for="price">소비자가격 <span class="star_point">*</span></label>
							</div>
							<input type="number" id="price" name="price" class="input_box">
						</div>
						<div class="input_wrap">
							<div class="label">
								<label for="discount">할인가격 <span class="star_point">*</span></label>
							</div>
							<input type="number" id="discount" name="discount" class="input_box">
						</div>
						<div class="input_wrap">
							<div class="label">
								<label for="origin">원산지 <span class="star_point">*</span></label>
							</div>
							<input type="text" id="origin" name="origin" class="input_box">
						</div>
						<div class="input_wrap">
							<div class="label">
								<label for="stock">재고 <span class="star_point">*</span></label>
							</div>
							<input type="number" id="stock" name="stock" class="input_box">
						</div>
						<div class="file_wrap">
							<span>썸네일 등록(대표 이미지) <span class="star_point">*</span></span><br>
							<span class="file_info">gif, png, jpg, jpeg 파일만 첨부가능 합니다.</span>
							<div class="filebox">
							    <input class="upload-name" value="대표이미지" placeholder="대표이미지" readonly>
							    <label for="thumbnail"><span id="thumbnail_add">썸네일 등록</span></label> 
							    <input type="file" name="thumbnail" id="thumbnail" multiple="multiple" accept="image/gif, image/png, image/jpg, image/jpeg">
							</div>
						</div>
						<div class="input_wrap content_wrap">
							<label for="content" class="lbl_content">상세설명 <span class="star_point">*</span></label>
					        <textarea name="content" id="content" name="content"></textarea>   
						</div>
						<!-- 써머노트에서 사용한 이미지 목록(등록 후 삭제한 이미지도 우선은 모두 올라감: 서비스단에서 지움) -->
						<div id="summernote_image_list"></div>
						<div class="button_wrap">
							<button class="pink_button loc_btn_submit">등록하기</button>
							<input type="button" class="button loc_btn_list" value="목록" id="btn_list">
						</div>
					</div>
					
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>