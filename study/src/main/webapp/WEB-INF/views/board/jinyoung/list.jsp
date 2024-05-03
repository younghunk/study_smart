<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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

<link rel="stylesheet" type="text/css" href="../resources/dhtmlx/dhtmlx.css"/>
<script src="../resources/dhtmlx/dhtmlx.js" type="text/javascript"></script>

<style type="text/css">
table {
	font-size: 12pt;
}

.ui-jqgrid tr.jqgrow {
	outline-style: none;
	height: 35px;
}

.ui-jqgrid .ui-jqgrid-bdiv {
	position: relative;
	margin: 0;
	padding: 0;
	overflow: auto;
	text-align: left;
	overflow-x: hidden;
	
}

</style>

</head>
<body>

<script type="text/javascript">

$(document).ready(function(){
  
	$("input:text[name='searchWord']").bind("keyup", function(e){
		if(e.keyCode == 13){ // 엔터를 했을 경우 
			goSearch();
		}  
	});
	
	// 검색시 검색조건 및 검색어값 유지시키기
	if(${not empty requestScope.paraMap}) {
		$("select[name='searchType']").val("${requestScope.paraMap.searchType}");
		$("input[name='searchWord']").val("${requestScope.paraMap.searchWord}");
	} 
  
	/* jqGrid를 이용한 테이블 생성 시작 */
	$("#grid").jqGrid({
		url : "<%=ctxPath%>searchList.action",
		datatype : "JSON",
		ajaxGridOptions: {cache: false}, // Ajax 요청 시 캐시를 사용하지 않고 최신 데이터를 가져오게 한다.
		postData: $('#grid').serializeArray(),
		mtype : "GET",
		colNames: ['글번호', '제목', '내용', '캘린더', '아이디', '작성일', '타입', 'groupno', 'fk_seq', 'depthno'],
		colModel: [
			{name:'seq',		index:'seq', 		align:'center',	width:'5%', 	sortable: false },
			{name:'subject',	index:'subject', 	align:'left',	width:'15%',	sortable: false, editable: true , required: true },
			{name:'content',	index:'content', 	align:'left',	width:'25%',	sortable: false, editable: true , required: true },
			{name:'date',		index:'date', 		align:'center',	width:'15%',	sortable: false, 
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
			{name:'userid',		index:'userid', 	align:'center',	width:'10%', 	sortable: false, editable: true, required: true },
			{name:'regDate',	index:'regDate', 	alwign:'center',	width:'10%', 	sortable: false },
			{name:'type',		index: 'type', 		align:'center', width: 5,		sorttype: 'text', hidden: true, editable: false },
			{name:'groupno',	index:'groupno', 	alwign:'center',	width:'15%', 	sortable: false, hidden: true, editable: false },
			{name:'fk_seq',		index:'fk_seq', 	alwign:'center',	width:'15%', 	sortable: false, hidden: true, editable: false },
			{name:'depthno',	index:'depthno', 	alwign:'center',	width:'15%', 	sortable: false, hidden: true, editable: false },
			],
		rowNum : 200,
		loadonce : false,
		height: 700,
		width: 1300,
		multiselect: true,
		beforeSelectRow: fn_BeforeSelectRow
		/* ,
		loadComplete: function() {
	        addSpan();
	    } */

	});// end of jqGrid ----------------------------------------------------------------------------------------------------
	
	
	// 생성, 수정, 삭제 이벤트 추가
	$("button#choice").click(function(){
		
		var choiceVal = $("#ddl").val();
		
		if(choiceVal === "create") {
			// 새 행의 ID 생성
			var newRowId = $.jgrid.randId(); 
			// 새 행의 데이터 생성
	        var newRowData = {}; 
	        
	        // 그리드에 새 행 추가
	        $("#grid").jqGrid('addRowData', newRowId,  newRowData, 'first');
	            
	        // 행이 추가된 후에 해당 행을 선택하고 편집 모드로 변경
	        setTimeout(function() {
	        	
	        	$("#grid").jqGrid('setSelection', newRowId); // 행 선택
	            $("#grid").jqGrid('editRow', newRowId, { keys: false }); // 편집 모드로 변경
	            $("#grid").jqGrid('setCell', newRowId, 'type', 'create'); // 생성된 행에 type('create') 을 부여 => 다중 생성, 수정, 삭제 구분
	            
	            var typeValue = $("#grid").jqGrid('getCell', newRowId, 'type'); 
	            
	        }, 100);
		}
		else if(choiceVal === "update") {
			// 선택된 행의 ID 배열 가져오기
			var selectedRowIdArr = $("#grid").jqGrid('getGridParam', 'selarrrow'); 
			// 선택된 행이 있고 행배열의 길이가 0보다 크다면
            if (selectedRowIdArr && selectedRowIdArr.length > 0) {
            	//선택된 각 행에 대한 반복
            	for (var i = 0; i < selectedRowIdArr.length; i++) {
            		//선택된 행의 ID를 현재 편집중인 행Id로 설정
                	var currentEditingRowId = selectedRowIdArr[i]; 
                	$("#grid").jqGrid('editRow', currentEditingRowId, { keys: false }); // 편집모드, keys: false 는 엔터를 막아둔 것이다.
                	
                    var typeValue = $("#grid").jqGrid('getCell', currentEditingRowId, 'type');
					// 현재 행의 type 의 값이 'create' 또는 'delete'가 아니라면,
                    if(typeValue !== 'create' && typeValue !== 'delete') {
                    	// type 값에 update 를 부여 => 다중 생성, 수정, 삭제 구분
                    	$("#grid").jqGrid('setCell', currentEditingRowId, 'type', 'update');
                    }
            	}
            }
		}
		else if(choiceVal === "delete") {
			// 선택된 행의 ID 배열 가져오기
			var selectedRowIdArr = $("#grid").jqGrid('getGridParam', 'selarrrow'); 
			// 선택된 행이 있고 행배열의 길이가 0보다 크다면
            if (selectedRowIdArr && selectedRowIdArr.length > 0) {
            	// 선택된 각 행에 대한 반복
            	for (var i = 0; i < selectedRowIdArr.length; i++) { 
            		//선택된 행의 ID를 현재 편집중인 행Id로 설정
                	var willDeleteRowId = selectedRowIdArr[i]; 
                	
                    var typeValue = $("#grid").jqGrid('getCell', willDeleteRowId, 'type'); 
					// 현재 행의 type 의 값이 'create' 또는 'update'가 아니라면,
                    if(typeValue !== 'create' && typeValue !== 'update') {
                    	// type 값에 delete 를 부여 => 다중 생성, 수정, 삭제 구분
                    	$("#grid").jqGrid('setCell', willDeleteRowId, 'type', 'delete');
                    	$("#grid").setRowData(willDeleteRowId, false, {background:"#ff0000"}); // 생성시 행의 색상을 빨간색으로 변경해 이벤트 종류가 무엇인지 구별
                    }
            	}
            }
		}
		
		
	});// end of $("#choice").click(function(){}()---------------------------------------------------------------------------------------
				
			
	// 적용 버튼을 눌렀을 때 이벤트 시작
	$("#apply").click(function(){
		// 선택된 행의 ID 배열 가져오기
		var selectedRowIdArr = $("#grid").jqGrid('getGridParam', 'selarrrow');
		// 선택된 행이 있고 행배열의 길이가 0보다 크다면
		if(selectedRowIdArr && selectedRowIdArr.length > 0) {
			for (var i = 0; i < selectedRowIdArr.length; i++) {
				
				var editingRowId = selectedRowIdArr[i];
				
				$("#grid").jqGrid('saveRow', editingRowId);
				
				var rowData = $("#grid").jqGrid('getRowData', editingRowId);
				
				var type = rowData.type;
				var subject = rowData.subject;
				var content = rowData.content;
				var userid = rowData.userid;
				
				// 전송할 데이터를 직렬화
				var serializedData = $.param({
					seq: rowData.seq,
					subject: rowData.subject,
					content: rowData.content,
					date: rowData.date,
					userid: rowData.userid,
				});
				// 생성(create), 수정(update), 삭제(delete)를 구분해 ajax 실행
				if (type === 'create') {
					if(subject !== '' && content !== '' && userid !== '') {
						$.ajax({
							url: '<%=ctxPath%>createNewPost.action',
							type: 'post',
							contentType: 'application/x-www-form-urlencoded',
							data: serializedData,
							success: function(json) {
								console.log(JSON.stringify(json));
							},
							erorr: function(request, status, error) {
								alert("생성에 실패했습니다. 원인 => code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
								$('#grid').jqGrid('editRow', editingRowId, true);
							}
						});
					}
					else {
						$("#grid").jqGrid('editRow', editingRowId, true); //편집모드로
						alert("제목, 내용, 아이디는 필수입력 사항입니다.");
						return;
					}
				}
				else if (type === 'update') {
					if(subject !== '' && content !== '' && userid !== '') {
						$.ajax({
							url: '<%=ctxPath%>updatePost.action',
							type: 'post',
							data: serializedData,
							contentType: 'application/x-www-form-urlencoded',
							success: function(json) {
								console.log(JSON.stringify(json));
							},
							erorr: function(request, status, error) {
								alert("업데이트에 실패했습니다. 원인 => code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
								$('#grid').jqGrid('editRow', editingRowId, true);
							}
							
						});
					}
					else {
						$("#grid").jqGrid('editRow', editingRowId, true); //편집모드로
						alert("제목, 내용, 아이디는 필수입력 사항입니다.");
						return;
					}
				}
				else if (type === 'delete') {
					$.ajax({
						url: '<%=ctxPath%>deletePost.action',
						type: 'post',
						data: serializedData,
						contentType: 'application/x-www-form-urlencoded',
						success: function(json) {
							console.log(JSON.stringify(json));
						},
						erorr: function(request, status, error) {
							alert("삭제에 실패했습니다. 원인 => code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}
					});
				}
			}// end of for
			$("#grid").trigger("reloadGrid");
		}// end of if(selectedRowIdArr && selectedRowIdArr.length > 0)
	});// end of $("#apply").click(function(){})------------------------------------------------------------------------------------------
	
	$("#reset").click(function(){
		
		var selectedRowId = $("#grid").jqGrid('getGridParam', 'selarrrow'); 
		
		// 선택된 행이 있고 행배열의 길이가 1이라면 (=체크된 행이 하나라면)
	    if (selectedRowId && selectedRowId.length > 0) {
	    	if(confirm("정말로 취소하시겠습니까?")) {
				$("#grid").trigger("reloadGrid");
			}
	    }
	    else {
	    	return;
	    }
		
	});// end of $("#reset").click(function(){}-------------------------------------------------------------------------------------------
	
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
	    str += '<button type="button" class="btn btn-danger" onclick="fn_clearDate(\'' + rowId + '\');">x</button>';
	    return str;
	}
	
	/* 
	// 그리드 로드 후 각 행의 depthno 값에 따라 subject 셀에 특정 태그 추가
	function addSpan() {
	    var grid = $("#grid");
	    var rows = grid.jqGrid("getDataIDs");
	    
	    rows.forEach(function(rowId) {
	        var rowData = grid.jqGrid("getRowData", rowId);
	        var depthno = parseInt(rowData.depthno);
	        var subjectCell = grid.jqGrid("getCell", rowId, "subject");
	        var reTag = "";
	        
	        if (depthno >= 1) {
	            var reTagCount = depthno; // depthno 만큼 Re 태그를 추가
	            for (var i = 0; i < reTagCount; i++) {
	                reTag += '<span style="color: red; font-style: italic;">┗Re&nbsp;</span>';
	            }
	        }
	        
	        // 기존 셀 내용과 Re 태그를 합쳐서 셀에 설정
	        grid.jqGrid("setCell", rowId, "subject", reTag + subjectCell);
	    });
	}
	 */

});// end of $(document).ready(function(){})------
	
	  
// Function Declaration
function fn_BeforeSelectRow(rowid, e) {
/* Row 선택시 체크박스 자동선택 안되게 하기 위해 
 * Checkbox 가 선택 되었을때만 true 를 리턴.
 * 만약 다른 체크박스가 있을 경우 id 값을 체크해야 한다.
 */
if($(e.target).is('input[type=checkbox]')){
	return true;
}
	return false;
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
  
function goView(seq) {

	const frm = document.goViewFrm;
	frm.seq.value = seq;
	 
	if(${not empty requestScope.paraMap}) { // 검색조건이 있을 경우 
		frm.searchType.value = "${requestScope.paraMap.searchType}";
		frm.searchWord.value = "${requestScope.paraMap.searchWord}";
	} 
	 
	frm.method = "get";
	frm.action = "<%=ctxPath%>/view.action";  
	frm.submit();
	 
 }// end of function goView(seq)---------------
  
  
function goSearch() {
	  
	var searchWord = $("input[name='searchWord']").val();
	var searchType = $("select#searchType").val();
	
	$("#grid").clearGridData();
	$("#grid").setGridParam({
		url:'<%=ctxPath%>/jinyoung/searchList.action',
		datatype:"json",
		mtype: "get",
		postData: {
			searchWord: searchWord,
			searchType: searchType
		}
	}).trigger("reloadGrid");
	
}// end of function goSearch()----------------
  
function goWrite() {
	
	location.href="<%=ctxPath%>/jinyoung/add.action";
	  
}// end of function goWrite()-----------------

function goWriteReply() {
	
	var selectedRowId = $("#grid").jqGrid('getGridParam', 'selarrrow'); 
	
	var rowData = $("#grid").jqGrid('getRowData', selectedRowId);
	
	var subject = rowData.subject;
	var groupno = rowData.groupno;
	var fk_seq = rowData.seq;
	var depthno = rowData.depthno;
	
	// 선택된 행이 있고 행배열의 길이가 1이라면 (=체크된 행이 하나라면)
    if (selectedRowId && selectedRowId.length == 1) {
    	window.open('<%=ctxPath%>/jinyoung/reply.action?subject='+subject+'&groupno='+groupno+'&fk_seq='+fk_seq+'&depthno='+depthno, 'pop', 'width=600,height=400');
   	}
    else if (selectedRowId && selectedRowId.length > 1) {
    	alert("답글을 달기 위한 게시물을 하나만 선택해주십시오.");
   		return;
    }
    else {
    	alert("답글을 달려면 게시물을 한개 선택해주십시오");
   		return;
    }
	

	
	// 전송할 데이터를 직렬화
	var serializedData = $.param({
		seq: rowData.seq,
		subject: rowData.subject,
		content: rowData.content,
		date: rowData.date,
		userid: rowData.userid,
	});
	
	
}
	  
</script>

	<div style="display: flex; width: 100%;">
		<div style="margin: auto;">
			<h2 style="margin: 30px 0 30px 0;">글목록</h2>
			
			<div style="margin-bottom: 10px;">

				<select id="ddl" style="width: 80px;">
					<option value="blank">선택</option>
					<option value="create">생성</option>
					<option value="update">수정</option>
					<option value="delete">삭제</option>
				</select>

				<button id="choice" class="btn btn-sm btn-light">&#62;</button>
				<div style="display: inline-block; float: right;">
					<button id="reset" class="btn btn-sm btn-light" style="width: 80px;">취소</button>
					<button id="apply" class="btn btn-sm btn-light" style="width: 80px;">적용</button>
				</div>
			</div>

			<table id="grid"></table>
			<div id="pager"></div>
			
			<%-- === #101. 글검색 폼 추가하기 : 글제목, 글쓴이로 검색을 하도록 한다. === --%>
			<form name="searchFrm" style="margin-top: 20px;">
				<select id="searchType" style="height: 26px;">
					<option value="subject">글제목</option>
					<option value="content">글내용</option>
					<option value="subject_content">글제목+글내용</option>
					<option value="userid">아이디</option>
				</select> 
				<input type="text" name="searchWord" size="40" autocomplete="off" />
				<input type="text" style="display: none;" />
				<button type="button" onclick="goSearch()"
					class="btn btn-success btn-sm">검색</button>
				<div style="display: inline-block; float: right;">
					<button type="button" onclick="goWriteReply()"
						class="btn btn-primary btn-sm">답글쓰기</button>
					<button type="button" onclick="goWrite()"
						class="btn btn-primary btn-sm">글쓰기</button>
				</div>
			</form>
		</div>
	</div>

	<form name="goViewFrm">
		<input type="hidden" name="seq" /> 
		<input type="hidden" name="searchType" /> 
		<input type="hidden" name="searchWord" />
	</form>

</body>
</html>
