<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>

body, html {
			margin: 0;
			padding: 0;
			width: 100%;
			height: 100%;
		/*	background-color:#26394E ;*/
		}

		#menu {
			height: 100%;
			position: fixed;
			background-color: #5b59d9;
			width: 300px;
			transition: 1000ms all cubic-bezier(0.19, 1, 0.22, 1);
			transform: translateX(-100%);
			left: 60px;
			top:0;
			z-index: 10;opacity: 0.7;
			
			text-indent: 20px;
						
		}

		#menu.expanded {
			transform: translateX(0%);
			left: 0px;opacity: 1;
		}

		.menu-inner {
			width: 100%;
			height: 100%;
			position: relative;
			top: 160px;
		}

		#blob {
			top: 0;
			z-index: -1;
			right: 60px;
			transform: translateX(100%);
			height: 100%;
			position: absolute;
		}

		#blob-path {
			height: 100%;
		/*	fill:  #FED057;*/
			fill:#5b59d9;
			
		}

		.hamburger {
			right: 20px;
			position: absolute;
			width: 20px;
			height: 20px;
			margin-top: -10px;	
		}

		.hamburger .line {
			width: 100%;
			height: 4px;
			background-color: #fff;
			position: absolute;
		}

		.hamburger .line:nth-child(2) {
			top: 50%; 
			margin-top: -2px;
		}

		.hamburger .line:nth-child(3) {
			bottom: 0;
		}

		.menu-inner h1 {
			position: fixed;
			right: 0;
			margin: 0;
		}
/*
		ul {
			padding: 0;
			list-style: none;
			width: 80%;
			margin-left: 10%;
			position: absolute;
			top: 10px;
		}
*/
		.menu-inner ul li {
			color: #fff;
			font-family: sans-serif;
			padding: 20px 0;
		}
	
		.menu-inner ul li a{
			color:#fff;
		}
	
		.action_mouse {
			position: absolute;
		   left: 50%;
      color: #fff;
			margin: 0;
      font-size: 16px;
      font-family: sans-serif;
      font-weight: 100;
		}


	.left_menu_hide{
		display: none;
		margin-left:20px;
	}
	
	.left_menu_hide_span{
	
		cursor: pointer;
	}
	
	.left_menu_show_span{
	cursor: pointer;
	}
	
	
	
	/* effect-shine */
	
menu-inner ul{
position: relative;
 -webkit-transform: translate(-50%,-50%);

}
menu-inner ul li:hover {
  -webkit-mask-image: linear-gradient(-75deg, rgba(0,0,0,.6) 30%, #000 50%, rgba(0,0,0,.6) 70%);
  -webkit-mask-size: 200%;
  animation: shine 2s infinite;
}

@-webkit-keyframes shine {
  from {
    -webkit-mask-position: 150%;
  }
  
  to {
    -webkit-mask-position: -50%;
  }
}
</style> 


<div id="menu">
		<div class="hamburger">
			<div class="line"></div>
			<div class="line"></div>
			<div class="line"></div>
		</div>
		<div class="menu-inner">
			
			<ul>				
			 	<li class="left_menu_hide_span ">
			 		게시판
			 		<ul  class="left_menu_hide">
			 			<li><a href="/free/list">자유게시판</a> </li>
			 			<li><a href="/local/list">운동 게시판</a> </li>
			 			<li><a href="/spo_review/list">운동후기게시판</a> </li>	
			 			<!--  			 	
					 	<li><a href="/shop/list">쇼핑몰</a> </li>
					 	<li><a href="/supp/singo">신고게시판</a> </li>
					 	<li><a href="/qna/list">고객문의게시판</a> </li>
					 	<li><a href="/faq/list">자주하는질문</a> </li>
					 	<li><a href="/admin/adminIndex">관리자게시판</a> </li>
					 	<li><a href="/admin/shopIndex">쇼핑몰관리자게시판</a> </li>
					 	-->	
			 		</ul>			 	
			 	</li>
			 	
			 	
			 	
			 	
			 	<li>
			 		<a href="/chat/chatList">실시간채팅</a>							 		
			 	</li>
			 	
			 	
			 	<li>
					<a href="/shop/list">
						쇼핑몰
					</a>			 		
			 	</li>
			 	
			 	
			 	<li  class="left_menu_hide_span">				
			 	고객지원						
					<ul class="left_menu_hide">						
			 			<li><a href="/faq/list">FAQ</a></li>
					 	<li><a href="/qna/list">QNA</a></li>
					 				 	
			 		</ul>			 		
			 	</li>
			 	<c:if test="${loginUser.id == 'admin'}">
			 	<li>
					<a href="/admin/adminIndex">
						관리자센터
					</a>			 		
			 	</li>
			 	</c:if>
			</ul>
		</div>
  
  
		
		<svg version="1.1" id="blob" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
			<path id="blob-path" d="M60,500H0V0h60c0,0,20,172,20,250S60,900,60,500z"/>
		</svg>
	</div>
	
	<p  class="action_mouse"></p>
	
<script type="text/javascript">

$('.left_menu_hide_span').click(function(){	
	/*
		$(this).removeClass('left_menu_hide_span');
		$(this).addClass('left_menu_show_span');
		.slideDown( 1000, 'swing' ); 
		
		*/
		$(this).children('.left_menu_hide').slideToggle();
	
		
		
});




	var height = window.innerHeight,
  x= 0, y= height/2,
	curveX = 10,
	curveY = 0,
	targetX = 0,
	xitteration = 0,
	yitteration = 0,
	menuExpanded = false;

	blob = $('#blob'),
	blobPath = $('#blob-path'),

	hamburger = $('.hamburger');
	playAlert = setInterval(function() {
	
	$(this).on('mousemove', function(e){
		x = e.pageX;
		
		y = e.pageY;
	});
	}, 500);
	$('.hamburger, .menu-inner').on('mouseenter', function(){
		$(this).parent().addClass('expanded');
		menuExpanded = true;
	});

	$('.menu-inner').on('mouseleave', function(){
		menuExpanded = false;
		$(this).parent().removeClass('expanded');
	});

	function easeOutExpo(currentIteration, startValue, changeInValue, totalIterations) {
		return changeInValue * (-Math.pow(2, -10 * currentIteration / totalIterations) + 1) + startValue;
	}

	var hoverZone = 150;
	var expandAmount = 20;
	
	function svgCurve() {
		if ((curveX > x-1) && (curveX < x+1)) {
			xitteration = 0;
		} else {
			if (menuExpanded) {
				targetX = 0;
			} else {
				xitteration = 0;
				if (x > hoverZone) {
					targetX = 0;
				} else {
					targetX = -(((60+expandAmount)/100)*(x-hoverZone));
				}			
			}
			xitteration++;
		}

		if ((curveY > y-1) && (curveY < y+1)) {
			yitteration = 0;
		} else {
			yitteration = 0;
			yitteration++;	
		}

		curveX = easeOutExpo(xitteration, curveX, targetX-curveX, 100);
		curveY = easeOutExpo(yitteration, curveY, y-curveY, 100);

		var anchorDistance = 200;
		var curviness = anchorDistance - 40;

		var newCurve2 = "M60,"+height+"H0V0h60v"+(curveY-anchorDistance)+"c0,"+curviness+","+curveX+","+curviness+","+curveX+","+anchorDistance+"S60,"+(curveY)+",60,"+(curveY+(anchorDistance*2))+"V"+height+"z";

		blobPath.attr('d', newCurve2);

		blob.width(curveX+60);

		hamburger.css('transform', 'translate('+curveX+'px, '+curveY+'px)');
		

    $('.action_mouse').css('transform', 'translateY('+curveY+'px)');
		window.requestAnimationFrame(svgCurve);

	}
		 
	window.requestAnimationFrame(svgCurve);
	
	/*
	playAlert = setInterval(function() {
	}, 500);
	*/


</script> 
 	
	
