<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script type="text/javascript" src="./js/menu.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<!-- 부트스트랩 사용 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@        5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

<script type="text/javascript">
$(function(){
let images = ['1.jpg', '2.jpg', '3.jpg', '4.jpg', '5.jpg', '6.jpg', '7.jpg', '8.jpg', '9.jpg', '10.jpg', '11.jpg', '12.jpg', '13.jpg', '14.jpg', '15.jpg', '16.jpg', '17.jpg', '18.jpg', '19.jpg', '20.jpg', '21.jpg'];
$('body').css({'background-image' : 'url(./img/' + images[Math.floor(Math.random() * images.length)] + ')', "background-size": "cover"});
});
   
      $(document).ready(function(){
        // 로그인 실패 시
        var errorMSG = '${errorMSG}';
        if(errorMSG && errorMSG.trim() !== ''){
            alert(errorMSG);
        }
    });
</script>
<style type="text/css">
/*body {
  background-image: url('./img/15.jpg');
  background-size: 100%;
  font-size: 0.75rem;
}*/

#loginBoxTitle {
  color:rgb(255, 255, 255, 0.7);
  font-weight: bold;
  font-size: 1.9rem;
  padding: 5px;
  margin-bottom: 20px;
  background: linear-gradient(to right, #270a09, #8ca6ce);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
 
}

input[type="submit"] {
  font-size: 0.75rem;
  padding: 5px 10px;
}
input[type="reset"] {
  font-size: 0.75rem;
  padding: 5px 10px;
}
.login-box {
  margin:150px auto;
  background-color: rgba(255, 255, 255, 0.8);
  border-radius: 10px;
  padding:40px 30px;
  border:5px solid #0e0e0e;width:350px;
  filter: drop-shadow(0px 0px 10px rgba(0,0,0,.5));
}

.form-group label {
  font-size: 0.75rem;
  margin:5px 0;
}
#login-btn-box{
  display: flex;
  align-items: center;
  justify-content: space-evenly;
  margin-top:10px;
}

</style>
</head>
<body>
	<div>
		<header>
			<%@ include file="menu.jsp"%>
		</header>
		<div>
			<div>
				<article>
				<div class="login-box">
				<div id="loginBoxTitle"><img alt="login" src="./img/login.png">TRIIPPP Login</div>
					<div>
						<form action="./login" method="post">
							
							<div class="form-group">
								<label style="font-weight: bold;">ID</label>
								<input type="text" name="id" id="id" class="form-control" value="">
							</div>
							<div class="form-group">
								<label style="font-weight: bold;">PASSWORD</label>	
								<input type="password" name="pw" id="pw" class="form-control" value="">
							</div>
							<div id="login-btn-box">
								<div style=""><input type="reset" id="btnReset" value="지우기" class="btn btn-Secondary"></div>
								<div style=""><input type="submit" id="btnLogin" value="로그인" class="btn btn-danger"></div>
							</div>
							<div id="errorMSG"></div>
							
								<div style="font-size: small; text-align: center">
									<br><a href="./join">회원가입</a>
									&nbsp;&nbsp;<a href="./idFind">ID 찾기</a>
									&nbsp;&nbsp;<a href="./idFind">PW 찾기</a>
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