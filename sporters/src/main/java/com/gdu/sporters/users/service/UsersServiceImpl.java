package com.gdu.sporters.users.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.gdu.sporters.users.domain.RetireUsersDTO;
import com.gdu.sporters.users.domain.SleepUsersDTO;
import com.gdu.sporters.users.domain.UsersDTO;
import com.gdu.sporters.users.mapper.UsersMapper;
import com.gdu.sporters.util.JavaMailUtil;
import com.gdu.sporters.util.SecurityUtil;


@Service
public class UsersServiceImpl implements UsersService {

	
	@Autowired
	private UsersMapper usersMapper;
	
	@Autowired
	private SecurityUtil securityUtil;
	
	@Autowired
	private JavaMailUtil javaMailUtil;
	
	
// 아이디 중복 확인
	@Override
	public Map<String, Object> isSameId(String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isUser", usersMapper.selectUsersByMap(map) != null);
		result.put("isRetireUser", usersMapper.selectRetireUsersById(id) != null);
		result.put("isSleepUser", usersMapper.selectSleepUserById(id) != null);
		return result;
	}
	
// 이메일 중복 확인
	@Override
	public Map<String, Object> isSameEmail(String email) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isUser", usersMapper.selectUsersByMap(map) != null);
		return result;
	}
	
// 닉네임 중복 확인
	@Override
	public Map<String, Object> isSameNickname(String nickname) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nickname", nickname);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isUser", usersMapper.selectUsersByMap(map) != null);
		return result;
	}	
	
	
// 인증코드
	@Override
	public Map<String, Object> sendAuthCode(String email) {

		// 인증코드 만들기
		String authCode = securityUtil.getAuthCode(6);  // String authCode = securityUtil.generateRandomString(6);
		System.out.println("발송된 인증코드 : " + authCode);
		
		// 메일 전송
		javaMailUtil.sendJavaMail(email, "[SPORTERS] 인증요청", "인증번호는 <strong>" + authCode + "</strong>입니다.");
		
		// join.jsp로 생성한 인증코드를 보내줘야 함
		// 그래야 사용자가 입력한 인증코드와 비교를 할 수 있음
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("authCode", authCode);
		return result;

	}
	
	
// 회원가입	
	@Transactional
	@Override
	public void join(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String nickname = request.getParameter("nickname");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String email = request.getParameter("email");
		String mobile = request.getParameter("mobile");
		String birthyear = request.getParameter("birthyear");
		String birthmonth = request.getParameter("birthmonth");
		String birthday = request.getParameter("birthday");
		String postcode = request.getParameter("postcode");
		String roadAddress = request.getParameter("roadAddress");
		String jibunAddress = request.getParameter("jibunAddress");
		String detailAddress = request.getParameter("detailAddress");
		String location = request.getParameter("location");
		String marketing = request.getParameter("marketing");
		
		pw = securityUtil.sha256(pw);
		name = securityUtil.preventXSS(name);
		//String birth = birthmonth + birthday;
		detailAddress = securityUtil.preventXSS(detailAddress);
		int agreeCode = 0;
		if(!location.isEmpty() && marketing.isEmpty()) {
			agreeCode = 1;
		} else if(location.isEmpty() && !marketing.isEmpty()) {
			agreeCode = 2;
		} else if(!location.isEmpty() && !marketing.isEmpty()) {
			agreeCode = 3;
		}
		
		// DB로 보낼 UsersDTO
		UsersDTO user = UsersDTO.builder()
				.id(id)
				.nickname(nickname)
				.pw(pw)
				.name(name)
				.gender(gender)
				.email(email)
				.mobile(mobile)
				.birthyear(birthyear)
				.birthmonth(birthmonth)
				.birthday(birthday)
				.postcode(postcode)
				.roadAddress(roadAddress)
				.jibunAddress(jibunAddress)
				.detailAddress(detailAddress)
				.agreeCode(agreeCode)
				.build();
		
		int result = usersMapper.insertUser(user);
		
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			if(result > 0) {
				
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", user.getId());
				UsersDTO loginUser = usersMapper.selectUsersByMap(map);
				
				// 세션에 로그인 정보 올리기
				request.getSession().setAttribute("loginUser", loginUser);
				
				// 로그인 기록 남기기
				int updateResult = usersMapper.updateAccessLog(loginUser.getUserNo());
				if(updateResult == 0) {
					usersMapper.insertAccessLog(loginUser.getUserNo());
				}
				out.println("<script>");
				out.println("alert('회원 가입되었습니다.');");
				out.println("location.href='/';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('회원 가입에 실패했습니다.');");
				out.println("history.go(-2);");
				out.println("</script>");
			}
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
// 로그인
	@Override
	public void login(HttpServletRequest request, HttpServletResponse response) {
		// 파라미터
		String url = request.getParameter("url");
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		// pw 암호화
		pw = securityUtil.sha256(pw);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("pw", pw);
		
		UsersDTO loginUser = usersMapper.selectUsersByMap(map);
		
		// id,pw가 일치하는 회원 -> 로그인 기록 남기기 + session에 loginUser 저장
		if(loginUser != null) {
			keepLogin(request, response);
			request.getSession().setAttribute("loginUser", loginUser);
			
			// 로그인 기록 남기기
			int updateResult = usersMapper.updateAccessLog(loginUser.getUserNo());
			if(updateResult == 0) {
				usersMapper.insertAccessLog(loginUser.getUserNo());
			}
			
			// 로그인페이지 이전 페이지로
			try {
				response.sendRedirect(url);		
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		// id, pw 불일치 하면 로그인페이지로 
		else {
			try {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('일치하는 회원 정보가 없습니다.');");
				out.println("location.href='/'");
				out.println("</script>");
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
	}
	
// 로그인유지	
	@Override
	public void keepLogin(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String keepLogin = request.getParameter("keepLogin");
		
		// 로그인유지 체크 유무
		if(keepLogin != null) {
			String sessionId = request.getSession().getId();
			Cookie cookie = new Cookie("keepLogin", sessionId);
			cookie.setMaxAge(60 * 60 * 24 * 14);	// 로그인 유지기간 14일
			cookie.setPath("/");
			response.addCookie(cookie);
			
			UsersDTO users = UsersDTO.builder()
					.id(id)
					.sessionId(sessionId)
					.sessionLimitDate(new Date(System.currentTimeMillis() + 1000 * 60 * 60 * 24 * 14))
					.build();
			usersMapper.updateSessionInfo(users);
		}
		else {
			// keppLogin 쿠키 제거
			Cookie cookie =  new Cookie("keepLogin", "");
			cookie.setMaxAge(0);
			cookie.setPath("/");
			response.addCookie(cookie);
		}
	}

// 로그아웃	
	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") != null) {
			session.invalidate();
		}
		
		Cookie cookie = new Cookie("keepLogin", "");
		cookie.setMaxAge(0);
		cookie.setPath("/");
		response.addCookie(cookie);
	}
	
	@Override
	public UsersDTO getUsersBySessionId(Map<String, Object> map) {
		return usersMapper.selectUsersByMap(map);
	}
	
	@Override
	public SleepUsersDTO getSleepUsersById(String id) {
		return usersMapper.selectSleepUserById(id);
	}
	

// 네아로
	@Override
	public String getNaverLoginApiURL(HttpServletRequest request) {
	    
		String apiURL = null;
		
		try {
			
			String requestURL = request.getRequestURL().toString();
			String requestURI = request.getRequestURI();
			String host = requestURL.substring(0, requestURL.indexOf(requestURI)); // http://localhost:9090, http://sporters.shop
			
			String clientId = "P3C81C5rIvVV7o7PVo3u";
			String redirectURI = URLEncoder.encode(host + "/users/naver/login", "UTF-8");  // 네이버 로그인 Callback URL에 작성한 주소 입력 
			SecureRandom random = new SecureRandom();
			String state = new BigInteger(130, random).toString();
			
			apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
			apiURL += "&client_id=" + clientId;
			apiURL += "&redirect_uri=" + redirectURI;
			apiURL += "&state=" + state;
			
			HttpSession session = request.getSession();
			session.setAttribute("state", state);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return apiURL;	
	}
	
	
	@Override
	public String getNaverLoginToken(HttpServletRequest request) {
		
		// access_token 받기
		
		String clientId = "P3C81C5rIvVV7o7PVo3u";
		String clientSecret = "GUFW88pu4f";
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		
		String redirectURI = null;
		try {
			String requestURL = request.getRequestURL().toString();
			String requestURI = request.getRequestURI();
			String host = requestURL.substring(0, requestURL.indexOf(requestURI));
			redirectURI = URLEncoder.encode(host, "UTF-8");
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		StringBuffer res = new StringBuffer();  // StringBuffer는 StringBuilder과 동일한 역할 수행
		try {
			
			String apiURL;
			apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
			apiURL += "client_id=" + clientId;
			apiURL += "&client_secret=" + clientSecret;
			apiURL += "&redirect_uri=" + redirectURI;
			apiURL += "&code=" + code;
			apiURL += "&state=" + state;
			
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			con.disconnect();

		} catch (Exception e) {
			e.printStackTrace();
		}
			
		JSONObject obj = new JSONObject(res.toString());
		String access_token = obj.getString("access_token");
		return access_token;
	}
	
	
	@Override
	public UsersDTO getNaverLoginProfile(String access_token) {
		
		// access_token을 이용해서 profile 받기
		String header = "Bearer " + access_token;
		
		StringBuffer sb = new StringBuffer();
		
		try {
			
			String apiURL = "https://openapi.naver.com/v1/nid/me";
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", header);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			while ((inputLine = br.readLine()) != null) {
				sb.append(inputLine);
			}
			br.close();
			con.disconnect();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 받아온 profile을 UserDTO로 만들어서 반환
		UsersDTO user = null;
		try {
			
			JSONObject profile = new JSONObject(sb.toString()).getJSONObject("response");
			String id = profile.getString("id");
			String name = profile.getString("name");
			String gender = profile.getString("gender");
			String email = profile.getString("email");
			String mobile = profile.getString("mobile").replaceAll("-", "");
			String birthyear = profile.getString("birthyear");
			
			// 네이버 프로필은 month-day로 연결되어 있기 때문에 split으로 분리해줌
			String str = profile.getString("birthday");
			String[] array = str.split("-");
			String birthmonth = array[0];
			String birthday = array[1];
			
			user = UsersDTO.builder()
					.id(id)
					.name(name)
					.gender(gender)
					.email(email)
					.mobile(mobile)
					.birthyear(birthyear)
					.birthmonth(birthmonth)
					.birthday(birthday)
					.build();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		return user;
	}
	
	
	@Override
	public UsersDTO getNaverUserById(String id) {
		
		// 조회 조건으로 사용할 Map
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		
		return usersMapper.selectUsersByMap(map);
	}
	
	
	@Transactional
	@Override
	public void naverLogin(HttpServletRequest request, UsersDTO naverUser) {
		
		// 로그인 처리를 위해서 session에 로그인 된 사용자 정보를 올려둠
		request.getSession().setAttribute("loginUser", naverUser);		

		// 로그인 기록 남기기
		
		int userNo = naverUser.getUserNo();

		int updateResult = usersMapper.updateAccessLog(userNo);
		if(updateResult == 0) {
			usersMapper.insertAccessLog(userNo);
		}
		
	}
	
	@Transactional
	@Override
	public void naverJoin(HttpServletRequest request, HttpServletResponse response) {
		
		// 파라미터
		String id = request.getParameter("id");
		String nickname = request.getParameter("nickname");
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String mobile = request.getParameter("mobile");
		String birthyear = request.getParameter("birthyear");
		String birthmonth = request.getParameter("birthmonth");
		String birthday = request.getParameter("birthday");
		String email = request.getParameter("email");
		String location = request.getParameter("location");
		String promotion = request.getParameter("promotion");
		
		// 일부 파라미터는 DB에 넣을 수 있도록 가공
		name = securityUtil.preventXSS(name);
		String birth = birthmonth + birthday;
		String pw = securityUtil.sha256(birthyear + birth);  // 생년월일을 초기비번 8자리로 제공하기로 함
		
		int agreeCode = 0;  // 필수 동의
		if(location != null && promotion == null) {
			agreeCode = 1;  // 필수 + 위치
		} else if(location == null && promotion != null) {
			agreeCode = 2;  // 필수 + 프로모션
		} else if(location != null && promotion != null) {
			agreeCode = 3;  // 필수 + 위치 + 프로모션
		}
		
		// DB로 보낼 UserDTO 만들기
		UsersDTO user = UsersDTO.builder()
				.id(id)
				.nickname(nickname)
				.pw(pw)
				.name(name)
				.gender(gender)
				.email(email)
				.mobile(mobile)
				.birthyear(birthyear)
				.birthmonth(birthmonth)
				.birthday(birthday)
				.agreeCode(agreeCode)
				.snsType("naver")  // 네이버로그인으로 가입하면 naver를 저장해 두기로 함
				.bannedState(0)
				.build();
				
		// 회원가입처리
		int result = usersMapper.insertNaverUser(user);
		
		// 응답
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(result > 0) {
				
				// 조회 조건으로 사용할 Map
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("userNo", user.getUserNo());
				
				// 로그인 처리를 위해서 session에 로그인 된 사용자 정보를 올려둠
				request.getSession().setAttribute("loginUser", usersMapper.selectUsersByMap(map));
				
				// 로그인 기록 남기기
				int updateResult = usersMapper.updateAccessLog(user.getUserNo());
				if(updateResult == 0) {
					usersMapper.insertAccessLog(user.getUserNo());
				}				
				out.println("<script>");
				out.println("alert('회원 가입되었습니다.');");
				out.println("location.href='/';");
				out.println("</script>");				
			} else {				
				out.println("<script>");
				out.println("alert('회원 가입에 실패했습니다.');");
				out.println("history.go(-2);");
				out.println("</script>");
			}
			
			out.close();

			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	@Transactional
	@Override
	public void sleepUserHandle() {
		int insertCount = usersMapper.insertSleepUser();
		if(insertCount > 0) {
			usersMapper.deleteUserForSleep();
		}	
	}
	
// 복구	
	@Transactional
	@Override
	public void comebackUser(HttpServletRequest request, HttpServletResponse response) {
		// 복구하는 사용자 아이디
		HttpSession session = request.getSession();
		SleepUsersDTO sleepSessionUser = (SleepUsersDTO)session.getAttribute("sleepUser");
		String id = sleepSessionUser.getSleepUserId();
		SleepUsersDTO sleepUser = usersMapper.selectSleepUserById(id);
		// 복구
		int insertCount = usersMapper.insertComebackUser(sleepUser);
		int deleteCount = 0;
		if(insertCount > 0 ) {
			deleteCount = usersMapper.deleteSleepUser(id);
		}
		
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			if(insertCount > 0 && deleteCount > 0) {
				session.removeAttribute("sleepUser");
				out.println("<script>");
				out.println("alert('휴면 계정이 복구되었습니다. 휴면 계정 활성화를 위해 곧바로 로그인을 해 주세요.');");
				out.println("location.href='/';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('휴면 계정이 복구되지 않았습니다.');");
				out.println("history.back();");
				out.println("</script>");
			}
			out.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
// 회원정보수정	
	@Override
	public void modifyInfo(HttpServletRequest request, HttpServletResponse response) {
	
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String mobile = request.getParameter("mobile");
		String gender = request.getParameter("gender");
		String birthyear = request.getParameter("birthyear");
		String birthmonth = request.getParameter("birthmonth");
		String birthday = request.getParameter("birthday");
		String postcode = request.getParameter("postcode"); 
		String roadAddress = request.getParameter("roadAddress");
		String jibunAddress = request.getParameter("jibunAddress");
		String detailAddress = request.getParameter("detailAddress");


		// DB로 보낼 DTO
		UsersDTO user = UsersDTO.builder()
						.id(id)
						.name(name)
						.email(email)
						.gender(gender)
						.mobile(mobile)
						.birthyear(birthyear)
						.birthmonth(birthmonth)
						.birthday(birthday)
						.postcode(postcode)
						.roadAddress(roadAddress)
						.jibunAddress(jibunAddress)
						.detailAddress(detailAddress)
						.build();
		int result = usersMapper.updateUser(user);		
		
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(result > 0) {
				
				// 조회 조건으로 사용할 Map
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", id);
				
				// session에 올라간 정보를 수정된 내용으로 업데이트
				request.getSession().setAttribute("loginUser", usersMapper.selectUsersByMap(map));
				
				out.println("<script>");
				out.println("alert('회원 정보가 수정되었습니다.');");
				out.println("location.href='/';");
				out.println("</script>");
				
			} else {
				
				out.println("<script>");
				out.println("alert('회원 정보 수정이 실패했습니다.');");
				out.println("history.back();");
				out.println("</script>");
				
			}
			
			out.close();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	
// 비번수정	
	@Override
	public void modifyPw(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		UsersDTO loginUser = ((UsersDTO)session.getAttribute("loginUser"));
		String pw = securityUtil.sha256(request.getParameter("pw"));
		
		if(pw.equals(loginUser.getPw())) {
			try {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
				out.println("alert('현재 비밀번호와 동일한 비밀번호로 변경할 수 없습니다.');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		int userNo = loginUser.getUserNo();
		
		UsersDTO user = UsersDTO.builder()
				.userNo(userNo)
				.pw(pw)
				.build();
		int result = usersMapper.updateUserPassword(user);	
		
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(result > 0) {
				loginUser.setPw(pw);
				out.println("<script>");
				out.println("alert('비밀번호가 수정되었습니다.');");
				out.println("location.href='/';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('비밀번호가 수정되지 않았습니다.');");
				out.println("history.back();");
				out.println("</script>");
			}
			out.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
// 탈퇴	
	@Transactional
	@Override
	public void withdraw(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		UsersDTO loginUser = (UsersDTO)session.getAttribute("loginUser");
		
		RetireUsersDTO withdrawUser = RetireUsersDTO.builder()
									.retireUserNo(loginUser.getUserNo())
									.retireUserId(loginUser.getId())
									.retireJoinDate(loginUser.getJoinDate())
									.build();
		int deleteResult = usersMapper.deleteUser(loginUser.getUserNo());
		int insertResult = usersMapper.insertWithdrawUser(withdrawUser);
		
		try {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			
			if(deleteResult > 0 && insertResult > 0) {
				
				// 세션 초기화
				session.invalidate();
				
				out.println("<script>");
				out.println("alert('회원 탈퇴되었습니다.');");
				out.println("location.href='/';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('회원 탈퇴에 실패했습니다.');");
				out.println("history.back();");
				out.println("</script>");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
// 비번확인
	@Override
	public Map<String, Object> confirmPassword(HttpServletRequest request) {
		String pw =securityUtil.sha256(request.getParameter("pw"));
		
		HttpSession session = request.getSession();
		String id = ((UsersDTO)session.getAttribute("loginUser")).getId();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("pw", pw);
		
		UsersDTO user = usersMapper.selectUsersByMap(map);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isUser", user != null);
		
		return result;
	}
	

// 아이디 찾기
	@Override
	public Map<String, Object> findUser(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("findUser", usersMapper.selectUsersByMap(map));
		return result;
	}
	
	
// 임시비번전송
	@Override
	public Map<String, Object> sendTemporaryPassword(UsersDTO user) {
		String temporaryPassword = securityUtil.generateRandomString(9);
		System.out.println("임시비번 : " + temporaryPassword);
		
		String text = "";
		text += "비밀번호가 초기화되었습니다. <br>";
		text += "임시비밀번호 : <strong>" + temporaryPassword + "</strong><br><br>";
		text += "임시비밀번호로 로그인 후에 반드시 비밀번호를 변경해주세요!";
		
		javaMailUtil.sendJavaMail(user.getEmail(), "[SPORTERS] 임시비밀번호 발급", text);
		
		user.setPw(securityUtil.sha256(temporaryPassword));
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("isSuccess", usersMapper.updateUserPassword(user));
		return result;
	}
	
	
	// 유저 정보 저장
	@Override
	public void userInformation(HttpServletRequest request, Model model) {
		String id = request.getParameter("id");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		
		UsersDTO user  = usersMapper.selectUsersByMap(map);
		model.addAttribute("user", user);
	}
	
	
}