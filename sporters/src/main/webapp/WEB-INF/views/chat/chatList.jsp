<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="sporters - 채팅방목록" name="title" />
</jsp:include>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"/>
<style>
#all_wrap {
	width : 900px;
	margin-left: 65px;
}

/* header */
.mapage_div { position: relative; }

.mapage_div:before,
.mapage_div:after {
  content: '[';
  display: inline-block;
  position: relative;
  top: 1px;
  height: 5%;
  font-size: 1.25em;
  color: #8282ff;
  transition: all 0.5s ease;
}

.mapage_div:after { content: ']'; }

.mapage_div:hover:before { 
  transform: translateX(-5px);
}

.mapage_div:hover:after { 
  transform: translateX(5px);
}

.div_btns{
    padding-bottom: 50px;
    text-align: center;
    width: 200px;
    height: 20px;
    margin-left: 575px;
    padding-bottom: 7px;
}

.buttons {
	position: relative;
	display: inline-block;
	text-align: center;
    height: 30px;
    border: none;
    font-size: 14px;
    color: white;
    background-color: #c8c8ff;
    border-radius: 4px;
}

.buttons:active {
	top: 4px; 
}
	    
.buttons.purple {box-shadow:0px 4px 0px #FF9E9B; margin-right: 30px;}
.buttons.purple:active {box-shadow: 0 0 #FF9E9B; background-color: #c8c8ff;}

.buttons.purple, .btn-two.purple {
	background-color: #FFB6C1;
    width: 100px;
    position: absolute;
    top: 64px;
    left: 704px;
}

.in_buttons {
	position: relative;
	display: inline-block;
	text-align: center;
	width:100px;
    height: 30px;
    border: none;
    font-size: 14px;
    color: white;
    background-color: #FFB6C1;
    border-radius: 4px;
    margin-bottom: 4px;
}

.in_buttons:active {
	top: 4px; 
}
	
.in_buttons.purple {box-shadow:0px 4px 0px #b6b6f3;}
.in_buttons.purple:active {box-shadow: 0 0 #c8c8ff; background-color: #c8c8ff;}

.in_buttons.purple, .btn-two.purple {background-color: #c8c8ff;}

/* table */
.tbl_wrap {
	width:700px;
	border: 2px solid #8c8cff;
	border-radius: 10px;
}
table {
	width:700px;
	border-collapse: collapse;
}

th {
	height:35px;
	background-color: #8c8cff;
	color: #fff;
}

td {
	height:40px;
}
.tb_center {
	text-align: center;
}
.chat_room_name {
	padding-left: 60px;
}

/* page */
.now_page{
	border: none;
	display:inline-block;
	width: 25px;
	height:25px;
	line-height: 25px;
	background-color: #8C8CFF;
	border-radius:3px;
	color : white;
	text-align: center;
	text-decoration: none;
	
}
tfoot td {
	text-align: center;
}

tfoot a {
	color:#8C8CFF;
	width:25px;
	height:25px;
	margin:0 5px;
}

.chat_info {
    position: absolute;
    top: 62px;
    border-radius: 7px;
    padding: 5px;
}
</style>
<body>


<section class="wrap"><!-- 기본틀 1 -->
	<section class="content_leyout_section"><!-- 기본틀 2 -->
	
		<div> <!-- 여기부터 각자 내용 넣기 시작 -->
			<script>
	
				$(function(){
					fn_openChat();
				});
				
				// 채팅방 입장
				var chatAddWindow;
				function fn_openChat(){
					$('#add_chat_room').click(function(){
						chatAddWindow = window.open('/chat/write', '실시간채팅', 'width=900,height=670,top=100,left=500,menubar=no,history=no');							
					});
				}
				
			</script>
		
			<div id="all_wrap">
				<div id="title_wrap">
					<div class="mapage_div" style="font-size: 32px; font-weight: bold; text-align: center; margin-bottom: 40px; margin-right: 185px;"> 채팅하기 </div>
				</div>
				<div class="div_btns">
					<input type="button" class="buttons purple" value="채팅방 생성" id="add_chat_room"/>
				</div>
				<span class="chat_info"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABkAAAAZCAYAAADE6YVjAAAACXBIWXMAAAsTAAALEwEAmpwYAAAB6ElEQVR4nMXVS4iNYRzH8Y8ZtwlZuBYLKXc7SphI2dm5bGxIiUgu0WFlVi4LsVEuKbmkrIYoUiLKhlymqFkQ07hEKAoreuo/ent757zvHKd861k87/mf5//8b7+H/0wL5mMDatiO1RjXjMNHxKFv0YUzOIRj6MRn3MCiRh3MxQtcxKx+bIZgPV7jQERcmXRoL9ZWtB+D2zhe1cFgPIkbDoSReIY1VYzX4VZm34HfJauPdrzEICXcxEqN04WFZUbvMDF3u1rJynISm5TwA8Mz++XRtvVWloPYq4RXmKpxzkddZ9dr6bPYWqHwHf3MzXtMicFN9VlS5CTVoDuXsqrsxLXMfkWoxaoi43M4VaUVMyyNKKYVKMcnzMl914ZHIYhltGALPmAZNhekcx8uFDnpjtT1MQmTMRSjQ5X3hL7dqaNviRkxGn9JYd3H6djPiyJ+RA9+4Sseh1YtjkN252Yne8FR+JZ10hvScALP8SbCHRvSn69TeyhwfnbSfPWROuyh3Ida5HkBWjO/bcTTEMOqpEtdx7aB/OEy7mF6RfvDeBDqXpkU2X58waWQ9pmR97YYxNZMVr5jggYZj13x/PaE5v2MAnfGQ5ba+yruFs3JvzAMRyPSKzgSl0hPdNNJkaR3KbX2jmZHUpc/Vet0lfGxSDcAAAAASUVORK5CYII="> 열린 채팅방 ${chatRoomCnt}개</span>
				<div class="tbl_wrap">
					<table>
						<colgroup>
							<col width="15%">
							<col width="55%">
							<col width="30%">
						</colgroup>
						<thead>
							<tr>
								<th>채팅방 번호</th>
								<th>채팅방 이름</th>
								<th>입장하기</th>
							</tr>
						</thead>
						<tbody id="#chatList">
							<c:forEach items="${chatRoomList}" var="chatRoom">
								<tr>
									<td class="tb_center">${chatRoom.chatRoomId}<input type="hidden" class="chatRoomId" name="chatRoomId" value="${chatRoom.chatRoomId}"></td>
									<c:if test="${chatRoom.isPw == '1'}">
										<td class="chat_room_name">${chatRoom.chatRoomTitle}&nbsp;<i class="fa-solid fa-lock" style="vertical-align: revert;"></i></td>
									</c:if>
									<c:if test="${chatRoom.isPw == '0'}">
										<td class="chat_room_name">${chatRoom.chatRoomTitle}</td>
									</c:if>
									<c:if test="${chatRoom.isPw == '1'}">
										<td class="tb_center"><input type="button" class="btn_in_chat in_buttons purple" value="입장" onclick="window.open('/chat/chatRoom/lock?chatRoomId=${chatRoom.chatRoomId}', '실시간채팅', 'width=900,height=670,top=100,left=500,menubar=no,history=no')"></td>
									</c:if>
									<c:if test="${chatRoom.isPw == '0'}">
										<td class="tb_center"><input type="button" class="btn_in_chat in_buttons purple" value="입장" onclick="window.open('/chat/chatRoom?chatRoomId=${chatRoom.chatRoomId}', '실시간채팅', 'width=900,height=670,top=100,left=500,menubar=no,history=no')"></td>
									</c:if>
								</tr>						
							</c:forEach>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="4" style="text-align: center;">
									${paging}
								</td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
			
		</div><!-- 여기부터 각자 내용 넣기 끝 -->
		
	</section><!-- 기본틀 2 -->
	
</section><!-- 기본틀 1 -->

<jsp:include page="../layout/right_side.jsp">
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