<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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
	<!-- container -->
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
		<c:if test="${loginUser.state =='0'}">
			<h3 class="text-center">일반회원은 본인이 작성한 글만 확인 가능합니다.</h3>
			<br>
			<div class="col-md-12">
				<div class="section-row text-center">
					<button class="primary-button" onclick="location.href='jobhunterlistme?userid=${loginUser.userid}'">본인이 작성한 글 확인</button>
				</div>
			</div>
		</c:if>
		<c:if test="${loginUser != null}">
			<c:if test="${loginUser.state !='0'}">
				<c:if test="${loginUser.state !='3' and loginUser.state !='-1'}">
					<!-- row -->
					<div class="row">
						<div class="col-md-8">
							<div class="row">
								<div class="text-center">
									<c:if test="${firstCount ne null}">
										<h3>
											총 <span class="text-danger">${totalCount}개</span>의 인재정보
										</h3>
										<br>
									</c:if>
								</div>
								<c:forEach var="jobhunterArr" items="${jobhunterArr}"
									varStatus="status">
									<!-- post -->
									<c:if test="${jobhunterArr == null}">
										<div class="section-title">
											<h3>등록된 인재 정보가 없습니다.</h3>
										</div>
									</c:if>
									<div class="col-md-6">
										<div class="post">
											<a class="post-img" href="jobhunterview?num=${jobhunterArr.num}"><c:if test="${jobhunterArr.imagename eq null}">
												<img src="./profileimage/noimage.png" class="img-responsive img-thumbnail">
												</c:if> <c:if test="${jobhunterArr.imagename ne null}">
												<img src="./profileimage/<c:out value="${jobhunterArr.imagename}"/>"class="img-responsive img-thumbnail">
												</c:if>
											</a>
											<div class="post-body">
												<div class="post-meta">
													<span class="post-date"><fmt:formatDate value="${jobhunterArr.wdate}" pattern="yyyy년 MM월 dd일"/></span>&nbsp;&nbsp;&nbsp;
													<c:if test="${jobhunterArr.type == '1'}">
														<a class="post-category cat-1">정규직</a>
													</c:if>
													<c:if test="${jobhunterArr.type == '2'}">
														<a class="post-category cat-2">계약직</a>
													</c:if>
													<c:if test="${jobhunterArr.career == '1'}">
														<a class="post-category cat-3">신입</a>
													</c:if>
													<c:if test="${jobhunterArr.career == '2'}">
														<a class="post-category cat-4">경력</a>
													</c:if>
												</div>
												<h3 class="post-title">
													<!-- 글자수 제한 걸기 -->
													<a href="obhunterview?num=${jobhunterArr.num}"> <c:choose>
															<c:when test="${fn:length(jobhunterArr.subject) > 20}">
																<c:out
																	value="${fn:substring(jobhunterArr.subject,0,19)}" />...
            												</c:when>
															<c:otherwise>
																${jobhunterArr.subject}
															</c:otherwise>
														</c:choose>
													</a>
													<c:if test="${jobhunterArr.filesize>0}">
														<img src="./img/file.gif">
													</c:if>
													<!-- --------------------- -->
												</h3>
											</div>
										</div>
									</div>
									<c:if test="${status.count mod 2 == 0}">
										<div class="clearfix visible-md visible-lg"></div>
									</c:if>
									<!-- /post -->
								</c:forEach>
							</div>
							<c:if test="${firstCount ne null}">
								<form role="form" name="searchform" action="jobhunterlist" method="get" onsubmit="return check()">
									<!-- hidden data---------------------------------------- -->
									<input type="hidden" name="cpage" value="${cpage}">
									<!-- --------------------------------------------------- -->
									<div class="col-md-3 text-center">
										<select name="searchtype" class="form-control">
											<option value="">::검색 유형::</option>
											<option value="1">글제목</option>
											<option value="2">작성자</option>
											<option value="3">글내용</option>
										</select>
										<p></p>
									</div>
									<div class="col-md-8 text-center">
										<input type="text" name="searchkeyword" class="form-control"
											placeholder="검색어를 입력하세요">
										<p></p>
									</div>
									<div class="col-md-1 text-center">
										<button type="button" onclick="check()" class="btn btn-info">검색</button>
										<p></p>
									</div>
								</form>
								<!-- ----------------------------- -->
								<div class="col-md-12 text-center">
									<c:set var="qstr" value="&search=${search}" />
									<!-- -문자열 생성한 변수를 선언하고 싶을때 set  -->
									<ul class="pagination">
										<c:if test="${prevBlock>0}">
											<li><a href="jobhunterlist?cpage=${firstCount}${qstr}">맨 앞으로</a></li>
											<li><a href="jobhunterlist?cpage=${prevBlock}${qstr}">이전</a></li>
										</c:if>
										<c:forEach var="i" begin="${prevBlock+1}" end="${nextBlock-1}">
											<c:if test="${i<=pageCount}">
												<li <c:if test="${cpage eq i}">class='active'</c:if>><a
													href="jobhunterlist?cpage=${i}${qstr}">${i}</a></li>
											</c:if>
										</c:forEach>
										<c:if test="${nextBlock<=pageCount}">
											<li><a href="jobhunterlist?cpage=${nextBlock}${qstr}">다음</a></li>
											<li><a href="jobhunterlist?cpage=${lastCount}${qstr}">맨 뒤로</a></li>
										</c:if>
									</ul>
								</div>
								<div class="col-md-12 text-center">
									<h4>
										<span class="text-info" style="font-weight: bold">${cpage}</span>
										/ ${pageCount} pages
									</h4>
								</div>
							</c:if>
						</div>

						<div class="col-md-4">
							<!-- catagories -->
							<div class="aside-widget">
								<div class="section-title">
									<h2 class="text-info">카테고리</h2>
								</div>
								<c:forEach var="jobhunterArr3" items="${jobhunterArr3}"
									varStatus="st">
									<div class="category-widget">
										<ul>
											<li><a href="jobhunterlist">총 게시글<span>${jobhunterArr3.totalcount}</span></a></li>
											<li><a href="jobhuntercategory?type=1&career=" class="cat-1">정규직<span>${jobhunterArr3.type1}</span></a></li>
											<li><a href="jobhuntercategory?type=2&career=" class="cat-2">계약직<span>${jobhunterArr3.type2}</span></a></li>
											<li><a href="jobhuntercategory?type=&career=1" class="cat-3">신입<span>${jobhunterArr3.career1}</span></a></li>
											<li><a href="jobhuntercategory?type=&career=2" class="cat-4">경력<span>${jobhunterArr3.career2}</span></a></li>
										</ul>
									</div>
								</c:forEach>

							</div>
							<!-- /catagories -->
							<!-- post widget -->
							<div class="aside-widget">
								<div class="section-title">
									<h2 class="text-danger">조회수 TOP 5</h2>
								</div>
								<c:forEach var="jobhunterArr2" items="${jobhunterArr2}" varStatus="st">
									<div class="post post-widget">
										<a class="post-img" href="jobhunterview?num=${jobhunterArr2.num}"><c:if test="${jobhunterArr2.imagename eq null}">
												<img src="./profileimage/no_image.png" class="img-responsive img-thumbnail">
											</c:if> <c:if test="${jobhunterArr2.imagename ne null}">
												<img src="./profileimage/<c:out value="${jobhunterArr2.imagename}"/>" class="img-responsive img-thumbnail">
											</c:if>
										</a>
										<div class="post-body">
											<h3 class="post-title">
												<!-- 글자수 제한 걸기 -->
												<a href="jobhunterview?num=${jobhunterArr2.num}"> <c:choose>
														<c:when test="${fn:length(jobhunterArr2.subject) > 14}">
															<c:out value="${fn:substring(jobhunterArr2.subject,0,13)}" />...
            											</c:when>
														<c:otherwise>
															${jobhunterArr2.subject}
														</c:otherwise>
													</c:choose>
												</a>
												<!-- --------------------- -->
											</h3>
										</div>
									</div>
								</c:forEach>
							</div>
							<!-- /post widget -->
						</div>
					</div>
				</c:if>
			</c:if>
		</c:if>
		<!-- /row -->
	</div>
	<!-- /container -->
</div>

<script type="text/javascript">
	var check = function() {

		if (!searchform.searchtype.value) {
			swal('','검색 유형을 선택하세요','warning');
			searchform.searchtype.focus();
			return false;
		}
		if (!searchform.searchkeyword.value) {
			searchform.search.value = "";
		}
		searchform.submit();
	}
</script>


<!-- foot -->
<c:import url="/foot" />