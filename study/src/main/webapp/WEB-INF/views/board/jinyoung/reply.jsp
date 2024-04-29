<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% String ctxPath = request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/bootstrap.min.css">

<title>Insert title here</title>
</head>
<body>
<h2>원글</h2>
<table class='table'>
	<tr>
		<th>글번호</th>
		<td>${orgPost.seq}</td>
	</tr>
	<tr>
		<th>제목</th>
		<td>${orgPost.seq}</td>
	</tr>
	<tr>
		<th>내용</th>
		<td>${orgPost.seq}</td>
	</tr>
	<tr>
		<th>아이디</th>
		<td>${orgPost.userid}</td>
	</tr>
	<tr>
		<th>작성일</th>
		<td>${orgPost.regDate}</td>
	</tr>
</table>

<h2>답글</h2>

<table class='table'>
	<tr>
		<th>제목</th>
		<td><input type="text" /></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><input type="text" /></td>
	</tr>
	<tr>
		<th>아이디</th>
		<td><input type="text" /></td>
	</tr>
</table>
</body>
</html>