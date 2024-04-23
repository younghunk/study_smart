<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>

<script src = "../resources/js/jquery-2.2.4.min.js" type = "text/javascript"></script>

<script type="text/javascript">

  $(document).ready(function(){
	  
	  // 글쓰기 버튼
	  $("button#btnWrite").click(function(){
		  
		  // 아이디 유효성 검사 및 공백체크 
		  const userid = $("input:text[name='userid']").val().trim();
		  if(userid == "") {
		  	 alert("아이디를 입력하세요");
		  	 return; // 종료
		  }
		  
		  const pattern = /^[A-Za-z]+$/;
		  
		  if(!pattern.test(userid)){
			  alert("아이디는 공백없이 영문으로만 작성해주십시오.");
			  return;
		  }
		
		  // 글제목 유효성 검사 
		  const subject = $("input:text[name='subject']").val().trim();
		  if(subject == "") {
		  	 alert("글제목을 입력하세요");
		  	 return; // 종료
		  }
		
		  // 글내용 유효성 검사
    	  let contentval = $("textarea#content").val();
    	  
          if(contentval.trim().length == 0) {
             alert("글내용을 입력하세요");
             return;
          }
		  
		  // 폼(form)을 전송(submit)
		  const frm = document.addFrm;
		  frm.method = "post";
		  frm.action = "<%= ctxPath%>/addEnd.action";
		  frm.submit();
	  });
	  
	  
	  $("button#btnCancle").click(function(){
		
		 if(confirm("정말로 취소하시겠습니까? \n취소시 이전 페이지로 이동합니다.")) {
			 window.history.back();
		 } 
		  
	  });
	  
  });// end of $(document).ready(function(){})-----------

</script>

</head>
<body>

<div style="display: flex;">
  <div style="margin: auto; padding-left: 3%;">
     
	<h2 style="margin-bottom: 30px;">글쓰기</h2>
     
 	<form name="addFrm">
        <table style="width: 1024px">
			<tr>
				<th style="width: 15%;">아이디</th>
				<td>
				    <input type="text" name="userid" autocomplete="off" /> 
				</td>
			</tr>
			
			<tr>
				<th style="width: 15%;">제목</th>
				<td>
    				<input type="text" name="subject" size="100" maxlength="200" autocomplete="off" /> 
				</td>
			</tr>
			
			<tr>
				<th style="width: 15%;">내용</th> 
				<td>
				    <textarea style="width: 100%; height: 200px;" name="content" id="content"></textarea>
				</td>
			</tr>
			
        </table>
        
        <div style="margin: 20px;">
            <button type="button" id="btnWrite">글쓰기</button>
            <button type="button" id="btnCancle">취소</button>  
        </div>
        
     </form>
     
  </div>
</div>

</body>
</html>






