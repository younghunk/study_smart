<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script
        src="/resources/js/jquery-2.2.4.min.js"></script>
<script>

</script>

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
    <title>답글 작성하기</title>
</head>
<body>
<script>
    function  checkSubmit(){
        if(check()){
            document.getElementById("reply").submit();
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
</script>

<h1>답글 작성</h1>
<form id="reply" action="reply" method="post" onsubmit="checkSubmit()">
    <input type="hidden" name = "id" value="${ref.id}">
    <input type="hidden" name ="root" value="${ref.root}">
    제 목: <input id= "title" type="text" name="title" value="${ref.re}"><br/>
    이 름: <input id="writer" type="text"  name="writer"></br>
    비밀번호: <input id= "password" type="text" name="password"></br>
    내 용: <input id= "content" type="text" name="content"></br>


    <input name="ref" type="hidden" value="${ref.ref}">
    <input name="step" type="hidden" value="${ref.step}">
    <input name="depth" type="hidden" value="${ref.depth}">

    <button onclick="location.href='select'">목록으로</button>
    <button onclick="return check();">답글 작성하기</button>
</form>

</body>
</html>