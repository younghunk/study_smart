<%--
  Created by IntelliJ IDEA.
  User: tnals
  Date: 24. 6. 18.
  Time: 오후 4:16
  To change this template use File | Settings | File Templates.
--%>
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

    <!-- jQuery -->
    <script src="../resources/js/jquery-2.2.4.min.js" type="text/javascript"></script>
    <!-- jQuery UI -->
    <script src="../resources/js/jquery-ui.min.js" type="text/javascript"></script>
    <!-- jqGrid -->
    <script src="../resources/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
    <script src="../resources/js/jquery.jqGrid.min.js" type="text/javascript"></script>
</head>
<body>
    <script>
        $(document).ready(function() {

            // 그리드 생성
            function createGrid(){
                $("#list").jqGrid({
                    datatype: "local",
                    data: mydata,
                    colNames:['글번호', '아이디', '제목','본문','조회수','작성일','삭제유무','댓글수','날짜','그룹번호'],
                    colModel:[
                        {name:'seq', index:'seq', width:20, align: "center"},
                        {name:'userid', index:'userid', width:50 , align: "center" },
                        {name:'subject', index:'subject', width:100, align: "center" ,sortable:false },
                        {name:'content', index:'content', align: "left"},
                        {name:'readCount', index:'readCount', width:30, align: "center"},
                        {name:'regDate', index:'regDate', width:80, align: "center"},
                        {name:'status', index:'status', width:40, align: "center"},
                        {name:'commentCount', index:'commentCount', width:30, align: "center"},
                        {name:'date', index:'date', width:50, align: "center"},
                        {name:'groupno', index:'groupno', width:30, align: "center"}
                    ],
                    autowidth: true,
                    //rownumbers : true,
                    pager:'#pager',
                    rowNum: 10,
                    //rowList: [10, 20, 50],
                    sortname: 'regDate',
                    sortorder: 'asc',
                    height: 250,
                });
            }

            var mydata = new Array();

            // 게시판 데이터 받아오기
            function getSMBoard (){
                $.ajax({
                    url: "/getSMBoard",
                    type: "GET",
                    datatype: "json",
                    success: function (response){
                         for(let i = 0; i<response.length; i++){
                             mydata.push({seq:response[i].seq, userid:response[i].userid, subject:response[i].subject, content:response[i].content, readCount:response[i].readCount, regDate:response[i].regDate, status:response[i].status, commentCount:response[i].commentCount, date:response[i].date, groupno:response[i].groupno})
                         }
                        createGrid();
                    },
                    error: function (error){
                        alert("게시판을 불러오는데 실패하였습니다.")
                    }
                })
            }

            getSMBoard();

            $(window).on('resize.jqGrid', function() {
                $("#list").jqGrid('setGridWidth', $("#list").parent().parent().parent().parent().parent().width());
            })
            $(".jarviswidget-fullscreen-btn").click(function(){
                setTimeout(function() {
                    $("#list").jqGrid('setGridWidth', $("#list").parent().parent().parent().parent().parent().width());
                }, 100);
            });
        });
    </script>
    <div>
        <div class="tableWrap">
            <table id="list"></table>
            <div id="pager"></div>
        </div>
    </div>
</body>
</html>
