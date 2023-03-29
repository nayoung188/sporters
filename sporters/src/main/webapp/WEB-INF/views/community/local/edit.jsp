<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../../layout/header.jsp">
	<jsp:param value="자유게시판" name="title" />
</jsp:include>


<script>

$(document).ready(function(){
//summernote
$('#content').summernote({
	width: 800,
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
					url: '/free/uploadImage',
					data: formData,
					contentType: false,  // ajax 이미지 첨부용
					processData: false,  // ajax 이미지 첨부용
					dataType: 'json',    // HDD에 저장된 이미지의 경로를 json으로 받아옴
					success: function(resData){
						console.log(resData);
						$('#content').summernote('insertImage', resData.src);
						$('#summernote_image_list').append($('<input type="hidden" name="summernoteImageNames" value="' + resData.filesystem + '">'))
					}
				});  // ajax
			}  // for
		}  // onImageUpload
	}  // callbacks
});
	

// 목록
$('#btn_list').click(function(){
	location.href =  '/free/list';// taglib 사용이 어려울수도 있으니까
})

// 서브밋
$('#frm_write').submit(function(event){
	if($('#title').val() == ''){
		alert('제목은 필수입니다.');
		event.preventDefault(); // 서브밋 취소
		return; // 더 이상 코드 실행할 필요 없음
	}
});

});
 
	
</script>



<body>

<section class="wrap"><!-- 기본틀 1 -->
	<section class="content_leyout_section"><!-- 기본틀 2 -->
	
		<div> <!-- 여기부터 각자 내용 넣기 시작 -->
			
		<h1>작성 화면</h1>
	
		<form id="frm_edit" action="/local/modify" method="post">
		
			<input type="hidden" name="freeNo" value="${gallery.localBoardNo}">
		
			<div>
				<label for="title">제목</label>
				<input type="text" name="title" id="title" value="${gallery.title}">
			</div>
			<label for="content">내용</label>
				<textarea name="content" id="content">${gallery.content}</textarea>		
			<div id="summernote_image_list">
						
			</div>
			
			<div>
				<button>수정완료</button>
				<input type="reset" value="작성초기화">
				<input type="button" value="목록" id="btn_list">
			</div>
			
		</form>
				
				
	
			
			
			
			
			
		</div><!-- 여기부터 각자 내용 넣기 끝 -->
		
	</section><!-- 기본틀 2 -->
	
</section><!-- 기본틀 1 -->
	
<jsp:include page="../../layout/right_side.jsp">
	<jsp:param value="right_side" name="right_side" />
</jsp:include>

<script type="text/javascript">
$(function(){
	 var right_side =  $('.content_leyout_section').offset().top;
	var my_right_side = $('.right_side_menu_area').width();
	var right_side_marginLeft = $('.content_leyout_section').width() + my_right_side*2 ;


	 $('.right_side_menu_area').offset({top:right_side});
	 $('.right_side_menu_area').css({marginLeft:right_side_marginLeft  });
	 
	 // content_leyout 현재 높이값을 구함. 
	 var left_side_top =  $('.content_leyout_section').offset().top;
	 var right_side_marginLeft = $('.content_leyout_section').offset().left;

	// 왼쪽 사이드 메뉴의 넓이값을 구함
	var my_left_side =right_side_marginLeft -  $('.left_side_gnd_area').width() - my_right_side;
	var left_side_marginLeft = $('.content_leyout_section').width();


	 $('.left_side_gnd_area').offset({top:left_side_top});	 
	 
	
}); 
</script>
</body>
</html>