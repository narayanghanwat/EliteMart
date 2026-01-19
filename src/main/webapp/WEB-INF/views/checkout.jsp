<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">

<style>
.address-box {
	border: 1px solid #ddd;
	padding: 12px;
	border-radius: 6px;
	margin-bottom: 10px;
	cursor: pointer;
}

.address-box.default {
	border-left: 5px solid #198754;
	background: #f9fff9;
}

.secure-checkout-floating {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	background: #000; /* black background */
	padding: 14px 24px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	z-index: 1050;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.6);
}

/* LEFT */
.secure-left {
	display: flex;
	align-items: center;
	gap: 8px;
}

.lock-icon {
	font-size: 20px;
	color: #fff; /* white lock */
}

.secure-text {
	font-size: 18px;
	font-weight: 600;
	color: #fff; /* white text */
}

/* RIGHT */
.secure-right {
	display: flex;
	align-items: center;
	gap: 10px;
}

/* Keep badges colored */
.safe-badge {
	background: #e6f4ea;
	color: #1e7f3b;
	font-size: 13px;
	font-weight: 600;
	padding: 4px 12px;
	border-radius: 20px;
	border: 1px solid #a8dab5;
}

.ssl-badge {
	background: #eef3f8;
	color: #0d6efd;
	font-size: 13px;
	font-weight: 500;
	padding: 4px 12px;
	border-radius: 20px;
	border: 1px solid #cfe2ff;
}

.checkout-container {
	margin-top: 80px;
}
</style>
</head>

<body>
	<div class="secure-checkout-floating">
		<div class="secure-left">
			<span class="lock-icon">🔒</span> <span class="secure-text">Secure
				Checkout</span>
		</div>

		<div class="secure-right">
			<span class="safe-badge">100% Safe Payments</span> <span
				class="ssl-badge">SSL Encrypted</span>
		</div>
	</div>


	<div class="checkout-container">
		<div class="container mt-4">

			<h3 class="mb-4">Checkout</h3>

			<c:if test="${product.productId == null }">
				<form action="/order/placeorder" method="post">
			</c:if>

			<c:if test="${product.productId != null }">
				<form action="/order/place" method="post">
			</c:if>
			<input type="hidden" name="productId" value="${product.productId}">
			<!-- ================= DELIVERY ADDRESS ================= -->
			<div class="card mb-4">
				<div class="card-body">
					<h5>1️⃣ Delivery Address</h5>

					<c:forEach var="address" items="${addresses}">
						<div
							class="address-box ${address.defaultAddress ? 'default' : ''}">
							<input type="radio" name="addressId" value="${address.addressId}"
								${address.defaultAddress ? 'checked' : ''}> <strong>${address.houseNo}</strong>,
							${address.street}, ${address.city}, ${address.state} -
							${address.pincode}

							<c:if test="${address.defaultAddress}">
								<span class="badge bg-success ms-2">Default</span>
							</c:if>
						</div>
					</c:forEach>

					<a href="/add-address" class="btn btn-sm btn-outline-primary mt-2">
						+ Add New Address </a>
				</div>
			</div>

			<!-- ================= ORDER SUMMARY ================= -->
			<div class="card mb-4">
				<div class="card-body">
					<h5>2️⃣ Order Summary</h5>
					<table class="table">
						<thead>
							<tr>
								<th>Product</th>
								<th>Quantity</th>
								<th>Price</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${product.productId == null }">
								<c:forEach var="item" items="${cartItems}">
									<tr>
										<td>${item.product.name}</td>
										<td>${item.quantity}</td>
										<td>₹ ${item.totalPrice}</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${product.productId != null }">
								<tr>
									<td>${product.name}</td>
									<td>${quantity}</td>
									<td>₹ ${totalAmount}</td>
								</tr>
							</c:if>
						</tbody>
					</table>

					<h5 class="text-end">
						Total:
						<c:if test="${product.productId != null }">₹ ${totalAmount}
							</c:if>
						<c:if test="${product.productId == null }">	
					₹ ${cart.totalPrice}
					</c:if>
					</h5>
				</div>
			</div>

			<!-- ================= PAYMENT MODE ================= -->
			<div class="card mb-4">
				<div class="card-body">
					<h5>3️⃣ Payment Method</h5>

					<div class="form-check">
						<input class="form-check-input" type="radio" name="paymentMode"
							value="COD" checked> <label class="form-check-label">
							Cash on Delivery </label>
					</div>

					<div class="form-check">
						<input class="form-check-input" type="radio" name="paymentMode"
							value="UPI"> <label class="form-check-label"> UPI
							(GPay / PhonePe / Paytm) </label>
					</div>

					<div class="form-check">
						<input class="form-check-input" type="radio" name="paymentMode"
							value="CARD"> <label class="form-check-label">
							Debit / Credit Card </label>
					</div>

					<div class="form-check">
						<input class="form-check-input" type="radio" name="paymentMode"
							value="NET_BANKING"> <label class="form-check-label">
							Net Banking </label>
					</div>
				</div>
			</div>

			<!-- ================= PLACE ORDER ================= -->
			<div class="d-grid">
				<button class="btn btn-warning btn-lg">Place Order</button>
			</div>

			</form>

		</div>
	</div>
</body>
</html>
