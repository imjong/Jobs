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
					<li>기업정보</li>
				</ul>
				<h1>기업정보</h1>
			</div>
		</div>
	</div>
</div>
<div class="section">
	<div class="container">
		<div class="col-md-10 col-md-offset-1">
			<div class="row">
				<hr color="blue">
				<div class="col-md-8">
					<div class="text-center">
						<label for="name">기업명</label>
					</div>
					<hr color="blue">
					<div class="text-center">
						<h3 class="text-info">${companyinfoArr.name}</h3>
					</div>
					<hr color="blue">
				</div>
				<div class="col-md-4">
					<div>
						<label for="imagefile">기업 로고</label>
						<c:if test="${companyinfoArr.imagename eq null}">
							<img src="./profileimage/noimage.png" class="img-responsive img-thumbnail" id="imagefile">
						</c:if>
						<c:if test="${companyinfoArr.imagename ne null}">
							<img
								src="./profileimage/<c:out value="${companyinfoArr.imagename}"/>" class="img-responsive img-thumbnail" id="imagefile">
						</c:if>
					</div>
				</div>
			</div>
			<hr color="red">
			<div class="text-center">
				<label for="content">내용</label>
			</div>
			<hr color="red">
			<div>
				<pre id="pre_large">
					<p>${companyinfoArr.info}</p>
				</pre>
			</div>
			<hr color="red">
			<div class="center-block" style="width: 200px">
				<button class="primary-button" onclick="location.href='companylist'">기업목록</button>
			</div>
			<hr color="red">
		</div>
	</div>
</div>

<!-- foot -->
<c:import url="/foot" />