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

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
	.uploadResult{width:100%;background-color: gray;}
	.uploadResult ul{display: flex;flex-flow: row;justify-content: center;align-items: center;}
	.uploadResult ul li{list-style: none;padding: 10px;align-content: center;text-align: center;}
	.uploadResult ul li img{width: 100px;}
	.uploadResult ul li span{color: white;}
	.bigPictureWrapper{position: absolute;display: none; justify-content: center; align-items: center;top: 0%; width: 100%;
						height: 100%; background-color: gray; z-index: 100; background: rgba(255,255,255,0.5);}
	.bigPicture{position: relative; display: flex;justify-content: center; align-items: center;}
	.bigPicture img{width: 600px;}
	</style>
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
                            Board Register
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <form role="form" action="/board/register" method="post">
                            	<div class="form-group">
                                    <label>Title</label>
                                    <input class="form-control" name="title">
                                </div>
                                <div class="form-group">
                                    <label>Content</label>
                                    <textarea row="5" cols="50" name="content" class="form-control" 
                                    		  style="height:25em;"></textarea>
                                </div>
                                <div class="form-group">
                                    <label>Writer</label>
                                    <input class="form-control" name="writer">
                                </div>
                            	<button type="submit" class="btn btn-default">Submit Button</button>
                                <button type="reset" class="btn btn-default">Reset Button</button>
                            </form>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
            	<div class="col-lg-12">
            		<div class="panel panel-default">
            		
            			<div class="panel-heading">File Attach</div>
            				<div class="panel-body">
            					<div class="form-group uploadDiv">
            					<input type="file" name='uploadFile' multiple>
            					</div>
            					<div class="uploadResult">
            					<ul></ul> <!-- 첨부파일 <li>구간 -->
            					</div>	
            				</div>
            			</div>
            		<!-- end panel-body -->
            		</div>
            	<!-- end panel -->
            	</div>
            <!-- /.row -->
        
<%@include file="../includes/footer.jsp" %>
<script>
$(document).ready(function(e){
	var formObj = $("form[role='form']");
	
	$("button[type='submit']").on("click", function(e){
		e.preventDefault();
		console.log("submit clicked");
		
		var str ="";
		$(".uploadResult ul li").each(function(i, obj){ //index, obj
			var jobj = $(obj);
			console.dir("dir확인"+jobj);
			str +="<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str +="<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str +="<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			str +="<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
		});
		console.log(str);
		formObj.append(str).submit();
	});
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	
	var maxSize = 5242880; // 5MB
	// 업로드 불가 경고 메시지
	function checkExtension(fileName, fileSize){
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	$("input[type='file']").change(function(e){ // 내용이 변경되는 것을 감지해서 처리, 파일 배열로 순서대로 첨부
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		console.log("files: "+files);
		for(var i = 0; i<files.length;i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
	$.ajax({
		url : '/uploadAjaxAction',
		processData: false,
		contentType: false,
		data: formData,
		type: 'POST',
		dataType: 'json', //json 데이터를 되돌려줘야 하기때문에
		success:function(result){
		console.log(result);
		showUploadResult(result); // 업로드 결과 처리 함수, result=배열
		}
	}); //$.ajax
	});
	
	function showUploadResult(uploadResultArr){ // 첨부파일 출력(s_이미지, 일반파일)
		if(!uploadResultArr || uploadResultArr.length == 0){
			return;
		}
		var uploadUL = $(".uploadResult ul");
		var str="";
		$(uploadResultArr).each(function(i, obj){
			//image type
			if(obj.image){  //encodeURIComponent(String) = & -> %26등으로 치환, 이스케이핑이라 부른다.
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" +obj.uuid+"_"+obj.fileName);
				console.log("확인 : "+fileCallPath);
				str +="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"'";
				str +=" data-type='"+obj.image+"'><div>";
				str +="<span>"+obj.fileName+"</span>";
				str +="<button type='button' data-file=\'"+fileCallPath+"\' data-type='image'";
				str +=" class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str +="<img src='/display?fileName="+fileCallPath+"'>";
				str +="</div></li>";
			}else{
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/" +obj.uuid+"_"+obj.fileName);
				var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
				console.log("확인 : "+fileLink);
				str +="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"'data-filename='"+obj.fileName+"'";
				str +=" data-type='"+obj.image+"'><div>";
				str +="<span>"+obj.fileName+"</span>";
				str +="<button type='button' data-file=\'"+fileCallPath+"\' data-type='file'";
				str +=" class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"; //x버튼
				str +="<img src='/resources/img/attach.png'></a>";
				str +="</div></li>";
			}
		});
		uploadUL.append(str);
	}
	// 첨부파일 삭제
	$(".uploadResult").on("click", "button", function(e){ 
		console.log("delete file");
		var targetFile = $(this).data("file");
		console.log("targetFile : "+ targetFile);
		var type = $(this).data("type");
		console.log("type : "+type);
		var targetLi = $(this).closest("li");
		$.ajax({
			url:'/deleteFile',
			data: {fileName: targetFile, type:type},
			dataType: 'text',
			type:'POST',         
			success:function(result){
				alert(result);
				targetLi.remove();
			}
		}); //$.ajax
	});

});


	
</script>