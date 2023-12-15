<%@ page import="java.util.HashMap" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" 			%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert here</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
          crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
            integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
            integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
            crossorigin="anonymous"></script>
    <script src="/resources/js/jquery-2.2.4.min.js"></script>
</head>
</head>
<body>

<div class="container">
    <h2>게시판 목록</h2>

<table class="table table-hover" border="1">
    <thead>
    <tr class="text-center">

        <th style="width: 10%">글번호</th>
        <th style="width: 55%">제목</th>
        <th style="width: 15%">작성자</th>
        <th style="width: 15%">조회수</th>
    </tr>
</thead>
    <tbody>
        <tr>
            <td colspan="4"><h3 style="text-align: center;"> 작성된 게시글이 없습니다. </h3></td>
        </tr>
    <!--    jstl사용  -->
    <!--    forEach문을 사용해 데이터의 각 값을 테이블 위에 뿌려줌 비어있지 않으면 테이블에 계속데이트를 뿌림  -->


    <nav aria-label="Page navigation example">
        <ul class="pagination">
            <li class="page-item">

    <tr><td colspan="4" align="center">



        <!--시작페이지가 마지막페이지와 같거나 작을경우 1씩 증가-->

        <!--총 페이지 개수가 현재페이지의 마지막페이지보다 많을때만 나옴-->
    </td>
    </tr>
            </li>
        </ul>
    </nav>
    </tbody>
</table>
    <button type="button" onclick="location.href='write'">글쓰기</button>

</div>

</body>
</html>