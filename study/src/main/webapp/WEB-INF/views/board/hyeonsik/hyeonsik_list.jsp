<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
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
    <style>
        /* Custom Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 50px;
        }
        h1 {
        
        }
        #posttable {
            border: 1px solid #dee2e6;
            border-radius: 5px;
        }
        .btn-custom {
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>게시판</h1>
        <table id="posttable"></table>
        <div id="pager"></div>
    </div>

    <div class="container">
        <h1>출력 예제</h1>
        <a href="/download/excel" class="btn btn-primary btn-custom">엑셀 다운로드</a>
        <a href="/download/pdf" class="btn btn-primary btn-custom">PDF 출력</a>
    </div>

    <!-- jQuery -->
    <script src="../resources/js/jquery-2.2.4.min.js" type="text/javascript"></script>
    <!-- jQuery UI -->
    <script src="../resources/js/jquery-ui.min.js" type="text/javascript"></script>
    <!-- jqGrid -->
    <script src="../resources/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
    <script src="../resources/js/jquery.jqGrid.min.js" type="text/javascript"></script>

    <script>   
    	// 게시판 리스트 조회(with jqgrid)
        $(document).ready(function() {
            $("#posttable").jqGrid({
                url: '/posts', // 게시글 목록을 가져오는 URL
                datatype: 'json',
                mtype: 'GET',
                colNames: ['번호','제목', '작성자', '작성일', '조회수','답글기준','게시판번호', '그룹번호'],
                colModel: [
                    { name: 'id', index: 'id', width: 30 },
                    { name: 'title', index: 'title', width: 200 },
                    { name: 'writer', index: 'writer', width: 100 },
                    { name: 'created_date', index: 'createdDate', width: 100 },
                    { name: 'view_cnt', index: 'viewCnt', width: 50 },
                    { name: 'groupOrd', index: 'groupOrd', width: 50},
                    { name: 'originNo', index: 'originNo', width: 50},
                    { name: 'groupLayer', index: 'groupLayer'}
                ],
                rowNum: 20,
                rowList: [10, 20, 30],
                pager: '#pager',
                sorttable:true,
                viewrecords: true,
                height: 500,
        		width: 1000,
                emptyrecords : "데이터가 없습니다.",
                autowidth:true,
                loadonce: true,
                showpage : true,
                caption: '게시글 목록',
       
                
                onSelectRow: function(rowid) {
                    var rowData = $("#posttable").jqGrid('getRowData', rowid);
                    var id = rowData.id; // 선택된 행의 게시글 ID
                    var groupOrd = rowData.groupOrd;
                    var groupLayer = rowData.groupLayer;
                    console.log(groupLayer);
                    if (groupOrd != undefined && groupOrd >= 2) {
                    	window.location.href = '/hyeonsik_post?id=' + id;
                     
                
                    } else {
                    	window.location.href = '/hyeonsik_post?id=' + id;
                       
                     
                    }
                    
                },
                loadComplete: function(data) {
                    var grid = $("#posttable");
                    var ids = grid.jqGrid('getDataIDs');
                    for (var i = 0; i < ids.length; i++) {
                        var rowData = grid.jqGrid('getRowData', ids[i]);
                        var groupOrd = rowData.groupOrd;
                        if (groupOrd !== undefined && groupOrd >= 2) {
                            var title = rowData.title;
                            title = "<span style='color: red;'>RE:</span> " + title;

                         
                            var parentTitle = rowData.originNo; // 여기서 originNo는 부모 게시물의 ID라고 가정
                            if (parentTitle !== null) {
                                title = parentTitle + " - " + title;
                            }
                            grid.jqGrid('setRowData', ids[i], {title: title});
                        }
                    }
                }
            });

            $("#posttable").jqGrid('navGrid', '#pager', { edit: false, add: false, del: false });
            // 게시글 작성 버튼 
            $("#posttable").jqGrid('navButtonAdd', '#pager', {
                caption: "게시글 작성",
                buttonicon: "ui-icon-add",
                onClickButton: function() {
                    window.location.href = "/hyeonsik_write";
                }
            });
        });
    
    </script>
    
</body>
</html>