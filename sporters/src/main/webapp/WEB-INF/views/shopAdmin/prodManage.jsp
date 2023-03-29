<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="../layout/adminHeader.jsp">
	<jsp:param value="쇼핑몰상품관리" name="title" />
</jsp:include>
<jsp:include page="../admin/adminLeftSide.jsp">
	<jsp:param value="left_side" name="left_side" />
</jsp:include>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script>

	$(function(){
		$('.attach_img').tooltip();
		
		// 검색 submit 확인
		$('#frm_search').submit(function(event){
			if($('#column').val() == '' || $('#query').val() == ''){
				alert('검색 조건을 확인하세요.');
				event.preventDefault();
				return;
			}
		});
		
		// 자동 완성
		$('#query').keyup(function(){
			if($('#column').val() == 'PROD_NAME' || $('#column').val() == 'PROD_CONTENT' || $('#column').val() == 'ORIGIN'){
				return;
			}
			if($(this).val() == ''){
				return;
			}
			$('#auto_complete').empty();
			$.ajax({
				/* 요청 */
				type: 'get',
				url: '/shopAdmin/prod/autoComplete',
				data: $('#frm_search').serialize(),
				/* 응답 */
				dataType: 'json',
				success: function(resData){
					if(resData.status == 200){
						$.each(resData.list, function(i, prod){
							$('#auto_complete')
							.append($('<option>').val(prod[resData.column]));
						});
					}
				}
			});
		});
	});
</script>
<style>
.in_wrap {
	position: relative;
}
.title_wrap {
	position: absolute;
}
.search_wrap {
	position: absolute;
    right: 50px;
    top: 15px;
}

/* 상품등록 버튼 */
.loc_add_btn {
	position: absolute;
    right: 50px;
}

h2 {
	font-size: 30px;
}

/* search */
#query {
	width: 300px;
    height: 25px;
    border-radius: 12px;
}
#column {
	width: 130px;
    height: 30px;
    border-style: groove;
    border-radius: 12px;
    border-width: initial;
    margin-right: 4px;
    padding-left: 3px;
}

/* 상품 리스트 */
.tbl_wrap {
	width:1000px;
	border: 2px solid #8c8cff;
	border-radius: 10px;
	margin: 0 auto;
	margin-top: 50px;
}
table {
	width:1000px;
	border-collapse: collapse;
}

th {
	height:35px;
	background-color: #8c8cff;
	color: #fff;
}

th {
	height:35px;
	background-color: #8c8cff;
	color: #fff;
}

td {
	height:133px;
	border-bottom: 1px solid #D2D2FF;
}
.center_td {
	text-align: center;
}

.red {
	background-color: #FFC8CD;
}
.prodName {
	color: #8C8CFF;
}
.prodName:hover {
	color:#ffc8c8;
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

/* page */
.now_page{
	border: none;
	display:inline-block;
	width: 25px;
	height:25px;
	line-height: 25px;
	background-color: #8C8CFF;
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
</style>
<body>
<div class="body_wrap">
	<div class="code_wrap">
		<div class="in_wrap">
			<div id="title_wrap">
				<h2>상품목록 (전체 ${totalRecord}개)</h2>
				<span>상품 관리 페이지입니다.</span>
			</div>
			<div class="search_wrap">
				<form id="frm_search" action="/shopAdmin/prodSearch">
					<select name="column" id="column">
						<option value="">===선택===</option>
						<option value="PROD_NO">상품번호</option>
						<option value="PROD_NAME">상품이름</option>
						<option value="PROD_CONTENT">상품설명</option>
						<option value="ORIGIN">원산지</option>
					</select>
					<input type="text" name="query" id="query" list="auto_complete">
					<datalist id="auto_complete"></datalist>
					<input type="submit" class="button" value="상품검색">
				</form>
			</div>
			<hr>
			<div class="loc_add_btn">
				<a href="/shopAdmin/prod/write" class="pink_button">상품등록</a>
			</div>
			<div class="tbl_wrap">
				<table>
					<colgroup>
						<col width="5%">
						<col width="7%">
						<col width="10%">
						<col width="7%">
						<col width="30%">
						<col width="7%">
						<col width="9%">
						<col width="9%">
						<col width="6%">
					</colgroup>
					<thead>
						<tr>
							<th>순번</th>
							<th>상품번호</th>
							<th>대표이미지</th>
							<th>카테고리</th>
							<th>상품명</th>
							<th>원산지</th>
							<th>소비자가격</th>
							<th>할인가격</th>
							<th>재고</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${prodList}" var="prod" varStatus="vs">
							<c:if test="${prod.stock == 0}">
								<tr class="tr red">
									<td class="center_td">${beginNo - vs.index}</td>
									<td class="center_td">${prod.prodNo}</td>
									<td>
										<c:if test="${prod.prodThumbnail.isThumbnail == 1}">
											<img src="/shopAdmin/prod/display?prodNo=${prod.prodNo}" width="100px" class="attach_img" alt="thumbnail_img" title="${prod.prodThumbnail.tnFilesystem}">
										</c:if>
										<c:if test="${prod.prodThumbnail.isThumbnail == 0 || prod.prodThumbnail.isThumbnail == null}">
											<img src="/resources/images/shopAdmin/no-image.jpeg" width="100px" class="attach_img" alt="thumbnail_img" title="${prod.prodName}">
										</c:if>
									</td>
									<td class="center_td">${prod.prodCategory.prodCategoryName}</td>
									<td><a class="prodName" href="/shopAdmin/prod/detail?prodNo=${prod.prodNo}">${prod.prodName}</a></td>
									<td class="center_td">${prod.origin}</td>
									<td class="center_td">${prod.price}</td>
									<td class="center_td">${prod.discount}</td>
									<td class="center_td prod_stock">${prod.stock}</td>
								</tr>
							</c:if>
							<c:if test="${prod.stock > 0}">
								<tr class="tr">
									<td class="center_td">${beginNo - vs.index}</td>
									<td class="center_td">${prod.prodNo}</td>
									<td>
										<c:if test="${prod.prodThumbnail.isThumbnail == 1}">
											<img src="/shopAdmin/prod/display?prodNo=${prod.prodNo}" width="100px" class="attach_img" alt="thumbnail_img" title="${prod.prodThumbnail.tnFilesystem}">
										</c:if>
										<c:if test="${prod.prodThumbnail.isThumbnail == 0 || prod.prodThumbnail.isThumbnail == null}">
											<img src="/resources/images/shopAdmin/no-image.jpeg" width="100px" class="attach_img" alt="thumbnail_img" title="${prod.prodName}">
										</c:if>
									</td>
									<td class="center_td">${prod.prodCategory.prodCategoryName}</td>
									<td><a class="prodName" href="/shopAdmin/prod/detail?prodNo=${prod.prodNo}">${prod.prodName}</a></td>
									<td class="center_td">${prod.origin}</td>
									<td class="center_td">${prod.price}</td>
									<td class="center_td">${prod.discount}</td>
									<td class="center_td prod_stock">${prod.stock}</td>
								</tr>
							</c:if>	
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="9" class="page_num">
									${paging}
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
</div>
</body>
</html>