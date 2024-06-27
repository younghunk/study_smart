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

    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
    <!-- jqGrid -->
    <script src="../resources/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
    <script src="../resources/js/jquery.jqGrid.min.js" type="text/javascript"></script>
</head>
<style>
    button {
        cursor: pointer;
    }
    .jqgrid-ellipsis {
        white-space: nowrap;
        text-overflow: ellipsis;
        overflow: hidden;
    }
    .editable.hasDatepicker{
        width:35% !important;
    }
    .ui-datepicker-current{
        display: none;
    }
</style>
<body>
    <script type="text/javascript">
        let id = 0;
        let row = 0;
        let idval = 0;

        //달력 새로고침
        function refresh(prefix) {
            idval = prefix + '_date';
            $('#' + idval).val('');
        }

        //그리드 그리기
        function fn_initGrid(grid_id) {
            $('#' + grid_id).jqGrid({
                url: '/chosumin/getSMBoard',
                datatype: "json",
                type: "GET",
                colNames: ['글번호', '제목', '내용', '캘린더', '작성자', '작성일', 'selectType', 'groupno','depthno'],
                colModel: [
                    { name: 'seq', index: 'seq', align: 'center', width: '5%', sortable: false},
                    { name: 'subject', index: 'subject', align: 'left', width: '15%', sortable: false, editable: true, required: true, classes: 'jqgrid-ellipsis' },
                    { name: 'content', index: 'content', align: 'left', width: '40%', sortable: false, editable: true, required: true, classes: 'jqgrid-ellipsis'},
                    { name: 'date', index: 'date', align: 'center', width: '20%', sortable: false, editable: true,showOn:'button', buttonText: 'calendar',
                        editoptions : { dataInit : function(e){
                                $(e).datepicker({ dateFormat: 'yy-mm-dd', constrainInput: false, showOn:'button', buttonText: '달력',showButtonPanel: true, showtoday:false, closeText: "닫기"});
                                idval = $(e).attr('id');
                                var prefix = idval.split('_')[0];
                                $(e).after("<button class='refresh' onclick=\"refresh('" + prefix + "')\">새로고침</button>");
                            }
                        }
                    },
                    { name: 'userid', index: 'userid', align: 'center', width: '10%', sortable: false, hidden: true},
                    { name: 'regDate', index: 'regDate', align: 'center', width: '10%', sortable: false},
                    { name: 'selectType', index: 'selectType', align: 'center', width: '5%', sortable: false, hidden: true},
                    { name: 'groupno', index: 'groupno', align: 'center', width: '15%', sortable: false, hidden: true},
                    { name: 'depthno', index: 'depthno', align: 'center', width: '15%', sortable: false, hidden: true}
                ],
                loadonce : true,
                height: 460,
                width: 1200,
                multiselect: true,
                loadtext : '로딩중..',
                rowNum: 9999,
                multiboxonly : true,
                sortable: false,
                // 그리드 다중선택 가능
                beforeSelectRow: function (rowid, e) {
                    var $myGrid = $(this),
                        i = $.jgrid.getCellIndex($(e.target).closest('td')[0]),
                        cm = $myGrid.jqGrid('getGridParam', 'colModel');
                    return (cm[i].name === 'cb');
                }
            });
        }

        $(document).ready(function() {
            fn_initGrid("grid");

            //글쓰기
            $("#write").click(function () {
                var rowId =  $.jgrid.randId();
                $("#grid").jqGrid("addRowData", rowId, {selectType:'write'}, 'first');
                $("#grid").jqGrid('setSelection', rowId);
                $("#grid").editRow(rowId);
                $('#grid').setRowData(rowId, false, { background:"#d0fc5c", border:"#acca69",color:"#777620" });
                $('button.editBtn').removeClass("d-none");
            });

            //편집기능
            $("#edit").click(function () {
                id = $("#grid").getGridParam('selarrrow');
                if (id == "") {
                    alert("수정할 게시글을 선택해주세요.");
                    return;
                } else {
                    $('button.editBtn').removeClass("d-none");
                    for(var i =0; i<id.length; i++){
                        row = $("#grid").getRowData(id[i]);
                        if(row.selectType == '' || row.selectType != 'write'){
                            $('#grid').jqGrid('setCell', id[i], 'selectType', 'edit');
                            $('#grid').setRowData(id[i], false, { background:"#fffa90", border:"#dad55e",color:"#777620" });
                            $("#grid").editRow(id[i]);
                        }
                    }
                }
            });

            //삭제기능
            $("#delete").click(function () {
                id = $("#grid").getGridParam('selarrrow');
                if (id == "") {
                    alert("삭제할 게시글을 선택해주세요.");
                    return;
                } else {
                    $('button.editBtn').removeClass("d-none");
                    for(var i =0; i<id.length; i++){
                        row = $("#grid").getRowData(id[i]);
                        if(row.selectType == '' || row.selectType != 'write'){
                            $("#grid").jqGrid('saveRow', id[i], true);
                            $('#grid').jqGrid('setCell', id[i], 'selectType', 'delete');
                            $('#grid').setRowData(id[i], false, { background:"#ffc0cb", border:"#fa8072",color:"black" });
                        }
                    }
                }
            });

            //저장 => 추가/수정/삭제 한번에 (selectType으로 구분)
            $("#save").click(function () {
                var reload = 0;
                var id = $("#grid").getGridParam('selarrrow');
                for(var i =0; i<id.length; i++){
                    $("#grid").jqGrid('saveRow', id[i], true);
                    row = $("#grid").getRowData(id[i]);

                if(row.selectType == 'edit'){
                        $.ajax({
                            url: "/chosumin/updateBoard",
                            type: "POST",
                            datatype: "json",
                            data: {"seq": row.seq, "subject": row.subject, "content": row.content, "date": row.date},
                            success: function (response) {
                            }, error: function () {
                                alert(response);
                            }
                        });
                        $('#grid').jqGrid('setCell', id[i], 'selectType', null);
                    }else if(row.selectType == 'write'){
                        reload = 1;
                        $.ajax({
                            url: "/chosumin/insertBoard",
                            type: "POST",
                            datatype: "json",
                            data: {"subject": row.subject, "content": row.content, "date": row.date},
                            success: function (response) {
                            }, error: function () {
                                alert(response);
                            }
                        });
                        $('#grid').jqGrid('setCell', id[i], 'selectType', null);
                    }else if(row.selectType == 'delete'){
                        reload = 1;
                        $.ajax({
                            url: "/chosumin/deleteBoard",
                            type: "POST",
                            datatype: "json",
                            data: {"seq": row.seq},
                            success: function (response) {
                            }, error: function () {
                                alert(response);
                            }
                        });
                    }
                }
                if(reload == 1){
                    location.reload();
                }else{
                    $("#grid").trigger("reloadGrid");
                }
                $('button.editBtn').addClass("d-none");
            });

            //답글기능
            $("#reply").click(function () {
                id = $("#grid").getGridParam('selarrrow');
                row = $("#grid").getRowData(id);
                if (id == "") {
                    alert("답글을 작성할 게시글을 선택해주세요.");
                    return;
                } else {
                    location.href = '/chosumin/replyBoard?seq='+row.seq;
                }
            });

            //취소기능(그리드 리로드)
            $("#cancel").click(function () {
                for(var i =0; i<id.length; i++){
                    $('#grid').jqGrid('setCell', id[i], 'selectType', null);
                }
                $("#grid").trigger("reloadGrid");
                $('button.editBtn').addClass("d-none");
            });


        });
    </script>

    <div class="d-flex">
        <div class="m-auto">
            <h2>글목록</h2>
            <div class="d-flex justify-content-end mb-3">
                <button type="button" class="mr-2 btn-sm btn-dark" id="write">글쓰기</button>
                <button type="button" class="mr-2 btn-sm btn-dark" id="edit">수정하기</button>
                <button type="button" class="mr-2 btn-sm btn-dark" id="delete">삭제하기</button>
                <button type="button" class="btn-sm btn-dark" id="reply">답글달기</button>
            </div>
            <table id="grid"></table>
            <div id="pager"></div>
            <div class="d-flex justify-content-end mt-3">
                <button type="button" class="mr-2 btn-sm btn-dark editBtn d-none" id="save">저장</button>
                <button type="button" class="btn-sm btn-dark editBtn d-none" id="cancel">취소</button>
            </div>
        </div>
    </div>
</body>
</html>
