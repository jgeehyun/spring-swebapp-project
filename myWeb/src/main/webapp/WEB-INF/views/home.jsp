<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<html>
<head>
	<title>Home</title>
		<!-- 합쳐지고 최소화된 최신 CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- 부가적인 테마 -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
 
</head>

<script type="text/javascript">
	$(document).ready(function(){
		$("#logoutBtn").on("click", function(){
			location.href="${pageContext.request.contextPath }/member/logout";
		})
		$("#registerBtn").on("click", function(){
			location.href="${pageContext.request.contextPath }/member/register";
		})
		$("#memberUpdateBtn").on("click", function(){
			location.href="${pageContext.request.contextPath }/member/memberUpdateView";
		})
		
	})
</script>
<body>
		<header>
			<%@include file="module/header.jsp"%>
		</header>
		
		<br>
		<br>
		<div class="container">

<c:if test="${member == null}">
	<form name='homeForm' method="post" action="${pageContext.request.contextPath }/member/login">
		
			<div>
				<label for="userId">ID:  </label>
				<input type="text" id="userId" name="userId">
			</div>
			<div>
				<label for="userPass">PW:</label>
				<input type="password" id="userPass" name="userPass">
			</div>
			<br>
			<div>
				<button type="submit">로그인</button>
				<button id="registerBtn" type="button">회원가입</button>
			</div>
			</form>
		</c:if>
		<c:if test="${member != null }">
			<div>
			<br>
			<br>
				<p>${member.userId}님 환영 합니다.</p>
				<br>
				<button id="memberUpdateBtn" type="button">회원정보수정</button>
				<button id="logoutBtn" type="button">로그아웃</button>
			</div>
		</c:if>
		<c:if test="${msg == false}">
			<p style="color: red;">로그인 실패! 아이디와 비밀번호 확인해주세요.</p>
		</c:if>
		</div>
	
</body>
</html>