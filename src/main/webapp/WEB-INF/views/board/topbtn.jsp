<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style>
#topButton {position: fixed; right: 2%; bottom: 60px; display: none; z-index: 999;}
</style>

</head>
<body>
<div id="topButton" style="cursor: pointer"><i class="fa fa-arrow-up fa-3x" aria-hidden="true" ></i></div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function() {

	$(window).scroll(function() {
	    // top button controll
	    if ($(this).scrollTop() > 1) {
	        $('#topButton').fadeIn();
	    } else {
	        $('#topButton').fadeOut();
	    }
	});

	$(".fa").click(function() {
		$('html, body').animate({scrollTop:0}, '300');
	});

});
</script>

</html>