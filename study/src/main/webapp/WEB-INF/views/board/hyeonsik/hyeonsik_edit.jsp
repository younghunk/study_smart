<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 수정</title>

    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1 class="mt-5">게시글 수정</h1>
        <form id="editForm" action="/posts/${post.id}/edit" method="post">
            <div class="form-group mt-3">
                <label for="title">제목</label>
                <input type="text" class="form-control" id="title" name="title" value="${post.title}">
            </div>
            <div class="form-group mt-3">
                <label for="content">내용</label>
                <textarea class="form-control" id="content" name="content" rows="5">${post.content}</textarea>
            </div>
            <button type="submit" class="btn btn-primary mt-3">수정</button>
        </form>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
    	//게시판 수정 폼
		$(document).ready(function() {
    $("#editForm").submit(function(event) {
        event.preventDefault();
        var queryString = window.location.search;

        // 쿼리 스트링에서 '?'을 제외한 파라미터 부분을 추출
        var params = new URLSearchParams(queryString);

        // postId를 추출
        var postId = params.get('id');
        var formData = {
        	id: postId,
            title: $("#title").val(),
            content: $("#content").val()
        };
        $.ajax({
            url: '/posts/update',
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(formData),
            success: function(response) {
                alert("게시글이 성공적으로 수정되었습니다.");
                window.location.href = "/"; // 수정 후 게시판 페이지로 이동
            },
            error: function(xhr, status, error) {
                alert("게시글 수정 중 오류가 발생하였습니다.");
                console.error(xhr.responseText);
            }
        });
    });
});
</script>
</body>
</html>