<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<%
	//쿠키 꺼내기 => 쿠키의 키값이 "saveId"가 있다면 해당 value값(사용자아아디)
	//				 을 꺼내서 input name이 userid인 곳에 value값으로 넣어준다.

	Cookie cks[] = request.getCookies();
	String uid = "";
	boolean isChk = false;
	if (cks != null) {
		for (Cookie c : cks) {
			String key = c.getName();//key값
			if (key.equals("saveId")) {
				uid = c.getValue();
				isChk = true;
				break;
			}
		}
	}
%>


<c:import url="/top" />

<style type="text/css">
	#table_info a {
		text-decoration: none;
	}
</style>

<!-- section -->
<div class="section">
	<!-- container -->
<div class="container">
	<!-- row -->
<div class="row">
	<div class="col-md-9">
		<div id="fullcarousel-example" data-interval="2000"
			class="carousel slide" data-ride="carousel">
			<div class="carousel-inner">
				<div class="item">
					<img src="./img/event.png">
					<div class="carousel-caption"></div>
				</div>
				<div class="item active">
					<img src="./img/open.png">
					<div class="carousel-caption"></div>
				</div>
			</div>
			<a class="left carousel-control" href="#fullcarousel-example"
				data-slide="prev"><i class="icon-prev fa fa-angle-left"></i></a> <a
				class="right carousel-control" href="#fullcarousel-example"
				data-slide="next"><i class="icon-next fa fa-angle-right"></i></a>
		</div>
	</div>
	<div class="col-md-3">
		<table id="table_info" class="table table-hover text-center">
			<c:if test="${loginUser eq null }">
				<form role="form" name="frm" id="frm" method="post" action="login"
					onsubmit="return onSubmit()">
					<thead>
						<tr>
							<th colspan="2" class="text-center">JOB's 로그인</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="2"><input type="text" class="form-control"
								id="userid" name="userid" placeholder="ID"></td>
						</tr>
						<tr>
							<td colspan="2"><input type="password"
								class="form-control" id="pwd" name="pwd"
								placeholder="Password"></td>
						</tr>
						<tr>
							<td><a href="join">회원가입</a></td>
							<td><a href="#"
								onclick="document.getElementById('frm').onsubmit();"
								id="submit">로그인</a></td>
						</tr>
						<tr>
							<td colspan="2">
								<jsp:include page="./login/naverlogin.jsp" />
							</td>
						</tr>
				</form>
			</c:if>
			<c:if test="${loginUser ne null}">
				<thead>
					<tr>
						<th colspan="2" class="text-center" style="color: purple;"><c:if
								test="${loginUser.state == '-1'}">${loginUser.userid}</c:if><c:if
								test="${loginUser.state == '0'}">일 반 회 원</c:if> <c:if
								test="${loginUser.state == '1'}">기 업 회 원</c:if> <c:if
								test="${loginUser.state == '2'}">관 리 자</c:if> <c:if
								test="${loginUser.state == '3'}">정 지 회 원</c:if> <c:if
								test="${loginUser.state == '4'}">탈 퇴 회 원</c:if></th>
					</tr>
				</thead>
				<tbody>
				
					<c:if test="${loginUser.state eq -1}">
						<tr>
							<td colspan="2" align="center">
								<img
									src="<c:out value='${loginUser.imagename}'/>"
									class="img-responsive img-thumbnail" width="150px"
									height="150px">
							</td>
						</tr>
						<tr>
							<td colspan="2" style="color: navy;">${loginUser.name}님
								환영합니다.</td>
						</tr>
						<tr>
							<td><a href="https://nid.naver.com/user2/help/myInfo.nhn?lang=ko_KR"
								style="color: blue;" target="_blank">정보수정</a></td>
							<td><a href="./logout" style="color: red;">로그아웃</a></td>
						</tr>
					</c:if>
					
					<c:if test="${loginUser.state ne -1}">
						<tr>
							<td colspan="2" align="center">
								<c:if test="${loginUser.imagename eq null}">
									<img src="./profileimage/noimage.png"
										class="img-responsive img-thumbnail" width="150px"
										height="150px">
								</c:if>
								<c:if test="${loginUser.imagename ne null}">
									<img
										src="./profileimage/<c:out value="${loginUser.imagename}"/>"
										class="img-responsive img-thumbnail" width="150px"
										height="150px">
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="color: navy;">${loginUser.name}님
								환영합니다.</td>
						</tr>
						<tr>
							<td><a href="./info" style="color: blue;">정보수정</a></td>
							<td><a href="./logout" style="color: red;">로그아웃</a></td>
						</tr>
					</c:if>
					
			</c:if>
			<c:if test="${loginUser.state == '2'}">
			<tr>
				<td colspan="2">
					<a href="userlist" style="color: red;">Job's 회원 목록</a>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="newsletterlist" style="color: red;">Job's Newsletter 목록</a>
				</td>
			</tr>
			</c:if>
			<tr>
				<td colspan="2"><a href="http://www.kidols.net/" target="_blank" >글자수 세기</a></td>
			</tr>
			<tr>
				<td colspan="2"><a href="http://164.125.7.61/speller/" target="_blank" >맞춤법
						검사</a></td>
			</tr>
			<tr>
				<td colspan="2"><a href="https://everytime.kr/calculator" target="_blank" >학점
						변환</a></td>
			</tr>
			<tr>
				<td colspan="2"><a href="https://www.work.go.kr/" target="_blank" >워크넷</a></td>
			</tr>
			<tr>
				<td colspan="2"><a href="#" id="favorite" title="즐겨찾기 등록">JOB's를
						즐겨찾기에 등록</a></td>
			</tr>
			</tbody>
		</table>
	</div>
</div>

<!-- /row -->

<!-- row -->
<br>
<div class="row">
	<div class="col-md-12">
		<div class="section-title">
			<c:if test="${loginUser eq null }">
				<h3>로그인 하시면 최근 등록된 채용 정보를 포함하여 JOB's의 모든 정보를 이용할 수 있습니다.</h3>
			</c:if>
			<c:if test="${loginUser.state eq 3 }">
				<h3>해당 계정은 사용 정지되었습니다. 관리자에게 문의하시기 바랍니다.</h3>
			</c:if>
			<c:if test="${loginUser ne null}">
				<c:if test="${loginUser.state !='3'}">
					<h3>최근 등록된 채용 정보</h3>
		</div>
	</div>

	<c:forEach var="recruitArr" items="${recruitArr}" varStatus="status">
		<c:if test="${recruitArr==null or empty recruitArr}">

			<div class="section-title">
				<h3>등록된 채용 정보가 없습니다.</h3>
			</div>

		</c:if>

		<!-- post -->
		<div class="col-md-4">
			<div class="post">
				<a class="post-img" href="recruitview?num=${recruitArr.num}"><c:if
						test="${recruitArr.imagename eq null}">
						<img src="./profileimage/no_logo.png"
							class="img-responsive img-thumbnail">
					</c:if> <c:if test="${recruitArr.imagename ne null}">
						<img
							src="./profileimage/<c:out value="${recruitArr.imagename}"/>"
							class="img-responsive img-thumbnail">
					</c:if></a>
				<div class="post-body">
					<div class="post-meta">
						<c:if test="${recruitArr.type == '1'}">
							<a class="post-category cat-1"
								href="recruitview?num=${recruitArr.num}">공채</a>
						</c:if>
						<c:if test="${recruitArr.type == '2'}">
							<a class="post-category cat-2"
								href="recruitview?num=${recruitArr.num}">특채</a>
						</c:if>
						<c:if test="${recruitArr.career == '1'}">
							<a class="post-category cat-3"
								href="recruitview?num=${recruitArr.num}">신입</a>
						</c:if>
						<c:if test="${recruitArr.career == '2'}">
							<a class="post-category cat-4"
								href="recruitview?num=${recruitArr.num}">경력</a>
						</c:if>
						<span> <a href="recruitview?num=${recruitArr.num}"
							style="color: navy;">${recruitArr.name}</a>
						</span>
					</div>
					<h3 class="post-title">
						<!-- 글자수 제한 걸기 -->
						<a href="recruitview?num=${recruitArr.num}"> <c:choose>
								<c:when test="${fn:length(recruitArr.subject) > 20}">
									<c:out value="${fn:substring(recruitArr.subject,0,19)}" />...
          								</c:when>
								<c:otherwise>
										${recruitArr.subject}
									</c:otherwise>
							</c:choose> <c:if test="${recruitArr.filesize>0}">
								<img src="./img/file.gif">
							</c:if>
						</a>
						<!-- --------------------- -->
					</h3>
				</div>
			</div>
		</div>
		<c:if test="${status.count mod 3 == 0}">
			<div class="clearfix visible-md visible-lg"></div>
		</c:if>
	</c:forEach>
	<!-- /post -->
</div>
</c:if>
</c:if>
<!-- /row -->
	
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$('#favorite')
								.on(
										'click',
										function(e) {
											var bookmarkURL = window.location.href;
											var bookmarkTitle = document.title;
											var triggerDefault = false;

											if (window.sidebar
													&& window.sidebar.addPanel) {
												// Firefox version < 23
												window.sidebar
														.addPanel(
																bookmarkTitle,
																bookmarkURL,
																'');
											} else if ((window.sidebar && (navigator.userAgent
													.toLowerCase()
													.indexOf('firefox') > -1))
													|| (window.opera && window.print)) {
												// Firefox version >= 23 and Opera Hotlist
												var $this = $(this);
												$this.attr('href',
														bookmarkURL);
												$this.attr('title',
														bookmarkTitle);
												$this.attr('rel',
														'sidebar');
												$this.off(e);
												triggerDefault = true;
											} else if (window.external
													&& ('AddFavorite' in window.external)) {
												// IE Favorite
												window.external
														.AddFavorite(
																bookmarkURL,
																bookmarkTitle);
											} else {
												// WebKit - Safari/Chrome
												//alert((navigator.userAgent.toLowerCase().indexOf('mac') != -1 ? 'Cmd': 'Ctrl')+ '+D 키를 눌러 즐겨찾기에 등록하실 수 있습니다.');
												swal('JOB\'s를 즐겨찾기에 등록',(navigator.userAgent.toLowerCase().indexOf('mac') != -1 ? 'Cmd': 'Ctrl')+ '+D 키를 눌러 즐겨찾기에 등록하실 수 있습니다.');
											}

											return triggerDefault;
										});
					});
</script>

<script type="text/javascript">
	var onSubmit = function() {

		if (!frm.userid.value) {
			swal({
				title: '',
				text: '아이디를 입력하세요',
				icon: 'warning',
				button: '확인'
			}).then(function () {
				frm.userid.focus();
			});
			return false;
			
		} else if (!frm.pwd.value) {
			swal({
				title: '',
				text: '패스워드를 입력하세요',
				icon: 'warning',
				button: '확인'
			}).then(function () {
				frm.pwd.focus();
			});
			return false;
		}
		document.getElementById('frm').submit();

	}
</script>

<script>
	$('#userid, #pwd').keypress(function(event) {
		if (event.which == 13) {
			$('#submit').click();
			return false;
		}
	});
</script>

<script>
	function myfile(fname) {
		//alert(fname);
		location.href = "fileDown?fname=" + encodeURIComponent(fname);
	}
</script>

<c:import url="/foot" />