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
					<li><a href="home">메인화면</a></li>
					<li>회원목록</li>
				</ul>
				<h1>회원목록</h1>
			</div>
		</div>
	</div>
</div>
<div class="section">
	<div class="container">
		<c:if test="${loginUser.state ne 2 }">
			<h3>관리자만 이용가능합니다.</h3>
		</c:if>
		<c:if test="${loginUser.state eq 2 }">
			
			<div class="col-md-10 col-md-offset-1">
				<table class="table table-bordered table-hover table-striped text-center" id="table">
					<thead>
						<tr>
							<th width="5%" class="text-center">Index</th>
							<th width="10%" class="text-center">ID</th>
							<th width="15%" class="text-center">Encrypted Password</th>
							<th width="15%" class="text-center">Decrypted Password</th>
							<th width="15%" class="text-center">Name</th>
							<th width="10%" class="text-center">State</th>
							<th width="15%" class="text-center">Join Date</th>
							<th width="15%" class="text-center">Withdrawal Date</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="userlistArr" items="${UserlistArr}" varStatus="st">
							<tr>
								<td id="uidx">${userlistArr.idx}</td>
								<td id="uid">${userlistArr.userid}</td>
								<td id="upwd">${userlistArr.epwd}</td>
								<td id="upwd">${userlistArr.pwd}</td>
								<td id="uname">${userlistArr.name}</td>
								<td id="ustate"><c:if test="${userlistArr.state == '0'}">일반회원</c:if>
									<c:if test="${userlistArr.state == '1'}">기업회원</c:if> <c:if
										test="${userlistArr.state == '2'}">관리자</c:if> <c:if
										test="${userlistArr.state == '3'}">정지회원</c:if> <c:if
										test="${userlistArr.state == '4'}">탈퇴회원</c:if></td>
								<td id="uindate"><fmt:formatDate value="${userlistArr.indate}" pattern="yyyy-MM-dd"/></td>
								<td id="uoutdate"><fmt:formatDate value="${userlistArr.outdate}" pattern="yyyy-MM-dd"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="center-block" style="width: 200px">
					<button class="primary-button" onclick="location.href='home'">HOME</button>
				</div>
			</div>
			
			<div id="floatMenu">
				<p class="text-center" style="font-weight: bold; color: red;">회원정보
					관리</p>
				<form role="form" name="userform" id="userform">
					<div class="text-center">해당 회원의 <br>Index를 <br>입력하세요 
					<input type="text" class="form-control" name="idx" id="idx">
					</div>
					<br>
					<div class="text-center">회원 상태 변경
					<select name="state" class="form-control">
							<option value="0">일반회원</option>
							<option value="1">기업회원</option>
							<option value="2">관리자</option>
							<option value="3">정지회원</option>
							<option value="4">탈퇴회원</option>
					</select>
					</div>
					<br>
					<div class="text-center" style="font-weight: bold;">해당 회원 정보를?</div>
					<br>
					<div class="text-center">
						<button class="btn btn-warning" onclick="modify()">수정</button>
						|
						<button class="btn btn-danger" onclick="del()">삭제</button>
					</div>
				</form>
			</div>
		</c:if>
	</div>
</div>

<script type="text/javascript">
	var modify = function() {

		if (!userform.idx.value) {
			alert('Index를 입력하세요');
			userform.idx.focus();
			return;
		} else if (!userform.state.value) {
			alert('state를 선택하세요');
			userform.state.focus();
			return;
		} else {
			var yn = confirm("해당 회원정보를 수정하시겠습니까?");
			if (!yn) {
				return;
			}
			userform.method = "POST";
			userform.action = "userstateupdate";
			userform.submit();
		}
	}

	var del = function() {

		if (!userform.idx.value) {
			alert('Index를 입력하세요');
			userform.idx.focus();
			return;
		} else {
			var yn = confirm("해당 회원정보를 삭제하시겠습니까?");
			if (!yn) {
				return;
			}
			userform.method = "POST";
			userform.action = "userdelete";
			userform.submit();
		}
	}
</script>
<script>
	$(document).ready(function() {

		var floatPosition = parseInt($("#floatMenu").css('top'));

		$(window).scroll(function() {
			var scrollTop = $(window).scrollTop();
			var newPosition = scrollTop + floatPosition + "px";

			$("#floatMenu").stop().animate({
				"top" : newPosition
			}, 500);

		}).scroll();

	});
</script>

<!-- foot -->
<c:import url="/foot" />