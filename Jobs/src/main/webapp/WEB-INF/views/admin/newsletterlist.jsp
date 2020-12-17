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
					<li>Newsletter에 등록된 Email 리스트</li>
				</ul>
				<h1>Newsletter에 등록된 Email 리스트</h1>
			</div>
		</div>
	</div>
</div>
<div class="section">
	<div class="container">
		<c:if test="${loginUser.state ne 2 }">
			<h3>관리자만 이용가능합니다.</h3>
		</c:if>
		<c:if test="${loginUser.state eq 2 }">
			<div class="col-md-10 col-md-offset-1">
				<table class="table table-bordered table-hover table-striped text-center" id="table">
					<thead>
						<tr>
							<th width="15%" class="text-center">Index</th>
							<th width="70%" class="text-center">E-mail</th>
							<th width="15%" class="text-center">Delete</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="newsletterArr" items="${newsletterArr}" varStatus="st">
							<tr>
								<td>${newsletterArr.idx}</td>
								<td>${newsletterArr.email}</td>
								<td><a href="newsletterdelete?idx=${newsletterArr.idx}">Delete</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="center-block" style="width: 200px">
					<button class="primary-button" onclick="location.href='home'">HOME</button>
				</div>
			</div>
		</c:if>
	</div>
</div>

<!-- foot -->
<c:import url="/foot" />