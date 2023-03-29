<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
	<style> @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap'); </style>
<style>
.right_side_menu_area {
	position: fixed;
	
		right:0px;
		top:164px;
		
	border: 1px solid #000;
}

.right_side_menu_area .weather_area {
	width: 200px;
	height: 200px;
	border: 1px solid #000;
}

.right_side_menu_area .map_area {
	width: 200px;
	height: 200px;
	border: 1px solid #000;
	margin-top: 20px;
}

.right_side_menu_area .right_side_board_list {
	width: 200px;
	height: 800px;
	border: 1px solid #000;
	margin-top: 20px;
}

#map {
	width: 100%;
	height: 100%;
}

.weather{
font-family: 'Poppins', sans-serif;
}


</style>


<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3436810b3f87959018036d9419f8c1b1"></script>

<nav class="right_side_menu_area"   style="display:none;">

<nav class="right_side_menu_area" style="display: none;">

	<div class="weather_area">
		<div id="openweathermap-widget-12"></div>
		<!-- <script>window.myWidgetParam ? window.myWidgetParam : window.myWidgetParam = [];  window.myWidgetParam.push({id: 12,cityid: '1835848',appid: '17f7777f4c3c5d6b66df232b3ee2ffc8',units: 'metric',containerid: 'openweathermap-widget-12',  });  (function() {var script = document.createElement('script');script.async = true;script.charset = "utf-8";script.src = "//openweathermap.org/themes/openweathermap/assets/vendor/owm/js/weather-widget-generator.js";var s = document.getElementsByTagName('script')[0];s.parentNode.insertBefore(script, s);  })();</script> -->
		<div class="weather">
			<ul>
				<li class="icon"></li>
				<li class="city"></li>
				<!-- 			<li class="time">현재 시간 : </li> -->
				<li class="ctemp">온도 :</li>
<!-- 				<li class="hightemp">최고 온도 :</li> -->
<!-- 				<li class="lowtemp">최저 온도 :</li> -->
				<li class="humidity">습도 :</li>
<!-- 				<li class="wind">풍속 :</li> -->
			</ul>
		</div>
		<!-- 날씨 api 주소 -->
	
  <!-- 날씨 api 구현 -->
      <script>
   $(document).ready(function(position) {
      //위치 측정 불가인 경우 기본 경/위도 : 서울
    	var lat = 33.450701;   // 제주도 카카오 사옥 좌표
		var lon = 126.570667;  // 제주도 카카오 사옥 좌표 
           
      var options = {
         enableHighAccuracy : true,
         timeout : 5000,
         maximumAge : 0
      };
      function success(pos) {
         var crd = pos.coords;
         
         console.log('위도 : ' + crd.latitude);
         console.log('경도: ' + crd.longitude);
         lat = crd.latitude;
         lon = crd.longitude;
      };
      function error(err) {
         console.warn('ERROR(' + err.code + '): '
               + err.message);
      };
      navigator.geolocation.getCurrentPosition(success, error, options);
      var wAPI = '17f7777f4c3c5d6b66df232b3ee2ffc8'

          function successs({ coords, timestamp }) {
                   lat = coords.latitude;   // 위도
                   lon = coords.longitude; // 경도
                  
                    
             
      //var url = 'https://api.openweathermap.org/data/2.5/weather?lat=' + lat + '&lon=' +lon+ '&appid=' + '9e59ce9dcb1014633e13dc6b7a7ffa54' + &units=metric';
      $.ajax({
            url : 'https://api.openweathermap.org/data/2.5/weather?lat='+ lat+ '&lon=' + lon + '&appid=' + wAPI + '&units=metric',
            dataType : 'json',
            type : 'POST',
            
            success : function(result) {
            // 보여질 정보
            $('.city').append(result.name);
            $('.ctemp').append(result.main.temp);
//             $('.lowtemp').append(result.main.temp_min);
//             $('.hightemp').append(result.main.temp_max);
            $('.humidity').append(result.main.humidity);
//             $('.wind').append(result.wind.speed);
            //아이콘
            var wiconUrl = '<img width="100" src="http://openweathermap.org/img/wn/'+ result.weather[0].icon + '.png" alt="'+result.weather[0].description +'">'
            $('.icon').html(wiconUrl);
//             //현재시간
//             var ct = result.dt;
//             function convertTime(t) {
//                console.log(t)
//                var ot = new Date(t * 1000);
//                var hr = ot.getHours();
//                var m = ot.getMinutes();
//                var s = ot.getSeconds();
//                var mo = ot.getMonth() + 1;
//                var d = ot.getDate();
//                //return ot;
//                return mo + '월' + d + '일' + '  '
//                      + hr + ':' + m + ':' + s;
                  
//             }
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
   
</script>

	</div>

	<div class="map_area"> 
		<div id="map"></div>
		<script type="text/javascript">
			 function success({ coords, timestamp }) {
		            const latitude = coords.latitude;   // 위도
		            const longitude = coords.longitude; // 경도
		            
		            console.log(latitude);
		            console.log(longitude);
		         //   alert(`위도: ${latitude}, 경도: ${longitude}, 위치 반환 시간: ${timestamp}`);
		           // alert(longitude);
		            
		            
		            
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
		
		
		
		
		<!-- 
		<div class="right_side_board_list">

			<ul>
				<c:forEach items="${galleryList}" var="gallery" varStatus="vs">									
					<li>
						<a id="moveDetail"
						href="/free/increase/hit?freeNo=${gallery.freeNo}">${gallery.title}</a>
					</li>									
					
				
				</c:forEach>	
				<li> 로컬게시판 최신글	</li>		
			</ul>
		 
		</div>
		-->
		<div class="right_side_board_list">
		<ul>
			<li>right_side_board_list</li>
			<li>right_side_board_list</li>
			<li>right_side_board_list</li>
			<li>right_side_board_list</li>
		</ul>
	</div>
	</nav>

	

	


