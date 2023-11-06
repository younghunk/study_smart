<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2023-10-17
  Time: 오전 10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script
        src="/resources/js/jquery-2.2.4.min.js"></script>
<html>
<head>
    <title>비밀번호 확인</title>
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
<div layout:fragment="content">
    <div>
        <form name="checkForm" action="check" autocomplete="off" method="post">
            <input type="hidden" name="id" value="${board.id}"/>
            <div>
                <br/>
                글을 작성할 때 입력했던 비밀번호를 적어주세요.
                <input type="password" id="password" name="password" maxlength='6'  value="${board.password}" placeholder="비밀번호">
                <BUTTON> 비밀번호 확인 </BUTTON>
                <br/>
            </div>
        </form>

    </div>
</div>
</body>

<script>
</script>
</html>
