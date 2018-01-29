<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>My Page</title>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	
<style>
a:hover {
	text-decoration: none;
}
</style>
</head>

<body class="index-3">
<!--==============================header=================================-->
<%@ include file="header.jsp"%>


<!--=======content================================-->

<section id="content">
	<div class="full-width-container block-1">
		<div class="container">
			<div class="row">
				<div class="grid_12">
					<header>
						<h2>My Page</h2>
					</header>
				</div>
			</div>
			<div class="row">
				<div class="grid_10">
					<article>
						<header>
							<h4><a href="#">Hivamus at magna non nuncerto limonit </a></h4>
						</header>
						<div class="img_block"><img src="images/index-3_img-1.jpg" alt="cant read"></div>
						<p class="first">Rehoncus. Aliquam nibh antegestas id ictum ado. Praesenterto faucibus maleada faucibusnec laeetert metus id laoreet. </p>
						<p class="second">Nullam consectetur orci sed nulla facilisisequaterto. Curabitur vel lorem sit amet nulla perermentum. Aliquam nibh ante, egestas id dictum a, commodo luctus libero. Raesent faucibus malesuada faucibus. Donecertolin laoreet metus id laoreet malesuadarem ipsum dolor sit amet, consectetur adipiscing elit. Nullam consectetur orci sed nulla facilisis consequat. </p>
						<footer>
							<div class="attributes">
								<div class="line-1">
									<div class="attr">
										<span class="fa fa-calendar"></span>
										<span class="title"><a href="#">June 10, 2014</a></span>
									</div>
									<div class="attr">
										<span class="fa fa-user"></span>
										<span class="title"><a href="#">Admin</a></span>
									</div>
									<div class="attr-2">
										<span class="fa fa-chain"></span>
										<span class="title"><a href="#">Permalink</a></span>
									</div>
								</div>
								<div class="line-2">
									<div class="attr">
										<span class="fa fa-bookmark"></span>
										<span class="title"><a href="#">Uncategorized</a></span>
									</div>
									<div class="attr">
										<span class="fa fa-tag"></span>
										<span class="title"><a href="#">No tags</a></span>
									</div>
								</div>
								<div class="line-3">
									<div class="attr">
										<span class="fa fa-comments"></span>
										<span class="title"><a href="#">No comments</a></span>
									</div>
									<div class="attr-3">
										<div class="el-1">
											<span class="fa fa-eye"></span>
											<span class="title"><a href="#">182</a></span>
										</div>
										<div class="el-2">
											<a href="#"><span class="fa fa-thumbs-up"></span></a>
											<span class="title">0</span>
										</div>
										<div class="el-3">
											<a href="#"><span class="fa fa-thumbs-down"></span></a>
											<span class="title">0</span>
										</div>
									</div>
								</div>
							</div>
						</footer>
					</article>
				</div>
			</div>
		</div>
	</div>
</section>

	<!--=======footer=================================-->
	<%@ include file="footer.jsp"%>
	<script>
		$(function() {
			$('#touch_gallery a').touchTouch();
		});
	</script>
</body>
</html>