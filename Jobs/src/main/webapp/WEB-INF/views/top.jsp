<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    pageContext.setAttribute("br", "<br/>");
	pageContext.setAttribute("cn", "\n");
%> 




<!DOCTYPE html>
<html lang="en">

<head>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-148969061-1"></script>
<link rel="shortcut icon" type="image/x-icon" href="./img/jobsicon.png" />
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-148969061-1');
</script>

<!-- naver -->
<meta name="naver-site-verification" content="1517c8df687b9df1b8727e0ce8a6923db0a7b762"/>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- ie호환성 -->
<!-- <META http-equiv="X-UA-Compatible" content="IE=9"> -->

<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<title>JOB's :: 세상의 모든 취업, 잡스</title>

<!-- Google font -->
<link
	href="https://fonts.googleapis.com/css?family=Nunito+Sans:700%7CNunito:300,600"
	rel="stylesheet">

<!-- Bootstrap -->
<link type="text/css" rel="stylesheet" href="./css/bootstrap.min.css" />

<!-- Font Awesome Icon -->
<link rel="stylesheet" href="./css/font-awesome.min.css">

<!-- Custom stlylesheet -->
<link type="text/css" rel="stylesheet" href="./css/style.css" />

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->



</head>

<style>
textarea {
 white-space: pre-wrap;
 word-wrap:break-word;
 /* word-break: keep-all 도 가능*/
}

#pre_large{
	font-family: Nunito Sans;
	padding: 0pt;
	border:0pt;
 	background-color: #ffffff;
    width:100%;
    overflow:hidden;
    word-break:break-all;
    word-break:break-word;
    line-height:21px;
    white-space: pre-wrap;       /* CSS 3 */
    white-space: -moz-pre-wrap;  /* Mozilla, since 1999 */
    white-space: -pre-wrap;      /* Opera 4-6 */
    white-space: -o-pre-wrap;    /* Opera 7 */
    word-wrap: break-word;       /* Internet Explorer 5.5+ */
    font-size: 12pt;
    font-weight: normal;

}

#pre_small{
	font-family: Nunito Sans;
	padding: 0pt;
	border:0pt;
 	background-color: #ffffff;
    width:100%;
    overflow:hidden;
    word-break:break-all;
    word-break:break-word;
    line-height:21px;
    white-space: pre-wrap;       /* CSS 3 */
    white-space: -moz-pre-wrap;  /* Mozilla, since 1999 */
    white-space: -pre-wrap;      /* Opera 4-6 */
    white-space: -o-pre-wrap;    /* Opera 7 */
    word-wrap: break-word;       /* Internet Explorer 5.5+ */
    font-size: 11pt;
    font-weight: normal;

}

#map {
        height: 100%;
}

#floatMenu {
	position: absolute;
	width: 150px;
	height: 350px;
	left: 20px;
	top: 320px;
	background-color: #ffffff;
	color: #000000;
	border: 1px solid silver;
	display: block; 
	z-index: 1000; 
	padding: 10px;
}

</style>

<script src="./js/jquery-3.4.1.min.js"></script>

<script>
	function myfile(fname) {
		//alert(fname);
		location.href = "fileDown?fname=" + encodeURIComponent(fname);

	}
</script>
<script>
	function chk(state) {
		
 		if (state == 1) {
			swal('','인재등록은 일반회원만 가능합니다.','warning');
			return;
		} else if ((state != 1 || null)) {
	 		location.href = "jobhunterregister";
		}
		
	}
</script>

<script type="text/javascript">
	var searchcheck = function() {
		
		if (!topsearchform.searchtype.value) {
			swal('','검색 유형을 선택하세요','warning');
			topsearchform.searchtype.focus();
			return false;
		}
		if (!topsearchform.searchkeyword.value) {
			swal('','검색어를 입력하세요','warning');
			topsearchform.searchkeyword.focus();
			return false;
		}
		topsearchform.submit();
	}
</script>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


<body>

	<!-- Header -->
	<header id="header">
		<!-- Nav -->
		<div id="nav">
			<!-- Main Nav -->
			<div id="nav-fixed">
				<div class="container">
					<!-- logo -->
					<div class="nav-logo">
						<a href="home" class="logo"><img src="./img/jobslogo.png"
							alt=""></a>
					</div>
					<!-- /logo -->

					<!-- nav -->
					<ul class="nav-menu nav navbar-nav">
						<li><a href="home">메인화면</a></li>
						<li class="cat-1"><a href="recruitlist">채용정보</a></li>
						<li class="cat-2"><a href="companylist">기업정보</a></li>
						<li class="cat-3"><a href="jobhunterlist">인재정보</a></li>
						<li class="cat-4"><a href="javascript:chk(${loginUser.state});">인재등록</a></li>
					</ul>
					<!-- state -->
					<!-- /nav -->

					<!-- search & aside toggle -->
					<div class="nav-btns">
						<button class="aside-btn">
							<i class="fa fa-bars"></i>
						</button>
						<button class="search-btn">
							<i class="fa fa-search"></i>
						</button>
						<form role="form" name="topsearchform" action="recruitlist" method="get"
						onsubmit="return searchcheck()">
						<div class="search-form">
						<input type="hidden" name="cpage" value="${cpage}">
						<input type="hidden" name="searchtype" value="4">
							<input class="search-input" type="text" name="searchkeyword" 
								placeholder="취업정보를 검색하려면 검색어를 입력하고 Enter를 누르세요">
						</form>
							<button class="search-close" type="button" ><i class="fa fa-times"></i></button>
						</div>
					</div>
					<!-- /search & aside toggle -->
				</div>
			</div>
			<!-- /Main Nav -->

			<!-- Aside Nav -->
			<div id="nav-aside">
				<!-- nav -->
				<div class="section-row">
					<ul class="nav-aside-menu">
						<br>
						<br>
						<br>
						<li><a href="home">메인화면</a></li>
						<br>
						<li><a href="recruitlist">채용정보</a></li>
						<br>
						<li><a href="companylist">기업정보</a></li>
						<br>
						<li><a href="jobhunterlist">인재정보</a></li>
						<br>
						<li><a href="javascript:chk(${loginUser.state});">인재등록</a></li>
					</ul>
				</div>
				<br> <br>
				<!-- /nav -->



				<!-- social links -->
				<div class="section-row">
					<h3>Follow us</h3>
					<ul class="nav-aside-social">
						<li><a href="http://www.facebook.com" target="_blank" ><i class="fa fa-facebook"></i></a></li>
						<li><a href="http://twitter.com/?lang=ko" target="_blank" ><i class="fa fa-twitter"></i></a></li>
						<li><a href="http://www.google.com" target="_blank" ><i class="fa fa-google-plus"></i></a></li>
						<li><a href="http://www.pinterest.co.kr" target="_blank" ><i class="fa fa-pinterest"></i></a></li>
					</ul>
				</div>
				<!-- /social links -->

				<!-- aside nav close -->
				<button class="nav-aside-close">
					<i class="fa fa-times"></i>
				</button>
				<!-- /aside nav close -->
			</div>
			<!-- Aside Nav -->
		</div>
		<!-- /Nav -->
	</header>
	<!-- /Header -->
	
	
	