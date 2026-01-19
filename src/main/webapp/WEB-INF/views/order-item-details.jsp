<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="navbar.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Item</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>
.product-img {
	width: 180px;
	height: 180px;
	object-fit: cover;
	border-radius: 10px;
}

a, a:visited, a:hover, a:active {
	color: inherit;
	text-decoration: none;
}
</style>
</head>
<body>

	<div class="container mt-5">

		<div class="card shadow p-4">

			<div class="row align-items-center">

				<!-- PRODUCT IMAGE -->
				<div class="col-md-4 text-center">
					<a href="/products/${item.product.productId}"> <img
						src="${item.product.image}" class="product-img"></a>
				</div>

				<!-- PRODUCT DETAILS -->
				<div class="col-md-6">
					<a href="/products/${item.product.productId}">
						<h4>${item.product.name}</h4>
					</a>

					<p class="text-muted mb-1">
						Ordered on : <strong>${orderDate}</strong>
					</p>

					<p class="text-danger">
						Return window closed on : <strong>${returnCloseDate}</strong>
					</p>

					<div class="mt-3">
						<a href="/products/${item.product.productId}"
							class="btn btn-outline-primary me-2"> View Product Details </a> <a
							href="/order/details/${item.order.orderId}"
							class="btn btn-outline-secondary"> View Order Details </a>
					</div>

				</div>
				<div class="col-md-2">
					<form action="/order/buy/${item.product.productId}/1" method="post">
						<button type="submit" class="btn btn-warning mt-2">Buy it
							Again</button>
					</form>
				</div>
			</div>

		</div>

	</div>

</body>
</html>
