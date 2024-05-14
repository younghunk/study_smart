<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" type="text/css"	href="<%=ctxPath%>/resources/css/bootstrap.min.css">
<script src="../resources/js/jquery-2.2.4.min.js" type="text/javascript"></script>

<style type="text/css">
* { padding: 0; margin: 0; }
html, body {  height: 100%;  background: #ffffff; }
#container {  display: flex;  flex-direction: row;  justify-content: center;  align-items: center;  height: 100%; }
#loginBox {  width: 300px;  text-align: center;  background-color: #ffffff; }
.input-form-box {  border: 0px solid #ff0000;  display: flex;  margin-bottom: 5px; }
.input-form-box > span {  display: block;  text-align: left;  padding-top: 5px;  min-width: 65px; }
.button-login-box {  margin: 10px 0; }
#loginBoxTitle {  color:#000000;  font-weight: bold;  font-size: 32px;  text-transform: uppercase;  padding: 5px;  margin-bottom: 20px;}
#inputBox {  margin: 10px;}
#inputBox button {  padding: 3px 5px;}
</style>

<script type="text/javascript">
$(document).ready(function(){
	
	$("button#googleLogin").click(function(){
		
		location.href="/oauth2/authorizaiton/google";
		
	});
	
	$("button#naverLogin").click(function(){
		
		location.href="/oauth2/authorizaiton/naver";
		
	});
	
});
</script>

<title>메인페이지</title>
</head>
<body>
    <div id="container">
      <div id="loginBox">
		<form name="loginFrm">
	        <div id="loginBoxTitle">Login</div>
	        <div id="inputBox">
	          <div class="input-form-box">
	          	<span>아이디 </span><input type="text" name="user_id" class="form-control">
	          </div>
	          <div class="input-form-box">
	          	<span>비밀번호 </span><input type="password" name="user_pwd" class="form-control">
	          </div>
	          <div class="button-login-box" >
	            <button id= "localLogin" type="button" class="btn btn-primary btn-xs" style="width:33%">로그인</button>
	            <button id= "googleLogin" type="button" class="btn btn-primary btn-xs" style="width:33%">구글로그인</button>
	            <button id= "naverLogin" type="button" class="btn btn-primary btn-xs" style="width:33%">네이버로그인</button>
	          </div>
	        </div>
		</form>
      </div>
    </div>
</body>



</html>