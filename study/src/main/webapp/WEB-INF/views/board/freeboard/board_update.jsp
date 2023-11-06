<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
</head>
<body>
<div>
    <h1>게시글 수정하기</h1>
    <form id ="updateForm" action="update" method="post">
        <input type="hidden" name="id" value="${board.id}" />
        <table border="1">

            <tr>
                <td> 제목 :</td>
                <td><input name="title" value="${board.title}" type="text"></td>
            </tr>

            <tr>
                <td> 작성자 </td>
                <td><input name="writer" value="${board.writer}" type="text"></td>
            </tr>

            <tr>
                <td> 내용 </td>
                <td><input name="content" value="${board.content}" type="text"></td>
            </tr>
        </table>

        <button type="button" onclick="location.href='select'">목록으로</button>
        <button>수정 완료</button>
        <BUTTON id="delete" type="button" onclick="doDelete()">삭제</BUTTON>
    </form>
<script>
function doDelete()  {
    if(!confirm("삭제할래요?")) return;
    document.getElementById("updateForm").action = "delete";
    document.getElementById("updateForm").submit();
}
</script>
</div>
</body>
</html>