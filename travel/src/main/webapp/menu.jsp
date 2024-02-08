<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="./index">
      <img src="./img/travel.png" alt="Logo" width="35" height="35" class="d-inline-block align-text-top">
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
   		 <div class="navbar-nav">
   		 	 <a class="nav-link" href="./index">Triippp</a>
       		 <a class="nav-link active" aria-current="page" href="./index">홈</a>
       		 <a class="nav-link" href="./inboard">국내게시판</a>
       		 <a class="nav-link" href="./outboard">국외게시판</a>
       		 <c:choose><c:when test="${sessionScope.mname eq null}">
       		 <a class="nav-link" href="./login">로그인</a>
       		 </c:when><c:otherwise>
       		 <a class="nav-link" href="./myInfo">${sessionScope.mname }님</a>
       		 <a class="nav-link" href="./logout">로그아웃</a>
       		 </c:otherwise></c:choose>
     	 </div>
     </div>
  </div>
</nav>