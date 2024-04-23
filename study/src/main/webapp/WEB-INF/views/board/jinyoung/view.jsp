<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
	String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="../resources/js/jquery-2.2.4.min.js" type="text/javascript"></script>

<title>글상세</title>

</head>
<body>

	<script type="text/javascript">
  
 	$(document).ready(function(){
	  
		$("input:text[name='content']").bind("keydown", function(e){
			if(e.keyCode == 13) { // 엔터
				goAddWrite();
			}
		});
	  
	});// end of $(document).ready(function(){})-------------

	
	
	// Function Declaration
	// == 글 수정하기 ==
	function goEdit(seq) {
		
		const orgPwd = "${requestScope.boardvo.pwd}";
		var pwd = $("input:password[name='pwd']").val();
		
		if (orgPwd != pwd){
			alert("비밀번호가 일치하지 않습니다");
			return;
		}
		else{
			location.href = "edit.action?seq="+seq;
		}
		
	}// end of function goEdit(seq)---------------------------
	
	
	// 게시글 삭제
	function goDel(seq) {
		
		const orgPwd = "${requestScope.boardvo.pwd}";
		var pwd = $("input:password[name='pwd']").val();
		
		if (orgPwd != pwd){
			alert("비밀번호가 일치하지 않습니다");
			return;
		}
		else{
			if(confirm("정말로 삭제하시겠습니까?")) {
				const frm = document.goViewFrm;
				frm.seq.value = seq;
				frm.method = "post";
				frm.action = "<%= ctxPath%>/del.action";
				frm.submit();
			}
		}
		
		
	}
	// == 댓글쓰기 == 
	function goAddWrite() {
	  
		const comment_content = $("input:text[name='content']").val().trim();
			if(comment_content == "") {
				alert("댓글 내용을 입력하세요!!");
				return; // 종료
		}
	  
	}// end of function goAddWrite(){}------------------
  
  
</script>


	<div style="display: flex;">
		<div style="margin: auto; padding-left: 3%; width: 1024px;">

			<h2 style="margin-bottom: 30px;">
				글내용보기
				<button type="button" style="float: right;"
					onclick="javascript:location.href='<%= ctxPath%>/list.action'">목록보기</button>
			</h2>

			<table id="content">
				<tbody>
					<tr>
						<th style="width: 15%">글번호</th>
						<td>${requestScope.boardvo.seq}</td>
					</tr>

					<tr>
						<th>아이디</th>
						<td>${requestScope.boardvo.userid}</td>
					</tr>

					<tr>
						<th>제&nbsp;&nbsp;&nbsp;목</th>
						<td>${requestScope.boardvo.subject}</td>
					</tr>

					<tr>
						<th>내&nbsp;&nbsp;&nbsp;용</th>
						<td>
							<p style="word-break: break-all;">${requestScope.boardvo.content}</p>
						</td>
					</tr>

					<tr>
						<th>조회수</th>
						<td>${requestScope.boardvo.readCount}</td>
					</tr>

					<tr>
						<th>날&nbsp;&nbsp;&nbsp;짜</th>
						<td>${requestScope.boardvo.regDate}</td>
					</tr>
				</tbody>
			</table>

			<br>
			<button type="button" onclick="goEdit(${requestScope.boardvo.seq})">수 정</button>
			<button type="button" onclick="goDel(${requestScope.boardvo.seq})">삭 제</button>
			<input type="password" name="pwd" placeholder="비밀번호를 입력하세요" autocomplete="off">

			<c:if test="${empty requestScope.boardvo}">
				<div style="padding: 20px 0; font-size: 16pt; color: red;">존재하지 않습니다</div>
			</c:if>

			<div class="mt-5">
				<br>

				<%-- === 댓글쓰기 === --%>
				<h3 style="margin-top: 50px;">댓글쓰기</h3>

				<form name="addWriteFrm" id="addWriteFrm" style="margin-top: 20px;">
					<table>
						<tr>
							<th>아이디</th>
							<td><input type="text" name="cmtUserid" /></td>
						</tr>
						<tr>
							<th>내&nbsp;&nbsp;용</th>
							<td><input type="text" name="cmtContent" style="width: 500px;" /></td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="password" name="cmtPwd" /></td>
						</tr>
					</table>
					<br>
					<button type="button" onclick="goAddWrite()">작 성</button>
					<button type="reset">취 소</button>
				</form>

				<%-- === 댓글 === --%>
				<table id="cmtGrid"></table>
				<div id="cmtPager"></div>
			</div>
		</div>
	</div>

</body>
</html>






