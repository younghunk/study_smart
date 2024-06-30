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
			margin-right: 10px;
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
		let saveArr = [];
		let col;
		
        $(document).ready(function() {
            fn_initGrid("grid");
		});

        function fn_initGrid(grid_id) {
            $('#' + grid_id).jqGrid({
                url: '/heojueun/getList.do',
                datatype: "json",
                mtype: "POST",
                colNames: ['글번호', '제목', '내용', '캘린더', '작성일', 'groupno', 'fk_seq', 'depthno', 'select', 'noninput'],
                colModel: [
                    { name: 'seq', index: 'seq', align: 'center', width: '5%', sortable: true },
                    { name: 'subject', index: 'subject', align: 'left', width: '15%', sortable: false, editable: true},
                    { name: 'content', index: 'content', align: 'left', width: '25%', sortable: false, editable: true},
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
                    { name: 'regDate', index: 'regDate', align: 'center', width: '10%', sortable: false },
					{ name:'groupno', index:'groupno', alwign:'center',	width:'15%', sortable: false, hidden: true, editable: false },
					{name:'fk_seq',	index:'fk_seq', alwign:'center', width:'15%', sortable: false, hidden: true, editable: false },
					{name:'depthno', index:'depthno', alwign:'center', width:'15%', sortable: false, hidden: true, editable: false },
					{name:'select', index:'depthno', alwign:'center', width:'10%', sortable: false, editable: true, edittype: 'select',
							editoptions: {
								value: "A:A;B:B;"
							}
					},
					{name:'noninput', index:'noninput', alwign:'center', width:'15%', sortable: false, hidden: true, editable: false }
                ],
                rowNum: 20,
				rowList:[5,10,15,20],
                viewrecords: true,
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
					var $myGrid = $(this);
				    var i = $.jgrid.getCellIndex($(e.target).closest('td')[0]);
				    var cm = $myGrid.jqGrid('getGridParam', 'colModel');
				    return (cm[i].name == 'cb'); // 선택된 컬럼이 cb가 아닌 경우 false를 리턴하여 체크선택을 방지
                },
				onCellSelect: function(rowid, iCol, cellcontent, e) {
					console.log("rowid : ", rowid);
                  	editArr.push(rowid);
				},
				afterEditCell: function(id,name,val,iRow,iCol){
		        	console.log("dd");
		        	$("#"+iRow+"_"+name).bind('blur',function(){
		        		$("#"+ grid_id).saveCell(iRow,iCol);
		        	});
		        }
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
		
		// 행 추가 버튼
		function fn_addRow() {
			// 새 행의 ID 생성
			var newRowId = $.jgrid.randId(); 
			// 새 행의 데이터 생성
	        var newRowData = {}; 
	        console.log("newRowId : ", newRowId)
	        // 그리드에 새 행 추가
	        $("#grid").jqGrid('addRowData', newRowId,  newRowData, 'first');
		}
		function before_save() {
			let selectedRowId = $("#grid").jqGrid('getGridParam', 'selrow');
			let arr = Array.from(new Set(editArr));
			let cur = [];
			let flag = false;
			let temp;
			let idx;
			
			
			console.log("selectedRowId : ", selectedRowId);
			
			if (selectedRowId) 
		        $("#grid").jqGrid('restoreRow', selectedRowId);
		    
			if(cur != 1) {
				idx = $("#grid").jqGrid('getGridParam', 'rowNum') * ($("#grid").jqGrid('getGridParam', 'page') - 1);
				flag = true;
			}
			console.log("arr : ", arr);
			// DB에 input tag 들어가는거 방지하는 코드
			for(let i = 0; i < arr.length; i++) {
				temp = $("#grid").jqGrid("getRowData", arr[i]);
				console.log("temp : ", temp);
				if(flag)
					idx = selectedRowId - idx;
				else
					idx = selectedRowId;
					
				if(arr[i] == selectedRowId)
					if(col == 2)
						temp.subject = $("#" + idx + "_subject").val();
					else if(col == 3)
						temp.content = $("#" + idx + "_content").val();
					else if(col == 4)
						temp.date = $("#" + idx + "_date").val();
				
				saveArr.push(temp);
			}
			
			fn_save(saveArr);
		}
		// 저장버튼
		function fn_save(saveArr) {
			// 저장 시작 ajax 
			$.ajax({
				url: '/heojueun/updatePost.do',
				type: 'POST',
				data: JSON.stringify(saveArr),
				contentType: 'application/json', // 요청 헤더에 Content-Type 설정
				success: function(res) {
					if(res == 200) {
						alert("Success");
						$("#grid").trigger("reloadGrid");
					}
					else
						alert("Server Error"+ res.message);
						console.log("res : ", res);
				},
				erorr: function(request, status, error) {
					alert("삭제에 실패했습니다. 원인 => code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
			
			
		}
		
		// 답글달기
		function newComent() {
	        var selectedRowIds = $("#grid").jqGrid('getGridParam', 'selrow');
	        if (selectedRowIds != undefined && selectedRowIds != null) {
	            var rowData = $("#grid").jqGrid('getRowData', selectedRowIds);
	            console.log("Row Data: ", rowData);

	            var subject = rowData.subject;
	            var groupno = rowData.groupno;
	            var fk_seq = rowData.seq;
	            var depthno = rowData.depthno;

	            var url = '<%=ctxPath%>/heojueun/newCommentPage.do?subject=' + encodeURIComponent(subject) +
	                      '&groupno=' + encodeURIComponent(groupno) +
	                      '&fk_seq=' + encodeURIComponent(fk_seq) +
	                      '&depthno=' + encodeURIComponent(depthno);

	            window.open(url, 'pop', 'width=600,height=400');
	        } else if (selectedRowIds.length > 1) {
	            alert("답글을 달기 위한 게시물을 하나만 선택해주십시오.");
	        } else {
	            alert("답글을 달려면 게시물을 선택해주십시오");
	        }
	    }


		// 삭제 버튼
		function fn_delete() {
		    var selectedRowIds = $("#grid").jqGrid('getGridParam', 'selarrrow'); // 다중 행 선택 지원
		    console.log("selectedRowIds: ", selectedRowIds);

		    if (selectedRowIds.length > 0) {
		        let rowDataArray = selectedRowIds.map(rowId => {
		            let rowData = $("#grid").jqGrid('getRowData', rowId);
		            console.log("Row ID: ", rowId);
		            console.log("Row Data: ", rowData);
		            return rowData;
		        });

		        console.log("Row Data Array: ", rowDataArray);

		        $.ajax({
		            url: '/heojueun/deletePost.do',
		            type: 'POST',
		            data: JSON.stringify(rowDataArray),
		            contentType: 'application/json',
		            success: function(res) {
	                    alert("삭제 성공");
	                    location.reload(); // 삭제 후 페이지를 다시 로드
		            },
		            error: function(request, status, error) {
		                alert("삭제에 실패했습니다. 원인 => code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
		            }
		        });
		    } else {
		        alert("삭제할 행을 선택해주세요.");
		    }
		}


		
		
    </script>

    <div style="display: flex;">
		<div style="margin: auto;">
			<h2 style="margin: 30px 0 30px 0;">글목록</h2>
			<table style="width: 1200px;" id="grid"></table>
			<button style="float: left;" type="button" onclick="fn_addRow()">행추가</button>
			<button type="button" onclick="before_save()">저장</button>
			<button type="button" onclick="fn_delete()">삭제</button>
			<button type="button" onclick="newPost()">글쓰기</button>
			<button type="button" onclick="newComent()">답글쓰기</button>
		</div>
    </div>

</body>
</html>
