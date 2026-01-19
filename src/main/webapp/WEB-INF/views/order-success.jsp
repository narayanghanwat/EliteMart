<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="navbar.jsp"%>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Placed</title>

<style>
.success-box {
	max-width: 500px;
	margin: 100px auto;
	text-align: center;
	border-radius: 10px;
}
</style>
</head>

<body>

	<div class="card shadow success-box">
		<div class="card-body">

			<h1 class="text-success">✅</h1>

			<h3 class="mt-3">Order Placed Successfully!</h3>

			<p class="text-muted">
				Thank you for shopping with us.<br> Your order will be
				delivered soon.
			</p>

			<div class="d-grid gap-2 mt-4">
				<a href="/order/my" class="btn btn-primary"> View My Orders </a> <a
					href="/" class="btn btn-outline-secondary"> Continue Shopping </a>
			</div>

		</div>
	</div>

</body>
</html>
