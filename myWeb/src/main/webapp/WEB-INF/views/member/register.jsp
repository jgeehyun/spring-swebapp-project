<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	 	
	 	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<title>회원가입</title>
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			var idValid = "N";
			var pwValid = "N";
			
			// 취소
			$(".cancle").on("click", function(){
				history.go(-1);
			})
		
			$("#submit").on("click", function(){
				if($("#userId").val()==""){
					alert("아이디를 입력해주세요.");
					$("#userId").focus();
					return false;
				}
				if($("#userPass").val()==""){
					alert("비밀번호를 입력해주세요.");
					$("#userPass").focus();
					return false;
				}
				if($("#userName").val()==""){
					alert("성명을 입력해주세요.");
					$("#userName").focus();
					return false;
				}
				
				var idChkVal = $("#idChk").val();
				if(idChkVal == "N"){
					alert("중복확인 버튼을 눌러주세요.");
					return false;
				}else if(idChkVal == "Y" && idValid == "Y" && pwValid == "Y"){
					$("#regForm").submit();
				}
			});
													
		})		

		function fn_idChk() {

			if($("#userId").val()==""){
				alert("아이디를 입력해주세요.");
				$("#userId").focus();
				return;
			}
			
			$.ajax({
				url : "${pageContext.request.contextPath }/member/idChk",
				type : "post",
				dataType : "json",
				data : {
					"userId" : $("#userId").val()
				},
				success : function(data) {
					if (data == 1) {
						alert("중복된 아이디입니다.");
					} else if (data == 0) {
						$("#idChk").attr("value", "Y");
						alert("사용 가능한 아이디입니다.");
					}
				}
			})
		}
		
		function idValidChk() {
			var id = $.trim($("#userId").val());
			
			var idReg = /^[a-zA-Z]+[a-z0-9]{4,9}$/g;

			if(idReg.test(id)){
				console.log("true");
				$('#idValidCheck').css("display", "none");
				idValid = "Y";
				console.log(idValid);
			}else{
				console.log("else");
				$('#idValidCheck').css("display", "block");
				idValid = "N";
				console.log(idValid);
			}
		}
		function pwValidChk() {
			var pw = $.trim($("#userPass").val());
			
			var pwReg = /^[a-zA-Z]+[a-z0-9]{7,14}$/g;

			if(pwReg.test(pw)){
				console.log("true");
				$('#pwValidCheck').css("display", "none");
				pwValid = "Y";
				console.log(pwValid);
			}else{
				console.log("else");
				$('#pwValidCheck').css("display", "block");
				pwValid = "N";
				console.log(pwValid);
			}
		}
	</script>
	<body>
		<section id="container">
			<form action="${pageContext.request.contextPath }/member/register" method="post">
				<div class="form-group has-feedback">
					<label class="control-label" for="userId">아이디</label>
					<input class="form-control" type="text" id="userId" name="userId" onkeyup="idValidChk();" /> 
					<span id="idValidCheck" style="color:red;">영어 대문자, 소문자로 시작하고 5글자 이상 10글자 이하여야 합니다.</span>
					<button class="idChk" type="button" id="idChk" onclick="fn_idChk();" value="N">중복확인</button>
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userPass">패스워드</label>
					<input class="form-control" type="password" id="userPass" name="userPass" onkeyup="pwValidChk();"/>
					<span id="pwValidCheck" style="color:red;">영어 대문자, 소문자로 시작하고 8글자 이상 15글자 이하여야 합니다.</span>
				</div>
				<div class="form-group has-feedback">
					<label class="control-label" for="userName">성명</label>
					<input class="form-control" type="text" id="userName" name="userName" />
				</div>
				<div class="form-group has-feedback">
					<button class="btn btn-success" type="submit" id="submit" >회원가입</button>
					<button class="cancle btn btn-danger" type="button">취소</button>
				</div>
			</form>
		</section>
		
	</body>
	
</html>