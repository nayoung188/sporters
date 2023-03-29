<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="layout/header.jsp">
	<jsp:param value="Spoters홈페이지" name="title" />
</jsp:include>
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css">
<script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/sniper.css">

<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3436810b3f87959018036d9419f8c1b1"></script>

<style>
	.div_hr{
	margin:3vh 0 3vh ; 
	height: 1vh;
	border-bottom: 1px solid rgba(0,0,0,0.3);
	
	}
	.weather_map_contaner{
	
	display: flex;
	flex-wrap: nowrap;
    justify-content: space-between;
	}
	.weather_map_contaner .map_area,.weather_map_contaner .weather_area {
	width: 48%;
/*	height: 250px;
*/

	height: 14vw;
	border: 1px solid #000;
	margin-top: 20px;
	overflow: hidden;
	
}
	
	#map {
	width: 100%;
	height: 100%;
}
	.team_area{
		position:relative;
		width:100%;
		/*
		height:400px;
		*/
	/*	overflow: hidden;*/
		margin-bottom: 50px;
		height: 20vw;
	}
	
	.team_area .swiper{
		width:100%;
		
	}
	.team_area .swiper-slide{
		background-size: cover;
		background-position: top;
		background-repeat: no-repeat;
	}
	.team_area img{
		width:100%; 
		opacity: 0;
	}

	.local_board_image_Area{
		margin-top: 5vw;
		width:100%;
		display: flex;
		justify-content: space-between;			
	
		
	}
	
	.spo_review_list{
		text-align: right;
		margin:1vw 0 5vw 0;
	}
	
	
	
	.local_board_image_Area li{
	
    width: 30%;
    height: 300px;	
	
	}
	.local_board_image_Area li img{
	width:100%;
	opacity: 0;
	}
	
	#preview{
		position: absolute;
		z-index: 10;
		
	}

    #moveDetail{
    position:relative;
    display: block;
    width: 100%;
    height: 100%;
    
    background-size: cover;
		background-position: top;
    
    }
    
    #moveDetail span{
    margin:0;
    position: absolute;
    top:0;
    left: 0;
    display: block;
    line-height: 40px;
    width: 100%;
    text-align: center;
    background-color: rgba(300,300,300,0.8); 
    }
    
    
    .swiper-button-next{
    
    	right: -40px;
    }
    
    .swiper-button-prev{
    	
    	left: -40px;
    }
    
    .weather ul{
    	display: flex;
    	    flex-wrap: nowrap;
    align-items: center;
    justify-content: space-around;
    line-height: 14vw;
    font-size: 1.3vw;
    }
    
    
    .citys{
        display: flex;
    align-content: center;
    flex-wrap: nowrap;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    line-height: 0;
    }
    
    
    .citys p{
        height: 3vw;
    }
</style>

<body>




<section class="wrap"><!-- 기본틀 1 -->
	<section class="content_leyout_section"><!-- 기본틀 2 -->
	
		<div> <!-- 여기부터 각자 내용 넣기 시작 -->
			
			<h1 style="height:50px;line-height:40px;margin-bottom: 20px;">
			<!--  
			<span class="spinner-double-section-out"></span>
			-->
			
			
			<a href="/chat/chatList">채팅하러가기</a></h1>
			
			
	<div class="weather_map_contaner"><!-- 메인 상단 날씨 위치 영역 끝 -->
			
	<div class="weather_area">
		<div id="openweathermap-widget-12"></div>
		
		<div class="weather">
			
			<ul style="display: flex;justify-content: space-around;align-items: center;font-size: 2.4vw;line-height: 14vw;">
				<li class="icons"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAACXBIWXMAAAsTAAALEwEAmpwYAAAE7ElEQVR4nO2dS48bRRCAGwhIPITEsomrvQ6PAxwgIA4QAWcOLFcIAs7AXwiPKwhxzQP+QxAcEg5wWtbdNouUCyjcUBCwQsBugkAkWbtKalTjMdl4/WTtnprp+qS+2J7p6f7cPdM9NT3GKIqiKIqiKIpSBsJ5c2sI5qaij0MxxpCrvYwe/kRn/yYHx7RSCgad/Y28DZzQ21+LPp7koVxGPyVfIUVDKkQWpEJkQSpEFqRCZEEqRBakQmRBKkQWpELGEzaW7sYmPB/ajZWqCgktuB8drIYva3cayYS1g3ehsz9k0xgOrqCHF6smBFvwEnq4lk/VfB/O2zuMVNDDC7srB71FLkBVhGAmw+INZXT154xUwnrtQfSwE1MKentxV14Xo8rwcC2s1w8byQw/8MVJQQer6GAzT6tVKNPc4XMHOtsdKACRs6+ZkoGjytK0r5oyUQUpWBUZVZCCVZNRZilYVRllPCliiY51Adfw0AlfrTxkhBCa9YeHtIzqyRgrZYbChmBu7rpDT5O375C3n5K3F9DDZa7ELHm4zJ9l3zn7Nv+Wt5l2/xy1koyMG6Q46OQt5JfQbixN2iZsrDTQwwc81hgcmU9KnAdvy/uYmM839Xv59/3WW3kZfbib4hPnJBkhqyD7cV/gfhLPIKCzH/E+x+bZbixlxyaoKxUBteqvoIPt/YoYImaLg+uKLl9pCGvmALeKeYvYK8ae5ryKLq9oQrtxO3l7btEyric4y3kWXW6RhDPmFvLwWTwZeXL2c20pQ4jRTdHo7utU/L+g8BN4UTLov5aikfO7LzO3ihaCDrbDml02qVNkV0V7ui44aVImG4HPYdBH8xOyEytaRiQ8pVG0BNrbdb1vUoQn/dDDzwKFbPIluEmNfNY2SEzddu2oSQ3y8G7RFU+jkrPHTWoUMir3Uwv5xKRGfiNJqpDvjFTQwYf9WNZZEkcRjgtcQweXCq94P+rYYSt2fUxFx9ef2FfBHGyOKVhHsJCd2PWhQnwJhWT/5N697CvzbqKl7bL8YuqjcPSkLow8jCcITWdMauSxVUFkcgkODEVPnbTgKZMaYicXPfw0S7RjpdDpd2HkIaI7glrHTtI3qBgO7xQjxMEJkzq9IAf7hwAZ25PifpOBY20LF9JKJNJ9WjjWlrSrkhZKaosYvZ/TUNKxwdZwNp4MDbae7nEEb09FOImf0JYxA+Tg2CKuvtDZ3/UEPtgK1pdt18OTk6YoQi/u9+Q8Bo982zVrFe6+e8bmeeGR27qt+rOhCQdNCvQeyoerWUU5+GKaeaPgD9c5ovD/zH3x3BQ6+x7vY2I+a+YAebvR287+E2O9L3GPRXeaK4/P9Fh0u3aUnH2LQ3U4OoTvPGZPzPbSJfLwbf7dcZ61nWWisOvrzyTzWPSIhQOuSnoEIKwv28GIkkpKGblchcAuAblLrfLSGmVcyAVLuGBOZWVUVkqZZVROSuwljsIC30FV+uWaYheAIryDqrRSOu1Dj8VebwojvYNq+GW77XZatSNGKuTsm7H/RTQwMl9kXsOkkLdvGKmEr2sPoLN/xVxviiIKub7eV68X4LLyOvBGMiyFvH2942qPxsiPIgthuJviMnJZY+RXKqgAIcoYVIgwSFuILEiFyIJUiCxIhciCVIgsSIXIglSILNDZH2O8g0oR9A4qRVEURVEURVEUU2H+BQG+q+d+yzpFAAAAAElFTkSuQmCC"></li>
				<li class="citys">
				
					
					<p class="">서울</p>
					<p class="ctemp">현재온도 :</p>
				
				</li>
				<!-- 			<li class="time">현재 시간 : </li> -->
				
				<!--  
				<li class="hightemp">최고 온도 :</li>
				<li class="lowtemp">최저 온도 :</li>
				<li class="humidity">습도 :</li>
				<li class="wind">풍속 :</li>
				-->
			</ul>
		</div>
		<!-- 날씨 api 주소 -->
	</div>
			
			
	<div class="map_area">
		<div id="map"></div>
		<script type="text/javascript">
			 function success({ coords, timestamp }) {
				 /*
		            const latitude = coords.latitude;   // 위도
		            const longitude = coords.longitude; // 경도
		           */
		      //     var latitude = 33.450701;   // 제주도 카카오 사옥 좌표
		      // 	var longitude = 126.570667;  // 제주도 카카오 사옥 좌표 
		             var latitude = 37.4730836;
		             var longitude = 126.8788276;
		            
		            
		            
		            var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
					var options = { //지도를 생성할 때 필요한 기본 옵션
						center: new kakao.maps.LatLng(latitude, longitude), //지도의 중심좌표.
						level: 6 //지도의 레벨(확대, 축소 정도)
					};
					
					var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
					
					// 마커가 표시될 위치입니다 
					var markerPosition = new kakao.maps.LatLng(latitude, longitude); 

					// 마커를 생성합니다
					var marker = new kakao.maps.Marker({
					    position: markerPosition
					});
					// 마커가 지도 위에 표시되도록 설정합니다
					marker.setMap(map);
					var iwContent = '<div style="padding:5px;">현재 나의 위치!</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
				    iwPosition = new kakao.maps.LatLng(latitude, longitude); //인포윈도우 표시 위치입니다

					// 인포윈도우를 생성합니다
					var infowindow = new kakao.maps.InfoWindow({
					    position : iwPosition, 
					    content : iwContent 
					});
					// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
					infowindow.open(map, marker); 
		            
		            
		            
		            
		        }

		        function getUserLocation() {
		            if (!navigator.geolocation) {
		                throw "위치 정보가 지원되지 않습니다.";
		            }
		            navigator.geolocation.watchPosition(success);
		        }

		        getUserLocation();
			
			
			
			
			
				
				
				
				
				
			</script>

		</div>
		
			
			
			</div><!-- 메인 상단 날씨 위치 영역 끝 -->
			
		<div class="div_hr"></div>	
			
			
			<ul class="local_board_image_Area">
				<c:forEach items="${selectindexThumbNail}"  var="gallery" varStatus="vs">
					<!-- 	
					<li>
						${beginNo - vs.index}	
					</li>	
					 -->			
					<li >
						<a id="moveDetail" href="/local/increase/hit?localBoardNo=${gallery.localBoardNo}" style="background-image: url(/load/image/${gallery.localImagess.filesystem})" >
						<span> ${gallery.title}</span>
						<br>						
							<img  style="width:100%;height:100%;" src="/load/image/${gallery.localImagess.filesystem}"  class="thumbnail">								
						</a>	
					</li>								
				</c:forEach>		
			</ul>
			<div class="spo_review_list">
			
				<a href="/spo_review/list">▶ 운동후기게시판</a>
			</div>
			
			
			
		<div class="div_hr"></div>
			
		<!-- 메인 슬라이드 시작 -->
		<div class="team_area">    
	    <div class="swiper mySwiper">
	      <div class="swiper-wrapper">
	      <!--  -->
	        <div class="swiper-slide" style="background-image: url('https://cdn.barnimages.com/wp-content/uploads/2022/01/20210118-barnimages-4-740x490.jpg');">      
	         	<p><img src="https://cdn.barnimages.com/wp-content/uploads/2021/01/20210104-barnimages-4-740x493.jpg"> </p>	         	      
	        </div>
	        <div class="swiper-slide" style="background-image: url('https://cdn.barnimages.com/wp-content/uploads/2018/04/2017-03-27-roman-drits-barnimages-015-740x493.jpg');"> 
	                <p><img src="https://cdn.barnimages.com/wp-content/uploads/2018/04/2017-03-27-roman-drits-barnimages-015-740x493.jpg"></p>
	        </div>
	        <div class="swiper-slide" style="background-image: url('https://media.istockphoto.com/id/1162195279/photo/fit-happy-poeple-playing-tennis-together-sport-concept.jpg?b=1&s=170667a&w=0&k=20&c=gy8zXit5OesRkF5FW7I7WEK0aKT8XmmVYoXVv2EzgJs=');"> 
	           <p><img src="https://media.istockphoto.com/id/1162195279/photo/fit-happy-poeple-playing-tennis-together-sport-concept.jpg?b=1&s=170667a&w=0&k=20&c=gy8zXit5OesRkF5FW7I7WEK0aKT8XmmVYoXVv2EzgJs="></p>
	        </div>
	        <div class="swiper-slide" style="background-image: url('https://media.istockphoto.com/id/514260952/photo/climbing.jpg?b=1&s=170667a&w=0&k=20&c=VeHeBniExMc8azxV7XghGx7hQMjVUCLo5aLw3kYGkG0=');"> 
	              <p><img src="https://media.istockphoto.com/id/514260952/photo/climbing.jpg?b=1&s=170667a&w=0&k=20&c=VeHeBniExMc8azxV7XghGx7hQMjVUCLo5aLw3kYGkG0="></p>
	        </div>	      
	      </div>
	      <div class="swiper-pagination"></div>   
	      
		
		</div>
	      <div class="swiper-button-next" tabindex="0" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-02491101839f2d8c1" aria-disabled="false"></div>
	      <div class="swiper-button-prev" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-02491101839f2d8c1" aria-disabled="true"></div>
	    	<div class="spo_review_list">
			
				<a href="/shop/list">▶ 쇼핑몰</a>
			</div>
	    </div>    
			
			
	
			
			
			
			
			
		</div><!-- 여기부터 각자 내용 넣기 끝 -->
		
	</section><!-- 기본틀 2 -->
	
</section><!-- 기본틀 1 -->


<script type="text/javascript">




<!-- 날씨 api 구현 -->

$(document).ready(function(position) {
//위치 측정 불가인 경우 기본 경/위도 : 서울
//	var  = 33.450701;   // 제주도 카카오 사옥 좌표
//var  = 126.570667;  // 제주도 카카오 사옥 좌표 
	var lat = 37.4730836;
    var lon = 126.8788276;
var options = {
   enableHighAccuracy : true,
   timeout : 5000,
   maximumAge : 0
};
function success(pos) {
   var crd = pos.coords;
   
  
   var lat = 37.4730836;
   var lon = 126.8788276;
   
};
function error(err) {
   console.warn('ERROR(' + err.code + '): '
         + err.message);
};
navigator.geolocation.getCurrentPosition(success, error, options);
var wAPI = '17f7777f4c3c5d6b66df232b3ee2ffc8'

    function successs({ coords, timestamp }) {
          //   lat = coords.latitude;   // 위도
           //  lon = coords.longitude; // 경도
               lat = coords.latitude;   // 위도
               lon = coords.longitude; // 경도
              
       
//var url = 'https://api.openweathermap.org/data/2.5/weather?lat=' + lat + '&lon=' +lon+ '&appid=' + '9e59ce9dcb1014633e13dc6b7a7ffa54' + &units=metric';
$.ajax({
      url : 'https://api.openweathermap.org/data/2.5/weather?lat='+ lat+ '&lon=' + lon + '&appid=' + wAPI + '&units=metric',
      dataType : 'json',
      type : 'POST',
      f
      success : function(result) {
      // 보여질 정보
      $('.city').append(result.name);
      $('.ctemp').append(result.main.temp);
      $('.lowtemp').append(result.main.temp_min);
      $('.hightemp').append(result.main.temp_max);
      $('.humidity').append(result.main.humidity);
      $('.wind').append(result.wind.speed);
      //아이콘
      var wiconUrl = '<img width="100" src="http://openweathermap.org/img/wn/'+ result.weather[0].icon + '.png" alt="'+result.weather[0].description +'">'
      $('.icon').html(wiconUrl);
//       //현재시간
//       var ct = result.dt;
//       function convertTime(t) {
//          console.log(t)
//          var ot = new Date(t * 1000);
//          var hr = ot.getHours();
//          var m = ot.getMinutes();
//          var s = ot.getSeconds();
//          var mo = ot.getMonth() + 1;
//          var d = ot.getDate();
//          //return ot;
//          return mo + '월' + d + '일' + '  '
//                + hr + ':' + m + ':' + s;
            
//       }
      }
})
 }
 function getUserLocation() {
      if (!navigator.geolocation) {
          throw "위치 정보가 지원되지 않습니다.";
      }
      navigator.geolocation.getCurrentPosition(successs);
  }

  getUserLocation();
});


var swiper = new Swiper(".mySwiper", {
	   loop:true,
	   navigation: {
	        nextEl: ".swiper-button-next",
	        prevEl: ".swiper-button-prev",
	      },
	  slidesPerView: 3,
	  spaceBetween: 30,
	  pagination: {
	    el: ".swiper-pagination",
	    clickable: true,
	  }
	});




/*

한장씩 fade 시키는 슬라이드
var swiper = new Swiper(".mySwiper", {
	loop:true,
  spaceBetween: 30,
  effect: "fade",
  autoplay: {
      delay: 1500,
      disableOnInteraction: false,
    },
  navigation: {
    nextEl: ".swiper-button-next",
    prevEl: ".swiper-button-prev",
  },
  pagination: {
    el: ".swiper-pagination",
    clickable: true,
  },
});

*/
</script>






<!-- 

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

 -->
<jsp:include page="layout/footer.jsp">
	<jsp:param value="we_are_best_team" name="title" />
</jsp:include>
</body>
</html>