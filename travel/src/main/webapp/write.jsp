<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<script type="text/javascript" src="js/menu.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- bootstrap css -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<!-- bootstrap js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<!-- summernot -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<style type="text/css">
.mname{
	width: 100%;
	height:30px;
	text-align: right;
	padding-right: 30px;
	padding-top: 17px;
	background-color: white;
	font-weight: bold;
	
}
#abc{
	height: 27px;
	margin-left: 3px;
}
.text{
	padding-top: 20px;

}
.btn-primary{
	color: #0d6efd;
    border-color: #0d6efd;
    background-color: white;
}
.form-control{
	margin-top: 3px;
}
.button{
	margin: 4px;
}
</style>
<script type="text/javascript">
function check(){// 글자 수 검사[민우]
	var title = document.getElementById("exampleFormControlInput1");
	var content = document.getElementsByClassName("content");
	let spaceremove = (title.value).replace(/\s/g,"");
	let spacec = (content[0].value).replace(/&nbsp;|<p>|<\/p>|<br>|\s|" "/g,"");
	if (spaceremove.length < 2 ) {
		alert("제목은 2글자 이상으로 적어주세요.");
		title.focus();
		return false;
	}
	if (spacec.length < 2) {
		alert("내용을 2글자 이상으로 적어주세요");
		content.focus();
		return false;
	}
}
</script>
</head>
<body>
	<header>
	<%@ include file="menu.jsp" %>
	</header>
	<div>
		<article>
			<h2>작성</h2>
				<div>
					<form action="./write" method="post">
						<input type="hidden" name="write" value="${param.write}">
						<select name="category" id="abc">
							<c:if test="${sessionScope.mname eq '관리자'}">
							<option value="공지사항" name="header">공지사항</option>
							</c:if>
							<option value="여행정보" name="header">여행정보</option>
							<option value="잡담" name="header" selected="seleteted">잡담</option>
							<option value="여행후기" name="header">여행후기</option>
						</select>
						<input type="text" class="form-control" id="exampleFormControlInput1" name ="title" placeholder="제목 2글자 이상 입력해주세요">
						<!-- <input type="text" name="title" id="title"></div> -->
						<div class="mname">${sessionScope.mname }</div>
						<div class="text"><textarea id="summernote" name="content" class="content"></textarea></div>
						<div class="button"><button type="submit" onclick="return check()" class="btn btn-primary btn-lg">저장</button></div>
 					</form>
				</div>
		</article>
	</div>
<script type="text/javascript">
	$(function(){
		$("#summernote").summernote({
			height:600,
			placeholder: '게시판 이용약관을 준수해주세요',
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