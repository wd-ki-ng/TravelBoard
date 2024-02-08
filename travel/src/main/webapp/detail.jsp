<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>

<!-- bootstrap 반응형 -->
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
<script type="text/javascript" src="./js/menu.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<!-- j쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript">
	//게시글 삭제하기
	function writedel() {
		var ch = confirm("글을 삭제하시겠습니까?");
		if(ch){
			location.href="./writedel?no=${detail.no}&inout=${param.inout}&del=1";
		}
	}
	function writeedit() {
		var ch = confirm("글을 수정하시겠습니까?");
		if(ch){
			location.href="./writeedit?no=${detail.no}";
		}
	}
	function selectBoard() {
		var inout = '<%=request.getParameter("inout")%>'
	
		if (inout == 0) {
			location.href = "./inboard";
		} else {
			location.href = "./outboard";
		}
	}

	// 본인 댓글 좋아요 눌렀을 때
	function myComment() {
		alert("자신의 댓글은 좋아요를 누를 수 없습니다.")
	}
	// 로그인 안하고 좋아요 눌렀을 때 
	function needLogin() {
		alert("로그인 후 이용해주세요.")
		location.href = "./login";
	}

	$(document).ready(function() {
		//게시글 추천하기[민우]
		$(".b_recommen").click(function() {
			if (confirm("추천하시겠습니까?")) {
				let bno = ${detail.no};
				let inout = ${param.inout};

				$.ajax({
					url : './detail',
					type : 'post',
					dataType : 'text',
					data : {bno : bno},
					success : function(result) {
						if (result == 1) {
							alert("추천 되었습니다.");
							location.href = "detail?no=" + bno + "&inout=" + inout;
						} else {
							alert("이미 추천했습니다.");
						}
					},
					error : function(request, status, error) {
						alert("오류 : 관리자에게 문의하세요");
					}
				});//ajax end
			}
		});
		// 댓글 삭제하기
		$(".commentDelete").click(function() {
			if (confirm("댓글을 삭제할까요?")) {
				let cno = $(this).prev().val();
				let point = $(this).closest(".comment"); // 상위에서 .comment를 찾아 전부지움

				$.ajax({
					url : './commentDel',
					type : 'post',
					dataType : 'text',
					data : {no : cno},
					success : function(result) {
						if (result == 1) {
							point.remove();
							alert("삭제되었습니다.")
						} else {
							alert("삭제할 수 없습니다.")
						}
					},
					error : function(request, status, error) {
						alert("문제가 발생했습니다.");
					}
				}); // end ajax
			}
		});

		// 댓글 작성하기를 눌렀을 때 실행될 꺼
		$("#comment-btn").click(function() {
			let commentcontent = $("#commentcontent").val();
			let bno = ${detail.no};
			let inout = ${param.inout};
			if (commentcontent.length < 1) {
				alert("내용을 입력해주세요.");
				$("#commentcontent").focus();
			} else {
				$.ajax({
					url : './comment',
					type : 'post',
					dataType : 'text',
					data : {
						commentcontent : commentcontent,
						bno : bno
					},
					success : function(result) {
						if (result == 1) {
							alert("댓글이 등록되었습니다.");
							location.href = "./detail?no=" + bno + "&inout=" + inout;
						} else {
							alert("로그인 후 이용해주세요.");
							location.href = "./login";
						}
					},
					error : function(request, status, error) {
						alert("댓글 작성에 문제가 발생했습니다.");
					}
				});
			}
		});

		$(".commentLike2").click(function() {
			let cno = $(this).prev().val();
			let clike = $(this).siblings('.clike').val();
			let bno = ${detail.no};
			let inout = ${param.inout};
			$.ajax({
				url : './commentLike',
				type : 'post',
				dataType : 'text',
				data : {no : cno, clike : clike},
				success : function(result) {
					if (result == 1) {
						location.href = "./detail?no=" + bno + "&inout=" + inout;
					} else {
						alert("이미 추천하셨습니다.")

					}
				},
				error : function(request, status, error) {

					alert("무언가 문제가 발새했슴다");
				}
			})
		});
	});
</script>
<style type="text/css">
body {
  width: 100%;
  }
  div{
  width: 100%;
  }
  .card-text img{
  width: 100%;
  }
</style>
</head>
<body>

	<header><%@ include file="menu.jsp"%></header>

	<div class="card text-center border-dark" style="min-width: 75rem; width: fit-content; margin: 0 auto; padding: 0 auto; justify-content: center">
		<div>
			<button type="button" class="btn btn-outline-primary" onclick="selectBoard()" style="float:left; margin: 10px 0px 0px 5px">목록</button>
			<div><h5 style="text-align:center; height:55px; padding: 15px 58px 0px 0px; " class="card-header border-dark">${detail.title}</h5></div>
			<input name="inout" value="${detail.inout}">
		</div>
		<div class="card-body">
			<h6 class="card-subtitle mb-2 text-body-secondary">글쓴이:${detail.write}&nbsp;&nbsp;조회:${detail.count}&nbsp;&nbsp;추천:${detail.like }</h6>
			<p class="card-text">${detail.content}</p>
		</div>
		<div class="card-footer border-dark">
			<button type="button" class="btn btn-outline-primary" onclick="selectBoard()" style="margin: 0 auto; padding: 0 auto; float: left">목록</button>
			<c:choose>
				<c:when test="${sessionScope.mname ne null }">
					<button type="button" class="btn btn-outline-danger btn-sm b_recommen" onclick="tboard_recomment()" >
						<img src="./img/like.png" alt="추천" height="20">&nbsp;<span class="badge text-bg-secondary">${detail.like }</span>
					</button>
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-outline-danger btn-sm" onclick="needLogin()">
						<img src="./img/like.png" alt="추천" height="20">&nbsp;<span class="badge text-bg-secondary">${detail.like }</span>
					</button>
				</c:otherwise>
			</c:choose>
			<c:if test="${detail.mid eq sessionScope.mid}">
				<button type="button" class="btn btn-outline-success btn-sm" onclick="writeedit()">글 수정</button>
				<button type="button" class="btn btn-outline-secondary btn-sm" onclick="writedel()">글 삭제</button>
			</c:if>
		</div>
	</div><br>
	<div class="comment-write card" style="width: 75rem; margin: 0 auto; padding: 0 auto; justify-content: center">
		<h5 class="card-header">댓글 남기기</h5>
			<div class="comment-form card-body">
				<textarea class="form-control mb-3" rows="3" id="commentcontent" name="commentcontent" ></textarea>
				<button id="comment-btn" type="button" class="btn btn-outline-success">등록</button>
			</div>
	</div>

    <c:forEach items="${commentList}" var="co">
      <div class="comment" style="width: 75rem; margin: 0 auto; padding: 0 auto; justify-content: center">
		<ul class="list-group list-group-flush border-bottom">
      		<li class="list-group-item">
        		<div class="d-flex w-100 justify-content-between">
          		<h6 class="mb-1 fw-bold" style="width:100px">${co.mname }</h6>
          		<small class="text-body-secondary" style="width: 120px;">${co.cdate } 
          			<c:if test="${sessionScope.mname ne null && co.mid eq sessionScope.mid }">
        			<input type="hidden" class="cno" value="${co.cno }">
        			<img class="commentDelete" alt="delete" src="./img/comment_del.png">
     				</c:if>
     			</small>
          		
					<div class='clike'>
						<button type="button" class="btn btn-outline-danger btn-sm" style="float: right;">
							<c:choose>
								<c:when test="${sessionScope.mname ne null && co.mid eq sessionScope.mid }">
             					<img class="commentLike1" onclick="myComment()" alt="like" src="./img/like1.png">
             					<span style="font-size: small;">${co.clike }</span>
           						</c:when>
	            				<c:when test="${sessionScope.mname ne null && co.mid ne sessionScope.mid }">
              					<input type="hidden" class="cno" value="${co.cno }">
              					<img class="commentLike2" alt="like" src="./img/like1.png">
              					<span style="font-size: small;">${co.clike }</span>
              					<input type="hidden" class="clike" value="${co.clike }">
            					</c:when>
            					<c:otherwise>
              					<img class="commentLike3" onclick="needLogin()" alt="like" src="./img/like1.png">
              					<span style="font-size: small;">${co.clike }</span>
            					</c:otherwise>
          					</c:choose>
          				</button>
         	 		</div>
        		</div>

        	<p class="mb-1" style="float:left;">${co.ccomment}</p>
        	
        	

       	 	
      		</li>
    	</ul>
  	</div>
  </c:forEach>
</body>
</html>