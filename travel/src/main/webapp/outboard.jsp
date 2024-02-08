<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>해외 게시판</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script type="text/javascript" src="./js/menu.js"></script>

<style type="text/css">
.bg-success{
	cursor: pointer;
}
.cursor{
	cursor: pointer;
}
.page-link{
	color: orange; 
}
</style>

</head>
<body>
	<header>
		<%@ include file="menu.jsp"%>
	</header>
	<h1>해외로 떠나요</h1>
	<article>	
		<div class="btn-group" role="group" aria-label="Basic outlined example">
			<button type="button" class="btn btn-outline-warning" onclick="url('./outboard?write=1')">전체</button>
			<button type="button" class="btn btn-outline-warning" onclick="url('./outboard?write=1&category=공지사항')">공지사항</button>
			<button type="button" class="btn btn-outline-warning" onclick="url('./outboard?write=1&category=여행정보')">여행정보</button>
			<button type="button" class="btn btn-outline-warning" onclick="url('./outboard?write=1&category=여행후기')">여행후기</button>
			<button type="button" class="btn btn-outline-warning" onclick="url('./outboard?write=1&category=잡담')">잡담</button>
		</div><br><br>
		<table class="table table-hover">
			<thead>
				<tr class="table-warning">
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">글쓴이</th>
					<th scope="col">등록일</th>
					<th scope="col">조회</th>
					<th scope="col">추천</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${list}" var="row">
				<tr>
					<c:if test="${row.inout eq 1 && row.del ne 0 && row.header eq '공지사항'}">  				
      				<th scope="row" class="bg-success p-2 bg-opacity-25">${row.no}</th>
    				<td class="bg-success p-2 text-danger bg-opacity-25" onclick="url('./detail?page=${page}&no=${row.no}&inout=${row.inout}')">[${row.header}] ${row.title} <span style="font-size: small;"><c:if test="${row.comment ne 0 }">[${row.comment }]</c:if></span></td>
      				<td class="bg-success p-2 bg-opacity-25">${row.write}</td>
      				<td class="bg-success p-2 bg-opacity-25">${row.date}</td>
      				<td class="bg-success p-2 bg-opacity-25">${row.count}</td>
      				<td class="bg-success p-2 bg-opacity-25">${row.like}</td></c:if>
				</tr>
			</c:forEach>
				<c:choose><c:when test="${param.category eq '공지사항'}"><c:forEach items="${list}" var="row">
   				<tr><c:if test="${row.inout eq 1 && row.del ne 0 && row.header eq '공지사항'}">
      				<th scope="row">${row.no}</th>
    				<td class="cursor" onclick="url('./detail?page=${page}&no=${row.no}&inout=${row.inout}')">[${row.header}] ${row.title} <span style="font-size: small;"><c:if test="${row.comment ne 0 }">[${row.comment }]</c:if></span></td>
      				<td>${row.write}</td>
      				<td>${row.date}</td>
      				<td>${row.count}</td>
      				<td>${row.like}</td></c:if>
    			</tr></c:forEach></c:when><c:when test="${param.category eq '여행정보'}"><c:forEach items="${list}" var="row">
   				<tr><c:if test="${row.inout eq 1 && row.del ne 0 && row.header eq '여행정보'}">
      				<th scope="row">${row.no}</th>
    				<td class="cursor" onclick="url('./detail?page=${page}&no=${row.no}&inout=${row.inout}')">[${row.header}] ${row.title} <span style="font-size: small;"><c:if test="${row.comment ne 0 }">[${row.comment }]</c:if></span></td>  
      				<td>${row.write}</td>
      				<td>${row.date}</td>
      				<td>${row.count}</td>
      				<td>${row.like}</td></c:if>
				</tr></c:forEach></c:when><c:when test="${param.category eq '여행후기'}"><c:forEach items="${list}" var="row">
					<tr><c:if test="${row.inout eq 1 && row.del ne 0 && row.header eq '여행후기'}">
						<th scope="row">${row.no}</th>
                    	<td class="cursor" onclick="url('./detail?page=${page}&no=${row.no}&inout=${row.inout}')">[${row.header}] ${row.title} <span style="font-size: small;"><c:if test="${row.comment ne 0 }">[${row.comment }]</c:if></span></td>  
						<td>${row.write}</td>
						<td>${row.date}</td>
						<td>${row.count}</td>
						<td>${row.like}</td></c:if>
					</tr></c:forEach></c:when><c:when test="${param.category eq '잡담'}"><c:forEach items="${list}" var="row">
   				<tr><c:if test="${row.inout eq 1 && row.del ne 0 && row.header eq '잡담'}">
      				<th scope="row">${row.no}</th>
    				<td class="cursor" onclick="url('./detail?page=${page}&no=${row.no}&inout=${row.inout}')">[${row.header}] ${row.title} <span style="font-size: small;"><c:if test="${row.comment ne 0 }">[${row.comment }]</c:if></span></td>  
      				<td>${row.write}</td>
      				<td>${row.date}</td>
      				<td>${row.count}</td>
      				<td>${row.like}</td></c:if>
    			</tr></c:forEach></c:when><c:otherwise><c:forEach items="${list}" var="row">
				<tr>
					<c:if test="${row.inout eq 1 && row.del ne 0}">
					<th scope="row">${row.no}</th>
					<td class="cursor" onclick="url('./detail?page=${page}&no=${row.no}&inout=${row.inout}')">[${row.header}] ${row.title} <span style="font-size: small;"><c:if test="${row.comment ne 0 }">[${row.comment }]</c:if></span></td>  
      				<td>${row.write}</td>
      				<td>${row.date}</td>
      				<td>${row.count}</td>
      				<td>${row.like}</td></c:if>
				</tr></c:forEach></c:otherwise></c:choose>
			</tbody>
		</table>		
		<div>
			<c:set var="totalPage" value="${totalCount/10 }"/>
			<fmt:parseNumber integerOnly="true" value="${totalPage }" var="totalPage"/>
			<c:if test="${totalCount % 10 gt 0}">
				<c:set var="totalPage" value="${totalPage +1 }"/>
			</c:if>
			<c:set var ="startPage" value="1"/>
			<c:if test="${page gt 5}">
				<c:set var="startPage" value="${page-5 }"/>
			</c:if>
			<c:set var = "endPage" value="${startPage +9 }"/>
			<c:if test="${endPage gt totalPage }">
				<c:set var="endPage" value="${totalPage }"/>
			</c:if>
  	
			<button type="button" class="btn btn-outline-warning" name="writebtn" onclick="url('./write?write=1')">글쓰기</button>
			<nav aria-label="Page navigation example">
  				<ul class="pagination justify-content-center">
					<li class="page-item"><button class="page-link" onclick="paging(${page-10})" <c:if test="${page - 10 lt 1 }">disabled="disabled"</c:if> >이전</button></li>
   					<c:forEach begin="${startPage }" end="${endPage }" var="p">
   					<li class="page-item"><a class="page-link" onclick="paging(${p})">${p }</a></li></c:forEach>
					<li class="page-item"><button class="page-link" onclick="paging(${page+10})" <c:if test="${page + 10 gt totalPage }">disabled="disabled"</c:if>>다음</button></li>
 				</ul>
			</nav>
		</div>
	</article>
<script type="text/javascript">
	function paging(no){
		location.href="outboard?page="+no;
}
</script>
</body>
</html>