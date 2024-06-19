<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% String ctxPath = request.getContextPath(); %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>글목록</title>
    <link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" media="screen" href="../resources/css/jquery-ui.min.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="../resources/css/ui.jqgrid.css" />

    <!-- jqGrid 세팅 -->
    <script src="../resources/js/jquery-2.2.4.min.js" type="text/javascript"></script>
    <script src="../resources/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
    <script src="../resources/js/jquery.jqGrid.min.js" type="text/javascript"></script>
	
</head>

<body>
    <script type="text/javascript">
        $(document).ready(function() {
            fn_initGrid("grid");
        });

        function fn_initGrid(grid_id) {
            $('#' + grid_id).jqGrid({
                url: '/heojueun/getList.do',
                datatype: "json",
                mtype: "GET",
                colNames: ['글번호', '제목', '내용', '캘린더', '작성일'],
                colModel: [
                    { name: 'seq', index: 'seq', align: 'center', width: '5%', sortable: false },
                    { name: 'subject', index: 'subject', align: 'left', width: '15%', sortable: false, editable: true, required: true },
                    { name: 'content', index: 'content', align: 'left', width: '25%', sortable: false, editable: true, required: true },
                    { name: 'date', index: 'date', align: 'center', width: '15%', sortable: false },
                    { name: 'regDate', index: 'regDate', align: 'center', width: '10%', sortable: false }
                ],
                rowNum: 9999,
                viewrecords: false,
                multiselect: true,
                sortorder: "desc",
                sortable: true,
                loadonce: true,
                gridview: false,
                autowidth: true,
                height: "450px"
            });
        }
    </script>

    <div style="display: flex;">
		<divstyle="margin: auto;">
			<h2 style="margin: 30px 0 30px 0;">글목록</h2>
			
			<table style="width: 1200px;" id="grid"></table>
		</div>
    </div>

</body>
</html>
