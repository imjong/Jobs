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
		<c:if test="${loginUser ne null}">
			<c:if test="${loginUser.state !='3' and loginUser.state !='-1'}">
				<!-- row -->
				<div class="row">
					<div class="col-md-8 col-md-offset-2">
						<div class="row">
							<c:forEach var="jobhunterArr" items="${jobhunterArr}"
								varStatus="st">
								<!-- post -->
								<c:if test="${empty jobhunterArr}">
									<div class="section-title">
										<h3>등록된 인재 정보가 없습니다.</h3>
									</div>
								</c:if>
								<c:if test="${not empty jobhunterArr}">
									<!-- post -->
									<div class="col-md-12">
										<div class="post post-row">
											<a class="post-img" href="jobhunterview?num=${jobhunterArr.num}"><c:if test="${jobhunterArr.imagename eq null}">
												<img src="./profileimage/noimage.png" class="img-responsive img-thumbnail">
												</c:if> <c:if test="${jobhunterArr.imagename ne null}">
													<img src="./profileimage/<c:out value="${jobhunterArr.imagename}"/>" class="img-responsive img-thumbnail">
												</c:if></a>
											<div class="post-body">
												<div class="post-meta">
													<span class="post-date">${jobhunterArr.wdate}</span>&nbsp;&nbsp;&nbsp;
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
													<a href="jobhunterview?num=${jobhunterArr.num}"
														style="color: navy;">${jobhunterArr.name}</a>
												</h3>
												<p>
													<!-- 글자수 제한 걸기 -->
													<a href="jobhunterview?num=${jobhunterArr.num}"> <c:choose>
															<c:when test="${fn:length(jobhunterArr.subject) > 25}">
																<c:out value="${fn:substring(jobhunterArr.subject,0,24)}" />...
            												</c:when>
															<c:otherwise>
																${jobhunterArr.subject}
															</c:otherwise>
														</c:choose> <c:if test="${jobhunterArr.filesize>0}">
															<img src="./img/file.gif">
														</c:if>
													</a>
													<!-- --------------------- -->
												</p>
											</div>
										</div>
									</div>
									<!-- /post -->
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
				<!-- /row -->
			</c:if>
		</c:if>
	</div>
	<!-- /container -->
</div>

<!-- foot -->
<c:import url="/foot" />