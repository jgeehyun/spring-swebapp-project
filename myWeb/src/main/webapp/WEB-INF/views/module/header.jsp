<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style type="text/css">
li {
	list-style: none;
	float: left;
	padding: 6px;
}
</style>
<h1><a href="#">MaFood</a></h1>
<ul>
	<li><a href="${pageContext.request.contextPath }/board/EatDeal">EAT딜</a></li>
	<li><a href="${pageContext.request.contextPath }/board/list">맛집 리스트</a></li>
	<li><a href="${pageContext.request.contextPath }/board/FoodStory">푸드 스토리</a></li>
	<li>
		<c:if test="${member != null}">
			<p>${member.userId}님 안녕하세요.</p>
			<ul>
				<li><a href="${pageContext.request.contextPath }/member/memberUpdateView">회원정보수정</li>
				<li><a href="${pageContext.request.contextPath }/member/logout">로그아웃</a></li>
		</ul>
		</c:if>		
		<c:if test="${member == null}"><a href="${pageContext.request.contextPath }/">로그인</a></c:if>
	</li>
</ul>