<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../layout/adminHeader.jsp">
	<jsp:param value="관리자페이지" name="title" />
</jsp:include>
<jsp:include page="adminLeftSide.jsp">
	<jsp:param value="left_side" name="left_side" />
</jsp:include>
<style>
body {
	background: #fff;
}
.tbl {
	width:1000px;
	border: 2px solid #8c8cff;
	border-radius: 10px;
	margin: 0 auto;
	margin-top: 50px;
}
.tbl thead {
	padding: 10px;
	height:35px;
	background-color: #8c8cff;
	color: #fff;
	border-bottom: 3px solid #D5C2EE;
}
.tbl td {
	color: #669;
	padding: 10px;
	border-bottom: 1px solid #D2D2FF;
	height:28px;
	word-break:break-all;
}
.tbl tr:hover td {
	color: #004;
}

#btn_init, #btn_search{
  	background:#8c8cff;
  	color:#fff;
  	border:3px solid;
  	border-color:#8282ed;
  	border-radius:3px;
  	position:relative;
  	height:30px;
  	font-size:20px;
  	cursor:pointer;
  	outline:none;
  	vertical-align: bottom;
}

#btn_deleteUser{
background:#8c8cff;
  	color:#fff;
  	border: 3px solid #8c8cff;
  	border-color:#8282ed;
  	border-radius:3px;
  	position:relative;
  	height:30px;
  	font-size:20px;
  	cursor:pointer;
  	outline:none;
  	vertical-align: bottom;
}

button:hover{
  	background:#9999FF;
  	color:#FFF;
}
</style>
<script>

$('.shopAdmin').addClass('checked');

	$(document).ready(function(){
		
		// 함수 호출
		fn_checkAll();
		fn_checkOne();
		fn_removeList();

		
		// 전체선택
		function fn_checkAll(){
			$('#check_all').click(function(){
				$('.check_one').prop('checked', $('#check_all').prop('checked'));
			});
		}
		
		// 개별선택
		function fn_checkOne(){
			$('.check_one').click(function(){
				var checkCount = 0;
				for(let i = 0; i < $('.check_one').length; i++){
					checkCount += $($('.check_one')[i]).prop('checked');				
				}
				$('#check_all').prop('checked', checkCount == $('.check_one').length);
			});
		}
		
		// 선택삭제
		function fn_removeList(){
			$('#frm_search').submit(function(event){
				if(confirm('선택한 모든 게시글을 삭제할까요?') == false){
					event.preventDefault();
					return;
				}
				if($('.check_one:checked').length == 0){
					alert('선택된 게시글이 없습니다.');
					event.preventDefault();
					return;
				}
			});
		}
		
		
	});
	
</script>

<body>

<div class="body_wrap">
	<div class="code_wrap">
		<div class="in_wrap">
			<div><a href="/free/write">글쓰러가기</a>  </div>				
				<form id="frm_search"  action="/admin/removeFreeList" method="post">										
				<hr>
					<button>선택삭제</button>
					<table border="1" class="tbl">
						<thead>
							<tr>	
								<td>
								<label for="check_all" id="lbl_check_all"></label>
								<input type="checkbox" id="check_all" class="blind">
								</td>
								<th>글 제목</th>	
								<th>회원 아이디</th>						
								<th>회원 이름</th>
								<th>회원 성별</th>				
								<th>회원 핸드폰번호</th>											
								<th>회원 포인트</th> 						 
								<th>작성 글 수</th>
									
							</tr>
						</thead>
						<tbody id="list">						
							<c:forEach items="${galleryList}" var="gallery" varStatus="vs">
								<tr>
									<td><input type="checkbox" name="galleryList" value="${gallery.freeNo}" class="check_one"></td>
									<td>${beginNo - vs.index}</td>						
									<td><a id="moveDetail" href="/free/increase/hit?freeNo=${gallery.freeNo}">${gallery.title}</a></td>									
									<td>${gallery.users.id}</td>
									<td>${gallery.users.nickname}</td>
									<td>${gallery.users.gender}</td>
									<td>${gallery.createDate}</td>
									<td>${gallery.hit}</td>
									
								</tr>
							</c:forEach>
						</tbody>
						
					</table>
					
				</form>
			
				<div class="div_paging">
					${paging}
				</div>
			
		</div>
	</div>
	</div>
</body>
</html>