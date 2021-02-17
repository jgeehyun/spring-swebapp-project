<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	 	
	 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	
	 	<title>게시판</title>
	</head>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='writeForm']");
			$(".write_btn").on("click", function(){
				if(fn_valiChk()){
					return false;
				}
				
				xssDefense();
				formObj.submit();
			});
		})
		function fn_valiChk(){
			var regForm = $("form[name='writeForm'] .chk").length;
			for(var i = 0; i<regForm; i++){
				if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
					alert($(".chk").eq(i).attr("title"));
					return true;
				}
			}
		}
		var __entityMap = {
				"&" : "&amp;",
				"<": "&lt;", 
	        ">" : "&gt;",
				'"' : '&quot;',
				"'" : '&#39;',
				"/" : '&#x2F;'
			};

			var escapeHTML = function(str) {
				return String(str).replace(/[&<>"'\/]/g, function(s) {
					return __entityMap[s];
				});
			}

			function xssDefense() {
				console.log("wow");
				var tit = document.getElementById("title");
				var con = document.getElementById("content");
				var title = escapeHTML(tit.value);
				var content = escapeHTML(con.value);

				tit.value = title;
				con.value = content;
				
			}
	</script>
	<body>
	
		<div id="container">
		<header>
			<%@include file="../module/header.jsp"%>
		</header>
			
			<section id="container">
			
				<form name="writeForm" method="post" action="${pageContext.request.contextPath }/board/write">
					<table>
						<tbody>
							<c:if test="${member.userId != null}">
								<tr>
									<td>
										<label for="title">제목</label><input type="text" id="title" name="title" class="chk" title="제목을 입력하세요."/>
									</td>
								</tr>	
								<tr>
									<td>
										<label for="content">내용</label><textarea id="content" name="content" class="chk" title="내용을 입력하세요."></textarea>
									</td>
								</tr>
								<tr>
									<td>
										<label for="writer">작성자</label><input type="text" id="writer" name="writer" class="chk" title="작성자를 입력하세요." value="${member.userId}" readonly="readonly"/>
									</td>
								<tr>
									<td>						
										<button class="write_btn">작성</button>	
									</td>
								</tr>	
							</c:if>
							<c:if test="${member.userId == null}">
								<p>로그인 후에 작성하실 수 있습니다.</p>
							</c:if>
							
						</tbody>			
					</table>
				</form>
				
			</section>
			<hr />
		</div>
	
</body>
</html>