<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="navbar.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Details</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<style>
.product-img {
	width: 80px;
	height: 80px;
	object-fit: cover;
	border-radius: 6px;
}

.section-title {
	font-weight: 600;
	margin-bottom: 10px;
}

a, a:visited, a:hover, a:active {
	color: inherit;
	text-decoration: none;
}

.pay-now-btn {
	background-color: #28a745; /* professional green */
	color: #ffffff; /* white text */
	font-weight: 600; /* bold but clean */
	font-size: 16px;
	padding: 10px 22px;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	transition: all 0.3s ease;
}

.pay-now-btn:hover {
	background-color: #218838;
	transform: translateY(-1px);
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
}
</style>
</head>
<body>
	<div class="modal fade" id="upiModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content bg-dark text-white">

				<div class="modal-header border-secondary">
					<h5 class="modal-title">Scan & Pay</h5>
					<button type="button" class="btn-close btn-close-white"
						data-bs-dismiss="modal"></button>
				</div>

				<div class="modal-body text-center">

					<!-- QR -->
					<img id="qrImage" width="220" height="220" class="mb-3"
						alt="UPI QR">

					<p class="text-success fw-bold">100% Safe Payments</p>

					<hr class="border-secondary">

					<!-- Screenshot Upload 
					<label class="form-label">Upload Payment Screenshot</label> <input
						type="file" class="form-control bg-dark text-white"
						accept="image/*" onchange="previewScreenshot(this)"> <img
						id="previewImg"
						class="img-fluid mt-3 d-none rounded border border-secondary"
						alt="Preview"> <small class="text-muted d-block mt-2">
						Upload screenshot after successful payment </small>
-->
				</div>

				<div class="modal-footer border-secondary justify-content-between">
					<button class="btn btn-outline-light" data-bs-dismiss="modal">
						Cancel</button>

					<button class="btn btn-success" onclick="submitPayment()">
						Submit Payment</button>
				</div>

			</div>
		</div>
	</div>
	<div class="container mt-4">

		<!-- ORDER HEADER -->
		<div class="card shadow-sm mb-3">
			<div class="card-body">

				<div class="row text-center text-md-start">
					<div class="col-md-3">
						<small class="text-muted">Order ID</small><br> <strong>${order.orderId}</strong>
					</div>

					<div class="col-md-3">
						<small class="text-muted">Ordered On</small><br> <strong>${order.orderDate.toLocalDate()}</strong>
					</div>

					<div class="col-md-3">
						<small class="text-muted">Order Status</small><br> <strong>${order.orderStatus}</strong>
					</div>

					<div class="col-md-3">
						<small class="text-muted">Total Amount</small><br> <strong>₹
							${order.totalAmount}</strong>
					</div>
				</div>

			</div>
			<div id="qrModal"
				style="display: none; text-align: center; margin-top: 20px;">
				<h5>Scan & Pay</h5>
				<img id="qrImage" alt="UPI QR Code">
				<p class="text-muted">Open any UPI app and scan</p>
			</div>
		</div>

		<!-- SHIPPING & PAYMENT -->
		<div class="row mb-3">

			<div class="col-md-6">
				<div class="card shadow-sm h-100">
					<div class="card-body">
						<div class="section-title">Shipping Address</div>
						<p class="mb-1">
							<strong>${order.user.name}</strong>
						</p>
						<p class="mb-1">${order.address.houseNo}</p>
						<p class="mb-1">${order.address.city},${order.address.state}-
							${order.address.pincode}</p>
						<p class="mb-0">📞 ${order.address.phone}</p>
					</div>
				</div>
			</div>

			<div class="col-md-6">
				<div class="card shadow-sm h-100">
					<div class="card-body">
						<div class="section-title">Payment Information</div>
						<p class="mb-1">
							<strong>Mode:</strong> ${order.paymentMode}
						</p>
						<p class="mb-0">
							<strong>Status:</strong> ${order.paymentStatus == null? 'PENDING' : 'PAID'}
						</p>

						<button class="pay-now-btn" onclick="pay(${order.totalAmount})">Pay Now </button>

					</div>
				</div>
			</div>

		</div>

		<!-- ORDER ITEMS -->
		<div class="card shadow-sm">
			<div class="card-body">

				<div class="section-title">Ordered Items</div>

				<c:forEach var="item" items="${order.orderItems}">
					<div class="d-flex align-items-center border-bottom py-3">
						<a href="/products/${item.product.productId}"> <img
							src="${item.product.image}"
							class="product-img me-3">
						</a>
						<div class="flex-grow-1">
							<a href="/products/${item.product.productId}"> <strong>${item.product.name}</strong>
							</a><br> <small class="text-muted"> Quantity:
								${item.quantity} </small>
						</div>

						<div>
							<strong> ₹ ${item.price * item.quantity} </strong>
						</div>

					</div>
				</c:forEach>

			</div>
		</div>

	</div>
	<script>
		let modalInstance;
		let screenshotUploaded = false;

		function pay(amount) {

			const upiUrl = "upi://pay" + "?pa=ghanwatnarayan5@okicici"
					+ "&pn=Narayan" + "&am=" + amount + "&cu=INR"
					+ "&tn=Order Payment";

			const qrUrl = "https://api.qrserver.com/v1/create-qr-code/?size=250x250&data="
					+ encodeURIComponent(upiUrl);

			document.getElementById("qrImage").src = qrUrl;

			modalInstance = new bootstrap.Modal(document
					.getElementById("upiModal"));
			modalInstance.show();

			screenshotUploaded = false;
		}

		function previewScreenshot(input) {
			const file = input.files[0];
			if (!file)
				return;

			const img = document.getElementById("previewImg");
			img.src = URL.createObjectURL(file);
			img.classList.remove("d-none");

			screenshotUploaded = true;
		}

		function submitPayment() {
			if (!screenshotUploaded) {
				alert("You Havent Paid Yet");
				return;
			}

			modalInstance.hide();
			alert("Payment submitted for verification");

			// OPTIONAL redirect
			// window.location.href = "/order/payment-submitted";
		}
	</script>
</body>
</html>
