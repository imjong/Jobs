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
					<li>기업정보</li>
				</ul>
				<h1>기업정보</h1>
			</div>
		</div>
	</div>
</div>


<div class="section">
	<!-- container -->
	<div class="container">
		<c:if test="${loginUser eq null }">
			<h3>로그인 하시면 기업 정보를 포함하여 JOB's의 모든 정보를 이용할 수 있습니다.</h3>
		</c:if>
		<c:if test="${loginUser.state eq 3 }">
			<h3>해당 계정은 사용 정지되었습니다. 관리자에게 문의하시기 바랍니다.</h3>
		</c:if>
		<c:if test="${loginUser ne null}">
			<c:if test="${loginUser.state !='3'}">
				<div class="col-md-offset-3 col-md-6 text-center">
					<form role="form" name="searchform" action="companylist"
						method="get" onsubmit="return check()">
						<!-- hidden data---------------------------------------- -->
						<input type="hidden" name="cpage" value="${cpage}">
						<!-- --------------------------------------------------- -->
						<div class="form-group">
							<div class="input-group">
								<input type="text" class="form-control" name="search"
									id="search" placeholder="검색하고 싶은 기업명을 입력하세요"> <span
									class="input-group-btn"> <a class="btn btn-success"
									type="button" onclick="check()">검색</a>
								</span>
							</div>
						</div>
					</form>
					<br>
					<h3>
						총 <span class="text-danger">${totalCount}개</span>의 기업정보
					</h3>
					<br>
				</div>
				<!-- row -->
				<div class="row">
					<div class="col-md-12">
						<div class="row">
							<c:forEach var="companyArr" items="${companyArr}" varStatus="st">
								<!-- post -->
								<c:if test="${companyArr==null or empty companyArr}">
									<div class="section-title">
										<h3>등록된 기업 정보가 없습니다.</h3>
									</div>
								</c:if>
								<c:if test="${companyArr != null and not empty companyArr}">
									<div class="col-md-12">
										<div class="post post-row">
											<a class="post-img" href="companyview?idx=${companyArr.idx}">
												<c:if test="${companyArr.imagename eq null}">
													<img src="./profileimage/noimage.png" class="img-responsive img-thumbnail">
												</c:if> 
												<c:if test="${companyArr.imagename ne null}">
													<img src="./profileimage/<c:out value="${companyArr.imagename}"/>"class="img-responsive img-thumbnail">
												</c:if>
											</a>
											<div class="post-body">
												<div class="post-meta"></div>
												<h3 class="post-title">
													<!-- 글자수 제한 걸기 -->
													<a href="companyview?idx=${companyArr.idx}"> <c:choose>
															<c:when test="${fn:length(companyArr.name) > 30}">
																<c:out value="${fn:substring(companyArr.name,0,29)}" />...
            												</c:when>
															<c:otherwise>
															${companyArr.name}
															</c:otherwise>
														</c:choose>
													</a>
													<!-- --------------------- -->
												</h3>
												<!-- 글자수 제한 걸기 -->
												<a href="companyview?idx=${companyArr.idx}" style="font-weight: normal;"> 
												<c:choose>
														<c:when test="${fn:length(companyArr.info) > 260}">
															<c:out value="${fn:substring(companyArr.info,0,259)}" />...
            											</c:when>
														<c:otherwise>
															${companyArr.info}
														</c:otherwise>
													</c:choose>
												</a>
												<!-- --------------------- -->
											</div>
										</div>
									</div>
								</c:if>
							</c:forEach>
							<!-- /post -->
							<!-- ----------------------------- -->
							<div class="col-md-12 text-center">
								<c:set var="qstr" value="&search=${search}" />
								<!-- -문자열 생성한 변수를 선언하고 싶을때 set  -->
								<ul class="pagination">
									<c:if test="${prevBlock>0}">
										<li><a href="companylist?cpage=${firstCount}${qstr}">맨 앞으로</a></li>
										<li><a href="companylist?cpage=${prevBlock}${qstr}">이전</a></li>
									</c:if>
									<c:forEach var="i" begin="${prevBlock+1}" end="${nextBlock-1}">
										<c:if test="${i<=pageCount}">
											<li <c:if test="${cpage eq i}">class='active'</c:if>><a href="companylist?cpage=${i}${qstr}">${i}</a></li>
										</c:if>
									</c:forEach>
									<c:if test="${nextBlock<=pageCount}">
										<li><a href="companylist?cpage=${nextBlock}${qstr}">다음</a></li>
										<li><a href="companylist?cpage=${lastCount}${qstr}">맨 뒤로</a></li>
									</c:if>
								</ul>
							</div>
							<div class="col-md-12 text-center">
								<h4>
									<span class="text-info" style="font-weight: bold">${cpage}</span>
									/ ${pageCount} pages
								</h4>
							</div>
						</div>
					</div>
				</div>
			</c:if>
		</c:if>
	</div>
</div>
<!-- /row -->
<!-- /container -->
<script type="text/javascript">
	var check = function() {

		if (!searchform.search.value) {
			searchform.search.value = "";
		}
		searchform.submit();
	}
</script>

<!-- foot -->
<c:import url="/foot" />