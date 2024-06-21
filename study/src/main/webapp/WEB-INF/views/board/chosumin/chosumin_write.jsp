<%--
  Created by IntelliJ IDEA.
  User: tnals
  Date: 24. 6. 20.
  Time: 오전 9:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>글쓰기</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery UI CSS -->
    <link rel="stylesheet" type="text/css" media="screen" href="../resources/css/jquery-ui.min.css" />
    <!-- jQuery -->
    <script src="../resources/js/jquery-2.2.4.min.js" type="text/javascript"></script>
    <!-- jQuery UI -->
    <script src="../resources/js/jquery-ui.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#btnWrite").click(function(){
                const userid = $('#userid').val();
                if(userid == ""){
                    alert("아이디를 입력해주세요.")
                    return;
                }
                const subject = $('#subject').val();
                if(subject == ""){
                    alert("제목을 입력해주세요.")
                    return;
                }
                const content = $('#content').val();
                if(content == ""){
                    alert("내용을 입력해주세요.")
                    return;
                }
                const form = document.write;
                form.method = "post";
                form.action = "/chosumin/write.action";
                form.submit();
            });
        })
    </script>
</head>
<body>
    <form name="write">
        <div class="m-auto d-flex flex-column w-50 h-75 justify-content-center p-2">
            <h2>글쓰기</h2>
                <label for="userid" class="mt-2">아이디</label>
                <input id="userid" name="userid" type="text">
                <label for="subject" class="mt-1">제목</label>
                <input id="subject" name="subject" type="text">
                <label for="content" class="mt-1">내용</label>
                <textarea name="content" id="content" cols="30" rows="10"></textarea>
                <div class="d-flex justify-content-end mt-2">
                    <button type="button" id="btnWrite" class="mr-2 btn-sm btn-dark">등록</button>
                    <button type="button" id="btnCancel" class="btn-sm btn-dark" onclick = "location.href = '/chosumin/SMBoard'">취소</button>
                </div>
        </div>
    </form>
</body>
</html>
