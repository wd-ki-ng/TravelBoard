<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<script type="text/javascript" src="./js/menu.js"></script>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.7.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>


<style type="text/css">
.id-alert, .name-alert, .pw-alert{
	background-color: gray;
}
.alert{
	color: red;
}
.join-box {
  margin:150px auto;
  background-color: rgba(255, 255, 255, 0.8);
  border-radius: 10px;
  padding:40px 30px;
  border:5px solid #0e0e0e;
  width:800px;
  filter: drop-shadow(0px 0px 10px rgba(0,0,0,.5));
}
#loginBoxTitle {
	color:#000000;
	font-weight: bold;
	font-size: 1.9rem;
	padding: 5px;
	margin-bottom: 20px;
	background: linear-gradient(to right, #270a09, #8ca6ce);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
}
.input-group-text{
	font-weight: bold;
}
</style>
<script type="text/javascript">
let CHECK = false;
$(function(){
	let images = ['join.jpg']
	$('body').css({'background-image' : 'url(./img/' + images + ')', "background-size": "cover"});

   		$('form').submit(function(e) {
   			
   			if(!CHECK){
   				alert("모든 확인을 마치고 진행해주세요.");
   				return false;
   			}else{
   				e.preventDefault(); // 폼의 기본 동작을 막음
   	        	$.ajax({
   	            	url: $(this).attr('action'),
   	            	type: 'POST',
   	            	data: $(this).serialize(),
   	            	success: function(result) {
   	                	if (result == 1) {
   	                    	alert('회원가입이 성공적으로 완료되었습니다.');
   	                    	window.location.href = './login';
   	                	} else {
   	                    	alert('회원가입에 실패하였습니다.');
   	                	}
   	            	},
   	            	error: function() {
   	                	alert('서버와의 통신 중에 오류가 발생하였습니다.');
   	            	}
   	        	});
   			}
        
    	});
	});

	let idCheckBool = false;

	$(function() {
		$('.id-alert, .name-alert, .pw-alert').hide();

		$('#id').on(
				"change keyup paste",
				function() {
					$('.id-alert').show();
					$('.id-alert').html('<p class = "alert">당신이 입력한 ID는 ' + $('#id').val() + '</p>');
					//if($('#id').val().length > 4)
				});
	});
	
	function findId() {
	    alert("ID를 찾습니다.");
	    window.location.href = './idFind';
	}

	function findPw() {
	    alert("PW를 찾습니다.");
	    window.location.href = './pwFind';
	}

	function check() {

		let id = $("#id").val();
		if (id.length < 4 || id == "") {
			$('.id-alert').show();
			$('#id').focus();
			return false;
		} else {
			$('.id-alert').hide();
		}
		if (!idCheckBool) {
			alert("ID검사를 먼저 진행해주세요.");
			return false;
		} 

		let name = $('#name').val();
		if (name.length < 2) {
			$('.name-alert').show();
			$('#name').focus();
			alert("이름은 2글자 이상이어야 합니다.");
			return false;
		}
		$('.name-alert').hide();

		let pw1 = $('#pw1').val();
		if (pw1.length < 8 || pw1 == "") {
			alert("암호는 8글자 이상이어야 합니다.");
			$('.pw-alert').show();
			$('#pw1').focus();
			return false;
		}

		let pw2 = $('#pw2').val();
		if (pw2 != pw1) {
			alert("암호는 동일해야 합니다.");
			$('#pw2').val("");
			$('#pw2').focus();
			return false;
		} else {			
			CHECK = true;
		}
	}

	function idCheck() {
		alert('id검사를 진행합니다.');
		let id = $('#id').val();
		const regExp = /^[a-z0-9]{5,15}$/;
		if (id.length < 4 || !regExp.test(id)) {
			$('.id-alert').html('<p class="alert">아이디는 5글자 이상 15글자 미만이고, 특수문자가 없어야 합니다.</p>');
			$('#id').focus();
		} else {
			//AJAX로 가상폼 방식으로 서블릿에 전달
			$.ajax({
				url : './idCheck',
				type : 'post',
				dataType : 'text',
				data : {id : id},
				success : function(result) {
					if (result == 1) {
						$('.id-alert').append('<p class="alert">중복된 id입니다.</p>');
						$('.id-alert .alert').css("color","red");
						$('.id-alert .alert').css("font-weight","bold");
						idCheckBool = false;
						$("#joinBtn").attr("disabled", "disabled");//가입버튼 비활성화
						$('#id').focus();
					} else {
						$('.id-alert').append('<p class="alert">사용 가능한 id입니다.</p>');
						$('.id-alert .alert').css("color", "blue");
						$('.id-alert .alert').css("font-weight","bold");
						idCheckBool = true;
						$("#joinBtn").removeAttr("disabled");//가입버튼 활성화
					}
				},
				error : function(request, status, error) {
					alert("에러가 발생했습니다.");
				}
			});
		}
		return false;
	}
</script>

</head>
<body>
	<div>
		<header>
			<%@ include file="menu.jsp"%>
		</header>
		<div class="main">
			<div class="mainStyle">
				<article>
					<div class="join-form">
						
						<div class="join-box" style="justify-content: center;">
						<div id="loginBoxTitle" style="margin: 0 auto; width: 700px">JOIN</div>
							<form action="./join" method="post" onsubmit="return check();" style="width: 100px auto;">
								<div class="input-group mb-2" style="width: 700px; margin: 0 auto; padding: 0 auto;">
									<label class="input-group-text">아이디</label>
									<input type="text" id="id" name="id" class="form-control" placeholder="ID를 입력해주세요">
									<button class="btn btn-danger input-group-text"
										onclick="return idCheck()">ID검사</button>
								</div>
								<div class="input-group mb-2 id-alert">
									<p class="alert">올바른 아이디를 입력해주세요</p>
								</div>
								<div class="input-group mb-2" style="width: 700px; margin: 0 auto; padding: 0 auto;">
									<label class="input-group-text">이&ensp;&ensp;름</label>
									<input type="text" id="name" name="name"
										class="form-control" placeholder="이름을 입력해주세요">
								</div>
								<div class="input-group mb-2 name-alert">
									<p class="alert">올바른 이름을 입력해주세요</p>
								</div>
								<div class="input-group mb-2" style="width: 700px; margin: 0 auto; padding: 0 auto;">
									<label class="input-group-text">Password</label>
									<input type="password" id="pw1" name="pw1" class="form-control" placeholder="PW를 입력해주세요">
									<label class="input-group-text">Password 확인</label>
									<input type="password" id="pw2" class="form-control" placeholder="PW를 한번 더 입력해주세요">
								</div>
								<div class="input-group mb-2 pw-alert">
									<p class="alert">올바른 Password를 입력하세요</p>
								</div>
								<div class="input-groub mb-2" style="width: 700px; margin: 0 auto; padding: 0 auto;">
									<label class="input-group-text">힌트 질문</label>
									<input type="text" id="mhint" name="mhint" class="form-control" placeholder="힌트로 쓰일 질문을 입력해주세요">
								</div>
								<div class="input-groub mb-2" style="width: 700px; margin: 0 auto; padding: 0 auto;">
									<label class="input-group-text">힌트 답변</label>
									<input type="text" id="manswer" name="manswer" class="form-control" placeholder="힌트에 대한 답변을 입력해주세요">
								</div>
								<div class="input-group mb-2" style="width: 700px; margin: 0 auto; padding: 0 auto;">
									<button type="reset" class="btn btn-danger">초기화</button>
									<button id="joinBtn" type="submit" disabled="disabled" class="btn btn-primary">가입하기</button>
								</div>
							</form>
						</div>
					</div>
				</article>
			</div>
			
		</div>
	</div>
</body>
</html>