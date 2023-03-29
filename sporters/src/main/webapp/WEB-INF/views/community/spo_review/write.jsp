<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../../layout/header.jsp">
	<jsp:param value="로컬게시판" name="title" />
</jsp:include>



<script src="/resources/js/datetimepicker-master/build/jquery.datetimepicker.full.min.js"></script>
<link rel="stylesheet" href="/resources/js/datetimepicker-master/jquery.datetimepicker.css">



<style>
	
	 .title-class{
	 	width:100%;
	 }

</style>
<body>
 
<script>



$(document).ready(function(){
	
	// summernote
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
						url: '/spo_review/uploadImage',
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
		location.href =  '/spo_review/list';// taglib 사용이 어려울수도 있으니까
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



$('#datetimepicker').datetimepicker();
jQuery.datetimepicker.setLocale('en');


jQuery(function(){
	 jQuery('#date_timepicker_start').datetimepicker({
	  format:'Y/m/d',
	  onShow:function( ct ){
	   this.setOptions({
	    maxDate:jQuery('#date_timepicker_end').val()?jQuery('#date_timepicker_end').val():false
	   })
	  },
	  timepicker:false
	 });
	 jQuery('#date_timepicker_end').datetimepicker({
	  format:'Y/m/d',
	  onShow:function( ct ){
	   this.setOptions({
	    minDate:jQuery('#date_timepicker_start').val()?jQuery('#date_timepicker_start').val():false
	   })
	  },
	  timepicker:false
	 });
	});

</script>

<script type="text/javascript">




</script>

<section class="wrap"><!-- 기본틀 1 -->
	<section class="content_leyout_section"><!-- 기본틀 2 -->
	
		<div> <!-- 여기부터 각자 내용 넣기 시작 -->
			
			<form id="frm_write" action="/spo_review/add" method="post" >
				<div style="margin-top: 50px; margin-bottom: 15px">
					<input class="title-class" type="text" name="title" id="title" placeholder="제목">
					<div>
						<select name="localNo">
						    <option value="1" selected>서울</option>
						    <option value="2">경기도</option>
						    <option value="3" >그외 시골</option>					   
						</select>
						모집일 <input id="date_timepicker_start" type="text" name="joinStart">
						종료일 <input id="date_timepicker_end" type="text" name="joinEnd" >
					</div>
					
				</div>
				
				<hr style="background: #D5C2EE; height: 1px; color: #D5C2EE;">
				
				<div style="margin-top: 20px">
			
					<textarea name="content" id="content"></textarea>
				</div>
				
				<!-- 써머노트에서 사용한 이미지 목록(등록 후 삭제한 이미지도 우선은 모두 올라감: 서비스단에서 지움) -->
				<div id="summernote_image_list"></div>

				
				<div style="margin-top: 20px; text-align: right;">
					<button class="btn">작성완료</button>
					<input class="btn" type="reset" value="제목초기화">
					<input class="btn" type="button" value="목록" id="btn_list"> 
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