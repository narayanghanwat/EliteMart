<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="navbar.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Elite-Mart</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>
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

a, a:visited, a:hover, a:active {
	color: inherit;
	text-decoration: none;
}
</style>
</head>

<body>
	<br> ${msg}
	<br>

	<div class="container mt-4">
		<!-- Products grid -->
		<div class="row row-cols-1 row-cols-md-4 g-4">

			<c:forEach var="product" items="${products}">

				<c:if test="${product.active}">
					<div class="col">
						<div class="card h-100 shadow-sm">

							<!-- Product Image -->
							<a href="/products/${product.productId}"> <c:if
									test="${not empty product.image}">
									<img src="${product.image}" class="card-img-top"
										alt="${product.name}" height="200">
								</c:if> <c:if test="${empty product.image}">
									<img src="/images/no-image.png" class="card-img-top"
										alt="No Image" height="200">
								</c:if>
							</a>

							<!-- CARD BODY MUST BE FLEX -->
							<div class="card-body d-flex flex-column">

								<!-- PRODUCT DETAILS -->
								<a href="/products/${product.productId}"
									class="text-decoration-none text-dark">
									<h6 class="card-title">${product.name}</h6>
									<p class="card-text text-success fw-bold">₹
										${product.price}</p> <c:choose>
										<c:when test="${product.stock == 0}">
											<p class="text-danger">Out of Stock</p>
										</c:when>
										<c:otherwise>
											<p class="text-success">In Stock</p>
											<p class="text-muted mb-2" style="font-size: 14px;">
												<span class="text-success fw-bold">FREE delivery</span> by <strong>
													<c:set var="deliveryDate"
														value="<%=java.time.LocalDate.now().plusDays(3)%>" />
													${deliveryDate}
												</strong>
											</p>
										</c:otherwise>
									</c:choose>
								</a>

								<!-- PUSH EVERYTHING BELOW TO BOTTOM -->
								<div class="mt-auto">

									<!-- Quantity -->
									<label class="qty-label">Quantity:</label> <select
										class="qty-dropdown qtySelect w-100 mb-3">
										<c:forEach var="q" begin="1" end="${product.stock}">
											<option value="${q}">${q}</option>
										</c:forEach>
									</select>

									<!-- Add to Cart -->
									<form action="/cart/add/${product.productId}" method="post"
										class="mb-2">
										<input type="hidden" name="quantity" class="cartQty">
										<button type="submit" class="btn btn-warning w-100"
											<c:if test="${product.stock == 0}">disabled</c:if>>
											Add to Cart</button>
									</form>

									<!-- Buy Now -->
									<form class="buyForm" data-product-id="${product.productId}"
										method="post">
										<button type="submit" class="btn btn-danger w-100"
											<c:if test="${product.stock == 0}">disabled</c:if>>
											Buy Now</button>
									</form>

								</div>
							</div>
						</div>
					</div>
				</c:if>
			</c:forEach>

		</div>
	</div>

	<script>
document.querySelectorAll('.qtySelect').forEach((select, index) => {
    const cartForm = select.closest('.card-body').querySelector('form[action^="/cart/add"]');
    const buyForm = select.closest('.card-body').querySelector('.buyForm');
    const productId = buyForm.dataset.productId;

    // Set initial Add to Cart hidden quantity
    cartForm.querySelector('.cartQty').value = select.value;

    // Update both Add to Cart hidden input and Buy Now PathVariable
    select.addEventListener('change', function() {
        // Update Add to Cart quantity
        cartForm.querySelector('.cartQty').value = this.value;

        // Update Buy Now URL with selected quantity
        buyForm.action = "/order/buy/" + productId + "/" + this.value;
    });

    // Initialize Buy Now action on page load
    buyForm.action = "/order/buy/" + productId + "/" + select.value;
});
</script>

</body>
</html>
