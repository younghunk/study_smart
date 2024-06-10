<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 상세 페이지</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1 class="mt-5">게시글 페이지</h1>
        <div class="card mt-3">
            <div class="card-body">
                <h5 class="card-title">${post.title}</h5>
                <h6 class="card-subtitle mb-2 text-muted">작성자: ${post.writer}</h6>
                <p class="card-text">${post.content}</p>
                <div class="btn-group" role="group" aria-label="Basic example">
                	<button type="button" class="btn btn-add" id="addPostBtn">답글 작성</button>
                    <button type="button" class="btn btn-primary" id="editPostBtn">수정</button>
                    <button type="button" class="btn btn-danger" id="deletePostBtn">삭제</button>
                </div> 
                <form id="commentForm">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="content">댓글 작성</label>
                            <input class="form-control" id="content" rows="3">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="writer">작성자</label>
                            <input type="text" class="form-control" id="writer">
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">댓글 등록</button>
                </form>
                <!-- 댓글 목록 출력 -->
                <div id="comments" class="mt-3">
                    <h5>댓글 목록</h5>
                    <ul id="commentsList" class="list-group"></ul>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script>
    $(document).ready(function () {
        var queryString = window.location.search;

        // 쿼리 스트링에서 '?'을 제외한 파라미터 부분을 추출
        var params = new URLSearchParams(queryString);

        // postId를 추출
        var postId = params.get('id');
        console.log(postId);
        var data = $('#commentForm').serialize();
        loadComments(postId);

        $('#commentForm').submit(function (event) {
            event.preventDefault();
            var content = $('#content').val();
            var writer = $('#writer').val();
            var postData = {
                postId: postId, // postId를 포함한 객체 생성
                content: content,
                writer: writer
            };
            $.ajax({
                type: 'POST',
                url: postId + '/comments',
                contentType: 'application/json',
                data: JSON.stringify(postData), // 객체를 JSON 문자열로 변환하여 전송
                success: function () {
                    loadComments(postId); // postId를 loadComments 함수에 전달하여 댓글을 다시 불러옴
                }
            });
        });
        function loadComments(postId) {
            $.get('/posts/' + postId + '/comments', function (comments) {
                var commentsList = $('#commentsList');
                commentsList.empty();
                var commentsHtml = '';
                $.each(comments, function (index, comment) {
                    commentsHtml += '<li class="list-group-item">' + comment.content + ' (작성자: ' + comment.writer + ')</li>';
                });
                commentsList.html(commentsHtml);
            });
        }


        $('#addPostBtn').click(function () {
        	window.location.href = '/hyeonsik_add?id=' + postId;
        });

        $('#editPostBtn').click(function () {
        	window.location.href = '/hyeonsik_edit?id=' + postId;
        });

        $('#deletePostBtn').click(function () {
            var formData = { id: postId };
            if (confirm('정말로 삭제하시겠습니까?')) {
                $.ajax({
                    type: 'POST',
                    data: JSON.stringify(formData),
                    contentType: "application/json",
                    url: '/posts/delete',
                    success: function () {
                    	alert("succes delete");
                        window.location.href = '/'; // 삭제 후 메인 페지로 이동이
                    }
                });
            }
        });
    });
    </script>
</body>