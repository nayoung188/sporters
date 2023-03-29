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

h2 {
	font-size: 30px;
}

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
  	border:none;
  	border-radius:3px;
  	position:relative;
  	height:31px;
  	font-size:18px;
  	padding:0 2em;
  	cursor:pointer;
  	outline:none;
  	vertical-align: bottom;
}

#btn_deleteUser{
  	background:#F09494;
  	color:#fff;
  	border:none;
  	border-radius:3px;
  	position:relative;
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

button:hover{
  	background:#9999FF;
  	color:#FFF;
}
#column{
    width: 134px;
    border: 3px solid #bbb;
    border-radius: 8px;
    font-size: 14px;
    height:30px;
}

#searchText{
  width: 135px;
  height: 5px;
  border: 3px solid #bbb;
  border-radius: 8px;
  padding: 10px 12px;
  font-size: 14px;
}
.search_grp{
display: inline-block;
position: relative;

}
.btn_group{
display: inline-block;
position: absolute;
}
</style>
<script type="text/javascript">

	$(document).ready(function(){
		fn_getUserList();
		fn_retireUser();
		
		// 검색키 엔터키에 연결
	    $("#searchText").keydown(function (key) {
	        if (key.keyCode == 13) {
	        	$('#btn_search').click();
	        	key.preventDefault();
	        }
	    });
		
		// 문서객체
        var checkall = document.getElementById('check_all');
        var checkone = document.getElementsByClassName('check_one');

        // 전체선택 클릭 이벤트
        checkall.onclick = function(event) {
            for(let i = 0; i < checkone.length; i++) {
                checkone[i].checked = checkall.checked;
            }
        }
            
        // 개별선택 클릭 이벤트
        for(let i = 0; i < checkone.length; i++) {
            checkone[i].onclick = function(event) {
                let checkcount = 0;
                for(let j = 0; j < checkone.length; j++) {
                    checkcount += checkone[j].checked;
                }
                checkall.checked = (checkcount == checkone.length);
            }
        }  
        
    	// 전역변수
    	var page = 1;
    	var totalPage = 0;
    	var timer;

	// 유저리스트 불러오기
	function fn_getUserList() {
		$('#list').addClass('blind');    // 목록 숨기기
		$.ajax({
			type : 'get',
			url : '/searchAllUsers',
			dataType : 'json',
			success : function(resData) {
				$('#list').empty();
				$.each(resData.userList, function(i, user) {
			var tr = '<tr>';
			if(user.id != 'admin'){
				tr += '<td><input type="checkbox" name="userCheck" class="check_one" value="'+ user.userNo +'"></td>';
					}else{
							tr += '<td></td>';
				}
			tr += '<td>' + user.userNo + '</td>';
			tr += '<td>' + user.id + '</td>';
			tr += '<td>' + user.nickname + '</td>';
			tr += '<td>' + user.name + '</td>';
			tr += '<td>' + (user.gender == 'M' ? '남자' : '여자') + '</td>';
			tr += '<td>' + user.email + '</td>';
			tr += '<td>' + user.mobile + '</td>';
			tr += '<td>' + user.joinDate + '</td>';
			tr += '</tr>';
			$('#list').append(tr);
			})
		},
			error : function() {
				alert('실패');
			}
		})
		
		$('#list').removeClass('blind'); // 목록 보여주기


	}
	
	$('#btn_search').click(function(){
		$.ajax({
			type:'get',
			url :'/searchUsers',
			data : 'column=' + $('#column').val() + '&searchText=' + $('#searchText').val(),
			dataType:'json',
			success : function(resData){
				$('#list').empty();
				$.each(resData.users, function(i, user){
					var tr = '<tr>';
					if(user.id != 'admin'){
						tr += '<td><input type="checkbox" name="userCheck" class="check_one" value="'+ user.userNo +'"></td>';
						}else{
						tr += '<td></td>';	
						}
					tr += '<td>' + user.userNo + '</td>';
					tr += '<td>' + user.id + '</td>';
					tr += '<td>' + user.nickname + '</td>';
					tr += '<td>' + user.name + '</td>';
					tr += '<td>' + (user.gender == 'M' ? '남자' : '여자') + '</td>';
					tr += '<td>' + user.email + '</td>';
					tr += '<td>' + user.mobile + '</td>';
					tr += '<td>' + user.joinDate + '</td>';
					tr += '</tr>';
					$('#list').append(tr);
				})
			},
			error : function() {
				alert('실패');
			}
		})
	});
	
	function fn_retireUser(){
		$('#btn_deleteUser').click(function(event){
			
// 		if($('input:[name="userCheck"]:checked').val() == 1){
// 			alert('관리자는 탈퇴할 수 없습니다.');
// 			event.preventDefault();
// 			return;
// 		}
			var userArray = [];
			$('input:checkbox[name="userCheck"]:checked').each(function(i){
				userArray.push($(this).val());
				
			});

			$.ajax({
				type:'post',
				url: '/retireUser',
				data:{"userNo" : userArray},
				dataType:'json',
				success:function(){
	 				alert('선택된 회원이 탈퇴 되었습니다.');
	 				fn_getUserList();
				}
			})
		
		});
	}	
	
// 	// 스크롤 이벤트
// 	$(window).scroll(function(){
// 		// 동일한 setTimeout이 다시 요청되었다면 setTimeout 동작 취소
// 		if(timer) {
// 			clearTimeout(timer);
// 		}
// 		// 마지막 스크롤 후 0.2초 후에 동작하는 setTimeout
// 		timer = setTimeout(function(){
// 			var scrollTop = $(this).scrollTop();        // 스크롤 된 길이
// 			var windowHeight = $(this).height();        // 웹 브라우저(화면) 높이
// 			var documentHeight = $(document).height();  // 문서 전체 높이
// 			if((scrollTop + windowHeight) >= documentHeight){  // 스크롤이 화면 끝까지 내려갔음
// 				if(page > totalPage){  // 마지막 페이지를 넘어가면 동작 안함
// 					return;
// 				}
// 				fn_getUserList();
// 			}
// 		}, 200);  // 200밀리초 = 0.2초(시간은 알아서 조절할 것)
// 	});
	
	});
	
</script>
<body>

<div class="body_wrap">
	<div class="code_wrap">
	<div class="in_wrap">
		<h2>회원 관리</h2><br>
		<div class="search_grp">
			<form id="frm_user_list" method="post">
				<select name="column" id="column">
					<option value="">회 원 분 류</option>
					<option value="ID">아이디</option>
					<option value="NAME">이름</option>
					<option value="USER_NO">회원번호</option>
				</select>
				<input type="text" id="searchText" name="searchText">
			</form>
		</div>&nbsp;
			<div class="btn_group">
				<button id="btn_search" value="검색" >검색</button>&nbsp;
				<button id="btn_init" value="초기화">초기화</button>&nbsp;
				<button id="btn_deleteUser" value="회원 탈퇴">탈퇴</button>
			</div>
			

				<form>
			<table class="tbl" style="border-collapse:collapse; border:1px gray solid;">
				<thead>
					<tr>
						<th><input type="checkbox" id="check_all"></th>
						<th style="size: 10px">회원번호</th>
						<th>아이디</th>
						<th>닉네임</th>
						<th>이름</th>
						<th>성별</th>
						<th>이메일</th>
						<th>연락처</th>
						<th>가입일</th>
					</tr>
				</thead>
				<tbody id="list">

				</tbody>
				<tfoot>
				</tfoot>
			</table>
			
		</form>
	</div>
	</div>
</div>

</body>
</html>