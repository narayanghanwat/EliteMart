<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="navbar.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${product.name}</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>
.product-img {
	width: 100%;
	max-height: 200px;
	object-fit: contain;
	border-radius: 8px;
}

.price {
	font-size: 24px;
	font-weight: 600;
	color: #b12704;
}

.qty-label {
	font-size: 14px;
	margin-right: 6px;
}

.qty-dropdown {
	padding: 6px 10px;
	border-radius: 8px;
	border: 1px solid #d5d9d9;
	background: #f0f2f2;
	font-size: 14px;
	cursor: pointer;
}

.qty-dropdown:focus {
	outline: none;
	box-shadow: 0 0 0 2px #ffd814;
}

.add-cart-btn {
	margin-left: 10px;
	padding: 8px 14px;
	border-radius: 8px;
	border: none;
	background: #ffd814;
	font-size: 14px;
	cursor: pointer;
}
</style>
</head>

<body>

	<div class="container mt-4">

		<div class="row">

			<!-- IMAGE -->
			<div class="col-md-5 text-center">
				<img src="${product.image}" class="product-img">
			</div>

			<!-- DETAILS -->
			<div class="col-md-4">

				<h3>${product.name}</h3>

				<p class="price">₹ ${product.price}</p>

				<p class="text-muted">${product.description}</p>

				<p>
					<strong>Availability:</strong>
					<c:choose>
						<c:when test="${product.stock > 0}">
                        In Stock
                    </c:when>
						<c:otherwise>
							<b>Out of Stock</b>
						</c:otherwise>
					</c:choose>
				</p>

				<p>
					<strong>Sold by:</strong> ${product.seller.storeName}
				</p>

			</div>

			<!-- BUY BOX -->
			<div class="col-md-3">

				<div class="card shadow-sm">
					<div class="card-body">

						<p class="price">₹ ${product.price}</p>

						<p class="text-muted">FREE delivery available</p>

						<form id="cartForm" action="/cart/add/${product.productId}"
							method="post">
							<label class="qty-label">Quantity:</label> <select
								name="quantity" id="qtySelect" class="qty-dropdown">
								<c:forEach var="q" begin="1" end="${product.stock}">
									<option value="${q}">${q}</option>
								</c:forEach>
							</select> <br> <br>
							<button type="submit" class="btn btn-warning w-100 mb-2"
								<c:if test="${product.stock == 0}">disabled</c:if>>Add
								to Cart</button>
						</form>

						<form id="buyForm" action="/order/buy/${product.productId}/1"
							method="post">
							<button type="submit" class="btn btn-danger w-100"
								<c:if test="${product.stock == 0}">disabled</c:if>>Buy
								Now</button>
						</form>


					</div>
				</div>

			</div>

		</div>

	</div>


	<script>
		const qtySelect = document.getElementById("qtySelect");
		const buyForm = document.getElementById("buyForm");

		// Update Buy Now form action dynamically
		qtySelect.addEventListener("change", function() {
			const qty = this.value;
			buyForm.action = "/order/buy/${product.productId}/" + qty;
		});

		// Set initial quantity for Buy Now on page load
		buyForm.action = "/order/buy/${product.productId}/" + qtySelect.value;
	</script>

</body>
</html>
