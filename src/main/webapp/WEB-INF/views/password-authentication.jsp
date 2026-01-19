<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Password</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
</head>

<body>

	<div class="container mt-5 col-md-4">
		<div class="card p-4 shadow">

			<c:if test="${not empty userId}">
				<!-- ENTER PASSWORD -->
				<c:if
					test="${sessionScope.loggedInUser != null and sessionScope.loggedInSeller == null}">
					<h3 class="mb-4 text-center">Enter password</h3>
					<c:if test="${not empty msg}">
						<div class="alert alert-danger text-center">${msg}</div>
					</c:if>
					<form action="/users/verify/password" method="post">
						<input type="hidden" name="userId"
							value="${sessionScope.loggedInUser.userId}"> <input
							type="password" name="password" class="form-control" required>
						<br>
						<button type="submit" class="btn btn-warning w-100">Verify</button>
					</form>
				</c:if>
			</c:if>
			<!-- ENTER PASSWORD -->
			<c:if test="${seller.password != null and seller.password != ''}">
				<h3 class="mb-4 text-center">Enter password</h3>
				<c:if test="${not empty msg}">
					<div class="alert alert-danger text-center">${msg}</div>
				</c:if>
				<form action="/seller/verify/password" method="post">
					<input type="hidden" name="sellerId" value="${seller.sellerId}">
					<input type="password" name="password" class="form-control"
						required> <br>
					<button type="submit" class="btn btn-warning w-100">Login</button>
				</form>
			</c:if>
			<c:if test="${seller.sellerId != null}">
				<c:if test="${seller.password == null or seller.password == ''}">
					<h3 class="mb-4 text-center">Set up password</h3>
					<c:if test="${not empty msg}">
						<div class="alert alert-danger text-center">${msg}</div>
					</c:if>
					<form action="/seller/addnew/password" method="post">
						<input type="hidden" name="sellerId" value="${seller.sellerId}">
						<input type="password" name="password" class="form-control"
							placeholder="Create password" required> <br> <input
							type="password" name="confirmPassword" class="form-control"
							placeholder="Confirm password" required> <br>
						<button type="submit" class="btn btn-warning w-100">Save</button>
					</form>
				</c:if>
			</c:if>
		</div>
	</div>

</body>
</html>
