<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="navbar.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<title>My Orders</title>
<style>
@page {
	size: A4;
	margin: 12mm;
}

@media print {
	body * {
		visibility: hidden !important;
	}
	.print-area, .print-area * {
		visibility: visible !important;
	}
	.print-area {
		position: absolute;
		left: 0;
		top: 0;
		width: 100%;
		max-width: 100%;
		background: white;
		font-size: 11px; /* smaller font to fit */
		overflow: hidden;
	}
	/* Hide buttons */
	.no-print {
		display: none !important;
	}
	table {
		width: 100%;
		table-layout: fixed;
		page-break-inside: avoid;
	}
	tr, td, th {
		page-break-inside: avoid;
	}
	img {
		max-width: 35px;
		max-height: 35px;
	}
}

a, a:visited, a:hover, a:active {
	color: inherit;
	text-decoration: none;
}

.order-header {
	background: #f3f3f3;
	border-radius: 6px;
	padding: 12px;
	font-size: 14px;
}

.product-img {
	width: 70px;
	height: 70px;
	object-fit: cover;
	border-radius: 6px;
}

.ship-to-wrapper {
	position: relative;
	display: inline-block;
	cursor: pointer;
}

.address-popup {
	display: none;
	position: absolute;
	top: 28px;
	left: 0;
	width: 260px;
	background: #fff;
	border: 1px solid #ddd;
	border-radius: 6px;
	padding: 10px;
	font-size: 13px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
	z-index: 1000;
}

.ship-to-wrapper:hover .address-popup {
	display: block;
}

.address-popup strong {
	font-size: 14px;
}

.address-popup p {
	margin: 2px 0;
	color: #555;
}
</style>
</head>
<body>
	<c:forEach var="o" items="${orders}">
		<div class="modal fade" id="invoiceModal${o.orderId}" tabindex="-1"
			aria-hidden="true">
			<div
				class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
				<div class="modal-content" id="print-area-${o.orderId}">

					<div class="modal-header bg-dark text-white">
						<h5 class="modal-title">Invoice - Order #${o.orderId}</h5>
						<button type="button" class="btn-close btn-close-white"
							data-bs-dismiss="modal"></button>
					</div>

					<div class="modal-body">

						<!-- Company / Store Info -->
						<div class="mb-3">
							<h6>Elite-Mart</h6>
							<small>Address: 123, Market Street,Karvenagar,Pune</small><br>
							<small>Phone: +91-8308767109</small>
						</div>

						<hr class="border-secondary">

						<!-- Customer Info -->
						<div class="mb-3">
							<strong>Customer:</strong> ${o.user.name} <br> <strong>Email:</strong>
							${o.user.email} <br> <strong>Order Date:</strong>
							${o.orderDate}
						</div>

						<hr class="border-secondary">

						<!-- Invoice Items Table -->
						<table class="table table-bordered table-striped text-white">
							<thead class="table-dark">
								<tr>
									<th>Product</th>
									<th>Qty</th>
									<th>Price (₹)</th>
									<th>Subtotal (₹)</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${o.orderItems}">
									<tr>
										<td><img
											src="${item.product.image}"
											style="width: 30px; height: 30px; object-fit: contain;">
											${item.product.name}</td>
										<td>${item.quantity}</td>
										<td>₹ ${item.price}</td>
										<td>₹ ${item.quantity * item.price}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						<hr class="border-secondary">

						<div class="text-end fw-bold fs-5">Total Amount: ₹
							${o.totalAmount}</div>

					</div>

					<div class="modal-footer">
						<button type="button" class="btn-close no-print"
							data-bs-dismiss="modal"></button>
						<button class="btn btn-primary no-print"
							onclick="printModal('print-area-${o.orderId}')"
							class="print-area container-fluid p-0">Print</button>
					</div>

				</div>
			</div>
		</div>
	</c:forEach>

	<div class="container mt-4">

		<h3 class="mb-4">My Orders</h3>

		<c:forEach var="order" items="${orders}">

			<!-- ORDER HEADER ROW -->
			<div class="order-header mb-2">
				<div class="row align-items-center text-center text-md-start">

					<div class="col-md-2">
						<small class="text-muted">Order placed</small><br> <strong>${order.orderDate}
						</strong>
					</div>

					<div class="col-md-2">
						<small class="text-muted">Total</small><br> <strong>₹
							${order.totalAmount}</strong>
					</div>

					<div class="col-md-2">
						<div class="col-md-2">
							<small class="text-muted">Ship to</small><br>

							<div class="ship-to-wrapper">
								<strong>${order.user.name}</strong>

								<!-- HOVER POPUP -->
								<div class="address-popup">
									<strong>${order.user.name}</strong>
									<p>
										${order.address.houseNo},<br> ${order.address.street},<br>
										${order.address.city}, ${order.address.state}<br>
										${order.address.pincode}
									</p>
									<p>📞 ${order.address.phone}</p>
								</div>
							</div>
						</div>
					</div>

					<div class="col-md-2">
						<small class="text-muted">Ordered by</small><br> <strong>${order.user.name}</strong>
					</div>

					<div class="col-md-2">
						<small class="text-muted">Order #</small><br> <strong>${order.orderId}</strong>
					</div>

					<div class="col-md-2 text-md-end">
						<a href="/order/details/${order.orderId}" class="me-2"> View
							order details </a> <br> <br>
						<td class="text-center">
							<!-- Invoice Button triggers modal -->
							<button class="btn btn-sm btn-success" data-bs-toggle="modal"
								data-bs-target="#invoiceModal${order.orderId}">Invoice</button>
						</td>

					</div>

				</div>
			</div>

			<!-- ORDER ITEMS -->
			<div class="card shadow-sm mb-4">
				<div class="card-body">

					<c:forEach var="item" items="${order.orderItems}">
						<div class="d-flex align-items-center mb-3">
							<a href="/products/${item.product.productId}"> <img
								src="${item.product.image}"
								class="product-img me-3"></a>

							<div class="flex-grow-1">
								<a href="/products/${item.product.productId}"> <strong>${item.product.name}</strong></a>
							</div>

							<a href="/order/item/${order.orderId}/${item.product.productId}"
								class="btn btn-sm btn-outline-primary"> View Item </a>

						</div>
					</c:forEach>

				</div>
			</div>

		</c:forEach>

	</div>
	<script>
function printModal(elementId) {

	  const printArea = document.getElementById(elementId);
	    printArea.classList.add("print-area");

	    setTimeout(() => {
	        window.print();
	        printArea.classList.remove("print-area");
	    }, 500);
}
</script>


</body>
</html>
