<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="../layout/header.jsp">
	<jsp:param value="Spoters쇼핑몰페이지" name="title" />
</jsp:include>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>

	$(function(){
		fn_showHide();
		fn_check();
		fn_pay();
	});
	
	function fn_showHide(){
		$('#priceAll').hide();
		$('#orderDetail').hide();
		$('#btn_orderOpen').click(function(){
			var priceArray = [];
			$('input:checkbox[name=checkOne]:checked').each(function (index){
				priceArray.push($(this).data('price'));
			});
			var priceAll = priceArray.reduce((a,b) => (a+b));
			$('#priceAll').show();
			$('#orderDetail').show();
			$.ajax({
				url : "/cartList/priceAll",
				type : 'post',
				data : 'priceAll=' + priceAll,
				success : function(priceAll) {
					$('#priceAll').empty();
					$('#priceAll').append('최종 구매 가격 : ' + priceAll.toLocaleString() + ' 원');
			     },
				error : function(sum) {
				}
			});
			
		});
		$('#btn_orderOpen_cancel').click(function(){
			$('#priceAll').hide();
			$('#orderDetail').hide();
		});
	}
	
	function fn_check(){
		var checkAll = document.getElementById('checkAll');
        var checkOne = document.getElementsByClassName('checkOne');
		
		checkAll.onclick = function(event) {
            for(let i = 0; i < checkOne.length; i++) {
            	checkOne[i].checked = checkAll.checked;
            }
        }

        for(let i = 0; i < checkOne.length; i++) {
        	checkOne[i].onclick = function(event) {
                let checkCount = 0;
                for(let j = 0; j < checkOne.length; j++) {
                	checkCount += checkOne[j].checked;
                }
                checkAll.checked = (checkCount == checkOne.length);
            }
        }
	}
		
	function fn_pay(){
		$(document).on('click', '.btn_payment', function(){
   			
			var IMP = window.IMP; 
			IMP.init('imp30603183');
			var merchant_uid = 'product_' + new Date().getTime();
			
			var priceArray = [];
			$('input:checkbox[name=checkOne]:checked').each(function (index){
				priceArray.push($(this).data('price'));
			});
			var priceAll = priceArray.reduce((a,b) => (a+b));
			
			var nameArray = [];
			$('input:checkbox[name=checkOne]:checked').each(function (index){
				nameArray.push($(this).data('prodname'));
			});
			if(nameArray.length < 2) {
				prodName = '' + nameArray;
			} else {
				prodName = nameArray[0] + ' 외 ' + (nameArray.length - 1) + '개';
			};
			var cartNoArray = [];
			$('input:checkbox[name=checkOne]:checked').each(function (index){
				cartNoArray.push($(this).data('cartno'));
			});
			
			var data = {
				'cartNo' : cartNoArray,
				'priceAll' : priceAll,
				'name' : $('#name').val(),
				'mobile' : $('#mobile').val(),
				'postcode' : $('#postcode').val(),
				'roadAddress' : $('#roadAddress').val(),
				'jibunAddress' : $('#jibunAddress').val(),
				'detailAddress' : $('#detailAddress').val()
			}
			
			var stockArray = [];
			$('input:checkbox[name=checkOne]:checked').each(function (index){
				stockArray.push($(this).data('stock') - $(this).data('prodcnt'));
			});
			
			var prodNoArray = [];
			$('input:checkbox[name=checkOne]:checked').each(function (index){
				prodNoArray.push($(this).data('prodno'));
			});
			
			var updateStock = {
				'stock' : stockArray,
				'prodNo' : prodNoArray
			}
			
			$.ajax({
				url: '/shop/addOrder',
				type: 'post',
				data: data,
				dataType : 'json',
				success: function(result){
					if(result == 1){
						alert('주문완료');
						$.ajax({
							url: '/shop/updateStock',
							type: 'post',
							data: updateStock,
							dataType : 'json',
							success: function(data){
								alert('업데이트 실패!');
							}
						});
					} else {
						alert('로그인하세요!');
					}
				},
				error: function(){
					alert('주문 실패');
				}
			});
			
			
			IMP.request_pay({ 
			pg: "html5_inicis",
			pay_method: 'card',
			merchant_uid: merchant_uid,
			name: prodName, 
			amount: priceAll,
			m_redirect_url: 'https://www.yourdomain.com/payments/complete'
			}, function (rsp) {
				if (rsp.success) {
					alert('성공');
					location.href='shop/cartList';
				} else {
				var msg = '';
				msg += rsp.error_msg;
				alert(msg)
       			}
			});
		});
	}
	
</script>
<style>
	ul {
		padding: 0;
	}
	li {
		list-style:none;
	}
	a {
		text-decoration:none;
	}
	#paging {
		text-align: center;
	}
	#aside {
      float: left;
      width: 180px;
      height: 500px;
   }
   #aside h3 {
      width: 180px;
      font-size:30px;
      margin-bottom:20px;
      text-align: center; 
      font-weight: bold;
   }
   #aside li {
      font-size:16px;
      text-align:center;
   }
   #aside li a {
      color:#000;
      display:block;
      padding:10px 0;
   }
   #aside li a:hover {
      text-decoration:none;
      background:#eee;
   }
	#title {
		font-size: 24px;
		text-align: center;
	}
	.cartListDetail {
		padding-bottom: 10px;
	}
	input[type='checkbox'] {
		width:20px;
		height:20px;
	}
	.blind {
		display: none;
	}
	.cartList_area{
   margin-top: 60px;
   
   }
</style>
<body>
<section class="wrap"><!-- 기본틀 1 -->
	<section class="content_leyout_section"><!-- 기본틀 2 -->
	<div id="aside">
      <br>
      <h3>카테고리</h3>
      <ul>
         <li><a href="/shop/list">전체</a></li>
         <li><a href="/shop/categoryList?prodCategoryNo=1">음식</a></li>
         <li><a href="/shop/categoryList?prodCategoryNo=2">의류</a></li>
         <li><a href="/shop/categoryList?prodCategoryNo=3">기타</a></li>
         <li class="cartList_area"><a href="/shop/cartList">장바구니로 이동</a></li>
         <li><a href="/shop/orderList">주문내역 확인</a></li>
      </ul>
   </div>
	<div>
			<table>
					<tbody>				
					<tr>
						<td style='width:20px; padding-top:5px;'>
							<div class="checkAll">
								<input type="checkbox" name="checkAll" id="checkAll"/><label for="allCheck" ></label> 
								<input type="hidden" id="prodCategoryNo" value="${prodCategoryNo}">
							</div>
						</td>
						<td>
							<div class="delBtn">
								<button type="button" id="btn_removeCartChecked">선택 삭제</button> 
							</div>
							<script>
								$("#btn_removeCartChecked").click(function(){
									var confirm_val = confirm("정말 삭제하시겠습니까?");
								 
									if(confirm_val) {
										var checkArr = new Array();
										$("input[class='checkOne']:checked").each(function(){
											checkArr.push($(this).attr("data-cartNo"));
										});
										
										$.ajax({
											url: "/shop/deleteCart",
											type: "post",
											data: { "checkOne" : checkArr },
											success: function(result){
												if(result == 1) {          
													alert("삭제 성공");
													location.href='/shop/cartList';
												} else {
													alert("삭제 실패");
												}
											},
											error: function(){
												alert("삭제할 상품을 1개 이상 선택해주세요.");
											}
										});
									} 
								});
							</script>
						</td>
					</tr>
					
					
					<c:set var="sum" value="0" />
					<c:forEach items="${cartList}" var="cartList">
						<tr>
							<td style="padding-right:10px;">
								<div>
									<input type="checkbox" name="checkOne" class="checkOne" data-cartno="${cartList.cartNo}" data-price="${cartList.product.price * cartList.prodCnt}" data-prodname="${cartList.product.prodName}" data-stock="${cartList.product.stock}" data-prodcnt="${cartList.prodCnt}" data-prodno="${cartList.prodNo}">
								</div>
							</td>
							<td class="cartListDetail">
								<div class="delete">
									<button type="button" class="btn_delete${cartList.cartNo}" data-cartno="${cartList.cartNo}">삭제</button>
								</div>
				
								<script>
									$(".btn_delete${cartList.cartNo}").click(function(){
										var confirm_val = confirm("정말 삭제하시겠습니까?");
									 
										if(confirm_val) {
											var checkArr = new Array();
									  
											checkArr.push($(this).attr("data-cartNo"));
											$.ajax({
												url : "/shop/deleteCart",
												type : "post",
												data : { "checkOne" : checkArr },
												success : function(result){
													if(result == 1) {
														alert("삭제 성공");
														location.href='/shop/cartList';
													} else {
														alert("삭제 실패");
													}
												},
												error: function(checkOne){
													alert("에러남!!");
												}
											});
										} 
									}); 
								</script>
								<input type="hidden" class="prodNo" value="${cartList.prodNo}">
								<input type="hidden" class="cartNo" value="${cartList.cartNo}">
								<div style="display: flex;">
									<div style="margin-right: 20px;">
										<img src="/shopAdmin/prod/display?prodNo=${cartList.prodNo}" width="120px" height="120px" class="attach_img" alt="thumbnail_img"><br>
									</div>
									<div>
					 					<a href="/shop/detail?prodNo=${cartList.prodNo}"><span class="productId">${cartList.product.prodName}</span></a><br>
										<span>가격 : <fmt:formatNumber pattern="###,###,###" value="${cartList.product.price}" /> 원<br /></span>
										<span>재고 : ${cartList.product.stock} 개</span><br>
										<span>구매할 수량 : ${cartList.prodCnt} 개</span><br>
										<span>합계 가격 : <fmt:formatNumber pattern="###,###,###" value="${cartList.product.price * cartList.prodCnt}" /> 원</span><br>
									</div>
								</div>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="2">
							<br><div class="listResult">
								<div class="orderOpen">
									<button type="button" id="btn_orderOpen">주문 정보 입력</button>
									<button type="button" id="btn_orderOpen_cancel">주문 정보 입력 취소</button>
								</div><br>
								<div id="priceAll"></div>
								<div id="orderDetail">
								    <br><input type="button" id="sameAdd" value="기본 배송지">
									<script>
										$(function(){
											fn_sameAdd();
										});
										
										function fn_sameAdd(){
											 
											$('#sameAdd').click(function(){
												
												$.ajax({
													url : "/cartList/sameAdd",
													type : 'post',
													success : function(order) {
														alert("기본 배송지로 변경되었습니다.");
														$('#name').val(order.name);
														$('#mobile').val(order.mobile);
														$('#postcode').val(order.postcode);
														$('#roadAddress').val(order.roadAddress);
														$('#jibunAddress').val(order.jibunAddress);
														$('#detailAddress').val(order.detailAddress);
												     },
													error : function(order) {
														alert("변경 실패!");
													}
												});
												
											});
										}
									</script>
									<div>
										<label for="name">수령인</label>
										<input type="text" name="name" id="name">
									</div>
									<div>
										<label for="mobile">전화번호</label>
										<input type="text" name="mobile" id="mobile">
									</div>
									<div>
										<input type="text" onclick="fn_execDaumPostcode()" name="postcode" id="postcode" placeholder="우편번호" readonly><br>
										<input type="button" onclick="fn_execDaumPostcode()" value="우편번호 찾기"><br>
										<input type="text" name="roadAddress" id="roadAddress" placeholder="도로명주소" readonly>
										<input type="text" name="jibunAddress" id="jibunAddress" placeholder="지번주소" readonly><br>
										<span id="guide" style="color:#999;display:none"></span>
										<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소">
										<input type="hidden" name="orderState" id="orderState" value="결제완료">
										<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
										<script>
										    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
										    function fn_execDaumPostcode() {
										        new daum.Postcode({
										            oncomplete: function(data) {
										                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
										
										                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
										                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
										                var roadAddr = data.roadAddress; // 도로명 주소 변수
										                var extraRoadAddr = ''; // 참고 항목 변수
										
										                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
										                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
										                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
										                    extraRoadAddr += data.bname;
										                }
										                // 건물명이 있고, 공동주택일 경우 추가한다.
										                if(data.buildingName !== '' && data.apartment === 'Y'){
										                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
										                }
										                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
										                if(extraRoadAddr !== ''){
										                    extraRoadAddr = ' (' + extraRoadAddr + ')';
										                }
										
										                // 우편번호와 주소 정보를 해당 필드에 넣는다.
										                document.getElementById('postcode').value = data.zonecode;
										                document.getElementById("roadAddress").value = roadAddr;
										                document.getElementById("jibunAddress").value = data.jibunAddress;
										                
										                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
										                /* if(roadAddr !== ''){
										                    document.getElementById("extraAddress").value = extraRoadAddr;
										                } else {
										                    document.getElementById("extraAddress").value = '';
										                }
										 				*/
										                var guideTextBox = document.getElementById("guide");
										                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
										                if(data.autoRoadAddress) {
										                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
										                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
										                    guideTextBox.style.display = 'block';
										
										                } else if(data.autoJibunAddress) {
										                    var expJibunAddr = data.autoJibunAddress;
										                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
										                    guideTextBox.style.display = 'block';
										                } else {
										                    guideTextBox.innerHTML = '';
										                    guideTextBox.style.display = 'none';
										                }
										            }
										        }).open();
										    }
										</script>
									</div>
									<div>
										<button type="submit" class="btn_payment">주문</button>
										<button type="button" class="btn_cancel">취소</button>
									</div>
								</div>
							</div><br>
						</td>
					</tr>				
				</tbody>
			 </table>
	 
	</div>
	</section><!-- 기본틀 2 -->
</section><!-- 기본틀 1 -->
</body>
</html>