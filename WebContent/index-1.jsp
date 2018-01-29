<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>Log In</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/loginCSS.css?ver=9">
<script>
	$(function() {
		var out;
		$("#user_login").click(
				function() {
					var data_param = "input_id=" + $("#user_id").val() + "&"
							+ "input_pw=" + $("#user_pw").val();
					$.ajax({
						type : "post",
						url : "loginCheckDB.jsp",
						data : data_param,
						success : function(result) {
							var p = result.trim();
							if (p == 1) {/* 로그인성공  */
								location.replace("index.jsp?controlCurrent=1");
							} else if (p == 2)
								alert("로그인 실패!");
						}
					});
				});
	});
	function Enter_Check(e) {
		if (e.keyCode == 13) { /* IE기준으로 설명 */
			document.getElementById("user_login").click();
			return false;
		}
	}
	
	$(".signIn").removeAttr("href");
	
</script>

	<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<style>
		a:hover{
			text-decoration : none;
		}
	</style>
</head>
<body class="index-1">
<!--==============================header=================================-->
<%@ include file="header.jsp" %>

<!--=======content================================-->
<section id="content">
	<div class="full-width-container block-1">
		<div class="container">
			<div class="row" style="margin:0px 0px 0px 0px;">
				<div class="grid_12">
					<header>
						<h2><span>Log In</span></h2>
					</header>
				</div>
				<div id="touch_gallery">
					<div id="loginHeader">
						<div>
							<form id="loginform">
								<label for="user_id">ID</label>
								<div class="input-group" style="margin: 5px 0px; padding: 0px;">
									<span class="input-group-addon" style="height: 50px;"><i
										class="glyphicon glyphicon-user"></i></span>
										<input id="user_id"
									style="height: 50px;" type="text" class="form-control"
										name="input_id" placeholder="ID">
								</div>
								<label for="user_pw">PW</label>
								<div class="input-group" style="margin: 5px 0px; padding: 0px;">
									<span class="input-group-addon" style="height: 50px;"><i
										class="glyphicon glyphicon-lock"></i></span> <input id="user_pw"
										style="height: 50px;" type="password" class="form-control"
										name="input_pw" placeholder="Password"
										onkeydown="JavaScript:Enter_Check(event);">
								</div>
								<label for="user_login">Login</label>
								<script>function f(){ location.replace("signin.jsp?controlCurrent=3"); }</script>
								<a onclick="f()" id="signIn">Sign In</a>
								<input type="button" id="user_login" name="login" value="Login">
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<!--=======footer=================================-->
<%@ include file="footer.jsp" %>
<!-- <script>
	$(function(){
		$('#touch_gallery a').touchTouch();
	});
</script> -->
</body>
</html>