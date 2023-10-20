<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>

    <%-- 제이쿼리 cdn--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <%-- 부트스트랩 --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

    <%-- js --%>
    <script>
        $(document).ready(function () {
            console.log("dataList??????","${dataList}");
            console.log("searchValue????", $("#searchValue").val());
        })

        function getDetail(SEQ) {
            $.ajax({
                type : 'get',
                url : '/qnaboard/detail',
                data : {
                    seq : SEQ
                },
                success : function (result) {
                    console.log(result);
                    location.href = "/qnaboard/detail?seq=" + SEQ;
                },
                error : function (error) {
                    console.log(error);
                }
            })
        }

        // function search() {
        //     $.ajax({
        //         type : 'get',
        //         url : '/qnaboard/list',
        //         data : {
        //             searchValue : $('#searchValue').val()
        //         },
        //         success : function (result) {
        //             console.log(result);
        //             location.href = "/qnaboard/detail?seq=" + SEQ + "&searchValue=" + searchValue;
        //         },
        //         error : function (error) {
        //             console.log(error);
        //         }
        //     })
        // }
    </script>

</head>
<body class="position-relative">

    <div id="search-box" class="position-absolute top-0 start-50 translate-middle-x">
        <form action="/qnaboard/list" method="get">
            <input type="search" id="searchValue" name="searchValue" value="${pvo.searchValue}">
            <button type="submit">검색</button>
        </form>
<%--        <button type="button" onclick="location.href='/qnaboard/list?p=${pvo.page}&searchValue=${pvo.searchValue}'">검색</button>--%>
    </div>

    <div id="table-wrapper" class="position-absolute top-50 start-50 translate-middle
                            w-25"
    >
        <table id="board-list"
               class="table
               table-striped
               table-hover"
        >
            <thead>
                <tr class="table-dark">
                    <th scope="col">번호</th>
                    <th scope="col">제목</th>
                    <th scope="col">글쓴이</th>
                </tr>
            </thead>

            <tbody>
            <c:forEach items="${dataList}" var="data" varStatus="status">
                <tr scope="row" onclick="getDetail(${data.SEQ});">
                    <td>${status.count + pvo.page * pvo.dataPerPage - pvo.dataPerPage}</td>
                    <td>${data.TITLE}</td>
                    <td>${data.WRITER}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div id="btn-wrapper"
        class="position-absolute bottom-0 start-50 translate-middle-x"
    >

        <%-- 처음, 이전 버튼 --%>
        <c:if test="${pvo.page > 1}">
            <button type="button" onclick="location.href='/qnaboard/list?p=1&searchValue=${pvo.searchValue}'"> 처음 </button>
            <button type="button" onclick="location.href='/qnaboard/list?p=${pvo.page-1}&searchValue=${pvo.searchValue}'"> < </button>
        </c:if>

        <%-- 페이지 버튼 --%>
        <c:forEach begin="${pvo.startBlock}" end="${pvo.endBlock}" step="1" var="i">
            <button type="button" onclick="location.href='/qnaboard/list?p=${i}&searchValue=${pvo.searchValue}'">${i}</button>
        </c:forEach>

        <%-- 다음, 끝 버튼 --%>
        <c:if test="${pvo.page < pvo.maxPage}">
            <button type="button" onclick="location.href='/qnaboard/list?p=${pvo.page+1}&searchValue=${pvo.searchValue}'"> > </button>
            <button type="button" onclick="location.href='/qnaboard/list?p=${pvo.maxPage}&searchValue=${pvo.searchValue}'"> 끝 </button>
        </c:if>

        <button type="button" onclick="location.href='/qnaboard/write'"
                id="write-btn"
                class="btn btn-dark"
        >글쓰기</button>
    </div>

</body>

</html>