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
					<li>채용정보</li>
				</ul>
				<h1>채용정보</h1>
			</div>
		</div>
	</div>
</div>
<div class="section">
	<!-- container -->
	<div class="container">
		<c:if test="${loginUser eq null }">
			<h3>로그인 하시면 채용 정보를 포함하여 JOB's의 모든 정보를 이용할 수 있습니다.</h3>
		</c:if>
		<c:if test="${loginUser.state eq 3 }">
			<h3>해당 계정은 사용 정지되었습니다. 관리자에게 문의하시기 바랍니다.</h3>
		</c:if>
		<c:if test="${loginUser ne null}">
			<c:if test="${loginUser.state !='3'}">
				<!-- row -->
				<div class="row">
					<div class="col-md-8">
						<div class="row">
							<div class="text-center">
								<c:if test="${firstCount ne null}">
									<h3>
										총 <span class="text-danger">${totalCount}개</span>의 채용정보
									</h3>
									<br>
								</c:if>
							</div>
							<c:if test="${loginUser.state == '1' or loginUser.state == '2'}">
								<div class="col-md-12">
									<div class="section-row">
										<button class="primary-button"
											onclick="location.href='recruitwrite'">채용정보 작성</button>
									</div>
								</div>
							</c:if>
							<c:forEach var="recruitArr" items="${recruitArr}" varStatus="st">
								<c:if test="${recruitArr == null}">
									<div class="section-title">
										<h3>등록된 채용 정보가 없습니다.</h3>
									</div>
								</c:if>
								<!-- post -->
								<div class="col-md-12">
									<div class="post post-row">
										<a class="post-img" href="recruitview?num=${recruitArr.num}"><c:if
												test="${recruitArr.imagename eq null}">
												<img src="./profileimage/noimage.png" class="img-responsive img-thumbnail">
											</c:if> 
											<c:if test="${recruitArr.imagename ne null}">
												<img src="./profileimage/<c:out value="${recruitArr.imagename}"/>" class="img-responsive img-thumbnail">
											</c:if>
										</a>
										<div class="post-body">
											<div class="post-meta">
												<span class="post-date"><fmt:formatDate value="${recruitArr.wdate}" pattern="yyyy년 MM월 dd일"/></span>&nbsp;&nbsp;&nbsp;
												<c:if test="${recruitArr.type == '1'}">
													<a class="post-category cat-1">공채</a>
												</c:if>
												<c:if test="${recruitArr.type == '2'}">
													<a class="post-category cat-2">특채</a>
												</c:if>
												<c:if test="${recruitArr.career == '1'}">
													<a class="post-category cat-3">신입</a>
												</c:if>
												<c:if test="${recruitArr.career == '2'}">
													<a class="post-category cat-4">경력</a>
												</c:if>
											</div>
											<h3 class="post-title">
												<a href="recruitview?num=${recruitArr.num}" style="color: navy;">${recruitArr.name}</a>
											</h3>
												<!-- 글자수 제한 걸기 -->
												<a href="recruitview?num=${recruitArr.num}"> <c:choose>
														<c:when test="${fn:length(recruitArr.subject) > 25}">
															<c:out value="${fn:substring(recruitArr.subject,0,24)}" />...
            											</c:when>
														<c:otherwise>
															${recruitArr.subject}
														</c:otherwise>
													</c:choose> <c:if test="${recruitArr.filesize>0}">
														<img src="./img/file.gif">
													</c:if>
												</a>
												<!-- --------------------- -->
											
										</div>
									</div>
								</div>
								<!-- /post -->
							</c:forEach>
						</div>
						
						<c:if test="${firstCount ne null}">
							<form role="form" name="searchform" action="recruitlist"
								method="get" onsubmit="return check()">
								<!-- hidden data---------------------------------------- -->
								<input type="hidden" name="cpage" value="${cpage}">
								<!-- --------------------------------------------------- -->
								<div class="col-md-3 text-center">
									<select name="searchtype" class="form-control">
										<option value="">::검색 유형::</option>
										<option value="1">글제목</option>
										<option value="2">기업명</option>
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
									<button type="button" onclick="check()" class="btn btn-warning">검색</button>
								</div>
							</form>
							
							<!-- ----------------------------- -->
							<div class="col-md-12 text-center">
								<c:set var="qstr" value="&search=${search}" />
								<!-- -문자열 생성한 변수를 선언하고 싶을때 set  -->
								<ul class="pagination">
									<c:if test="${prevBlock>0}">
										<li><a href="recruitlist?cpage=${firstCount}${qstr}">맨 앞으로</a></li>
										<li><a href="recruitlist?cpage=${prevBlock}${qstr}">이전</a></li>
									</c:if>
									<c:forEach var="i" begin="${prevBlock+1}" end="${nextBlock-1}">
										<c:if test="${i<=pageCount}">
											<li <c:if test="${cpage eq i}">class='active'</c:if>>
											<a href="recruitlist?cpage=${i}${qstr}">${i}</a></li>
										</c:if>
									</c:forEach>
									<c:if test="${nextBlock<=pageCount}">
										<li><a href="recruitlist?cpage=${nextBlock}${qstr}">다음</a></li>
										<li><a href="recruitlist?cpage=${lastCount}${qstr}">맨 뒤로</a></li>
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
							<c:forEach var="recruitArr3" items="${recruitArr3}" varStatus="st">
								<div class="category-widget">
									<ul>
										<li><a href="recruitlist">총 게시글<span>${recruitArr3.totalcount}</span></a></li>
										<li><a href="recruitcategory?type=1&career="
											class="cat-1">공개채용<span>${recruitArr3.type1}</span></a></li>
										<li><a href="recruitcategory?type=2&career="
											class="cat-2">특별채용<span>${recruitArr3.type2}</span></a></li>
										<li><a href="recruitcategory?type=&career=1"
											class="cat-3">신입<span>${recruitArr3.career1}</span></a></li>
										<li><a href="recruitcategory?type=&career=2"
											class="cat-4">경력<span>${recruitArr3.career2}</span></a></li>
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
							<c:forEach var="recruitArr2" items="${recruitArr2}"
								varStatus="st">
								<div class="post post-widget">
									<a class="post-img" href="recruitview?num=${recruitArr2.num}">
									<c:if test="${recruitArr2.imagename eq null}">
										<img src="./profileimage/no_logo.png" class="img-responsive img-thumbnail">
									</c:if> <c:if test="${recruitArr2.imagename ne null}">
										<img src="./profileimage/<c:out value="${recruitArr2.imagename}"/>" class="img-responsive img-thumbnail">
										</c:if></a>
									<div class="post-body">
										<h3 class="post-title">
											<!-- 글자수 제한 걸기 -->
											<a href="recruitview?num=${recruitArr2.num}"> 
											<c:choose>
												<c:when test="${fn:length(recruitArr2.subject) > 14}">
												<c:out value="${fn:substring(recruitArr2.subject,0,13)}" />...
            								</c:when>
												<c:otherwise>
												${recruitArr2.subject}
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
				<!-- /row -->
			</c:if>
		</c:if>
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
			searchform.searchkeyword.value = "";
		}
		searchform.submit();
	}
</script>

<!-- foot -->
<c:import url="/foot" />