<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
	<head>
	<title>Home</title>
	<meta charset="utf-8">
	<meta name = "format-detection" content = "telephone=no" />
		
	<link rel="icon" href="images/favicon.ico" type="image/x-icon">
	<link rel="stylesheet" href="css/grid.css">
	<link rel="stylesheet" href="css/style.css?ver=2">
	<link rel="stylesheet" href="css/touchTouch.css">
	<link rel="stylesheet" href="css/camera.css">		

	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	
	<script src="js/jquery-migrate-1.2.1.js"></script>	
	<script src='js/camera.js'></script>
	<script src="js/touchTouch.jquery.js"></script>
	<script src="js/jquery.stellar.js"></script>
	<script src="js/script.js"></script>
	<script src='//maps.googleapis.com/maps/api/js?v=3.exp&amp;sensor=false'></script>
	<script src="js/jquery.mobile.customized.min.js"></script>
	<script src="js/wow.js"></script>
	<script>
		$(document).ready(function () {
			if ($('html').hasClass('desktop')) {
				new WOW().init();
			}
		}); 
	</script>
	
<script>
	 


	
</script>
	<%
		request.setCharacterEncoding("utf-8");
		int controlCurrent = 1;
		if(request.getParameter("controlCurrent") != null)
			controlCurrent = Integer.parseInt(request.getParameter("controlCurrent"));
	%>
	</head>
<body>
<!--==============================header=================================-->
<header id="header">
	<div id="stuck_container">
		<div class="container">
			<div class="row">
				<div class="grid_12">
					<h1><a href="index.jsp?controlCurrent=1">HIFLY<span>Streaming Service</span></a></h1>
					<nav>
						<ul class="sf-menu">
							<li <% if(controlCurrent == 1) out.print("class='current'"); %>><a href="index.jsp?controlCurrent=1" id="home">Home</a></li>
							<li <% if(controlCurrent == 2) out.print("class='current'"); %>><a href="index-2.jsp?controlCurrent=2" id="service">Services</a></li>							
							<% if ((String)session.getAttribute("signedUser") != null)
							{
							%><li <% if(controlCurrent == 4) out.print("class='current'"); %>><a href='logout.jsp' id="my_page">Log Out</a><ul>
<!-- 											<li><a href="logout.jsp">Log Out</a></li>
											<li><a href="#">My Page</a></li>
 -->											<!-- <li><a href="#">Lorem ipsum</a></li> -->
										</ul></li>
							<% 
							}
							else
							{
							%>
								<li <% if(controlCurrent == 3) out.print("class='current'"); %>><a href='index-1.jsp?controlCurrent=3' id="log_in">Log In</a><ul>
<!-- 											<li><a href="#">Log In</a></li>
											<li><a href="#">Sign In</a></li> -->
											<!-- <li><a href="#">Lorem ipsum</a></li> -->
										</ul></li>
							<%
							}
							%>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
</header>
</body>
</html>