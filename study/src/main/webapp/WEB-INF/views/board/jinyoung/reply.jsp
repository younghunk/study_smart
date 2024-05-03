<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% String ctxPath = request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/bootstrap.min.css">

<script src="../resources/js/jquery-2.2.4.min.js" type="text/javascript"></script>

<title>답글 쓰기</title>
</head>
<body>

<script type="text/javascript">

$(document).ready(function(){
	
	$("button#btnWrite").click(function(){
		
		var content = $("textarea[name='content']").val().trim();
		var userid = $("input:text[name='userid']").val().trim();
		
		if(userid == "") {
			alert("아이디는 필수사항입니다.");
			return;
		}
		
		if(content == "") {
			alert("글내용은 필수사항입니다.");
			return;
		}
		
		$.ajax({
			url: '<%=ctxPath%>addEnd.action',
			type: 'post',
			data: $("form[name='addFrm']").serialize(),
			success: function(json) {
				window.close();
				window.opener.location.reload();
			},
			erorr: function(request, status, error) {
				alert("답글 달기에 실패했습니다. 원인 => code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
	});
	
});
	
</script>

<div style="padding: 20px;">

	<h2>답글</h2>
	
	<form name="addFrm">
	
		<table class='table'>
			<tr>
				<th style="width: 100px;">제목</th>
				<td><input type="text" value="${requestScope.subject}" name="subject" readonly /></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td><input type="text" name="userid" /></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea style="width: 80%; height: 200px;" name="content" id="content"></textarea></td>
			</tr>
		</table>
		
		<div style="margin-left: 10px;">
			<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:self.close()">취소</button>
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">글쓰기</button>
		</div>
	
		<input type="hidden" name="groupno" value="${requestScope.groupno}" />
		<input type="hidden" name="fk_seq" value="${requestScope.fk_seq}" />
		<input type="hidden" name="depthno" value="${requestScope.depthno}" />

	</form>
	
</div>

</body>
</html>