<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 작성</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
    <div class="container">
        <h1 class="mt-5">게시글 작성</h1>
        <form id="postForm" method="post">
            <div class="form-group mt-3">
                <label for="title">제목</label>
                <input type="text" class="form-control" id="title" name="title">
  
            </div>
            <div class="form-group mt-3">
                <label for="writer">작성자</label>
                <input type="text" class="form-control" id="writer" name="writer">
            </div>
            <div class="form-group mt-3">
                <label for="content">내용</label>
                <textarea class="form-control" id="content" name="content" rows="5"></textarea>
            </div>
            <button type="submit" class="btn btn-primary mt-3">등록</button>
        </form>
    </div>

    <script>
        $(document).ready(function() {
            // 폼 제출 시 서버로 게시물을 등록하고, 콘솔에 새로운 게시물의 ID 출력
            $("#postForm").submit(function(event) {
                event.preventDefault();
                var title = $('#title').val();
                var content = $('#content').val();
                var writer = $('#writer').val();
                var formData = {
                    title: title,
                    content: content,
                    writer: writer
                };

                $.ajax({
                    url: "/posts/insert",
                    type: "POST",
                    contentType: 'application/json',
                    data: JSON.stringify(formData),
                    success: function(response) {
                    	 alert("게시글이 성공적으로 작성되었습니다.");
                         window.location.href = "/"; // 수정 후 게시판 페이지로 이동
                    },
                    error: function(xhr, status, error) {
                        alert("게시글 등록 중 오류가 발생하였습니다.");
                    }
                });
            });
        });
    </script>
</body>
</html>