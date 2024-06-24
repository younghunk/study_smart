<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% String ctxPath = request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/bootstrap.min.css">
<script src="<%=ctxPath%>/resources/js/jquery-2.2.4.min.js" type="text/javascript"></script>
<title>답글 쓰기</title>
</head>
<body>

<script type="text/javascript">
$(document).ready(function(){
    $("#btnWrite").click(function(){
        var content = $("textarea[name='content']").val().trim();
        
        if(content === "") {
            alert("글내용은 필수사항입니다.");
            return;
        }

        var formData = {
            subject: $("input[name='subject']").val(),
            content: content,
            groupno: $("input[name='groupno']").val(),
            fk_seq: $("input[name='fk_seq']").val(),
            depthno: $("input[name='depthno']").val()
        };

        $.ajax({
            url: '<%=ctxPath%>/heojueun/newComment.do',
            type: 'post',
            data: JSON.stringify(formData),
            contentType: 'application/json; charset=utf-8',
            success: function(json) {
                console.log("Success response: ", json);
                window.close();
                window.opener.location.reload();
            },
            error: function(request, status, error) {
                console.error("Request: ", request);
                console.error("Status: ", status);
                console.error("Error: ", error);
                alert("답글 달기에 실패했습니다. 원인 => code: " + request.status + "\nmessage: " + request.responseText + "\nerror: " + error);
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
                <td><input type="text" value="${subject}" name="subject" readonly /></td>
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
        <input type="hidden" name="groupno" value="${groupno}" />
        <input type="hidden" name="fk_seq" value="${fk_seq}" />
        <input type="hidden" name="depthno" value="${depthno}" />
    </form>
</div>

</body>
</html>
