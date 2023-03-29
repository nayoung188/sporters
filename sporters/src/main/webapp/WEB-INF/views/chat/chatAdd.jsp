<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sporters - 실시간 채팅</title>
<script src="/resources/js/jquery-3.6.1.min.js"></script>
</head>
<script>
	
	$(function(){
		pwInputCheck();
		chatAddSubmit();
	});

	function pwInputCheck() {
		$('#isPw').click(function(){
			if($('#isPw').is(':checked')){
				$('#roomPw').removeAttr("disabled");
			} else {
				$('#roomPw').attr("disabled", true);
			}
		});
	}
	
	function chatAddSubmit() {
		
		$('#chatAddFrm').submit(function(){
			if($('#room_title').val() == ''){
				alert('채팅방 이름을 입력해 주세요.');
				event.preventDefault();
				$('#room_title').focus();
				return; 
			}
			if($('#isPw').val() == '') {
				alert('비밀번호를 입력해주세요.');
				event.preventDefault();
				return;
			}
		});
		
	}
	
	
</script>
<style>
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
/* wrap */
.all_wrap {
	width:800px;
	margin: 0 auto;
	margin-top: 35px;
}
.frm_wrap {
	width: 600px;
	margin: 0 auto;
	position: relative;
}
.form_content_wrap {
	margin-bottom: 30px;
}

form {
	margin-top: 50px;
}


/* input_box */
.label_name {
	font-size: 17px;
}
.input_box {
	width: 600px;
	border:none;
	border-bottom: 2px solid #8c8cff;
	outline: none;
	font-size: 18px;
}

/* select box */
select {
    width: 130px;
    margin-left: 10px;
    -webkit-appearance:none; /* 크롬 화살표 없애기 */
    -moz-appearance:none; /* 파이어폭스 화살표 없애기 */
    appearance:none /* 화살표 없애기 */
}
.selectBox {
  position: relative;
  width: 150px;
  height: 35px;
  border-radius: 4px;
  border: 2px solid #8c8cff;
  margin-left: 80px;
}
.selectBox .select {
  height: inherit;
  background: transparent;
  border: 0 none;
  outline: 0 none;
  padding: 0 5px;
  position: relative;
  z-index: 3; // select가 위로 올라와야 함
}
.selectBox .select option {
  background: #8c8cff;
  color: #fff;
  padding: 3px 0;
  font-size: 16px;
}
.selectBox .icoArrow {
  position: absolute; 
  top: 0; 
  right: 0; 
  z-index: 1; 
  width: 35px; 
  height: inherit;
  border-left: 2px solid #8c8cff;
  display: flex;
  justify-content: center;
  align-items: center;
}

.selectBox .icoArrow img {
  width: 50%;
  transition: .5s; /* 부드럽게 회전 */
}

.selectBox .select:focus + .icoArrow img {
  transform: rotate(180deg);
}

/* button */
.div_btns{
    padding-bottom: 50px;
    text-align: center;
    width: 200px;
    height: 20px;
    margin-left: 470px;
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
    top: 287px;
    right: -19px;
}

/* checkbox */
input[type="checkbox"] {
    width: 1rem;
    height: 1rem;
    border-radius: 50%;
    border: 1px solid #c8c8ff;
    appearance: none;
    cursor: pointer;
    transition: background 0.4s;
    vertical-align: middle;
}

input[type="checkbox"]:checked {
    background: #c8c8ff;
    border: none;
}

#roomPw {
	width:300px;
	height:30px;
	border: 2px solid #8c8cff;
	padding-left:10px;
	outline: none;
}
/* 모든 비활성 <input> 선택 */
input:disabled {
  	background: #dcdcdc;
}
</style>
<body>
<div class="all_wrap">
	<div id="title_wrap">
		<div class="mapage_div" style="font-size: 32px; font-weight: bold; text-align: center; margin-bottom: 40px;"> 채팅방 생성 </div>
	</div>
	<hr>
	<div class="frm_wrap">
		<form id="chatAddFrm" action="/chat/chatAdd" method="post">
			<div class="form_content_wrap">
				<label for="room_title" class="label_name">채팅방 이름</label><br>
				<input type="text" id="room_title" style="margin-top: 8px;" class="input_box" name="roomTitle" maxlength="30"><br>
			</div>
			<div class="form_content_wrap">
				<label for="max_user_cnt" class="label_name">인원수</label>
				<div class="selectBox">
			        <select id="max_user_cnt" class="select" name="maxUserCnt">
			            <option selected value="2">2</option>
			            <option value="3">3</option>
			            <option value="4">4</option>
			            <option value="5">5</option>
			            <option value="6">6</option>
			            <option value="7">7</option>
			            <option value="8">8</option>
			            <option value="9">9</option>
			            <option value="10">10</option>
			            <option value="11">11</option>
			            <option value="12">12</option>
			            <option value="13">13</option>
			            <option value="14">14</option>
			            <option value="15">15</option>
			            <option value="16">16</option>
			            <option value="17">17</option>
			            <option value="18">18</option>
			            <option value="19">19</option>
			            <option value="20">20</option>
			            <option value="21">21</option>
			            <option value="22">22</option>
			            <option value="23">23</option>
			            <option value="24">24</option>
			            <option value="25">25</option>
			            <option value="26">26</option>
			            <option value="27">27</option>
			            <option value="28">28</option>
			            <option value="29">29</option>
			            <option value="30">30</option>
			            <option value="31">31</option>
			            <option value="32">32</option>
			            <option value="33">33</option>
			            <option value="34">34</option>
			            <option value="35">35</option>
			            <option value="36">36</option>
			            <option value="37">37</option>
			            <option value="38">38</option>
			            <option value="39">39</option>
			            <option value="40">40</option>
			            <option value="41">41</option>
			            <option value="42">42</option>
			            <option value="43">43</option>
			            <option value="44">44</option>
			            <option value="45">45</option>
			            <option value="46">46</option>
			            <option value="47">47</option>
			            <option value="48">48</option>
			            <option value="49">49</option>
			            <option value="50">50</option>
			            <option value="51">51</option>
			            <option value="52">52</option>
			            <option value="53">53</option>
			            <option value="54">54</option>
			            <option value="55">55</option>
			            <option value="56">56</option>
			            <option value="57">57</option>
			            <option value="58">58</option>
			            <option value="59">59</option>
			            <option value="60">60</option>
			            <option value="61">61</option>
			            <option value="62">62</option>
			            <option value="63">63</option>
			            <option value="64">64</option>
			            <option value="65">65</option>
			            <option value="66">66</option>
			            <option value="67">67</option>
			            <option value="68">68</option>
			            <option value="69">69</option>
			            <option value="70">70</option>
			            <option value="71">71</option>
			            <option value="72">72</option>
			            <option value="73">73</option>
			            <option value="74">74</option>
			            <option value="75">75</option>
			            <option value="76">76</option>
			            <option value="77">77</option>
			            <option value="78">78</option>
			            <option value="79">79</option>
			            <option value="80">80</option>
			            <option value="81">81</option>
			            <option value="82">82</option>
			            <option value="83">83</option>
			            <option value="84">84</option>
			            <option value="85">85</option>
			            <option value="86">86</option>
			            <option value="87">87</option>
			            <option value="88">88</option>
			            <option value="89">89</option>
			            <option value="90">90</option>
			            <option value="91">91</option>
			            <option value="92">92</option>
			            <option value="93">93</option>
			            <option value="94">94</option>
			            <option value="95">95</option>
			            <option value="96">96</option>
			            <option value="97">97</option>
			            <option value="98">98</option>
			            <option value="99">99</option>
			            <option value="100">100</option>
			        </select>
			        <span class="icoArrow"><img src="/resources/images/shopAdmin/arrow.jpeg" alt=""></span>
				</div>
			</div>
			<div class="form_content_wrap cbx">
				<label for="isPw" class="label_name">비밀번호</label>
				<input type="checkbox" name="isPw" id="isPw" value="1"><br>
				<input type="text" maxlength="4" id="roomPw" name="roomPw" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" disabled><br>
			</div>
			<div class="div_btns">
				<button class="buttons purple">생성하기</button>
			</div>
		</form>
	</div>
	
</div>


</body>
</html>