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
	
	<!-- style 설정 -->
	<link rel="stylesheet" type="text/css" href="../resources/dhtmlx/dhtmlx.css"/>
	<script src="../resources/dhtmlx/dhtmlx.js" type="text/javascript"></script>
	
	<style type="text/css">
		
		button {
			margin-top: 20px;
			float: right;
			border-radius: 3px;
			background: none;
			border-width: 1px;
		}
		
		table {
			font-size: 12px;
		}
		
	</style>
	
</head>

<body>
    <script type="text/javascript">
		let editArr = new Array();
		
        $(document).ready(function() {
            fn_initGrid("grid");
		});

        function fn_initGrid(grid_id) {
            $('#' + grid_id).jqGrid({
                url: '/heojueun/getList.do',
                datatype: "json",
                mtype: "POST",
                colNames: ['글번호', '제목', '내용', '캘린더', '작성일'],
                colModel: [
                    { name: 'seq', index: 'seq', align: 'center', width: '5%', sortable: false },
                    { name: 'subject', index: 'subject', align: 'left', width: '15%', sortable: false, editable: true, editoptions: { defaultValue: function() { return $('#grid').jqGrid('getCell', rowid, 'subject'); }} },
                    { name: 'content', index: 'content', align: 'left', width: '25%', sortable: false, editable: true, editoptions: { defaultValue: function() { return $('#grid').jqGrid('getCell', rowid, 'content'); }} },
					{ name:'date',		index:'date', 		align:'center',	width:'15%',	sortable: false, 
						editable:true, edittype: 'custom',
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
                    { name: 'regDate', index: 'regDate', align: 'center', width: '10%', sortable: false }
                ],
                rowNum: 20,
				rowList:[5,10,15,20],
                viewrecords: false,
                multiselect: true,
                sortorder: "desc",
                sortable: true,
                loadonce: true,
				cellEdit:true,
				cellsubmit: 'clientArray',
                gridview: false,
                autowidth: true,
                height: "auto",
				pager:'#grid',
				loadtext  : "로딩중...",
				beforeSelectRow: function (rowid, e) {
				    return false;
				},
				onCellSelect: function(rowid, iCol, cellcontent, e) {
                  	editArr.push(rowid);
				},
				afterEditCell:function(rowid, cellname, value, iRow, iCol){
				    $("#" + rowid + "_" + cellname).blur(function(){ 
				       $("#grid").jqGrid("saveCell",iRow,iCol);   
				 	});
				},
				afterSaveCell: function (rowid, name, val, iRow, iCol) {
					if ($("#"+id).jqGrid('getRowData', rowid, "statusV") !== "U" && $("#"+id).getRowData(rowid).statusV!=="I" ) {
						$("#"+id).jqGrid('setRowData', rowid, { statusV: "U" });
									
					}
				},
            });
        }
		
		
		//달력에서 버튼 클릭시 날짜 input값 지워짐
		function fn_clearDate(rowId) {
			$('input[id='+rowId+']').val('');
		}
		
		function setVal(elem, operation, value) {
			if (operation === 'get') {
				return $(elem).val();
			}
		}
		
		function newPost() {
			location.href="<%=ctxPath%>/heojueun/newPostPage.do";
		}
		
		
		// 캘린더 설정
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
		    str += '<button type="button" style="width= 5px; class="btn btn-danger" onclick="fn_clearDate(\'' + rowId + '\');">x</button>';
		    return $(str)[0];
		}
		
		function fn_save() {
			// 현재 선택된 행의 편집 모드 종료
		    let selectedRowId = $("#grid").jqGrid('getGridParam', 'selrow');
		    if (selectedRowId) {
		        $("#grid").jqGrid('restoreRow', selectedRowId);
		    }
			
			
			let arr = Array.from(new Set(editArr));
			let saveArr = [];
			
			for(let i = 0; i < arr.length; i++) {
				saveArr.push($("#grid").jqGrid("getRowData", arr[i]));
			}
			
			
			
			// 저장 시작 ajax 
			
			$.ajax({
				url: '/heojueun/updatePost.do',
				type: 'POST',
				data: JSON.stringify(saveArr),
				contentType: 'application/json', // 요청 헤더에 Content-Type 설정
				success: function(res) {
					if(res == 200) {
						alert("Success");
						$("#grid").trigger('reloadGrid');
					}
					else
						alert("Server Error");
				},
				erorr: function(request, status, error) {
					alert("삭제에 실패했습니다. 원인 => code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
		}
		
		
    </script>

    <div style="display: flex;">
		<div style="margin: auto;">
			<h2 style="margin: 30px 0 30px 0;">글목록</h2>

			<table style="width: 1200px;" id="grid"></table>
			<button onclick="newPost()">글쓰기</button>
			<button type="button" onclick="fn_save()">저장</button>
		</div>
    </div>

</body>
</html>
