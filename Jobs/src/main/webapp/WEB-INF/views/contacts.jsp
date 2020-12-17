<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- top -->
<c:import url="/top" />

<!-- 여기에 추가 -->
<div class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-10">
				<ul class="page-header-breadcrumb">
					<li><a href="index.html">메인화면</a></li>
					<li>Contacts</li>
				</ul>
				<h1>Contacts</h1>
			</div>
		</div>
	</div>
</div>
<div class="section">
	<div class="container">
		<c:if test="${loginUser eq null }">
			<h3>로그인 하시면 JOB's의 모든 정보를 이용할 수 있습니다.</h3>
		</c:if>
		<c:if test="${loginUser.state eq 3 }">
			<h3>해당 계정은 사용 정지되었습니다. 관리자에게 문의하시기 바랍니다.</h3>
		</c:if>
		<c:if test="${loginUser ne null }">
			<c:if test="${loginUser.state !='3'}">
				<div class="row">
					<div class="col-md-12">
						<h1 class="text-center text-danger">Team JOB's</h1>
						<p class="text-center text-primary">We are a group of skilled
							individuals.</p>
					</div>
				</div>
				<br>
				<br>
				<br>
				<div class="row">
					<div class="col-md-2">
						<img
							src="http://pingendo.github.io/pingendo-bootstrap/assets/user_placeholder.png"
							class="img-circle img-responsive">
					</div>
					<div class="col-md-4">
						<h3 class="text-left">최 원 영</h3>
						<p class="text-left text-success">010 - **** - ****</p>
						<p class="text-left text-primary">androidapk@naver.com</p>
						<p class="text-left">
							Spring Framework는 제 인생의 전부입니다. <br>Oracle도 제 인생의 전부입니다.
						</p>
					</div>
					<div class="col-md-2">
						<img
							src="http://pingendo.github.io/pingendo-bootstrap/assets/user_placeholder.png"
							class="img-circle img-responsive">
					</div>
					<div class="col-md-4">
						<h3 class="text-left">이 종 현</h3>
						<p class="text-left text-success">010 - **** - ****</p>
						<p class="text-left text-primary">redbabo67@naver.com</p>
						<p class="text-left">
							한때는... html장인, javascript장인, css장인,<br>jquery장인, bootstrap장인, 겐트위한 장인
						</p>
					</div>
				</div>
				<br>
				<br>
				<div id="map_canvas"
					style="width: 100%; height: 400px; margin: 0px;"></div>
			</c:if>
		</c:if>
	</div>
</div>

<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKsUUTbcO8B_OqKncUxmnpnpZ3QnrSttg&callback=initMap"
	async defer></script>

<script>
	function initialize() {
		var myLatlng = new google.maps.LatLng(37.673328, 126.753973);
		var mapOptions = {
			zoom : 14,
			center : myLatlng,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		}
		var map = new google.maps.Map(document.getElementById('map_canvas'),
				mapOptions);
		var marker = new google.maps.Marker({
			position : myLatlng,
			map : map,
			title : "map"
		});
	}
	window.onload = initialize;
</script>

<!-- foot -->
<c:import url="/foot" />