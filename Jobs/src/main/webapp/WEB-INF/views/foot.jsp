<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Footer -->
<footer id="footer">
	<!-- container -->
	<div class="container">
		<!-- row -->
		<div class="row">
			<div class="col-md-5">
				<div class="footer-widget">
					<div class="footer-logo">
						<a href="home" class="logo"><img src="./img/jobslogo.png"
							alt=""></a>
					</div>
					<div class="footer-copyright">
						<span>Copyright ⓒ JOB’s COMPANY Corp. All Right Reserved. <i
							class="fa fa-heart-o" aria-hidden="true"></i></span>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="row">
					<div class="col-md-6">
						<div class="footer-widget">
							<h3 class="footer-title">About Us</h3>
							<ul class="footer-links">
								<li><a href="about">About Us</a></li>
								<li><a href="contacts">Contacts</a></li>
								<c:if test="${loginUser.state eq '2'}">
								<li><a href="https://analytics.naver.com/summary/dashboard.html" target="_blank" >NAVER Analytics</a></li>
								<li><a href="https://analytics.google.com/analytics/web/" target="_blank" >GOOGLE Analytics</a></li>
								</c:if>
							</ul>
						</div>
					</div>
					<div class="col-md-6">
						<div class="footer-widget">
							<h3 class="footer-title">Catagories</h3>
							<ul class="footer-links">
								<li><a href="recruitlist">채용정보</a></li>
								<li><a href="companylist">기업정보</a></li>
								<li><a href="jobhunterlist">인재정보</a></li>
								<li><a href="javascript:chk(${loginUser.state});">인재등록</a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-3">
				<div class="footer-widget">
					<h3 class="footer-title">Join our Newsletter</h3>
					<div class="footer-newsletter">
						<form role="form" name="emailfrm" method="post"
							action="insertnewsletter" onsubmit="return onSubmit2()">
							<input class="input" type="email" name="email" id="email"
								placeholder="Enter your email">
							<button type="submit" class="newsletter-btn" id="submit">
								<i class="fa fa-paper-plane"></i>
							</button>
						</form>
					</div>
					<ul class="footer-social">
						<li><a href="http://www.facebook.com" target="_blank" ><i
								class="fa fa-facebook"></i></a></li>
						<li><a href="http://twitter.com/?lang=ko" target="_blank" ><i
								class="fa fa-twitter"></i></a></li>
						<li><a href="http://www.google.com" target="_blank" ><i
								class="fa fa-google-plus"></i></a></li>
						<li><a href="http://www.pinterest.co.kr" target="_blank" ><i
								class="fa fa-pinterest"></i></a></li>
					</ul>
				</div>
			</div>

		</div>
		<!-- /row -->
	</div>
	<!-- /container -->
</footer>
<!-- /Footer -->

<!-- jQuery Plugins -->
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>

<script type="text/javascript">
	var onSubmit2 = function() {

		if (!emailfrm.email.value) {
			swal('','이메일을 입력하세요','warning');
			emailfrm.email.focus();
			return false;
		} else {
			document.getElementById('emailfrm').submit();
			return true;
		}

	}
</script>

<script type="text/javascript">
	//마우스 우클릭시 alert메시지를 보내도록 만든다
	document.oncontextmenu = function() {
		swal('','마우스 오른쪽버튼은 사용할 수 없습니다.','warning');
		return false;
	};
	/* document.onselectstart = function(){ 
	 alert( "Ctrl + C 기능은 사용할 수 없습니다" ); 
	 return false; 
	 };  
	 document.ondragstart = function(){ 
	 alert( "드래그 기능은 사용할 수 없습니다" ); 
	 return false; 
	 };  */
</script>
	
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
if(!wcs_add) var wcs_add = {};
wcs_add["wa"] = "1c74db49803eb4";
wcs_do();
</script>



</body>

</html>