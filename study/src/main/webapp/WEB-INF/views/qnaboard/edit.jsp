<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>

    작성자 <input type="text" name="writer" value="${vo.writer}" readonly>
    <br>
    제목 <input type="text" name="title" value="${vo.title}" readonly>
    <br>
    내용 <input type="text" name="content" value="${vo.content}" readonly>
    <br>

    <button type="button" onclick="location.href='/freeboard/detail?seq=${vo.seq}'">수정</button>

</body>
</html>