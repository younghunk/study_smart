<%--
  Created by IntelliJ IDEA.
  User: tnals
  Date: 24. 6. 18.
  Time: 오후 4:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery UI CSS -->
    <link rel="stylesheet" type="text/css" media="screen" href="../resources/css/jquery-ui.min.css" />
    <!-- jqGrid CSS -->
    <link rel="stylesheet" type="text/css" media="screen" href="../resources/css/ui.jqgrid.css" />

    <!-- jQuery -->
    <script src="../resources/js/jquery-2.2.4.min.js" type="text/javascript"></script>
    <!-- jQuery UI -->
    <script src="../resources/js/jquery-ui.min.js" type="text/javascript"></script>
    <!-- jqGrid -->
    <script src="../resources/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
    <script src="../resources/js/jquery.jqGrid.min.js" type="text/javascript"></script>
</head>
<style>
    button {
        cursor: pointer;
    }
</style>
<body>
    <script type="text/javascript">
        let id = 0;
        let row = 0;
        $(document).ready(function() {
            fn_initGrid("grid");
            $('#grid').jqGrid('hideCol', 'cb');

            $("button#edit").click(function () {
                id = $("#grid").getGridParam('selarrrow');
                if (id == "") {
                    alert("수정할 게시글을 선택해주세요.");
                    return;
                } else {
                    $('button.editBtn').removeClass("d-none");
                    row = $("#grid").jqGrid('getRowData', id);
                    $("#grid").editRow(id);
                }
            });

            $("button#save").click(function () {
                $("#grid").jqGrid('saveRow', id, true);
                row = $("#grid").getRowData(id);
                $.ajax({
                    url: "/chosumin/edit.action",
                    type: "POST",
                    datatype: "json",
                    data: {"seq": row.seq, "userid": row.userid, "subject": row.subject, "content": row.content},
                    success: function (response) {
                        alert(response);
                    }, error: function () {
                        alert(response);
                    }
                });
                $("#grid").trigger("reloadGrid");
                $('button.editBtn').addClass("d-none");
            });

            $("button#reply").click(function () {
                id = $("#grid").getGridParam('selarrrow');
                row = $("#grid").getRowData(id);
                if (id == "") {
                    alert("답글을 작성할 게시글을 선택해주세요.");
                    return;
                } else {
                    location.href = '/chosumin/SMReply?seq='+row.seq;
                }
            });

        });

        function fn_initGrid(grid_id) {
            $('#' + grid_id).jqGrid({
                url: '/chosumin/getSMBoard',
                datatype: "json",
                type: "GET",
                colNames: ['글번호', '제목', '내용', '캘린더', '작성자', '작성일', 'groupno','depthno'],
                colModel: [
                    { name: 'seq', index: 'seq', align: 'center', width: '5%', sortable: false },
                    { name: 'subject', index: 'subject', align: 'left', width: '15%', sortable: false, editable: true, required: true },
                    { name: 'content', index: 'content', align: 'left', width: '40%', sortable: false, editable: true, required: true },
                    { name: 'date', index: 'date', align: 'center', width: '15%', sortable: false },
                    { name: 'userid', index: 'dauseride', align: 'center', width: '10%', sortable: false },
                    { name: 'regDate', index: 'regDate', align: 'center', width: '15%', sortable: false },
                    { name: 'groupno', index: 'groupno', align: 'center', width: '15%', sortable: false },
                    { name: 'depthno', index: 'depthno', align: 'center', width: '15%', sortable: false }
                ],
                 loadonce : true,
                 height: 450,
                 width: 1100,
                 multiselect: true,
                 loadtext : '로딩중..',
                 rowNum: 20,
                 pager: '#pager',
                 multiboxonly : true
            });
        }
    </script>

    <div class="d-flex">
        <div class="m-auto">
            <h2>글목록</h2>
            <div class="d-flex justify-content-end mb-3">
                <button type="button" class="mr-2 btn-sm btn-dark" onclick = "location.href = '/chosumin/SMWrite'">글쓰기</button>
                <button type="button" class="mr-2 btn-sm btn-dark" id="edit">수정하기</button>
                <button type="button" class="btn-sm btn-dark" id="reply">답글달기</button>
            </div>
            <table style="width: 1200px;" id="grid"></table>
            <div id="pager"></div>
            <div class="d-flex justify-content-end mt-3">
                <button type="button" class="mr-2 btn-sm btn-dark editBtn d-none" id="save">저장</button>
                <button type="button" class="btn-sm btn-dark editBtn d-none" onclick = "location.href = '/chosumin/SMBoard'">취소</button>
            </div>
        </div>
    </div>
</body>
</html>
