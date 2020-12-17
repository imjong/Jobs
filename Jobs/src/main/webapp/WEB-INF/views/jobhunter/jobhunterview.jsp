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
				<h1>인재정보</h1>
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
					<table class="table table-bordered text-center">
						<tbody>
							<tr>
								<td width="20%"><label>작성자</label></td>
								<td width="50%" style="font-weight: bold;">${jobhunterinfoArr.name}</td>
								<td rowspan="5" width="30%">
								<c:if test="${jobhunterinfoArr.imagename eq null}">
									<img src="./profileimage/noimage.png"
											class="img-responsive img-thumbnail">
								</c:if> 
								<c:if test="${jobhunterinfoArr.imagename ne null}">
										<img src="./profileimage/<c:out value="${jobhunterinfoArr.imagename}"/>" class="img-responsive img-thumbnail">
								</c:if>
								</td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr>
								<td><c:if test="${jobhunterinfoArr.type == '1'}">
										<label class="text text-danger">정규직</label>
									</c:if> <c:if test="${jobhunterinfoArr.type == '2'}">
										<label class="text text-warning">계약직</label>
									</c:if> <c:if test="${jobhunterinfoArr.type == '3'}"></c:if></td>
								<td>조회수</td>
							</tr>
							<tr>
								<td><c:if test="${jobhunterinfoArr.career == '1'}">
										<label class="text text-success">신입</label>
									</c:if> <c:if test="${jobhunterinfoArr.career == '2'}">
										<label class="text text-info">경력</label>
									</c:if> <c:if test="${jobhunterinfoArr.career == '3'}">
										<a class="post-category cat-4"></a>
									</c:if></td>
								<td>${jobhunterinfoArr.readnum}</td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
							</tr>
							<tr>
								<td><label>제목</label></td>
								<td colspan="2" style="font-weight: bold;">${jobhunterinfoArr.subject}</td>
							</tr>
							<tr>
								<td><label>작성일</label></td>
								<td colspan="2"><fmt:formatDate value="${jobhunterinfoArr.wdate}" pattern="yyyy년 MM월 dd일"/></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr>
								<td><label>내용</label></td>
								<td colspan="2" class="text-left"><pre id="pre_small">${jobhunterinfoArr.content}</pre></td>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr>
								<td><label>첨부파일</label></td>
								<c:if test="${jobhunterinfoArr.filename eq null}">
									<td colspan="2">첨부파일이 없습니다.</td>
								</c:if>
								<c:if test="${jobhunterinfoArr.filename ne null}">
									<td colspan="2">${jobhunterinfoArr.viewFname} (${jobhunterinfoArr.filesize} Bytes) <a href="#" onclick="myfile('${jobhunterinfoArr.filename}')" id="data"><img src="./img/download.jpg" alt="" width="100px" height="30px"></a>
									</td>
								</c:if>
							</tr>
							<tr>
								<td colspan="3">&nbsp;</td>
							</tr>
							<tr>
								<td colspan="3">
									<button class="btn btn-warning" onclick="go(1)">글수정</button>&nbsp;&nbsp;|&nbsp;&nbsp;
									<a href="jobhunterlist"><button class="btn btn-success">글목록</button></a>&nbsp;&nbsp;|&nbsp;&nbsp;
									<button class="btn btn-danger" onclick="go(2)">글삭제</button>
								</td>
							</tr>
							<!-- 수정, 삭제할때 사용할 폼 -->

							<form role="form" name="frm" id="frm">

								<input type="hidden" class="form-control" name="num" id="num" value="${jobhunterinfoArr.num}" readonly="readonly"> 
								<input type="hidden" class="form-control" name="wuserid" id="wuserid" value="${jobhunterinfoArr.userid}" readonly="readonly">
								<c:if test="${loginUser.state == '2'}">
									<input type="hidden" class="form-control" name="luserid" id="luserid" value="${jobhunterinfoArr.userid}" readonly="readonly">
									<input type="hidden" class="form-control" name="adminchk" id="adminchk" value="${loginUser.state}" readonly="readonly">
									<input type="hidden" class="form-control" name="auserid" id="auserid" value="${loginUser.userid}" readonly="readonly">
								</c:if>
								<c:if test="${loginUser.state != '2'}">
									<input type="hidden" class="form-control" name="luserid" id="luserid" value="${loginUser.userid}" readonly="readonly">
									<input type="hidden" class="form-control" name="adminchk" id="adminchk" value="${loginUser.state}" readonly="readonly">
								</c:if>
								<input type="hidden" class="form-control" name="wpwd" id="wpwd" value="${jobhunterinfoArr.epwd}" readonly="readonly">
								<c:if test="${loginUser.state == '2'}">
									<input type="hidden" class="form-control" name="lpwd" id="lpwd" value="${jobhunterinfoArr.epwd}" readonly="readonly">
								</c:if>
								<c:if test="${loginUser.state != '2'}">
									<input type="hidden" class="form-control" name="lpwd" id="lpwd" value="${loginUser.epwd}" readonly="readonly">
								</c:if>
							</form>
						</tbody>
					</table>
				</div>
			</c:if>
		</c:if>
	</div>
</div>

<script>
	function myfile(fname) {
		//alert(fname);
		location.href = "fileDown?fname=" + encodeURIComponent(fname);
	}
</script>

<script type="text/javascript">
	var go = function(md) {

		if (frm.wuserid.value != frm.luserid.value
				|| frm.wpwd.value != frm.lpwd.value) {
			swal('','작성자만 가능합니다.','warning');
			return;
		} else {
			frm.method = "POST";
			if (md == 1) {
				swal({
					title: "",
					text: "글을 수정하시겠습니까?",
					icon: "warning",
					buttons: true,
					dangerMode: true
				}).then(function (confirm) {
					if (confirm) {
						frm.action = "jobhunterupdate";
						frm.submit();
					} else {
						return;
					}
				});


				if (frm.adminchk.value == 2) {
					if (frm.wuserid.value == frm.auserid.value) {

					} else {
						swal('','관리자는 글삭제만 가능합니다.','warning');
						return;
					}
				}
				
			}
			if (md == 2) {
				swal({
					title: "",
					text: "글을 삭제하시겠습니까?",
					icon: "warning",
					buttons: true,
					dangerMode: true
				}).then(function (willDelete) {
					if (willDelete) {
						frm.action = "jobhunterdelete";
						frm.submit();
					} else {
						return;
					}
				});
			}
		}
	}
</script>

<!-- foot -->
<c:import url="/foot" />