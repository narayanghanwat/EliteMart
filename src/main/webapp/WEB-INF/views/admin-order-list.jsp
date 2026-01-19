<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<%@ include file="admin-navbar.jsp"%>
<body>
	<c:forEach var="o" items="${orders}">
		<div class="modal fade" id="orderModal${o.orderId}" tabindex="-1"
			aria-hidden="true">
			<div class="modal-dialog modal-lg modal-dialog-centered">
				<div class="modal-content">

					<div class="modal-header bg-primary text-white">
						<h5 class="modal-title">Order #${o.orderId} Details</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>

					<div class="modal-body">
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>Product</th>
									<th>Quantity</th>
									<th>Price</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${o.orderItems}">
									<tr>
										<td>${item.product.name}</td>
										<td>${item.quantity}</td>
										<td>₹ ${item.price}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						<p class="text-end fw-bold">Total: ₹ ${o.totalAmount}</p>
					</div>

					<div class="modal-footer">
						<button class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
					</div>

				</div>
			</div>
		</div>
	</c:forEach>

	<div class="container mt-4">

		<h3 class="mb-3">🧾 Orders Management</h3>

		<div class="card shadow">
			<div class="card-body">

				<table class="table table-hover align-middle">
					<thead class="table-dark">
						<tr>
							<th>#</th>
							<th>Order ID</th>
							<th>User</th>
							<th>Total (₹)</th>
							<th>Payment</th>
							<th>Status</th>
							<th>Date</th>
							<th class="text-center">Action</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="o" items="${orders}" varStatus="i">
							<tr>
								<td>${i.index + 1}</td>
								<td>#${o.orderId}</td>
								<td>${o.user.name}</td>
								<td>₹ ${o.totalAmount}</td>
								<td>${o.paymentMode}</td>

								<td><span
									class="badge 
                                ${o.status == 'PLACED' ? 'bg-warning' :
                                  o.status == 'SHIPPED' ? 'bg-info' :
                                  o.status == 'DELIVERED' ? 'bg-success' :
                                  'bg-secondary'}">
										${o.status} </span></td>

								<td>${o.orderDate}</td>

								<td class="text-center">
									<!-- View Button triggers modal -->
									<button class="btn btn-sm btn-primary" data-bs-toggle="modal"
										data-bs-target="#orderModal${o.orderId}">View</button>
								</td>

							</tr>
						</c:forEach>

						<c:if test="${empty orders}">
							<tr>
								<td colspan="8" class="text-center text-muted">No orders
									found</td>
							</tr>
						</c:if>
					</tbody>

				</table>

			</div>
		</div>
	</div>
</body>