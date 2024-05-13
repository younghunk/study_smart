<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<html>
<head>
    <title>회원 로그인</title>
</head>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/bootstrap.min.css">

<script type="text/javascript">

    document.addEventListener("DOMContentLoaded", function() {

        document.addEventListener("keydown", function(event) {
            if(event.keyCode === 13) {
                accessMemberRequest();
            }
        });

        document.getElementById("memberLogIn").addEventListener("click", function() {
            accessMemberRequest();
        });
    });

    function accessMemberRequest() {

        if(document.getElementsByName("memberId")[0].value.replace(/\s/gi, "") == "") {
            alert("ID가 입력되지 않았습니다.\nID를 입력해 주세요.");
            document.getElementsByName("memberId")[0].focus();
            return false;
        }

        if(document.getElementsByName("memberPw")[0].value.replace(/\s/gi, "") == "") {
            alert("비밀번호가 입력되지 않았습니다.\n비밀번호를 입력해 주세요.");
            document.getElementsByName("memberPw")[0].focus();
            return false;
        }

        document.getElementById("formMemberAccess").method = "POST";
        document.getElementById("formMemberAccess").action = "/member/authenticationProcess.do";
        document.getElementById("formMemberAccess").submit();
    }
    
</script>

<body>
<h1>회원 로그인</h1>
<c:if test="${param.error != null}">
    <p style="color:#FF0000;">Login failed.</p>
</c:if>
<form id="formMemberAccess">
    <table>
        <tbody>
        <tr>
            <th>사용자 ID</th>
            <td><input type="text" name="memberId" required/></td>
        </tr>
        <tr>
            <th>비밀번호</th>
            <td><input type="password" name="memberPw" required/></td>
        </tr>
        </tbody>
        <tfoot style="border:0px">
        <tr>
            <td colspan="2">
                <button type="button" id="memberLogIn">Log In</button>
            </td>
        </tr>
        </tfoot>
    </table>
</form>
</body>
</html>