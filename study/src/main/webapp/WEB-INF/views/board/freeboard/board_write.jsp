<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script
        src="/resources/js/jquery-2.2.4.min.js"></script>

<%--<script>--%>
<%--    $.ajax({--%>
<%--        type : "POST",--%>
<%--        url : "/board/write",--%>
<%--        dataType: 'json',--%>
<%--//응답, 상태, XMLHttpRequest객체를 파라미터로 받음--%>
<%--        success:function(result, status, xhr){--%>
<%--//응답 결과 출력--%>
<%--            console.log(result);--%>
<%--        }--%>
<%--    });--%>
<%--</script>--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
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
<script>
    function  checkSubmit(){
        if(check()){
            document.getElementById("write").submit();
        }
    }
    function check(){

        if(document.getElementById("title").value==""){
            alert("제목을 입력하세요.");
            return false;
        }
        else if(document.getElementById("writer").value==""){
            alert("이름을 입력하세요.");
            return false;
        }
        else if(document.getElementById("password").value==""){
            alert("비밀번호를 입력하세요.");
            return false;
        }
        else if(document.getElementById("content").value==""){
            alert("내용을 입력하세요.");
            return false;
        }
        return true;
    }

    function Check(obj){
        var check = obj.check;
        if(check){
            obj.value ="Y";
        }else {
            obj.value = "N";
        }

    }
</script>

<h1>게시글 작성</h1>
<form id="write" action="write" method="post" onsubmit="checkSubmit()">

    <div class="input-group mb-3">
        <span class="input-group-text" >제목</span>
        <input type="text" id= "title" name="title" class="form-control" placeholder="제목을 입력주세요." aria-label="Username" aria-describedby="basic-addon1">

    </div>

    <div class="input-group mb-3">
        <span class="input-group-text" >이름</span>
        <input type="text" id="writer" name="writer" class="form-control" placeholder="이름을 입력주세요." aria-label="Username" aria-describedby="basic-addon1">
    </div>

    <div class="input-group mb-3">
        <span class="input-group-text" >비밀번호</span>
        <input type="text" id= "password" name="password" class="form-control" placeholder="비밀번호를 입력주세요." aria-label="Username" aria-describedby="basic-addon1">
    </div>

    <div class="form-check">
        <input class="form-check-input" value="Y" type="checkbox" id="check" name = "check">
        <label class="form-check-label" for="check">
            공지사항 체크박스
        </label>
    </div>

    <div class="input-group">
        <span class="input-group-text">내용</span>
        <textarea id= "content" type="text" name="content" class="form-control" aria-label="With textarea"></textarea><br/>
    </div>
    <button onclick="location.href='select'">목록으로</button>
    <button onclick="return check();">글 작성하기</button>

</form>

</body>
</html>