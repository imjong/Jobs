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
					<li>인재정보</li>
				</ul>
				<h1>인재정보 수정</h1>
			</div>
		</div>
	</div>
</div>
<div class="section">
	<div class="container">
		<c:if test="${loginUser eq null }">
			<h3>로그인 하시면 인재 정보를 포함하여 JOB's의 모든 정보를 이용할 수 있습니다.</h3>
		</c:if>
		<c:if test="${loginUser.state eq 3 }">
			<h3>해당 계정은 사용 정지되었습니다. 관리자에게 문의하시기 바랍니다.</h3>
		</c:if>
		<c:if test="${loginUser.state eq -1 }">
			<h3>네이버로 로그인한 회원은 채용정보와 기업정보만 이용 가능합니다.</h3>
		</c:if>
		<c:if test="${loginUser ne null}">
			<c:if test="${loginUser.state !='3' and loginUser.state !='-1'}">
				<div class="col-md-10 col-md-offset-1">
					<form role="form" name="frm" method="post" enctype="multipart/form-data">
						<div class="row">
							<div class="col-md-8">
								<div class="form-group">
									<label for="name">이름</label>
									<input type="text" class="form-control" name="name" id="name" value="${loginUser.name}" readonly="readonly">
								</div>
								<div class="form-group">
									<label for="type">원하는 고용형태를 선택하시기 바랍니다.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
									<c:if test="${jobhunterinfoArr.type ne '1'}">
										<input type="radio" name="type" value="1" id="type">정규
									</c:if>
									<c:if test="${jobhunterinfoArr.type eq '1'}">
										<input type="radio" name="type" value="1" id="type" checked="checked">계약
									</c:if>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<c:if test="${jobhunterinfoArr.type ne '2'}">
										<input type="radio" name="type" value="2" id="type">특채
									</c:if>
									<c:if test="${jobhunterinfoArr.type eq '2'}">
										<input type="radio" name="type" value="2" id="type" checked="checked">특채
									</c:if>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<c:if test="${jobhunterinfoArr.type ne '3'}">
										<input type="radio" name="type" value="3" id="type">해당없음
									</c:if>
									<c:if test="${jobhunterinfoArr.type eq '3'}">
										<input type="radio" name="type" value="3" id="type" checked="checked">해당없음
									</c:if>
								</div>
								<div class="form-group">
									<label for="career">본인의 경력유무를 선택하시기 바랍니다.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
									<c:if test="${jobhunterinfoArr.career ne '1'}">
										<input type="radio" name="career" value="1" id="type">신입
									</c:if>
									<c:if test="${jobhunterinfoArr.career eq '1'}">
										<input type="radio" name="career" value="1" id="type" checked="checked">신입
									</c:if>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<c:if test="${jobhunterinfoArr.career ne '2'}">
										<input type="radio" name="career" value="2" id="type">경력
									</c:if>
									<c:if test="${jobhunterinfoArr.career eq '2'}">
										<input type="radio" name="career" value="2" id="type" checked="checked">경력
									</c:if>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<c:if test="${jobhunterinfoArr.career ne '3'}">
										<input type="radio" name="career" value="3" id="type">해당없음
									</c:if>
									<c:if test="${jobhunterinfoArr.career eq '3'}">
										<input type="radio" name="career" value="3" id="type" checked="checked">해당없음
									</c:if>
								</div>
							</div>
							<div class="col-md-4">
								<div>
									<label for="imagefile">이미지</label>
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
							<input type="text" class="form-control" name="subject" id="subject" placeholder="제목을 100자 이내로 입력하세요" value="${jobhunterinfoArr.subject}" onkeyup="test(this.value)">
						</div>
						<div class="text-right text-danger" id="check"></div>
						<div class="form-group">
							<label for="content">내용</label>
							<textarea class="form-control" rows="10" name="content" id="content" placeholder="내용을 2000자 이내로 입력하세요" onkeyup="test2(this.value)">${jobhunterinfoArr.content}</textarea>
						</div>
						<div class="text-right text-danger" id="check2"></div>
						<div class="form-group">
							<input type="hidden" name="oldFilename" value="${jobhunterinfoArr.filename}"> 
							<label for="jobhunterfile">파일 첨부 [ ${jobhunterinfoArr.viewFname} (${jobhunterinfoArr.filesize} bytes) ]</label> 
							<input class="form-control-file border" type="file" id="jobhunterfile" name="jobhunterfile"> 
							<input type="hidden" class="form-control" name="num" id="num" value="${jobhunterinfoArr.num}" readonly="readonly">
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
		frm.action="jobhunterupdatecomplete";
		frm.submit();
		
	}
</script>


<!-- foot -->
<c:import url="/foot" />