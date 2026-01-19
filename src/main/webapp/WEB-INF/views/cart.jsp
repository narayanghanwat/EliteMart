<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="navbar.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>Your Cart</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>
body {
	background: #eaeded;
}

.cart-box {
	background: white;
	padding: 20px;
	border-radius: 4px;
}

.product-img {
	width: 90px;
	height: 90px;
	object-fit: cover;
}

.price {
	font-weight: bold;
	font-size: 18px;
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

<script>

function updateQuantity(cartItemId, quantity) {

    fetch('/cart/update-ajax', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: 'cartItemId=' + cartItemId + '&quantity=' + quantity
    })
    .then(response => response.json())
    .then(data => {

        // item total
        let itemTotalEl = document.getElementById("item-total-" + cartItemId);
        if (itemTotalEl) {
            itemTotalEl.innerText = '₹' + data.itemTotal;
        }

        // cart total
        let cartTotalEl = document.getElementById('cart-total');
        if (cartTotalEl) {
            cartTotalEl.innerText = '₹' + data.cartTotal;
        }
    })
    .catch(err => console.error(err));
}

</script>

</head>
<body>

	<div class="container mt-4">
		<div class="row">

			<!-- CART ITEMS -->
			<div class="col-md-9">
				<div class="cart-box">
					<h4>Shopping Cart</h4>
					<hr>

					<c:if test="${empty cart.items}">
						<p>Your cart is empty.</p>
					</c:if>

					<c:forEach items="${cart.items}" var="item">
						<div class="row mb-3 align-items-center">

							<!-- Product Image -->
							<div class="col-md-2">
								<img src="${item.product.image}"
									class="product-img img-thumbnail">
							</div>

							<!-- Product Name & Stock -->
							<div class="col-md-4">
								<h6 class="mb-1">${item.product.name}</h6>
								<small class="text-success">In stock</small>
							</div>

							<!-- Quantity -->
							<div class="col-md-2 d-flex align-items-center">
								<label class="qty-label me-2 mb-0">Qty:</label> <select
									name="quantity" class="qty-dropdown"
									onchange="updateQuantity(${item.cartItemId}, this.value)">
									<c:forEach var="q" begin="1" end="${item.product.stock}">
										<option value="${q}" ${q == item.quantity ? 'selected' : ''}>${q}</option>
									</c:forEach>
								</select>
							</div>

							<!-- "x" Separator -->
							<div class="col-md-1 d-flex justify-content-center">
								<span class="mb-0">x</span>
							</div>

							<!-- Price -->
							<div class="col-md-2 d-flex justify-content-center">
								<span class="price">₹ ${item.product.price}</span>
							</div>

							<!-- Remove Button -->
							<div class="col-md-1 d-flex justify-content-center">
								<a href="/cart/remove/${item.cartItemId}"
									class="btn btn-sm btn-outline-danger">Remove</a>
							</div>

						</div>

						<hr>
					</c:forEach>

				</div>
			</div>

			<!-- CART SUMMARY -->
			<div class="col-md-3">
				<div class="cart-box">
					<h5>Subtotal</h5>
					<hr>

					<p class="price" id="cart-total">₹ ${cart.totalPrice}</p>

					<c:choose>
						<c:when test="${not empty cart.items}">
							<form action="/order/checkout" method="post">
								<input type="submit" class="btn btn-warning w-100 fw-bold"
									value="Proceed to Buy">
							</form>
						</c:when>
						<c:otherwise>
							<button class="btn btn-secondary w-100" disabled>Cart is
								Empty</button>
						</c:otherwise>
					</c:choose>
				</div>
			</div>


		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
