<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
	<style>
	#select { height: 26px;}
	.btn-default {margin-top: -2px;height: 30px;display: table;}
	#srtbtn { vertical-align: middle;display: table-cell;}
	</style>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Bootstrap Admin Theme</title>

    <!-- Bootstrap Core CSS -->
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
</head>

<%@include file="../includes/header.jsp" %>

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Tables</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board List Page
                            <button id="regBtn" type="button" class="btn btn-xs pull-right">Register New Board</button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>#??????</th>
                                        <th>??????</th>
                                        <th>?????????</th>
                                        <th>?????????</th>
                                        <th>?????????</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <!-- ????????? -->
                                	<c:forEach items="${list }" var="board">
                                    <tr class="odd gradeX">
                                        <td><c:out value="${board.bno }" /></td>
                                        <td><a class='move' href='<c:out value="${board.bno }" />'><c:out value="${board.title }" />
                                        <b>[ <c:out value="${board.replyCnt }" /> ]</b></a></td>
                                        <td><c:out value="${board.writer }" /></td>
                                        <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate }" /></td>
                                        <td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate }" /></td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <!-- ?????? -->
                            <form id='searchForm' action='/board/list' method='get'>
                            	<select name='type' id=select>
                            		<option value="" ${pageMaker.cri.type == null?"selected":"" } style="text-align:center">?????? ??????</option>
                            		<option value="T" ${pageMaker.cri.type eq 'T'?"selected":"" } style="text-align:center">??????</option>
                            		<option value="C" ${pageMaker.cri.type eq 'C'?"selected":"" } style="text-align:center">??????</option>
                            		<option value="W" ${pageMaker.cri.type eq 'W'?"selected":"" } style="text-align:center">?????????</option>
                            		<option value="TC" ${pageMaker.cri.type eq 'TC'?"selected":"" } style="text-align:center">??????+??????</option>
                            		<option value="TCW" ${pageMaker.cri.type eq 'TCW'?"selected":"" } style="text-align:center">??????+??????+?????????</option>
                            	</select>
                            	<input type='text' name='keyword' value='${pageMaker.cri.keyword }'>
                            	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
                            	<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
                            	<button class='btn btn-default'>
                            	<span id=srtbtn>Search</span>
                            	</button>
                            </form>
                            <!-- ????????? -->
                            <div class='pull-right'>
                            	<ul class="pagination">
                            	<c:if test="${pageMaker.prev }"> <!-- ?????? ?????? -->
                            	<li class="page-item"><a class="page-link" href="${pageMaker.startPage - 1 }" tabindex="-1">Previous</a></li>
                            	</c:if>
                            	<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var ="num">
                            		<li class='page-item ${pageMaker.cri.pageNum == num?"active":"" }' >
                            		<a class="page-link" href="${num }">${num }</a></li>
                            	</c:forEach>
                            	<c:if test="${pageMaker.next }"> <!-- ?????? ?????? -->
                            	<li class="page-item"> <a class="page-link" href="${pageMaker.endPage + 1 }">Next</a></li>
                            	</c:if>
                            	</ul>
                            </div>
                            <form id='actionForm' action="/board/list" method='get'>
                            	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
                            	<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
                            	<input type='hidden' name='type' value='${pageMaker.cri.type }'>
                            	<input type='hidden' name='keyword' value='${pageMaker.cri.keyword }'>
                            </form>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
<div id="myModal" class="modal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>Modal body text goes here.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">Save changes</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
            
<script>
$(document).ready(function(){
	
	var result = '<c:out value="${result}" />';
	checkModal(result);
	history.replaceState({}, null, null); /* ???????????? ??? ?????? ???????????? ?????? ????????? ?????? ????????? ?????? 1???, ?????? ?????? ?????? ????????? ??? */
	function checkModal(result){
		if(result==='' || history.state){ /* ???????????? ??? ?????? ???????????? ?????? ????????? ?????? ????????? ?????? or??? history ?????? ?????? */
			return;
		}
		if(result === 'success'){
			$(".modal-body").html(		
					"??????????????? ?????????????????????.");
		}else if(parseInt(result)>0){
			$(".modal-body").html(
					"?????????" + parseInt(result) + " ?????? ?????????????????????.");
		}
		$("#myModal").modal("show");
	}
	
	$("#regBtn").click(function(){
		self.location = "/board/register"
	});
	
	var actionForm = $("#actionForm");
	
	$(".page-link").on("click", function(e){
		e.preventDefault();
		var targetPage = $(this).attr("href")
		console.log(targetPage);
		actionForm.find("input[name='pageNum']").val(targetPage);
		actionForm.submit();
	});
	
	$(".move").on("click", function(e){
		
		e.preventDefault();
		
		var targetBno = $(this).attr("href");
		console.log(targetBno);
		
		actionForm.append("<input type='hidden' name='bno' value='"+targetBno+"'>'");
		actionForm.attr("action", "/board/get");
		actionForm.submit();
	})
	var searchForm = $("#searchForm");
	
	$("#searchForm button").on("click", function(e){
		e.preventDefault();
		console.log("............click");
		searchForm.find("input[name='pageNum']").val(1);
		searchForm.submit();
	})
});

</script>
        
<%@include file="../includes/footer.jsp" %>