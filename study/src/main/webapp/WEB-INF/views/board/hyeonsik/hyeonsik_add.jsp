<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <h1 class="mt-5">게시글 답변 달기</h1>
        <form id="addForm">
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
            <button type="button" class="btn btn-primary mt-3" id="submitBtn">등록</button>
        </form>
    </div>

    <script>
    $(document).ready(function() {
        // 폼 제출 시 서버로 게시물을 등록하고, 콘솔에 새로운 게시물의 ID 출력\
         var groupLayer = ${post.groupLayer};
        $("#submitBtn").click(function() {
            var originNo = ${post.originNo}; // originNo 가져오기
            var groupLayer = ${post.groupLayer}; // groupLayer 가져오기
            var groupOrd = ${post.groupOrd}; // groupOrd 가져오기
            var title = $('#title').val();
            var content = $('#content').val();
            var writer = $('#writer').val();
            
            
            // JSON 데이터 생성
            var jsonData = {
                "originNo": originNo,
                "groupLayer": groupLayer,
                "groupOrd": groupOrd,
                "title": title,
                "content": content,
                "writer": writer
            };
            
            $.ajax({
                url: "/posts/insertreq",
                type: "POST",
                contentType: 'application/json', // 컨텐츠 타입을 JSON으로 설정
                data: JSON.stringify(jsonData), // JSON 데이터 전송
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

