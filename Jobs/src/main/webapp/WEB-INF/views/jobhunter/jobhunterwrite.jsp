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
					<li>인재등록</li>
				</ul>
				<h1>인재등록 작성</h1>
			</div>
		</div>
	</div>
</div>

<div class="section">
	<div class="container">
		<c:if test="${loginUser eq null }">
			<h3>로그인 하시면 채용 정보를 포함하여 JOB's의 모든 정보를 이용할 수 있습니다.</h3>
		</c:if>
		<c:if test="${loginUser.state eq 3 }">
			<h3>해당 계정은 사용 정지되었습니다. 관리자에게 문의하시기 바랍니다.</h3>
		</c:if>
		<c:if test="${loginUser.state eq 1 }">
			<h3>기업회원은 해당 페이지를 이용할 수 없습니다.</h3>
		</c:if>
		<c:if test="${loginUser.state eq -1 }">
			<h3>네이버로 로그인한 회원은 채용정보와 기업정보만 이용 가능합니다.</h3>
		</c:if>
		<c:if test="${loginUser ne null}">
			<c:if test="${loginUser.state !='3' and loginUser.state !='-1'}">
				<c:if test="${loginUser.state !='1'}">
					<div class="col-md-10 col-md-offset-1">
						<form role="form" name="frm" enctype="multipart/form-data">
							<div class="form-group text-center">
								<label class="text-danger">입사 지원서 기본양식은 아래에서 다운받으시기 바랍니다.</label>
							</div>
							<div>&nbsp;</div>
							<div class="form-group text-center">
								<a href="https://drive.google.com/uc?authuser=1&id=1Kc1MnrzuGyKyp_fEqzsb9vVNbgsxkfl9&export=download"><img src="./img/download.gif" alt="" width="100px" height="100px"></a>
							</div>
							<div>&nbsp;</div>
							<div>&nbsp;</div>
							<div class="row">
								<div class="col-md-8">
									<div class="form-group">
										<label for="name">이름</label>
										<input type="text" class="form-control" name="name" id="name" value="${loginUser.name}" readonly="readonly">
									</div>
									<div class="form-group">
										<label for="type">원하는 고용형태를 선택하시기 바랍니다.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
										<input type="radio" name="type" value="1" id="type">
										정규 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
										<input type="radio" name="type" value="2" id="type">
										계약 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
										<input type="radio" name="type" value="3" id="type">
										해당없음
									</div>
									<div class="form-group">
										<label for="career">본인의 경력유무를 선택하시기 바랍니다.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
										<input type="radio" name="career" value="1" id="career">
										신입 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
										<input type="radio" name="career" value="2" id="career">
										경력 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
										<input type="radio" name="career" value="3" id="career">
										해당없음
									</div>
								</div>
								<div class="col-md-4">
									<div>
										<label for="imagefile">사진</label>
										<c:if test="${loginUser.imagename eq null}">
											<img src="./profileimage/noimage.png" class="img-responsive img-thumbnail" id="imagefile">
										</c:if>
										<c:if test="${loginUser.imagename ne null}">
											<img src="./profileimage/<c:out value="${loginUser.imagename}"/>" class="img-responsive img-thumbnail" id="imagefile">
										</c:if>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label for="subject">제목</label> 
								<input type="text" class="form-control" name="subject" id="subject" placeholder="제목을 100자 이내로 입력하세요" onkeyup="test(this.value)">
							</div>
							<div class="text-right text-danger" id="check">100자 입력가능</div>
							<div class="form-group">
								<label for="content">내용</label>
								<textarea class="form-control" rows="10" name="content" wrap="hard" id="content" placeholder="내용을 2000자 이내로 입력하세요" onkeyup="test2(this.value)"></textarea>
							</div>
							<div class="text-right text-danger" id="check2">2000자 입력가능</div>
							<div class="form-group">
								<label for="jobhunterfile">파일 첨부</label> 
								<input
									class="form-control-file border" type="file" id="jobhunterfile" name="jobhunterfile">
							</div>
							<div class="form-group">
								<input type="hidden" class="form-control" name="idx_fk" id="idx_fk" value="${loginUser.idx}" readonly="readonly">
							</div>
							<div class="center-block" style="width: 200px">
								<button class="btn btn-success" type="button" onclick="check()">등록하기</button>
								|
								<button type="reset" class="btn btn-warning">다시쓰기</button>
							</div>
						</form>
					</div>
				</c:if>
			</c:if>
		</c:if>
	</div>
</div>
<script>
	var len = 0;

	function test(val) {
		//alert(obj);
		len = 100 - val.length;
		var obj = document.getElementById('check');
		if (len < 0) {
			obj.innerHTML = "100글자를 초과했습니다.";
			var arr = document.getElementById("subject");
			arr[1].maxLength = 100;
			var str = val.substr(0, 100);
			arr[1].value = str;
		} else {
			obj.innerHTML = len + "자 입력가능";
		}
	}
</script>

<script>
	var len = 0;

	function test2(val) {
		//alert(obj);
		len = 2000 - val.length;
		var obj = document.getElementById('check2');
		if (len < 0) {
			obj.innerHTML = "2000글자를 초과했습니다.";
			var arr = document.getElementsByTagName("textarea");
			arr[1].maxLength = 2000;
			var str = val.substr(0, 2000);
			arr[1].value = str;
		} else {
			obj.innerHTML = len + "자 입력가능";
		}
	}
</script>

<script type="text/javascript">
	var check = function() {
		if (!frm.name.value) {
			swal('','이름을 입력하시기 바랍니다.','warning');
			frm.name.focus();
			return;
		}else if (!$(':radio[name="type"]:checked').val()) {
			swal('','고용형태를 선택하시기 바랍니다.','warning');
			$(':radio[name="type"]').focus();
			return;
		}else if (!$(':radio[name="career"]:checked').val()) {
			swal('','경력유무를 선택하시기 바랍니다.','warning');
			$(':radio[name="career"]').focus();
			return;
		}else if (!frm.subject.value) {
			swal('','제목을 입력하시기 바랍니다.','warning');
			frm.subject.focus();
			return;
		}else if (!frm.content.value) {
			swal('','내용을 입력하시기 바랍니다.','warning');
			frm.content.focus();
			return;
		}
		
		frm.method = "POST";
		frm.action="jobhunterwrite";
		frm.submit();
		
	}
</script>


<!-- foot -->
<c:import url="/foot" />