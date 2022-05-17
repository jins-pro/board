<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>

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
	<!-- Fontawesome -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	
	<style>
	.uploadResult{width:100%;background-color: #ffe4e1;}
	.uploadResult ul{display: flex;flex-flow: row;justify-content: center;align-items: center;}
	.uploadResult ul li{list-style: none;padding: 10px;align-content: center;text-align: center;}
	.uploadResult ul li img{width: 100px;}
	.uploadResult ul li span{color: white;}
	.bigPictureWrapper{position: absolute;display: none; justify-content: center; align-items: center;top: 0%; width: 100%;
						height: 100%; background-color: gray; z-index: 100; background: rgba(255,255,255,0.5);}
	.bigPicture{position: relative; display: flex;justify-content: center; align-items: center;}
	.bigPicture img{width: 600px;}
	</style>
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
                            Board Read
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            	
                           	
                            	
                            	<div class="form-group">
                                    <label>Bno</label>
                                    <input class="form-control" name="bno" readonly="readonly" value='<c:out value="${board.bno}" />'>
                                </div>
                            	<div class="form-group">
                                    <label>Title</label>
                                    <input class="form-control" name="title" readonly="readonly" value='<c:out value="${board.title}" />'>
                                </div>
                                <div class="form-group">
                                    <label>Content</label>
                                    <textarea row="5" cols="50" name="content" class="form-control" style="height:25em;"><c:out value="${board.content}" /></textarea>
                                </div>
                                <div class="form-group">
                                    <label>Writer</label>
                                    <input class="form-control" name="writer" value='<c:out value="${board.writer}" />'>
                                </div>
                            	<form id='actionForm' action="/board/list" method='get'>
                            		<input type='hidden' name='pageNum' value='${cri.pageNum }'>
                            		<input type='hidden' name='amount' value='${cri.amount }'>
                            		<input type='hidden' name='bno' value='${board.bno }'>
                            		<input type='hidden' name='type' value='${cri.type }'>
                            		<input type='hidden' name='keyword' value='${cri.keyword }'>
                            	</form>
                            	<button type="button" class="btn btn-default listBtn"><a href='/board/list'>List</a></button>
                                <button type="button" class="btn btn-default modBtn"><a href='/board/modify?bno=<c:out value="${board.bno}" />'>Modify</a></button>
				
				<script>
                            	
                            	var actionForm = $("#actionForm");
                            	
                            	$(".listBtn").click(function(e){
                            		e.preventDefault();
                            		actionForm.find("input[name='bno']").remove();
                            		actionForm.submit();
                            	});
                            	$(".modBtn").click(function(e){
                            		e.preventDefault();
                            		actionForm.attr("action", "/board/modify");
                            		actionForm.submit();
                            	});
                            	</script>
                            
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <div class='bigPictureWrapper'>
            	<div class='bigPicture'>
            	</div>
            </div>
            
            <div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default">
							<div class="panel-heading">Files</div>
							<div class='paner-body'>
            					<div class='uploadResult'>
            						<ul></ul>
            					</div>
            				</div>
           				 </div>
           			 </div>
            </div>
            
            <!-- 댓글 -->
            <div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default">
							<div class="panel-heading">
								<i class="fa fa-comments fa-fw"></i> Reply
								<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
							</div>
							<div class="panel-body">
								<ul class="chat">
									<li class="left clearfix" data-rno='12'>
										<div>
											<div class="header">
												<strong class="primary-font"></strong> <small
													class="pull-right text-muted"></small>
											</div>
											<p></p>
										</div>
									</li>
								</ul>
							</div>
							<div class="panel-footer"> <!-- 댓글 페이징 -->
									
							</div>
						</div>
					</div>
				</div>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Reply Modal</h4>
			</div>
			<div class="modal-body">
			 <div class="form-group">
			 	<label>Reply</label>
			 	<input class="form-control" name='reply' value='New Reply!!!!'>
			 </div>
			 <div class="form-group">
			 	<label>Replyer</label>
			 	<input class="form-control" name='replyer' value='replyer'>
			 </div>
			 <div class="form-group">
			 	<label>Reply Date</label>
			 	<input class="form-control" name='replyDate' value=''>
			 </div>
			</div>
			
			<div class="modal-footer">
				<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
				<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
				<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
				<button id='modalCloseBtn' type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<%@include file="../board/topbtn.jsp" %>
<%@include file="../includes/footer.jsp" %>



<script type="text/javascript" >
	console.log("==============");
	console.log("JS TEST");

	/* var bnoValue = '<c:out value = "${board.bno}"/>'; */

	//for replyService add test

	/* replyService.add({
		reply : "JS Test",
		replyer : "tester",
		bno : bnoValue
	}, function(result) {
		alert("RESULT: " + result);
	});
 */
	//reply List Test
	/* replyService.getList({
		bno : bnoValue,
		page : 1
	}, function(list) {
		for (var i = 0, len = list.length || 0; i < len; i++) {
			console.log(list[i]);
		}
	}); */

	//11번째 댓글 삭제 테스트
	/* replyService.remove(11, function(count) {
		console.log(count);

		if (count === "success") {
			alert("REMOVED");
		}
	}, function(err) {
		alert('ERROR...');
	}); */
	//12번째 댓글 수정 테스트
	/* replyService.update(12, function(count){
	 rno : 12,
	 bno : bnoValue,
	 reply : "Modifies Reply...."
	 },function(result){
	 alert('수정 완료...');
	 }); */

	/* replyService.get(10, function(data) {
		console.log(data);
	}); */
	/* $(document).ready(function(){
	 console.log(replyService);
	 }) */
	 
	$(document).ready(function() {
		var bno = '<c:out value="${board.bno}" />';
		
		$.getJSON("/board/getAttachList", {bno : bno}, function(arr){
			console.log(arr);
		});
		
		var bnoValue = '<c:out value="${board.bno}"/>';
		var replyUL = $(".chat");
		showList(1);
		// 리스트 출력
		function showList(page) {
			console.log("show list " + page);
			replyService.getList({
				bno : bnoValue,
				page : page || 1
			},
			function(replyCnt, list) {
				//console.log("replyCnt: " + replyCnt);		// BNO에 해당하는 댓글 수
				//console.log("list: "+ list);				// 리스트 배열
				/* if(page == -1){									// 페이지 -1일 경우 대기 
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);			
					return;
				} */
				var str = "";
				if (list == null || list.length == 0) {
					//replyUL.html("");
					return;
				}
				for (var i = 0, len = list.length || 0; i < len; i++) {
					str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
					str += "<div><div class='header'><strong class='primary-font'>["
						+ list[i].rno+"]"+list[i].replyer+ "</strong>";
					str += "<small class='pull-right text-muted'>"
						+ replyService.displayTime(list[i].replyDate)
						+ "</small></div>";
					str += "<p>"+ list[i].reply+ "</p></div></li>";
				}
				replyUL.html(str);
				showReplyPage(replyCnt);
				}); //end function
			} //end showLIst
			
			var pageNum=1;
			var replyPageFooter = $(".panel-footer");
		
			function showReplyPage(replyCnt){
			var endNum = Math.ceil(pageNum / 10.0) * 10;  
			var startNum = endNum -9;
			var prev = startNum != 1;
			var next = false;
			
			if(endNum * 10 >= replyCnt){
				endNum = Math.ceil(replyCnt/10.0);
			}
			if(endNum * 10 < replyCnt){
				next = true;
			}
			var str = "<ul class='pagination pull-right'>";
			
			if(prev){
				str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
			}
			for(var i = startNum ; i<= endNum;i++){
				var active = pageNum ==i?"active":"";
				str+="<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
			}
			if(next){
				str+="<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>";
			}
			str+= "</ul></div>";
			
			console.log("콘솔 나와라"+str);
			replyPageFooter.html(str);
		}
			
		replyPageFooter.on("click", "li a",function(e){
				e.preventDefault();
				console.log("page click");
				
				var targetPageNum = $(this).attr("href");
				console.log("targetPageNum: "+ targetPageNum);
				pageNum = targetPageNum;
				showList(pageNum);
		});
			
			var modal = $(".modal");
			var modalInputReply = modal.find("input[name='reply']");
			var modalInputReplyer = modal.find("input[name='replyer']");
			var modalInputReplyDate = modal.find("input[name='replyDate']");
			
			var modalModBtn = $('#modalModBtn');
			var modalRemoveBtn = $('#modalRemoveBtn');
			var modalRegisterBtn = $('#modalRegisterBtn');
			
			$("#addReplyBtn").on("click", function(e){
				modal.find("input").val(""); // reply, replyer, replyDate
				modalInputReplyDate.closest("div").hide(); //날짜 출력 X
				modal.find("button[id != 'modalCloseBtn']").hide(); // 버튼 4개 중 3개 출력 X
				modalRegisterBtn.show(); // 출력X 버튼 중 Register버튼 출력
				$(".modal").modal("show");
			});
			
		
			
			
	//	});
	

modalRegisterBtn.on("click",function(e){
	var reply = {
			reply : modalInputReply.val(), // reply
			replyer:modalInputReplyer.val(), //replyer
			bno:bnoValue					// bno
	};
	replyService.add(reply, function(result){
		alert(result);
		modal.find("input").val("");
		modal.modal("hide");
		// reload안해주면 날짜는 HIDE, 새로고침 해야  날짜 DISPLAY
		location.reload(); 					
		showList(pageNum);
	});
});

$(".chat").on("click","li",function(e){
	var rno = $(this).data("rno");
	replyService.get(rno, function(reply){
		modalInputReply.val(reply.reply);
		modalInputReplyer.val(reply.replyer);
		modalInputReplyDate.val(replyService.displayTime(reply.replyDate))
		.attr("readonly","readonly");
		modal.data("rno",reply.rno);
		
		modal.find("button[id != 'modalCloseBtn']").hide();
		modalModBtn.show();
		modalRemoveBtn.show();
		
		$(".modal").modal("show");
	});
});

modalModBtn.on("click", function(e){
	console.log("여기야");
	var reply = {rno:modal.data("rno"), reply:modalInputReply.val()}; //rno는 변경 X, reply
	replyService.update(reply, function(result){
		console.log("들어온다고?");
		alert(result);
		modal.modal("hide");
		showList(pageNum);
	});
});

modalRemoveBtn.on("click", function(e){
	var rno = modal.data("rno");
	replyService.remove(rno, function(result){
		alert(result);
		modal.modal("hide");
		console.log("???");
		location.reload(); 
		showList(pageNum);
	});
});

/* 첨부파일 보여주기 */
$.getJSON("/board/getAttachList", {bno: bno}, function(arr){
    console.log(arr);
    var str = "";
    $(arr).each(function(i, attach){
    
      //image type
      if(attach.fileType){
        var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
        str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
        str += "<span> "+ attach.fileName+"</span><br/>";
        str += "<img src='/display?fileName="+fileCallPath+"'>";
        str += "</div>";
        str +"</li>";
      }else{
        str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
        str += "<span> "+ attach.fileName+"</span><br/>";
        str += "<img src='/resources/img/attach.png'></a>";
        str += "</div>";
        str +"</li>";
      }
    });
    $(".uploadResult ul").html(str);
  });//end getjson
  
 	 /* 사진 클릭시 이벤트  - 다운로드 */
 	 $(".uploadResult").on("click","li", function(e){
	    console.log("view image");
	    var liObj = $(this);
	    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" 
	    		   + liObj.data("filename"));
	    if(liObj.data("type")){
	      showImage(path.replace(new RegExp(/\\/g),"/"));
	      self.location ="/download?fileName="+path;
	    }else {
	      //download 
	      self.location ="/download?fileName="+path;
	    }
	  });
 	 /* 사진 클릭시 이벤트 - 확대보기 */
	  function showImage(fileCallPath){
	    alert(fileCallPath);
	    $(".bigPictureWrapper").css("display","flex").show();
	    $(".bigPicture")
	    .html("<img src='/display?fileName="+fileCallPath+"' >")
	    .animate({width:'100%', height: '100%'}, 1000);
	  }
	  $(".bigPictureWrapper").on("click", function(e){
	    $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
	    setTimeout(function(){
	      $('.bigPictureWrapper').hide();
	    }, 1000);
	  });

});
	
</script>
<script type="text/javascript" src="/resources/js/reply.js">
	 $(document).ready(function() {
		var operForm = $("#operForm");
		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "board/modify").submit();
		});
		$("button[data-oper='list']").on("click", function(e){
		    
		    operForm.find("#bno").remove();
		    operForm.attr("action","/board/list")
		    operForm.submit();
		  });
	}); 
</script>

