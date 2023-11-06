<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

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
<body>
<div class="container">
<h1>게시글 상세 열람</h1>
<form action="" method="post" type="table table-hover">
    <table border="1" class="table table-hover">

            <tr>
                <td> 제목 </td><td>${board.title}</td>
            </tr>

            <tr>
                <td> 작성자 </td><td>${board.writer}</td>
            </tr>

            <tr>
                <td> 내용 </td><td>${board.content}</td>
            </tr>

    </table>
</form>

    <div class="btn-group">
<BUTTON onclick="location.href='select'" class="btn btn-outline-primary" id="select">목록으로</BUTTON>
<button onclick="location.href='check?id=${board.id}'" class="btn btn-outline-primary" id="edit">수정</button>
    <BUTTON onclick="location.href='reply?id=${board.id}'" class="btn btn-outline-primary" id="reply">답글달기</BUTTON>


</div>
<div class="container">
<ul class="list-group list-group-flush">

    <nav class="navbar bg-body-tertiary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-list" viewBox="0 0 16 16">
                    <path fill-rule="evenodd" d="M2.5 12a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5z"/>
                </svg>
                댓글 목록
            </a>
        </div>
    </nav>

<ul class="list-group list-group-flush">
    <%-- 댓글 내용 출력 --%>
    <c:forEach var="comment" items="${comment}" varStatus="i">
    <li class="list-group-item">
        <div>
            <table class="comm">
                <input type="hidden" id="reid" value="${comment.reid}">
        <p>이름: ${comment.comname}</p>
        내용: ${comment.comcontents}

                <BUTTON class="btn btn-info" id="deleteCom" type="button" onclick="deleteCom()" size="10sp">삭제</BUTTON>
            </table>
        </div>

    </li>
    </c:forEach>
</ul>

<div>

    <nav class="navbar bg-body-tertiary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                    <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                    <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
                </svg>
                댓글 달기
            </a>
        </div>
    </nav>
        <%--   댓글 달기   --%>
        <form id="comment" action="freeboard/commentBoard" method="post" onsubmit = "check()">
            <input type="hidden" id = "board_id" name="board_id" value="${board.id}">
            <p>이 름: <input id= "comname" type="text" name="comname" ></p>
            <p>내 용: <input id="comcontents" type="text" name="comcontents" ></p>
            <button type="button" id="commentIn" class ="btn btn-outline-primary">댓글 작성</button>
        </form>

</div>

</body>
</html>

<script>

    function deleteCom(){
        var result = confirm('삭제하시겠습니까?');
        if(result) {
            var reid = $("#reid").val();
            $.ajax({
                url: "/board/freeboard/deleteCom",
                type: "POST",
                data: {
                    reid: reid
                }, success: function () {
                    console.log("삭제 성공");
                    location.reload();
                },
                error: function () {
                }
            });
        }else{
            alert("취소하셨습니다.");
        }
    }


    console.log($("#board_id").val());

    //commentIn이라는 버튼을 누르면 실행
    $("#commentIn").click(function () {
        var board_id = $("#board_id").val();
        var comname = $("#comname").val();
        var comcontents = $("#comcontents").val();

        if(document.getElementById("comname").value===""){
            alert("이름을 입력하세요.");
            return false;
        }

        else if(document.getElementById("comcontents").value===""){
            alert("내용을 입력하세요.");
            return false;
        }
        else {

            $.ajax({
                url: "/board/freeboard/commentBoard", // 댓글 저장을 처리하는 서버 엔드포인트
                type: "POST",
                data: {
                    board_id: board_id,
                    comname: comname,
                    comcontents: comcontents
                },
                success: function (response) {
                    // 댓글 저장 성공 시 메시지 출력 또는 화면 갱신
                    alert("성공"); // 저장 성공 메시지를 알림으로 표시
                    location.reload();
                },
                error: function (xhr, status, error) {
                    // 댓글 저장 실패 시 에러 메시지 출력
                    alert("댓글 저장 실패: " + error);
                }
            });
        }
    });
</script>

<%--     디자인      --%>
<style>
    #deleteCom {
        position: absolute;
        top: 10px;
        right: 8px;
    }
</style>