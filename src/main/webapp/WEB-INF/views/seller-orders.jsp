<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seller Orders</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>
.product-img {
	width: 70px;
	height: 70px;
	object-fit: cover;
	border-radius: 6px;
}

a, a:visited, a:hover, a:active {
	color: inherit;
	text-decoration: none;
}
</style>
</head>

<body>

	<div class="container mt-4">

		<h3 class="mb-4">Seller Orders</h3>

		<c:if test="${empty sellerOrderItems}">
			<div class="alert alert-info">No orders for your products yet.</div>
		</c:if>

		<c:forEach var="item" items="${sellerOrderItems}">
			<div class="card mb-3 shadow-sm">
				<div class="card-body d-flex align-items-center">

					<a href="/products/${item.product.productId}"> <img
						src="${item.product.image}"
						class="product-img me-3">
						<div class="flex-grow-1">
							<h6 class="mb-1">${item.product.name}</h6></a>
					<p class="mb-1">Quantity: ${item.quantity}</p>
					<p class="mb-1 text-muted">Buyer: ${item.order.user.name}</p>
					<p class="mb-0 text-muted">Order Date:
						${item.order.orderDate.toLocalDate()} | Status:
						${item.order.orderStatus} | Payment: ${item.order.paymentStatus}</p>
				</div>

				<a href="/order/details/${item.order.orderId}"
					class="btn btn-sm btn-outline-primary"> View Order Details </a>

			</div>
	</div>
	</c:forEach>

	</div>

</body>
</html>
