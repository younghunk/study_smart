<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>

        // $(document).ready(function () {
        //     console.log("!!!!!!!!!!!!!!!!!!!!");
        //     console.log($("#writer").val());
        //     console.log($("#title").val());
        //     console.log($("#content").val());
        // })

        function savePost(){

            console.log($("#writer").val());
            console.log($("#title").val());
            console.log($("#content").val());

            $.ajax({
                type : 'post',
                url : '/board/qnaboardr/write',
                data : {
                    writer : $("#writer").val(),
                    title : $("#title").val(),
                    content : $("#content").val()
                } ,
                success : function (result) {
                    if(result.result == "success"){
                        // alert("저장성공");
                        location.href = "/board/qnaboardr/list";
                    }
                    else{
                        alert("저장실패");
                        return false;
                    }
                },
                error : function (error) {
                    console.log(error)
                }
            })
        }
    </script>

</head>
<body>

<%--    <form action="/board/qnaboardr/write" method="post" id="writeForm">--%>
<%--        작성자 <input type="text" name="writer" id="writer" value="test">--%>
<%--        <br>--%>
<%--        제목 <input type="text" name="title" id="title">--%>
<%--        <br>--%>
<%--        내용 <input type="text" name="content" id="content">--%>
<%--        <br>--%>

<%--        <button type="submit">등록</button>--%>
<%--    </form>--%>

    <div id="writeForm">
        작성자 <input type="text" name="writer" id="writer">
        <br>
        제목 <input type="text" name="title" id="title"> &nbsp; 공지<input type="checkbox" name="noticeYn" value="Y">
        <br>
        내용 <input type="text" name="content" id="content">
        <br>
    </div>
    <button type="button" onclick="savePost();">등록</button>

</body>
</html>