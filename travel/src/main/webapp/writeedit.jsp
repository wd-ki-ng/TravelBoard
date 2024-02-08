<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정 중</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- bootstrap css -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<!-- bootstrap js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<link href="./css/menu.css" rel= "stylesheet"/>
<script type="text/javascript" src="./js/menu.js"></script>
<script type="text/javascript">
function echeck(){// 글자 수 검사[민우]
	var title = $(".form-control").val();
	let content = $(".content").val();
	let spaceremove = (title).replace(/\s/g,"");
	let spacec = (content).replace(/&nbsp;|<p>|<\/p>|<br>|\s|" "/g,"");
 	if (spaceremove.length < 2 ) {
		alert("제목은 2글자 이상으로 적어주세요.");
		$(".form-control").focus();
		return false;
	}
	 if (spacec.length < 2) {
		alert("내용을 2글자 이상으로 적어주세요");
		$(".content").focus();
		return false; 
	 }
}
</script>
</head>
<body>
	<header>
		<%@ include file="./menu.jsp" %>
		<!-- jsp:은 출력 결과만 화면에 나옵니다. -->
	</header>
	<div class="main">
		<div class="mainstyle">
			<article>
			<h1>글 수정하기</h1>
						
			<div class="writeFORM">
				<form action="./writeedit" method="post">
					<input type="hidden" name="no" value="${write.no }">
					<input type="text" class="form-control" id="exampleFormControlInput1" name ="title" value="${write.title }">
					<textarea id="summernote" name="content" class="content">${write.content }</textarea>
					<button type="submit" onclick="return echeck()">수정</button>
				</form>
				</div>
			</article>
		
		</div>
	</div>

	<script type="text/javascript">
	$(document).ready(function(){
		$('#summernote').summernote({
			height: 600,
			toolbar:[
			    ['style', ['bold', 'italic', 'underline', 'clear']],
			    ['font', ['strikethrough', 'superscript', 'subscript']],
			    ['fontsize', ['fontsize']],
			    ['color', ['color']], 
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
			    ['insert', ['link', 'picture', 'video']]
			]
		});
	});
	</script>
</body>
</html>