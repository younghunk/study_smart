<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
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

    <link rel="stylesheet" type="text/css" href="../resources/dhtmlx/dhtmlx.css"/>
    <script src="../resources/dhtmlx/dhtmlx.js" type="text/javascript"></script>
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

        //달력에서 버튼 클릭시 날짜 input값 지워짐
        function fn_clearDate(rowId) {
            $('input[id='+rowId+']').val('');
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
                    { name: 'date', index: 'date', align: 'center', width: '20%', sortable: false, editable: true,
                        edittype: 'custom',
                        editoptions: {
                            custom_element:Calendar,
                            custom_value: setVal,
                            dataInit: function(e) {
                                var id = $(e).find("input").attr("id");
                                $(e).find("img").attr("id", id + '_img');
                                $(e).find("img").attr("name", id + '_img');
                                $(e).find("button").attr("id", id + '_btn');
                                $(e).find("button").attr("name", id + '_btn');
                                initCal(id, id + '_img');
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

        var calendar;
        function initCal(inputId, btnId) {
            calendar = new dhtmlXCalendarObject({input: inputId, button: btnId});
            calendar.setDate(new Date());
            calendar.setDateFormat("%Y-%m-%d");
        }

        // 달력 커스텀 사용
        function Calendar(value, options) {
            var rowId = options.id;
            var str = "";
            str += '<input type="text" readonly style="width= 40px;" value="' + value + '"/>';
            str += '<img class="btnCalendar" src="/resources/images/calendar.png"/>';
            str += '<button type="button" onclick="fn_clearDate(\'' + rowId + '\');">새로고침</button>';
            return str;
        }

        function setVal(elem, operation, value) {
            if (operation === 'get') {
                return $(elem).val();
            }
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
                var rowDataList = [];
                var id = $("#grid").getGridParam('selarrrow');
                for(var i =0; i<id.length; i++){
                    $("#grid").jqGrid('saveRow', id[i], true);
                    row = $("#grid").getRowData(id[i]);
                    rowDataList.push(row);
                    $('#grid').jqGrid('setCell', id[i], 'selectType', null);
                }

                $.ajax({
                    url: "/chosumin/updateBoardList",
                    type: "POST",
                    contentType: 'application/json',
                    data: JSON.stringify(rowDataList),
                    success: function (response) {
                        alert("성공");
                    }, error: function () {
                        alert(response);
                    }
                });

                location.reload();
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
