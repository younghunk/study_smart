<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src = "../resources/js/jquery-2.2.4.min.js" type = "text/javascript"></script>

<title>Insert title here</title>
</head>
<body>

<script type="text/javascript">

	alert("${requestScope.msg}");
	location.href = "${requestScope.loc}";

</script>

</body>
</html>