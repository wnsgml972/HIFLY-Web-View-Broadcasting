<%@page import="group.GroupManagementDTO"%>
<%@page import="java.util.Vector"%>
<%@page import="group.GroupManagementDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">
	<head>
	<title>Services</title>
	<%
		request.setCharacterEncoding("utf-8");
	%>	

	</head>
<body class="index-2">

<!--=======header================================-->
<%@ include file="header.jsp" %>
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script>

	function f(url){ 
			var form = document.createElement("form");
			form.setAttribute("charset", "UTF-8");
			form.setAttribute("method", "Post"); // Get 또는 Post 입력
			form.setAttribute("action", "index-4.jsp");

			var hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "url");
			hiddenField.setAttribute("value", url);
			form.appendChild(hiddenField);
			document.body.appendChild(form);
			form.submit();
		}
	function ff(url , password){
		var val = prompt("암호를 입력해주세요");
		 
		if(val == password){
			var form = document.createElement("form");
			form.setAttribute("charset", "UTF-8");
			form.setAttribute("method", "Post"); // Get 또는 Post 입력
			form.setAttribute("action", "index-4.jsp");

			var hiddenField = document.createElement("input");
			hiddenField.setAttribute("type", "hidden");
			hiddenField.setAttribute("name", "url");
			hiddenField.setAttribute("value", url);
			form.appendChild(hiddenField);
			document.body.appendChild(form);
			form.submit();
		}
		else{
			alert("틀렸습니다.");
		}	
	}
	$(".removeHref").removeAttr("href");	
</script>
<!--=======content================================-->
<section id="content">
	<div class="full-width-container block-1">
		<div class="container">
			<div class="row">
				<div class="grid_12">
					<header>
						<h2><span>Live Streaming</span></h2>
					</header>
				</div>
				<div id="touch_gallery">
<!-- 					<div class="grid_4">
						<div>
							<a class="removeHref" onclick="f('images/2.mp4')"><img src="images/test.PNG" alt="Services"></a>
						</div>
						<article>
							<h4 class="group_title">Bliquam nibh ante</h4>
							<p class="group_description">Dorem ipsum dolor sit amet, consectetur adipiscing elit. In mollis erat mattis neque facilisis, sit amet ultricies erat rutrum. Cras facilisis, nulla vel viverra auctor, leo magna sodales felis, quis malesuada nibh odio ut</p>
						</article>
					</div> -->
					<%
						GroupManagementDAO groupDAO = new GroupManagementDAO();
						Vector<GroupManagementDTO> vector = groupDAO.getAllGroup();
						
						for(int i=0; i<vector.size(); i++){
							
							
							//먼저 URL이 있는지 검사
							if(vector.get(i).getURL() == null){
								groupDAO.deleteRoomUser(vector.get(i).getUser_id());
								continue;
							}
							
							//암호 있을 때
							if(vector.get(i).getPassword_check().equals("false")){
								out.print("<div class='grid_4'>");
								out.print("		<div>");
								out.print("			<a class='removeHref' onclick='f(\"" + vector.get(i).getURL() + "\")'>");
							
								if(vector.get(i).getImage_url().equals("NULL"))
								{
									out.print("<img src='images/test.PNG' alt='Services' width='400px' height='280px'></a>");
								}
								else
								{
									out.print("<img src='" + vector.get(i).getImage_url() + "' alt='Services' width='400px' height='280px'></a>");
								}
								
								out.print("		</div>");
								out.print("		<article><h4 class='group_title'> " + vector.get(i).getTitle() + "</h4><p class='group_description'> " + vector.get(i).getDescription() + "</p></article>");
								out.print("</div>");
								//암호 없을 때
							}else{
								out.print("<div class='grid_4'>");
								out.print("		<div>");
								out.print("			<a class='removeHref' onclick='ff(\"" + vector.get(i).getURL() + "\",\"" + vector.get(i).getRoom_password() + "\")'>");
								
								if(vector.get(i).getImage_url().equals("NULL"))
								{
									out.print("<img src='images/test.PNG' alt='Services' width='400px' height='280px'></a>");
								}
								else
								{
									out.print("<img src='" + vector.get(i).getImage_url() + "' alt='Services' width='400px' height='280px'></a>");
								}
								
								out.print("		</div>");
								out.print("		<article><h4 class='group_title'> " + vector.get(i).getTitle() + "</h4><p class='group_description'> " + vector.get(i).getDescription() + "</p></article>");
								out.print("</div>");
							}
						}
					%>
					
<!-- 				@@		Open Stream		@@
					<div class="grid_4">
						<div class="img_block"><a class="removeHref" onclick="f()"><img src="images/index-2_img-1.jpg" alt="Services"><i></i></a></div>
						<article>
							<h4>Open Stream</h4>
							<p>Click this if you want to stream.<br/>
							But you can't use it if you are not logged in.</p>
						</article>
					</div> -->
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