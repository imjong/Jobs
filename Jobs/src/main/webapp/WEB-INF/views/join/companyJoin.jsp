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
		<form role="form" name="frm" method="post" action="join"
			enctype="multipart/form-data" onsubmit="return onSubmit()">
			<div class="row">
				<div class="col-md-12">
					<div class="section-title">
						<h3>회원가입(기업회원)</h3>
					</div>
				</div>
				<div align="center" class="col-md-6 col-md-offset-3">
					<table class="table table-responsive">
						<thead>
							<tr>
								<th colspan="2" class="text-center"><a href="join">일반회원
										가입은 이곳을 클릭하세요</a></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td width="30%" class="text-right">
									<label for="userid" class="control-label">아이디</label></td>
								<td width="70%" colspan="2">
									<input class="form-control" id="userid" name="userid" placeholder="" type="text">
									<span id="idCheck" class="pull-right joinCheck"></span>
								</td>
							</tr>
							<tr>
								<td width="30%" class="text-right">
									<label for="pwd" class="control-label">비밀번호</label></td>
								<td width="70%">
									<input class="form-control" id="pwd" name="pwd" placeholder="" type="password">
									<span id="pwdCheck" class="pull-right joinCheck"></span>
								</td>
							</tr>
							<tr>
								<td width="30%" class="text-right">
									<label class="control-label">비밀번호 확인</label>
								</td>
								<td width="70%">
									<input class="form-control" id="pwd2" placeholder="" type="password">
									<span id="pwd2Check" class="pull-right joinCheck"></span>
								</td>
							</tr>
							<tr>
								<td width="30%" class="text-right">
									<label for="name" class="control-label">기업 이름</label>
								</td>
								<td width="70%">
									<input class="form-control" id="name" name="name" placeholder="" type="text">
									<span id="nameCheck" class="pull-right joinCheck"></span>
								</td>
							</tr>
							<tr>
								<td class=" text-right" width="30%">
									<label for="imagefile" class="control-label">기업 로고 등록</label>
								</td>
								<td width="70%">
									<input class="form-control" id="imagefile" type="file" name="imagefile">
								</td>
							</tr>
							<tr>
								<td class="text-right" width="30%"><label
									class="control-label">기업 정보</label></td>
								<td width="70%">
									<textarea name="info" id="info" rows="10"
										cols="50" class="form-control"
										placeholder="기업 정보를 1000자 이내로 입력하세요"></textarea>
									<span id="textCheck" class="pull-right joinCheck">남은 글자수 : 1000자</span>
								</td>
							</tr>
							<tr>
								<td colspan="2" class="text-center">
									<iframe src="./html/agree.html" width="100%" height="120px"
										style="border: 1px solid silver"></iframe>
								</td>
							</tr>
							<tr>
								<td colspan="2" class="text-right">
									<input type="checkbox" id="agree">이용약관 동의 <br/>
									<span id="agreeCheck" class="pull-right joinCheck"></span>
								</td>
							</tr>

							<tr>
								<td class="text-center"><input class="form-control"
									id="state" name="state" value="1" readonly type="hidden">
								</td>
								<td class="text-right">
									<button type="submit" class="btn btn-success">회원가입</button>
									<button type="reset" class="btn btn-warning">다시쓰기</button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</form>
	</div>
</div>

<script>
	var count = 0;
	
	$('#info').on('keyup', function () {
		count = 1000 - $(this).val().length;
		
		if (count < 0) {
 			$(this).val($(this).val().substring(0, 1000));
		} else {
			$('#textCheck').text("남은 글자수 : " + count + "자");
		}
	});
</script>

<script type="text/javascript">
	var userid_regex = /^[a-zA-Z0-9]{4,20}$/;
	var pwd_regex = /^[a-zA-Z0-9!@#$%^&*()]{4,20}$/;
	var name_regex = /^[a-zA-Z가-힣]{2,15}$/;
	
	/* ID 유효성 중복 검사 */
	var idCheck = function () {
	    var bool = false;
		var userid = $('#userid').val();
	
	    if (!userid) {
	    	$('#idCheck').text("아이디를 입력하세요.");
	        $('#idCheck').css('color', 'red');
	    }
	    else if (!userid_regex.test(userid)) {
	    	$('#idCheck').text("4~20자의 영문과 숫자로만 사용 가능합니다.");
	        $('#idCheck').css('color', 'red');
	    }
	    else {
	    	$.ajax({
	            type: "GET",
	            url: "/jobs/join/idCheck?userid=" + userid,
	            dataType: "JSON",
	            async: false,
	            success: function (response) {
	                var isExistID = response.isExistID;
	
	                if (isExistID == 1) {
	                    $('#idCheck').text("사용중인 아이디 입니다.");
	                    $('#idCheck').css('color', 'red');
	                } else if (isExistID == 0) {
	                	$('#idCheck').text("사용 가능한 아이디 입니다.");
	                    $('#idCheck').css('color', 'blue');
	                    bool = true;
	                }
	            },
	            error: function (error) {
	                console.error(error);
	            }
	        });
	    }
	    return bool;
	};
	
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
	
	/* 이용약관 동의 검사 */
	var agreeCheck = function () {
	    var agree = $('#agree').is(':checked');
	    
	    if (agree) {
	    	$('#agreeCheck').text("");
	    	return true;
	    } else {
	    	$('#agreeCheck').text("Jobs 이용약관에 동의해주세요.");
	    	return false;
	    }
	}
	
	$("#userid").blur(function () {
		let result = idCheck();
	    console.log(result);
	});
	
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
		if (idCheck() & pwdCheck() & pwd2Check() & nameCheck() & agreeCheck()) {
	        return true;
	    } else {
	    	return false;
	    }
	}
</script>

<!-- foot -->
<c:import url="/foot" />