<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>DETAIL</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>

        $(document).ready(function () {
            fn_get_reply_list();
        })

        function fn_edit() {
            $.ajax({
                type : 'post',
                url : '/qnaboard/edit',
                data : {
                    SEQ : $('#SEQ').val(),
                    WRITER : $('#WRITER').val(),
                    TITLE : $('#TITLE').val(),
                    CONTENT : $('#CONTENT').val(),
                },
                success : function (result) {
                    console.log(result);
                    alert("수정성공");
                    location.href = '/qnaboard/detail?seq=' + ${data.SEQ};
                },
                error : function (error) {
                    console.log(error);
                }
            })
        }

        function fn_delete(SEQ) {
            $.ajax({
                type: 'post',
                url: '/qnaboard/delete',
                data: {
                    seq : SEQ
                },
                success : function (result) {
                    console.log(result);
                    alert("삭제성공");
                    location.href = '/qnaboard/list';
                },
                error : function(error) {
                    console.log(error);
                }
            })
        }

        function fn_write_answer() {
            $.ajax({
                type: 'post',
                url: '/qnaboard/answer',
                data: {
                    seq : '${data.SEQ}',
                    parentNo : '${data.PARENT_NO}',
                    title : $('#ANSWER_TITLE').val(),
                    content : $('#ANSWER_CONTENT').val(),
                    writer : $('#ANSWER_WRITER').val(),
                    childNo : '${data.CHILD_NO}',
                    pTitle : '${data.TITLE}',
                    groupNo : '${data.GROUP_NO}'
                },
                success: function (result) {
                    console.log(result);
                    location.href = '/qnaboard/list';
                },
                error: function (error){
                    console.log(error);
                }
            })
        }

        function fn_write_reply() {
            $.ajax({
                url: '/qnaboard/reply/write',
                type: 'post',
                data: {
                    content : $('#REPLY_CONTENT').val(),
                    writer : $('#REPLY_WRITER').val(),
                    qnaSeq : '${data.SEQ}'
                },
                success: function (result) {
                    console.log(result);
                    location.href = '/qnaboard/detail?seq=' + ${data.SEQ};
                },
                error: function (error) {
                    console.log(error);
                }
            })
        }

        function fn_delete_reply(seq) {
            $.ajax({
                type : 'post',
                url : '/qnaboard/reply/delete',
                data : {
                    seq : seq
                },
                success : function (result) {
                    console.log(result);
                    location.href = '/qnaboard/detail?seq=' + ${data.SEQ};
                },
                error : function (error){
                    console.log(error);
                }
            })
        }

        function fn_get_reply_list() {
            const replyArea = $("#reply-area");

            $.ajax({
                url: '/freeboard/reply/list',
                type: 'post',
                data:{
                	qnaSeq : '${data.SEQ}'
                },
                success : function (result) {
                    console.log("result : " + result.replyList);
                    var data = result.replyList;
                    var html = '';
                    for(var i = 0; i < data.length; i++){
                        console.log(data[i].WRITER);
                        html += '<input type="hidden" name="REPLY_SEQ" id="REPLY_SEQ" value="'+data[i].SEQ+'">';
                        html += '<span> 작성자 : ' + data[i].WRITER + '&nbsp;</span>';
                        html += '<span> 내용 : ' + data[i].CONTENT + '&nbsp;</span>';
                        html += '<button onclick="fn_delete_reply(' + data[i].SEQ + ');">삭제</button>';
                        html += '<br>';
                    }
                    replyArea.html(html);
                },
                error : function (error) {
                    console.log(error);
                }
            })
        }

    </script>
</head>
<body>

    <h3>본문</h3>
    <input type="hidden" name="SEQ" id="SEQ" value="${data.SEQ}">
    작성자 <input type="text" name="WRITER" id="WRITER" value="${data.WRITER}">
    <br>
    제목 <input type="text" name="TITLE" id="TITLE" value="${data.TITLE}">
    <br>
    내용 <input type="text" name="CONTENT" id="CONTENT" value="${data.CONTENT}">
    <br>
    <br>

    <button type="button" onclick="fn_edit();">수정</button>
    <button type="button" onclick="fn_delete(${data.SEQ});">삭제</button>
    <br>
    <br>

    <hr>
    <h3>답글 쓰기</h3>
    답글 작성자 <input type="text" id="ANSWER_WRITER">
    <br>
    답글 제목 <input type="text" id="ANSWER_TITLE">
    <br>
    답글 내용 <input type="text" id="ANSWER_CONTENT">
    <br>
    <button type="button" onclick="fn_write_answer();">답글쓰기</button>
    <br>
    <br>

    <hr>
    <h3>댓글</h3>
    <div id="reply-area">
<%--        <c:forEach items="${replyList}" var="list">--%>
<%--            <input type="hidden" name="REPLY_SEQ" id="REPLY_SEQ" value="${list.SEQ}">--%>
<%--            <span>--%>
<%--                    ${list.WRITER}--%>
<%--            </span>--%>
<%--            <span>--%>
<%--                    ${list.CONTENT}--%>
<%--            </span>--%>
<%--        </c:forEach>--%>
    </div>

    <hr>
    <h3>댓글 쓰기</h3>
    댓글 작성자 <input type="text" id="REPLY_WRITER">
    <br>
    댓글 내용 <input type="text" id="REPLY_CONTENT">
    <br>
    <button type="button" onclick="fn_write_reply();">댓글쓰기</button>

</body>
</html>