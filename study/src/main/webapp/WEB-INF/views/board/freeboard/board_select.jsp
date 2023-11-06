<%@ page import="java.util.HashMap" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" 			%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    HashMap<String,Object> data = (HashMap<String,Object>)request.getAttribute("data");
    int startPage = (int)request.getAttribute("startPage");
    int endPage = (int)request.getAttribute("endPage");

    int nowPage = (int)request.getAttribute("nowPage");
    int totalPage =(int)request.getAttribute("totalPage");
    int perBlock = (int)request.getAttribute("perBlock");

%>

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
    <c:if test='${board.isEmpty()}'>
        <tr>
            <td colspan="4"><h3 style="text-align: center;"> 작성된 게시글이 없습니다. </h3></td>
        </tr>
    </c:if>
    <!--    jstl사용  -->
    <!--    forEach문을 사용해 데이터의 각 값을 테이블 위에 뿌려줌 비어있지 않으면 테이블에 계속데이트를 뿌림  -->
        <c:forEach var="board" items="${list}" varStatus="i">
            <tr>
                <!--차례대로 글번호 제목 작성자 조회수-->
                <td>${board.id}</td>
                <td>
                    <c:choose>
                  <c:when test="${board.check eq 'Y'}">
                      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-megaphone" viewBox="0 0 16 16">
                          <path d="M13 2.5a1.5 1.5 0 0 1 3 0v11a1.5 1.5 0 0 1-3 0v-.214c-2.162-1.241-4.49-1.843-6.912-2.083l.405 2.712A1 1 0 0 1 5.51 15.1h-.548a1 1 0 0 1-.916-.599l-1.85-3.49a68.14 68.14 0 0 0-.202-.003A2.014 2.014 0 0 1 0 9V7a2.02 2.02 0 0 1 1.992-2.013 74.663 74.663 0 0 0 2.483-.075c3.043-.154 6.148-.849 8.525-2.199V2.5zm1 0v11a.5.5 0 0 0 1 0v-11a.5.5 0 0 0-1 0zm-1 1.35c-2.344 1.205-5.209 1.842-8 2.033v4.233c.18.01.359.022.537.036 2.568.189 5.093.744 7.463 1.993V3.85zm-9 6.215v-4.13a95.09 95.09 0 0 1-1.992.052A1.02 1.02 0 0 0 1 7v2c0 .55.448 1.002 1.006 1.009A60.49 60.49 0 0 1 4 10.065zm-.657.975 1.609 3.037.01.024h.548l-.002-.014-.443-2.966a68.019 68.019 0 0 0-1.722-.082z"/>
                      </svg>
                      <a href="/board/freeboard/selectdetail?id=${board.id}">
                              ${board.title}</a>
                  </c:when>

                <c:otherwise><a href="/board/freeboard/selectdetail?id=${boards.id}">
                        ${board.title}</a></c:otherwise></c:choose>
                </td>
                <td>${board.writer}</td>
                <td>${board.hit_cnt}</td>

            </tr>

        </c:forEach>


    <nav aria-label="Page navigation example">
        <ul class="pagination">
            <li class="page-item">

    <tr><td colspan="4" align="center">
        <c:if test="${nowPage > perBlock}">
            <!-- 지금 페이지가 표시할 페이지 개수보다 많을 경우 1로 가는 화살표 생성 -->
            <a href="/board/freeboard/select?nowPage=1"> &lt;&lt; </a>
        </c:if>

        <!--지금 페이지가 표시할 페이지 개수보다 많을 경우 뒤로가는 화살표 생성-->
        <c:if test="${nowPage > perBlock}">
        <!--지금 페이지가 표시할 페이지 개수보다 많을 경우 뒤로가는 화살표 생성-->
        <a href="/board/freeboard/select?nowPage=<%= startPage-1 %>"> &lt; </a>
        </c:if>



        <!--시작페이지가 마지막페이지와 같거나 작을경우 1씩 증가-->
        <%for(int i=startPage; i <= endPage; i++ ) {%>
        <!--현재 페이지를 누르면 빨간색으로 표시-->
            <%if(i == nowPage){%>
            <font color="red"><%=i%></font>
            <%}else{%>
        <!--지금페이지가 -->
                <a href="/board/freeboard/select?nowPage=<%=i %>"><%=i%></a>
            <%}%>,&nbsp;
        <%}%>

        <!--총 페이지 개수가 현재페이지의 마지막페이지보다 많을때만 나옴-->
        <c:if test= "${totalPage > endPage}" >
        <a href="/board/freeboard/select?nowPage=<%= endPage+1 %>"> > </a>
            </c:if>

        <c:if test="${totalPage > endPage}">
        <a href="/board/freeboard/select?nowPage=<%= totalPage %>"> >> </a>
            </c:if>
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