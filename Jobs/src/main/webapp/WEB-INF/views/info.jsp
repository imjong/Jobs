<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- top -->
<c:import url="/top" />

<style type="text/css">
	.joinCheck {
		padding-top: 5px;
		color: red;
		font-size: 12px;
	}
</style>

<div class="section">
	<div class="container">
		<br>
		<form role="form" name="frm" method="post" action="info"
			enctype="multipart/form-data" onsubmit="return onSubmit()">
			<div class="row">
				<div class="col-md-12">
					<div class="section-title">
						<h3>회원 정보</h3>
					</div>
				</div>
				<div align="center" class="col-md-6 col-md-offset-3">
					<table class="table table-responsive">
						<thead>
							<tr>
								<th colspan="2" class="text-center">정보 수정</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td width="30%" class="text-right">
									<label for="userid" class="control-label">아이디</label></td>
								<td width="70%" colspan="2">
									<input class="form-control" id="userid" name="userid" 
										value="${loginUser.userid}" type="text" readonly>
								</td>
							</tr>
							<tr>
								<td width="30%" class="text-right">
									<label for="pwd" class="control-label">패스워드</label></td>
								<td width="70%">
									<input class="form-control" id="pwd" name="pwd" type="password">
									<span id="pwdCheck" class="pull-right joinCheck"></span>
								</td>
							</tr>
							<tr>
								<td width="30%" class="text-right">
									<label class="control-label">패스워드 확인</label>
								</td>
								<td width="70%">
									<input class="form-control" id="pwd2" type="password">
									<span id="pwd2Check" class="pull-right joinCheck"></span>
								</td>
							</tr>
							<tr>
								<td width="30%" class="text-right">
									<label for="name" class="control-label">이름</label>
								</td>
								<td width="70%">
									<input class="form-control" id="name" name="name" type="text"
										value="${loginUser.name}">
									<span id="nameCheck" class="pull-right joinCheck"></span>
								</td>
							</tr>
							<tr>
								<td class=" text-right" width="30%">
									<label for="imagefile" class="control-label">사진 변경</label>
								</td>
								<td width="70%">
									<input class="form-control" id="imagefile" type="file" name="imagefile">
								</td>
							</tr>
							<tr>
								<td>
									<input id="state" name="state" value="${loginUser.state}" type="hidden">
									<input id="imagename" name="imagename" value="${loginUser.imagename}" type="hidden">
								</td>
								<td class="text-right" colspan="2">
									<button type="button" class="btn btn-danger" onclick="quit()" >회원탈퇴</button>
									<button type="submit" class="btn btn-info">정보수정</button>
									<input id="idx" name="idx" value="${loginUser.idx}" type="hidden">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</form>
	</div>
</div>

<script type="text/javascript">
	var pwd_regex = /^[a-zA-Z0-9!@#$%^&*()]{4,20}$/;
	var name_regex = /^[a-zA-Z가-힣]{2,15}$/;
	
	/* 비밀번호 유효성 검사 */
	var pwdCheck = function () {
		var pwd = $('#pwd').val();
	    
		if (!pwd) {
			$('#pwdCheck').text("비밀번호를 입력하세요.");
		}
		else if (!pwd_regex.test(pwd)) {
	    	$('#pwdCheck').text("4~20자의 영문과 숫자 특수문자를 사용하세요.");
		}
		else {
			$('#pwdCheck').text("");
			return true;
		}
		return false;
	};
	
	/* 비밀번호 확인 일치 검사 */
	var pwd2Check = function () {
	    var pwd2 = $('#pwd2').val();
		
		if (!pwd2) {
	    	$('#pwd2Check').text("비밀번호를 확인을 입력하세요.");
	    }
		else if ($('#pwd').val() != pwd2) {
			$('#pwd2Check').text("비밀번호가 일치하지 않습니다.");
		}
		else {
	    	$('#pwd2Check').text("");
	    	return true;
		}
		return false;
	};
	
	/* 이름 유효성 검사 */
	var nameCheck = function () {
	    var name = $('#name').val();
	    
		if (!name) {
	    	$('#nameCheck').text("이름을 입력하세요.");
	    }
		else if (!name_regex.test(name)) {
	    	$('#nameCheck').text("2자 이상 한글과 영문 대 소문자를 사용하세요.");
		}
		else {
	    	$('#nameCheck').text("");
	    	return true;
		}
		return false;
	};
	
	$("#pwd").blur(function () {
		let result = pwdCheck();
	    console.log(result);
	});
	
	$("#pwd2").blur(function () {
		let result = pwd2Check();
	    console.log(result);
	});
	
	$("#name").blur(function () {
	    let result = nameCheck();
	    console.log(result);
	});
	
	var onSubmit = function() {
		if (pwdCheck() & pwd2Check() & nameCheck()) {
	        return true;
	    } else {
	    	return false;
	    }
	}
	
	/* 회원 탈퇴 */
	var quit = function() {

		frm.method = "POST";

		swal({
			title: "",
			text: "회원탈퇴를 진행하시겠습니까? \n회원정보는 탈퇴 이후로 30일간 유지되며, \n30일 내에는 동일한 계정으로 회원가입이 불가능합니다.",
			icon: "warning",
			buttons: true,
			dangerMode: true
		}).then(function (willDelete) {
			if (willDelete) {
				frm.action = "userquit";
				frm.submit();
			} else {
				return;
			}
		});
		//var yn = confirm("회원탈퇴를 진행하시겠습니까? \n회원정보는 탈퇴 이후로 30일간 유지되며, \n30일 내에는 동일한 계정으로 회원가입이 불가능합니다.");
		//if (!yn) {
		//	return;
		//}
		//frm.action = "userquit";
		//frm.submit();
	}
	
</script>

<!-- foot -->
<c:import url="/foot" />